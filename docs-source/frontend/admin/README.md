# Admin — Documentação do app

> Painel de **administração da instância** (dados, configs e operadores).
> Superfície distinta do painel operacional (`app.`) e do cadastramento (`cad.`).
> Faz parte da mesma instalação unificada — mesma API, mesmo banco, porta/subdomínio próprios.

## Objetivo

App de administração que permite à associação (ou ao operador com papel admin):

1. **Editar dados do banco** — CRUD completo nas collections da whitelist, navegação por FKs, visualização de arquivos
2. **Gerir `system_configs`** — variáveis e configurações de todos os sistemas da instância, agrupadas por `system`
3. **Gerir operadores e permissões** — criar, editar e excluir `system_users`; definir roles (`permissions`)
4. **Configurar triagem** — formulário público, statuses e módulos (ver [`../kunk/triagem/`](../kunk/triagem/README.md))
5. **Aparência do Kunk** — logo, título, tema (`/aparencia`)
6. **Loja e serviços externos** — frete no carrinho, enable Loggi/Melhor Envio, assistente de API keys (ver [`../kunk/pedidos/`](../kunk/pedidos/README.md))

## Limites do produto (neste app)

- Fluxos operacionais de acolhimento, produção, pedidos, etc. → isso é o **painel** (`apps/kunk` / `app.`)
- Funil público de associados → **cadastramento** (`apps/registration` / `cad.`)
- Assinatura de termos → **doc-sign** (`apps/doc-sign` / `termos.`)
- Flows, revisions e SQL livre do cliente → não disponíveis neste produto
