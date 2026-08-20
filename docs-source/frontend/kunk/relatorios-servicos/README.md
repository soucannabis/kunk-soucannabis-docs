# Relatórios de serviços — Documentação

> Relatório de **serviços** (comissões / valores a pagar a profissionais) no produto (`apps/kunk` + `apps/admin` + `kunk-api`).
> Relatório de pedidos (`reportOrders`) **não** faz parte desta área.

## Objetivo

Fluxo de **relatório de serviços** com:

1. Layout e visual da página (filtros mês/profissional, agrupamento, tabela, cores)
2. Listagem **completa** dos serviços com status `Pagamento Concluído`, organizada por **mês** da data de atendimento (`consultation_date`)
3. Filtro por profissional e totais de **valor a receber** para fechamento de pagamento
4. Conta de **usuário do sistema** por profissional (role `Profissional`) com acesso **somente** ao relatório dos próprios dados
5. **Contestações** visíveis no portal do profissional e no painel interno (staff)
6. **Taxas por tipo** + flag **descontar doação** no admin (defaults: fee 0, doação não desconta)
7. Catálogo de **tipos** + **valor padrão de consulta** por tipo
8. **Criar conta** em `/app/profissionais` com convite (link expirável → `/cadastro`); envio de e-mail quando o módulo SMTP estiver ativo
9. Role `Profissional` **nunca** acessa outras páginas do Kunk — só o relatório de pagamento

## Limites do produto

| Item | Detalhe |
|---|---|
| Relatório de pedidos | Não disponível nesta área — só serviços |
| Cupons no portal do profissional | Não disponível neste produto |
| Recipients Pagar.me nesta tela | Pagamento — módulo separado |
| Mensagens automáticas ao resolver contestação | Módulo de chat externo (quando configurado) |
| Bônus por tags | Não disponível; usa só taxa por tipo |
| Relatórios custom / dashboards (`reports` collection) | Outro módulo |

Docs relacionadas:

| Documento | Conteúdo |
|---|---|
| [`../servicos/README.md`](../servicos/README.md) | Serviços + profissionais (origem dos dados) |
| [`../../admin/flow.md`](../../admin/flow.md) | Admin — rotas de tipos/taxas |

Rotas: staff `/app/relatorios/servicos` · portal `/relatorio/servicos`.

## Exemplo de política customizada

| Tipo | `association_fee` | Efeito |
|---|---|---|
| `medic` | `20` | Consulta R$ 220 → pagar R$ 200 |
| `therapist` | `10` | Consulta R$ 110 → pagar R$ 100 |

Sem configurar taxas, consulta R$ 220 → pagar R$ 220.
