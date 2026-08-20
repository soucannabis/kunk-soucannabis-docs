# Doc-sign — Documentação do app

> Gerenciador nativo de **termos de adesão e assinaturas eletrônicas**.

## Objetivo

1. **Dois modelos** — `self` (himself/pet) e `with_patient` (another)
2. **Editor TipTap no `apps/doc-sign`** — texto do zero + variáveis; fonte de verdade em **JSON (`JSONB`)**
3. **PDF gerado na `kunk-api`** a partir do JSON (sem Document Server / LibreOffice / DOCX)
4. **Assinatura** draw / type / upload
5. **Audit log** com hashes + IP, UA, timezone (**sem session_id**)
6. **Fase 4** por redirect; um `completed` por e-mail/associado; sem webhook

## Limites do produto

| Item | Detalhe |
|---|---|
| DOCX / OnlyOffice / Collabora / Gotenberg | Não faz parte do produto — PDF a partir do JSON TipTap |
| Multi-signatários / reassinatura após completed | Não disponível neste produto |
| Editor no `apps/admin` | Só no `doc-sign` |
| Session ID no audit | Não incluído |

## Escopo do módulo de termos

| Conceito | doc-sign |
|---|---|
| PDF + labels | TipTap JSON + variáveis |
| Submitters API | `POST /doc-sign/contracts` |
| 3 métodos de assinatura | Iguais |
| Audit Log | `term_events` + PDF |
| Webhook | Handler interno |
| DOCX API | Não usado |
