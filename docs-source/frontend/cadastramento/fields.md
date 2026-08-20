# Cadastramento — Campos

> Campos do fluxo de cadastro público.
> Fases e guards: [flow.md](./flow.md).

## Campos de controle (todos os passos)

| Papel | Campo | Notas |
|---|---|---|
| Fase do funil (responsável) | `associate_status` **1–5** | Ver [flow.md](./flow.md) |
| Tipo / conclusão | `status` | `Associado` \| `patient` |
| Campos que falharam validação | `invalid_fields` | JSON lista de nomes de campo |
| Ref. do termo | `adhesion_term` | |
| Receita | `prescription` | |

---

## 1. Conta inicial (`/cadastro`) — fase 1

| UI | Campo | Obrig. | Notas |
|---|---|---|---|
| E-mail | `email_account` | sim | |
| — | `associate_status = 1` | — | |
| Senha | `account_password` | sim | Hash só no servidor; nunca expor em GET |

---

## 2. Responsável (`/cadastro-associado`) — fase 2

| UI | Campo | Obrig. |
|---|---|---|
| Tipo responsável | `responsible_type` | sim |
| Nome | `associate_name` | sim |
| Sobrenome | `associate_last_name` | sim |
| Nascimento | `associate_birth_date` | sim |
| Gênero | `gender` | sim |
| Nacionalidade | `nationality` | sim |
| CPF | `associate_cpf` | sim |
| RG | `associate_rg` | sim |
| Órgão RG | `associate_rg_issuer` | sim |
| Estado civil | `marital_status` | sim |
| Senha | `account_password` | sim |
| Celular | `mobile_number` | sim |
| Rua | `street` | sim |
| Número | `street_number` | sim |
| Complemento | `complement` | não |
| Bairro | `neighborhood` | sim |
| Cidade | `city` | sim |
| UF | `state` | sim |
| CEP | `cep` | sim |
| CIAP2 | `ciap_codes` | sim |
| Motivo (texto) | `reason_treatment_text` | sim |
| — | `invalid_fields` | — | atualizado a cada submit |

Submit: persistência parcial + `invalid_fields` — [flow.md](./flow.md).
Form completo (`invalid_fields` vazio) → segue na fase 2 (paciente se `another`) ou libera fase 3.

### Valores canônicos

**`responsible_type`:** `himself` | `another` | `pet` (no filho: `patient`)

**`marital_status`:** `Solteiro(a)` | `Casado(a)` | `União-Estável` | `Viúvo(a)` | `Divorciado(a)`

**`gender`:** `homem-cis` | `mulher-cis` | `homem-trans` | `mulher-trans` | `travesti` | `nao-binario` | texto livre (`outro`)

### CIAP2

| Aspecto | Comportamento |
|---|---|
| Campo | `ciap_codes` |
| Texto | `reason_treatment_text` |
| UI | Multi-select por categorias + busca |
| Limite | máx. **10**; mín. **1** para form completo |
| Persistência parcial | 1–10 → grava; vazio ou >10 → não grava + entra em `invalid_fields` |

---

## 3. Paciente (`/cadastro-paciente`) — ainda fase 2 do responsável

Registro **filho** em `users`. O progresso 1–5 continua no **responsável**.

| Campo | Valor / origem |
|---|---|
| `status` | `"patient"` (fixo) |
| `responsible_type` | `"patient"` (fixo) |
| `email_account` | e-mail do responsável |
| `mobile_number` | herdado do responsável |
| `responsible_code` | `user_code` do responsável (FK) |
| demográficos + CIAP2 | formulário (iguais ao responsável, sem senha) |

No responsável: `patient_user_code` = `user_code` do paciente criado neste funil.

### Semântica de `patient_user_code` (dois contextos)

| Contexto | Campo | Papel |
|---|---|---|
| **Funil** (`apps/registration`) | `users.patient_user_code` no **responsável** | Ponteiro do paciente cadastrado quando `responsible_type = another`. **Não** significa “paciente ativo” editável no painel. |
| **Relação estrutural** | `users.responsible_code` no **paciente** | FK paciente → responsável. Usar para listar/CRUD de pacientes. |
| **Atendimento** (painel Serviços) | `services.patient_user_code` | Beneficiário **daquele** serviço. Escolhido no modal Novo Serviço. |

Regras cruzadas (painel Kunk — ver [`../kunk/associados/`](../kunk/associados/README.md) e [`../kunk/servicos/`](../kunk/servicos/README.md)):

1. Painel **não** tem Tornar/Remover Ativo sobre `users.patient_user_code`.
2. Pacientes adicionados depois na aba Pacientes usam só `responsible_code`; **não** precisam atualizar `users.patient_user_code`.
3. Ao criar serviço com associado pré-carregado (`?u=`): se `users.patient_user_code` existir e o paciente tiver `responsible_code` = responsável → **pré-selecionar** esse paciente como beneficiário; o operador pode mudar.

Persistência parcial + `invalid_fields` no registro que está sendo editado.

---

## 4. Documentos (`/documentos`) — fases 3–4

| UI | Comportamento |
|---|---|
| Seleção de tipo | **RG** ou **Carteira de motorista (CNH)** |
| RG | upload **frente** + **verso** |
| CNH | upload só **frente** |
| `another` | assistente para **responsável** e para **paciente** |
| Termo | gera só quando **todos** os docs obrigatórios do caso estiverem OK → fase **4** |

Arquivos com metadados (`doc_type`, `side`, `subject`) via `users_files` / files API — ver [flow.md](./flow.md).

| Campo | Notas |
|---|---|
| `documents_folder_id` | server-side |
| `adhesion_term` | após assinatura |

Assinatura OK → `associate_status = 5`, grava `adhesion_term`.

---

## 5. Consulta (`/consulta`) — fase 5

| UI | Campo / efeito |
|---|---|
| Receita médica | `prescription` |
| Laudo / exame | files API + tipo |
| Concluir | `status = "Associado"` |

---

## 6. Sessão (servidor)

`session_token`, `session_expires`, `is_session_active`, `last_activity` — só no server; cookie HttpOnly no browser.

---

## 7. Payload do termo (módulo nativo / doc-sign)

| Campo template | Origem |
|---|---|
| `usercode` | `user_code` (não `id`) |
| `email` | `email_account` |
| Nome | `associate_name` + `associate_last_name` |
| Estado civil, nacionalidade, CPF, RG, órgão, endereço | campos equivalentes do associado |
| Data | por extenso PT |

---

## Limites e regras

**Não usados neste produto:** `met_us`, `bvid`, `proof_of_address`, `aguardando-aprovacao`.

Progresso: **`associate_status` 1–5**. Conclusão do responsável: **`status = Associado`**. Filho: **`status = patient`**.

Nunca expor `account_password` em GET. Hash só no servidor.
