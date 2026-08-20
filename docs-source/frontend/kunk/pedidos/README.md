# Pedidos / Carrinho — Documentação

> Checkout e loja no produto (`apps/kunk` + `apps/admin` + `kunk-api`).

## Objetivo

Fluxo de **novo pedido** com:

1. Lógica e layout do carrinho (associado, catálogo, itens, soma, prescritor, **desconto + doação**, pagamento personalizado, histórico)
2. **Sem** cupons, checkbox de comissão, seleção de parceiros e auto-tag de frete
3. **Simulação de frete** via facade, com modalidades e favorito
4. **Admin → Loja** (remetente, caixa, declaração compartilhada, frete no total, favorito)
5. **Admin → Serviços externos** (enable, quote/label, credenciais com teste)
6. **Create** com total validado no server (`TOTAL_MISMATCH` se divergir)

## Limites do produto

| Item | Detalhe |
|---|---|
| Cupons no checkout | Não disponível neste produto |
| Checkbox `no_commission` | Não disponível neste produto |
| Parceiros / afiliados | Não disponível neste produto |
| Rota pública `/cart` sem auth | Unificado em `/app/loja/novo-pedido` autenticado |
| Pagar.me no create do carrinho | Pagamento **pós-pedido** via PaymentModal — [`../pagamentos-soucannabis/`](../pagamentos-soucannabis/README.md) |
| Sync Pedidos SouCannabis | [`../pagamentos-soucannabis/`](../pagamentos-soucannabis/README.md) (create remoto só após pago) |
| Etiqueta no momento do create do pedido | Continua na página Pedidos |

Docs de API dos módulos:

| Documento | Conteúdo |
|---|---|
| [`../../api/modules/loggi.md`](../../api/modules/loggi.md) | Cotação, etiqueta, cancelamento, teste Loggi |
| [`../../api/modules/melhorenvio.md`](../../api/modules/melhorenvio.md) | Cotação Correios, etiqueta, OAuth, teste ME |
| [`../../api/modules/credentials.md`](../../api/modules/credentials.md) | Tabela `system_api_credentials` + assistente |
| [`../pagamentos-soucannabis/README.md`](../pagamentos-soucannabis/README.md) | Pagar.me + Pedidos SouCannabis (pagamento, split, catálogo SC) |
