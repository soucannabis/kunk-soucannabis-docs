# Pagar.me + Pedidos SouCannabis — Documentação

> Dois serviços externos: **Pagar.me** e **Pedidos SouCannabis** (catálogo/tags/pedidos via API do Kunk central).
> Contrato SC: [`../../external_apps_kunk_doc.md`](../../external_apps_kunk_doc.md) (inclui `external_payment_info`).

## Objetivo

1. **Pagar.me** no Admin — credenciais, teste, webhook, `association_recipient_id`; PaymentModal em pedidos/serviços.
2. **Pedidos SouCannabis** — só com Pagarme ativo; OAuth + teste; recebedor SC cadastrado **pela SC via API**.
3. Carrinho com SC: produtos remotos; **sem frete** e **sem estoque** local.
4. Tags: seção SC **somente leitura** + tags do sistema.
5. Pedido na SC **após** pagamento (webhook Pagarme ou comprovante; total 0 pode ser manual).
6. Com SC ativo e total > 0: cobrança com **split**; confirmação via **webhook** (fonte Pagarme) ou comprovante; `external_payment_info` no create SC.

## Limites do produto

| Item | Detalhe |
|---|---|
| Afiliados / workflows externos no webhook | Não disponível neste produto |
| PIX como aba dedicada | Não no PaymentModal; opcional fora do núcleo |
| Split em serviços / CreateRecipient de profissionais | Não disponível; `POST /recipients` pode reusar em outros fluxos |
| Cartão parcial com SC ativo | Proibido com `split_mode` |

API: [`pagarme.md`](../../api/modules/pagarme.md) · [`soucannabis_orders.md`](../../api/modules/soucannabis_orders.md) · [`credentials.md`](../../api/modules/credentials.md)
