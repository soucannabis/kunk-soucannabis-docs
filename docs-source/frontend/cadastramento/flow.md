# Cadastramento — Fluxo e status

> Funil de inscrição, fases em **`associate_status`** (strings pt-BR) e tipo/conclusão em **`status`**.
> Todo cadastro é feito por um **responsável** (si mesmo, outra pessoa ou pet).

## Conceitos (dois campos distintos)

| Campo | Papel |
|---|---|
| **`associate_status`** (VARCHAR pt-BR) | **Fase do funil** do responsável. Flag para router, guards e menu/sidebar. |
| **`status`** (string) | **Tipo / conclusão.** `NULL` no funil → **`Associado`** ao assinar o termo. `patient` = registro do paciente. |
| **`invalid_fields`** (JSON/texto) | Lista dos campos que **não passaram** na validação no último submit. **Não** é fase do funil. No Kunk aparece como **Problema no cadastro**. |

Não existe fase/status `consulta`. Após `status = Associado`, a tela `/consulta` permite agendar, enviar docs extras ou finalizar (`associate_status = concluido`).

---

## Fases (`associate_status`)

| Fase | Significado | Rota | Label no Kunk |
|---|---|---|---|
| `cadastro_criado` | Cadastro criado com e-mail | `/bem-vindo` → `/cadastro-associado` | Não preencheu os dados |
| `dados_pessoais` | Preenchendo / preenchidos dados pessoais (+ paciente se `another`) | `/cadastro-associado` e, se preciso, `/cadastro-paciente` | Apenas preencheu os dados |
| `documentos` | Envio de documentos de identidade | `/documentos` | Documentos enviados |
| `assinatura_termo` | Assinatura do termo | `/documentos` | Termo criado |
| `status=Associado` | Termo assinado | `/consulta` | Associado |
| `concluido` | Cadastro finalizado na UI (após Associado) | `/cadastro-concluido` | Associado (no painel) |
| `invalid_fields` ≠ vazio | Save com campos faltando | (mesma fase) | Problema no cadastro |

Ao **assinar o termo**:

- responsável: `status = "Associado"` (permanece em `assinatura_termo` até finalizar)
- se existir paciente vinculado: o registro filho continua `status = "patient"`

### Guards (não voltar)

Quando o usuário **avança** de fase, o router **não** permite reabrir etapas anteriores:

| Situação | Pode acessar | Bloqueado (redirect) |
|---|---|---|
| `cadastro_criado` | welcome, form associado | docs, consulta, concluído |
| `dados_pessoais` | form associado / paciente | docs, consulta… |
| `documentos` | `/documentos` (uploads) | forms de dados, consulta |
| `assinatura_termo` | assinatura do termo | uploads já concluídos / forms |
| `status=Associado` (não concluído) | `/consulta` | forms e docs anteriores |
| `concluido` | `/cadastro-concluido` | demais etapas do funil |

`/` (home) sempre redireciona para a rota da fase atual.

---

## Diagrama (happy path)

```
[/cadastro] e-mail
 │ associate_status = cadastro_criado
 ▼
[/bem-vindo] → [/cadastro-associado]
 │ dados pessoais (+ senha + CIAP2)
 │ persistência parcial + invalid_fields
 │ quando form completo e válido → associate_status = dados_pessoais
 │
 ├── responsible_type = "another"
 │ [/cadastro-paciente] (ainda dados_pessoais)
 │ cria/atualiza registro filho status="patient"
 │ liga patient_user_code no responsável ← ponteiro do FUNIL
 │ (responsible_code no filho = user_code do responsável)
 │ form paciente completo → segue para documentos
 │
 └── himself | pet → documentos
 ▼
[/documentos] associate_status = documentos
 │ assistente de documentos (RG ou CNH)
 │ se another: docs do responsável E do paciente
 │ quando TODOS os docs obrigatórios OK:
 │ associate_status = assinatura_termo
 │ assina o termo → status = Associado (+ adhesion_term)
 ▼
[/consulta] status = Associado
 │ receita / laudos / exames / agendar (opcional)
 │ finalizar → associate_status = concluido
 ▼
[/cadastro-concluido]
 status = Associado · associate_status = concluido
```

---

## Rotas alvo

| Rota | Página | Auth |
|---|---|---|
| `/cadastro` | E-mail inicial | pública |
| `/login` | Login associado | pública |
| `/bem-vindo` | Boas-vindas | sessão |
| `/cadastro-associado` | Form responsável | sessão · cadastro_criado / dados_pessoais |
| `/cadastro-paciente` | Form paciente | sessão · dados_pessoais · só `another` |
| `/documentos` | Assistente de docs + termo | sessão · documentos / assinatura_termo |
| `/consulta` | Extras + finalizar | sessão · Associado (não concluído) |
| `/cadastro-concluido` | Encerramento | sessão · concluido |
| `/nova-senha` | Redefinir senha | pública (token) |
| `/` | Router por fase / status | sessão |

Rotas não usadas: `/iniciar-cadastro`, `/loja`, `/seu-cadastro`, `/cadastro-aprovado`.

---

## Responsável vs paciente (esclarecimento)

