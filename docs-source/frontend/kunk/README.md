# Kunk — App operacional

> Painel operacional da associação (`apps/kunk`, subdomínio `app.`, porta local **4257**).
> Superfície distinta do admin da instância (`admin.`) e do cadastramento público (`cad.`).

## Objetivo

App usado no dia a dia pelos operadores:

1. **Acolhimento** — associados, triagem, clientes institucionais
2. **Loja** — pedidos, carrinho, produtos e frete
3. **Serviços** — atendimentos, profissionais e relatório de serviços
4. **Pagamentos e integrações** — Pagar.me, Pedidos SouCannabis, Loggi/Melhor Envio (opt-in)
5. **Busca e analytics** — busca global no shell e dashboard analítico

Administração da instância (configs globais, operadores, aparência) fica em [`../admin/`](../admin/).

## Módulos

| Módulo | Doc |
|---|---|
| Associados | [associados/](./associados/README.md) |
| Triagem | [triagem/](./triagem/README.md) |
| Pedidos / carrinho | [pedidos/](./pedidos/README.md) · [listagem](./pedidos-listagem/README.md) |
| Pagamentos (Pagar.me / Pedidos SC) | [pagamentos-soucannabis/](./pagamentos-soucannabis/README.md) |
| Serviços | [servicos/](./servicos/README.md) |
| Relatório de serviços | [relatorios-servicos/](./relatorios-servicos/README.md) |
| Analytics | [analytics/](./analytics/README.md) |
| Clientes institucionais | [clientes-institucionais/](./clientes-institucionais/README.md) |
| Search global | [search-global/](./search-global/README.md) |

## Limites deste app

- Administração de `system_configs`, operadores e aparência global → **admin**
- Funil público de cadastro → **cadastramento** (`apps/registration`)
- Assinatura de termos → **doc-sign** (`apps/doc-sign`)
- Integrações de terceiros vêm **desabilitadas por padrão** e só entram quando configuradas na instância
