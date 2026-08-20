# Módulos opcionais

Integrações de terceiros **desabilitadas por padrão**, ativáveis apenas pelo Admin (Serviços externos → `system_configs` `modules.*.enabled`).

## Prefixo

```
/api/v1/modules/{module}/...
```

Lista de IDs: ver também [Catálogo de rotas](./routes-catalog).

## Módulos com implementação HTTP

| Módulo | Função | Doc |
|---|---|---|
| `pagarme` | Pagamentos (pedidos/serviços), recipients, webhooks | [pagarme](./modules/pagarme) |
| `soucannabis_orders` | Catálogo/tags/sync de pedidos SC (**requer** `pagarme`) | [soucannabis_orders](./modules/soucannabis_orders) |
| `loggi` | Frete / etiqueta | [loggi](./modules/loggi) |
| `melhorenvio` | Frete Correios / OAuth / etiqueta | [melhorenvio](./modules/melhorenvio) |
| `google_calendar` | Agenda / OAuth / eventos | [google_calendar](./modules/google_calendar) |
| `utalk` | WhatsApp / chat (triagem: sync + transfer) | [utalk](./modules/utalk) |
| `geoapify` | Geocoding / verificação de endereço | [geoapify](./modules/geoapify) |
| `email` | SMTP (envio) | [email](./modules/email) |
| `ciap2` | Status + enable admin | (mínimo; ver código `modules/ciap2`) |

Credenciais compartilhadas: [credentials](./modules/credentials).
Webhooks outbound (Admin): [webhooks](./modules/webhooks).
Sync manual SC: [soucannabis_orders_webhook_sync](./modules/soucannabis_orders_webhook_sync).

## Comportamento se desabilitado

```http
GET /api/v1/modules/loggi/quote
→ 503
```

```json
{
 "data": null,
 "meta": null,
 "errors": [
 {
 "code": "MODULE_DISABLED",
 "message": "Módulo loggi não está ativo nesta instalação"
 }
 ]
}
```

## Ativação

1. **Admin** — Serviços externos → interruptor **Módulo ativo** (`modules.{name}.enabled` em `system_configs`)
2. Credenciais em `system_api_credentials` (ou fallbacks `*_API_KEY` / `SMTP_*` no `.env` quando aplicável)

Sem valor no Admin → módulo **desligado**.

## Autorização

Setup / OAuth / teste / segredo (`oauth/authorize`, `*/test`, webhooks Pagar.me de validação, `outbound-credentials`) exigem sessão **Administrador** ou API key com scope `*`.

Operação de loja (status, checkout, etiqueta, cotação, calendários, sync) exige sessão autenticada e o módulo ligado (`requireModule`). Cotação de frete no carrinho permanece em `/freight/quote`.

## Papéis no frete (quote vs label)

Além de enabled, Loggi e Melhor Envio têm flags em `system_configs` (`system=modules`):

| Key | Default | Uso |
|---|---|---|
| `modules.loggi.use_for_quote` | `false` | Simulação no carrinho |
| `modules.loggi.use_for_label` | `false` | Geração de etiqueta em Pedidos |
| `modules.melhorenvio.use_for_quote` | `false` | Cotação Correios no carrinho |
| `modules.melhorenvio.use_for_label` | `false` | Etiqueta ME |
| `modules.freight.label_provider` | `loggi` | Provider preferido para etiqueta |

## Documentação por módulo

| Módulo | Doc |
|---|---|
| Credenciais (todos) | [modules/credentials](./modules/credentials) |
| `loggi` | [modules/loggi](./modules/loggi) |
| `melhorenvio` | [modules/melhorenvio](./modules/melhorenvio) |
| `geoapify` | [modules/geoapify](./modules/geoapify) |
| `google_calendar` | [modules/google_calendar](./modules/google_calendar) |
| `email` | [modules/email](./modules/email) |
| `pagarme` | [modules/pagarme](./modules/pagarme) |
| `soucannabis_orders` | [modules/soucannabis_orders](./modules/soucannabis_orders) |
| `utalk` | [modules/utalk](./modules/utalk) |
| Webhooks outbound (Admin) | [modules/webhooks](./modules/webhooks) |
