# Estrutura frontend (multi-app)

> Organização do código de UI para **todas** as superfícies do Kunk
> (cadastramento, admin, painel, termos).

## Princípios

1. **Um repositório de produto** — apps e pacotes no mesmo tree.
2. **Apps finos, pacotes gordos** — lógica de API, auth, tema e forms reutilizáveis ficam em `packages/`.
3. **Deploy por subdomínio** — cada app gera um artefato estático (ou SSR mínimo) servido em host distinto; todos apontam para a mesma API.
4. **Schema no cliente** — nomes de campo do schema do produto (`associate_name`, `associate_cpf`, etc.).
5. **Branding por env** — logo, nome, cores e URLs de contato via variáveis; o código não hardcoda SouCannabis além de defaults de exemplo.

## Árvore

```
├── apps/
│ ├── registration/ # Cadastramento (cad.) · :4255
│ ├── admin/ # Admin da instância (admin.) · :4256
│ ├── kunk/ # Painel operacional (app.) · :4257
│ └── doc-sign/ # Termos/assinaturas (termos.) · :4258
├── packages/
│ ├── api-client/ # fetch tipado → kunk-api /v1
│ ├── auth-session/ # login/logout/me, UserProvider genérico
│ ├── ui/ # inputs, alerts, layout primitives
│ ├── forms/ # CPF, telefone, CEP, CIAP2, nationality…
│ ├── theme/ # CSS variables + tokens por associação
│ └── config/ # schema Zod das envs públicas (VITE_*)
├── kunk-api/ # API unificada
├── docs/ # documentação técnica
└── …
```

### Nomes

| Pasta | Subdomínio | Porta dev | Nome de produto |
|---|---|---|---|
| `apps/registration` | `cad.` | 4255 | Cadastramento |
| `apps/admin` | `admin.` | 4256 | Admin da instância |
| `apps/kunk` | `app.` | 4257 | Painel Kunk (operacional) |
| `apps/doc-sign` | `termos.` | 4258 | Gerenciador de termos / assinaturas |

Os nomes em inglês nas pastas evitam acentos em paths; a UI e a docs permanecem em português.

## Responsabilidade de cada pacote

### `packages/api-client`

- Base URL, `credentials: 'include'`, envelope `{ data, meta, errors }`
- Helpers tipados para `/users`, `/files`, `/auth/*`
- Sem conhecimento de rotas de página

### `packages/auth-session`

- `login` / `logout` / `me`
- Contexto React opcional (ou hook) consumido por registration, admin e kunk
- Distinguir **tipo de sessão**: `associate` (`users`) vs `operator` (`system_users`) — ver [`../api/authentication.md`](../api/authentication.md)
- No admin: após `me`, gate por role `Administrador`

### `packages/ui` + `packages/forms`

- Componentes sem acoplamento rígido a um único kit de UI
- O cadastramento pode usar Bootstrap; o painel pode manter MUI
- Forms compartilhados (CPF, telefone, CIAP2) devem ser headless ou com skin mínima

### `packages/theme`

- CSS variables: `--color-bg`, `--color-nav`, `--color-cta`, logos
- Carregadas a partir de `packages/config` / env da associação

### `packages/config`

- Lista canônica de `VITE_*` públicas
- **Proibido** embutir API keys ou chaves de criptografia no bundle

## Cookie cross-subdomain

Para sessão compartilhada entre `cad.` e `app.` (quando fizer sentido):

| Atributo | Valor |
|---|---|
| `Domain` | `.exemplo.ong.br` (raiz da associação) |
| `Path` | `/` |
| `HttpOnly` | `true` |
| `Secure` | `true` (produção) |
| `SameSite` | `Lax` |

CORS da API deve listar as origens dos apps (`cad.`, `admin.`, `app.`, `termos.`). Detalhes: [`../api/authentication.md`](../api/authentication.md).
