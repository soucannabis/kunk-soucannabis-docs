# Cadastramento — Requisitos de API

> Contrato da API do app de cadastramento (`apps/registration`).
> Fases: [flow.md](./flow.md).
> Auth detalhada: [`../../api/authentication.md`](../../api/authentication.md).

## Princípio

Front só fala `/api/v1`. Sessão de **associado** via cookie **`associate_session`** (não misturar com `session_token` do painel).

---

## Auth de associado

| Método | Path | Notas |
|---|---|---|
| POST | `/auth/associate/register-email` | Body `{ email, password }` → user fase 1 + cookie (senha min. 8). 429 `RATE_LIMITED` após 5 pedidos / 15 min / IP. |
| POST | `/auth/associate/login` | `{ email, password }`. 429 `RATE_LIMITED` após 5 falhas / 5 min por IP+e-mail (teto 30 falhas / IP). Acertos não contam. |
| POST | `/auth/associate/logout` | |
| GET | `/auth/associate/me` | Sem senha; fase, status, invalid_fields, patient link |
| POST | `/auth/associate/forgot-password` | `{ email }` → 200 genérico |
| POST | `/auth/associate/reset-password` | `{ token, password }` |

Senha: hash **bcrypt** no servidor; nunca expor `account_password` em GET. Cookie **`associate_session`** HttpOnly / Secure / SameSite. Reset: token de uso único com expiração; resposta de forgot sempre 200 genérico (não revelar se o e-mail existe).

---

## Users / funil

| Método | Path | Função |
|---|---|---|
| GET | `/users/exists?email=` | `{ exists, state: "none"\|"in_progress"\|"associado" }`. 429 `RATE_LIMITED` após 5 pedidos / 15 min / IP. |
| PATCH | `/users/me` | Persistência parcial do responsável |
| GET | `/users/me/patients` | Pacientes do responsável |
| POST | `/users/me/patients` | Cria paciente (parcial ou completo) |
| PATCH | `/users/me/patients/:id` | Persistência parcial do paciente |
| POST | `/users/me/advance` | Tenta avançar fase (server valida pré-condições) |

### PATCH parcial

```http
PATCH /users/me
Cookie: associate_session=…

{ "associate_name": "Ana", "associate_cpf": "000", "cep": "" }
```

**200**

```json
{
 "data": { "id": 1, "associate_status": 2, "invalid_fields": ["associate_cpf", "cep"], "…": "…" },
 "meta": {
 "saved_fields": ["associate_name"],
 "invalid_fields": ["associate_cpf", "cep"]
 },
 "errors": null
}
```

- **400** se nenhum campo conhecido no body.
- Server é fonte de verdade de `invalid_fields`.

### E-mail duplicado (register-email)

| Caso | HTTP | Código |
|---|---|---|
| Novo | 201 | — |
| Já Associado | 409 | `ACCOUNT_EXISTS` |
| Em andamento (fases 1–5) | 409 | `ACCOUNT_IN_PROGRESS` |
| 5+ pedidos no mesmo IP / 15 min | 429 | `RATE_LIMITED` |

---

## Documentos (fase 3)

| Método | Path | Função |
|---|---|---|
| POST | `/files` | multipart + `doc_type`, `side`, `subject`, `doc_kind` |
| GET | `/users/me/documents/status` | O que falta para completar identidade |
| DELETE | `/files/:id` | Remover upload próprio na fase 3 |

Metadados por upload: `doc_type` (`rg` \| `cnh`), `side` (`front` \| `back`), `subject` (`responsible` \| `patient`), além de `doc_kind` quando aplicável.

---

## Termos (fase 4) — comportamento atual

O produto expõe a fase 4 do funil, mas o módulo de assinatura de termos responde como indisponível:

| Método | Path | Comportamento atual |
|---|---|---|
| POST | `/terms/contracts` | **501/503** `TERMS_MODULE_IN_DEVELOPMENT` |
| GET | `/terms/status` | `{ status: "module_in_development" }` |

No front, após documentos OK, a tela da fase 4 mostra mensagem de módulo indisponível. O advance 4→Associado exige `adhesion_term`; sem assinatura válida retorna **400**. Não há avanço automático por webhook.

Contrato do módulo nativo: [`../doc-sign/`](../doc-sign/README.md) — API `/doc-sign/*`, avanço 4→5 na mesma `kunk-api`, `adhesion_term` = UUID do contrato, payload com **`user_code`**.

---

## Fase 5

| Uso | API |
|---|---|
| Receita | PATCH `prescription` +/ou file `doc_kind=prescription` |
| Laudo / exame | files `doc_kind=report\|exam` |
| Concluir | PATCH `status=Associado` (ou `POST /users/me/complete`) |

Acessível quando o associado está na fase 5 (após conclusão da assinatura do termo).

---

## Guards

- Rotas de associado exigem cookie `associate_session`.
- Ações de fase anterior → **403** `PHASE_LOCKED` se `associate_status` já passou.
- Associado só acessa o próprio user / próprio paciente.

---

## Erros

Envelope [`../../api/errors.md`](../../api/errors.md).
Códigos: `ACCOUNT_EXISTS`, `ACCOUNT_IN_PROGRESS`, `PHASE_LOCKED`, `TERMS_MODULE_IN_DEVELOPMENT`.
