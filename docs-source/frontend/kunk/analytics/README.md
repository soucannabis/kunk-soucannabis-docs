# Analytics Dashboard — Documentação

> Página **Relatórios → Dashboard** no Kunk (`apps/kunk`), com agregação no `kunk-api`.
> **Não disponível neste produto:** embeds de afiliados/financeiro externo e dashboards SQL editáveis (`reports` collection).

## Objetivo

Visão geral institucional com KPIs e gráficos de:

- Associados
- Serviços
- Pedidos
- Triagem

## Rota e menu

| Item | Valor |
|---|---|
| Path | `/app/relatorios/dashboard` |
| Menu | Relatórios → Dashboard (`relatorios-dashboard`) |
| Página | `apps/kunk/src/pages/analytics/AnalyticsDashboardPage.jsx` |
| Auth | Staff Kunk (`RequireKunkStaff`) + `authorize('reports', 'read')` na API |

## Stack

- Front: MUI + **Recharts**
- Back: SQL agregado (`date_trunc`, `COUNT`, `SUM`, `GROUP BY`)
- Blocos declarativos em `analyticsLayout.js` (padrão KPI / chart / ranking)
