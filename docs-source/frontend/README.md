# Frontends — Visão geral

> Superfícies de UI do produto Kunk.

## Apps do produto

| App | Pasta | Subdomínio | Porta local |
|---|---|---|---|
| **Cadastro de Associados** | `apps/registration/` | `cad.` | 4255 |
| **Assinatura de termos** | `apps/doc-sign/` | `termos.` | 4258 |
| **Kunk** | `apps/kunk/` | `app.` | 4257 |
| **Área Admin** | `apps/admin/` | `admin.` | 4256 |

Cada app é um **entrypoint** independente (build/deploy próprio) e compartilha pacotes do monorepo. Não são produtos nem APIs separados.

O **admin** administra a instância (CRUD de dados, `system_configs`, operadores/permissões). O **Kunk** (`apps/kunk`) é o app operacional (acolhimento, pedidos, etc.). Ver [admin/](./admin/) e [kunk/](./kunk/).

## O que é compartilhado vs. específico

| Compartilhado (`packages/`) | Específico por app |
|---|---|
| Cliente HTTP da `kunk-api` | Rotas e páginas |
| Auth de sessão (cookie) | Fluxos de negócio |
| Tokens de tema / branding da associação | Layout (sidebar de progresso vs. dashboard) |
| Componentes de formulário reutilizáveis | Copy e CTAs |
| Utilitários (máscaras, CPF, telefone) | Integração doc-sign (fase 4 do cadastro) |

## Relação com a API

Todos os apps browser usam:

- Base: `/api/v1`
- Auth: cookie `session_token` (HttpOnly) para operadores; cookie `associate_session` para associados
- Collections e rotas de domínio documentadas em [`../api/`](../api/)

O cadastramento usa **auth de associado** (`users`), distinta da auth de operador (`system_users`) do painel. Ver [cadastramento/api.md](./cadastramento/api.md).

## Índice desta pasta

| Documento | Conteúdo |
|---|---|
| [structure.md](./structure.md) | Estrutura de monorepo e pacotes |
| [**Mapa de funcionalidades**](../funcionalidades/) | Módulos/páginas por app |
| [cadastramento/](./cadastramento/) | App de cadastro de associados |
| [admin/](./admin/) | App de administração da instância |
| [kunk/](./kunk/) | App operacional Kunk |
| [doc-sign/](./doc-sign/) | Termos de adesão e assinaturas |
