# Serviços — Documentação

> Página de serviços (consultas/atendimentos) no produto (`apps/kunk` + `apps/admin` + `kunk-api`).

## Objetivo

Fluxo de **serviços** com:

1. Layout e visual da página (barra de filtros, tabela, cores, modal de infos, modal novo serviço)
2. **Agrupamento por `booking_group_code`** — vários serviços do mesmo associado com profissionais diferentes no mesmo grupo
3. **Modal de infos do serviço** (observações, tags, profissional, telefone, comprovante)
4. **Gestão de profissionais** (CRUD, valor de consulta, tipo/especialidade, visibilidade no input de serviços, agenda Google)
5. **Módulo Google Calendar** no admin de serviços externos + assistente de autenticação OAuth
6. Agendamento na **agenda do profissional** via `calendar_id`

## Limites do produto

| Item | Detalhe |
|---|---|
| Cupons no serviço | Não disponível neste produto |
| Afiliados / parceiros (`bvid`) | Não disponível neste produto |
| Chat / WhatsApp automático | Módulo Utalk (serviços externos), quando ativo |
| Sync Pedidos SouCannabis | Só pedidos — ver [`../pagamentos-soucannabis/`](../pagamentos-soucannabis/README.md) |

Campos de valor (`price`, `donation`, `price_paid`), `payment_type` e status `Aguardando Pagamento` / `Pagamento Concluído` **permanecem**. Toggle manual / comprovante continuam; **PaymentModal (Pagar.me)** entra quando o módulo `pagarme` estiver ativo — [`../pagamentos-soucannabis/`](../pagamentos-soucannabis/README.md). Split SouCannabis **não** se aplica a serviços.

Docs de API do módulo:

| Documento | Conteúdo |
|---|---|
| [`../../api/modules/google_calendar.md`](../../api/modules/google_calendar.md) | OAuth, listagem de agendas, CRUD de eventos |
| [`../../api/modules/credentials.md`](../../api/modules/credentials.md) | Tabela `system_api_credentials` + assistente |

Relatório de pagamento a profissionais (mês / taxas / portal): [`../relatorios-servicos/README.md`](../relatorios-servicos/README.md).
