# Arquitetura da API

## Objetivo

API REST sobre PostgreSQL, com:

1. Autenticação segura para **frontend** (sessão) e **integrações** (Bearer)
2. CRUD genérico no da API Kunk (`/items/:collection`)
3. Rotas de domínio para regras de negócio
4. Módulos opcionais desligados por padrão

## Diagrama lógico

```
┌─────────┐ ┌──────────────┐ ┌─────────┐ ┌─────────────┐
│ Painel │ │ Cadastramento│ │ Admin │ │ Integrações │
│ (cookie)│ │ (cookie) │ │(cookie +│ │ (Bearer) │
│ │ │ │ │ Admin) │ │ │
└────┬────┘ └──────┬───────┘ └────┬────┘ └──────┬──────┘
 │ │ │ │
 └─────────────┴───────┬──────┴─────────────┘
 ▼
 ┌───────────────────┐
 │ Kunk API /v1 │
 │ auth · items · │
 │ domain · files · │
 │ config · modules │
 └─────────┬─────────┘
 ▼
 ┌───────────────────┐
 │ PostgreSQL │
 │ (schema do produto) │
 └───────────────────┘
```
## Camadas internas

```
routes/ → HTTP (Express/Fastify)
controllers/ → orquestração
services/ → regras de negócio
repositories/ → acesso ao Postgres
middleware/ → auth, RBAC, validação, rate limit
schema/ → whitelist de collections + Zod/Joi
```

## Princípios

1. **Whitelist de collections** — só tabelas do schema do produto são acessíveis via `/items`
2. **Dual auth** — cookie para browser; Bearer para API; nunca misturar
3. **Genérico + domínio** — CRUD simples em `/items`; regras complexas em rotas específicas
4. **Sem SQL livre** — filtros tipados; nunca aceitar SQL do cliente
5. **Permissões por collection/ação** — RBAC explícito
6. **Resposta padronizada** — `{ data, meta, errors }`
7. **Versionamento** — prefixo `/api/v1`
8. **Módulos opt-in** — Loggi, Pagar.me, Calendar, etc. via env/config

## Stack

| Peça | Tecnologia |
|---|---|
| Runtime | Node.js + Express ou Fastify |
| Banco | PostgreSQL + `pg` / Kysely |
| Validação | Zod |
| Senhas / tokens | bcrypt ou argon2 |
| Docs runtime | OpenAPI 3 + Swagger UI |
| Testes | node:test / Vitest |

## O que a API **não** é

- Não replica painéis admin de terceiros (flows, revisions, admin UI)
- Não expõe o schema inteiro do Postgres
- Não substitui o frontend; só a camada de dados/auth

Frontends (cadastramento, admin, painel, termos): ver [`../frontend/`](../frontend/).

## Persistência e lógica de negócio

A API Kunk:

- Usa `NEW_API_DATABASE_URL` (Postgres próprio)
- Usa repositórios SQL nativos
- Mantém, quando fizer sentido, a lógica de negócio já existente (orders, services, auth)
