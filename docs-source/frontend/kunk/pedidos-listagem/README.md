# Pedidos — listagem

> Página `/app/loja/pedidos` no Kunk operacional — listagem em cards, filtros, bulk e etiquetas Loggi/Melhor Envio.

## Funcionalidades

| Área | Detalhe |
|---|---|
| Layout | Cards, seleção, paginação, cores `#5a7a5b` |
| Facets | Contagem de status + tags (sob demanda) |
| Filtros | busca, status, tags, datas (criação/pagamento) |
| Toggle pagamento | Aguardando ↔ Pagamento concluído + `payment_date` |
| Bulk | status, tags add/remove, gerar/cancelar etiqueta Loggi e ME, relatório de produção PDF |
| Status config | `store.order_statuses` (seed: 2 system) + Admin Loja |

## Limites do produto

- Etiquetas de frete nesta tela: Loggi e Melhor Envio (quando os módulos estão ativos)
- Cupom e comissão de prescritor não fazem parte desta listagem