**Todo cadastro é feito por um responsável** (`responsible_type`: `himself` | `another` | `pet`).

| Situação | Registros | `status` |
|---|---|---|
| Cadastro para si (`himself`) ou pet | 1 usuário (o responsável) | ao fim: `Associado` |
| Cadastro para outra pessoa (`another`) | 2 usuários: responsável + paciente | responsável → `Associado`; filho → `patient` |

O progresso **`associate_status`** (strings pt-BR) roda no **responsável** (quem tem login/senha e percorre o funil).

O registro **paciente** não tem funil próprio: é criado/atualizado na **fase 2**, recebe docs na **fase 3**, e permanece `status = "patient"`.

> **Nota:** a fase 2 cobre dados do responsável e, se `another`, os do paciente.

> **Painel / Serviços:** `users.patient_user_code` no responsável é só o ponteiro do funil. Atendimento operacional grava `services.patient_user_code`. Semântica completa em [fields.md §3](./fields.md#semântica-canônica-de-patient_user_code-dois-contextos) e [`../kunk/associados/`](../kunk/associados/README.md).

---

## `invalid_fields`

Campo que guarda os inputs que **não passaram** na validação no último envio.

### Objetivo

- Identificar o que falta para o cadastro avançar.
- Permitir suporte / contato com o usuário sobre campos pendentes.
- **Não** altera a fase sozinho: o usuário permanece na fase 2 até o form estar completo.

### Regras

1. Em todo submit (associado ou paciente): validar todos os campos.
2. Persistir **somente** campos válidos (persistência parcial).
3. Campos inválidos/vazios obrigatórios → **não** gravar valor; incluir o nome do campo em `invalid_fields`.
4. Se um campo que estava em `invalid_fields` passar a validar → gravar o valor e **remover** esse campo de `invalid_fields`.
5. Form **completo** (lista `invalid_fields` vazia + todos obrigatórios OK) → avança a fase (ex.: permanece/avança em fase 2 e libera ida à fase 3 quando paciente também OK).

---

## Persistência parcial

Cada submit grava só o que passou na validação. Detalhe de API em [api.md](./api.md).

---

## Documentos — assistente (fase 3)

Assistente que guia o envio de documentos de identidade.

### Tipo de documento (por pessoa)

| Tipo | Arquivos exigidos |
|---|---|
| **RG** | Frente **e** verso |
| **Carteira de motorista (CNH)** | Apenas **frente** |

O usuário **seleciona o tipo** antes de enviar.

### Quem precisa enviar

| `responsible_type` | Documentos |
|---|---|
| `himself` / `pet` | Identidade do responsável (RG ou CNH conforme escolha) |
| `another` | Identidade do **responsável** + identidade do **paciente** (cada um com seu tipo RG/CNH) |

### Geração do termo

- **Só após todos os documentos obrigatórios** do caso estarem enviados e válidos → `associate_status = 4` (`assinatura_termo`).
- Na fase 4 a UI informa que o **módulo de assinatura de termos está indisponível**. O funil **não** avança sozinho para a fase 5.
- Com o módulo nativo ativo (doc-sign): gera-se o contrato, o usuário assina e a API grava `adhesion_term` e avança para a fase 5. Identificador no termo: **`user_code`**.

### `awaiting_signature`

Campo reservado ao fluxo nativo de termos. No comportamento atual (módulo indisponível) não é usado.

### Campos de arquivo

O assistente modela **frente/verso** e tipo via metadados no upload:

- metadados por upload: `doc_type` (`rg` \| `cnh`), `side` (`front` \| `back`), `subject` (`responsible` \| `patient`)
- ou campos dedicados / `users_files` com tags

`proof_of_address` **não** faz parte deste produto.

---

## Fase 5 — consulta / extras / finalizar

| Ação | Efeito |
|---|---|
| Enviar receita | grava `prescription` |
| Enviar laudo / exame | arquivos extras (assistente ou anexos tipados) |
| Agendar consulta | abre `VITE_CONTACT_URL` |
| Concluir (com ou sem receita) | `status = "Associado"` → `/cadastro-concluido` |

Único status de encerramento do responsável: **`Associado`**. Não usar `aguardando-aprovacao`.

---

## Router de `/`

| `associate_status` | Destino |
|---:|---|
| 1 | `/bem-vindo` |
| 2 | `/cadastro-associado`; se `another` e paciente incompleto → `/cadastro-paciente` |
| 3 | `/documentos` (uploads) |
| 4 | `/documentos` — UI “módulo de termos indisponível” |
| 5 | `/consulta`; se já `status=Associado` → `/cadastro-concluido` |

---

## Sidebar de progresso (UX)

Etapas visuais: **Cadastro → Documentos → Consulta → Concluído** (no produto).

| Etapa UI | Ativa / check quando |
|---|---|
| Cadastro | fase 1–2 (check a partir da 3) |
| Documentos | fase 3–4 (check a partir da 5) |
| Consulta | fase 5 |
| Concluído | `status = Associado` |

Animação/estados (check, atual, bloqueado) seguem `associate_status`, como no cadastramento atual.

---

