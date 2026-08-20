---
title: Variáveis de ambiente
description: Variáveis de ambiente da API, dos apps Vite e do deploy SPA.
---

A API lê `kunk-api/.env`. Cada frontend em `apps/*` lê o próprio `.env` (prefixo Vite `VITE_*`). Em produção, as `VITE_*` entram no **build** da SPA; na API, as variáveis ficam no ambiente do processo.

Mínimo para subir em local: Postgres (`PG_URL` ou `PG*`), `PORT` na API, e em cada app `VITE_API_URL` + `VITE_URL`. O restante depende dos módulos e do branding da instância.

Veja também [instância](/configuracao/instancia/), [deploy](/instalacao/deploy/) e o [`.env.example` da API](https://github.com/SouCannabis/kunksoucannabis-open/blob/main/kunk-api/.env.example). Detalhes de módulos: [API → Módulos](/referencia-api/modules/).

## Precedência de valores

- **Credenciais de módulos** (`system_api_credentials`) e **branding** (`system_configs`): o Admin/banco tem prioridade; a variável de ambiente só entra se o valor no banco estiver vazio. Ativação de módulos é sempre pelo Admin → Serviços externos.
- **Bootstrap Vite** (`VITE_API_URL`, `VITE_URL`): só build/runtime do frontend — **não** vêm do banco.
- Demais envs da API (Postgres, `PUBLIC_API_URL`, `CONFIG_ENCRYPT_KEY`, etc.): só ambiente do processo (e defaults do código).

---

## API (`kunk-api/.env`)

### Banco e processo

| Variável | Uso |
|---|---|
| `PG_URL` | Connection string completa do PostgreSQL. Preferida quando disponível. |
| `PGHOST`, `PGPORT`, `PGUSER`, `PGPASSWORD`, `PGDATABASE` | Alternativa a `PG_URL`: a API monta a URL se as partes estiverem definidas. `PGPORT` default `5432`. |
| `PORT` | Porta HTTP da API (default `8056`; no Docker unificado costuma ser `4250`). |
| `HOST` | Interface de bind (default `0.0.0.0`). |
| `NODE_ENV` | Ambiente Node (`development`, `production`, `test`). Afeta mensagens de erro, cookies e custo de hash de senha. |

### Sessão e CORS

| Variável | Uso |
|---|---|
| `COOKIE_SECURE` | Se `true`/`1`, cookies de sessão exigem HTTPS. Em produção o default é ligado quando a env está vazia. |
| `SESSION_MAX_HOURS` | Duração máxima da sessão em horas (default `168` = 7 dias). |
| `CORS_ORIGIN` | Allowlist de `Origin` do browser (lista separada por vírgula). Vazio ou omitido = CORS desligado. Apps oficiais chamam `/api/v1` no próprio host via proxy e em geral **não** precisam desta env; use só se um front externo falar com a URL pública da API. |

### URLs públicas

Usadas em callbacks OAuth, webhooks e links de e-mail (reset de senha, convites, termos). Sem barra final.

| Variável | Uso |
|---|---|
| `PUBLIC_API_URL` | URL pública da API. Obrigatória em produção. Callbacks OAuth (Google, Melhor Envio) usam **só** este valor — nunca `Host` / `X-Forwarded-Host`. Alias legado: `API_PUBLIC_URL`. |
| `PAGARME_WEBHOOK_PUBLIC_URL` | Override opcional só para webhooks Pagar.me quando a URL pública do webhook difere de `PUBLIC_API_URL`. Precisa ser alcançável pela internet (não localhost). |
| `KUNK_PUBLIC_URL` | URL pública do app operacional. Links em e-mails e convites. Alias: `PUBLIC_APP_URL`. Default local `http://localhost:4257`. |
| `ADMIN_PUBLIC_URL` | URL pública do Admin. Default local `http://localhost:4256`. |
| `REGISTRATION_PUBLIC_URL` | URL pública do cadastramento. Alias: `CADASTRO_PUBLIC_URL`. Default local `http://localhost:4255`. |
| `DOC_SIGN_PUBLIC_URL` | URL pública do doc-sign (assinatura de termos). Fallback na API: `VITE_DOC_SIGN_URL`. Default local `http://localhost:4258`. |

### Segurança e criptografia

| Variável | Uso |
|---|---|
| `CONFIG_ENCRYPT_KEY` | Chave mestra AES-256-GCM para valores sensíveis em `system_configs` e `system_api_credentials`. **Nunca** gravar no banco. Necessária em produção se houver secrets persistidos. |
| `SYSTEM_INVITE_SECRET` | Segredo para assinar tokens de convite (Admin / portal profissional). Se vazio, cai em `SESSION_SECRET` e depois em fallbacks internos. |
| `SESSION_SECRET` | Fallback de assinatura quando `SYSTEM_INVITE_SECRET` não está definido. |
| `ASSOCIATION_NAME` | Nome curto da associação no lado da API (e-mails de teste SMTP, convites, alguns textos). Preferível alinhar com o branding do Admin. |
| `AUTH_ENUM_RATE_LIMIT` | Liga rate limit em rotas públicas sensíveis a enumeração (exists, register-email, triagem, falhas de login). Default ligado; `0`/`false` desliga (útil em e2e local). |

### Armazenamento de arquivos

Também configurável no Admin → Armazenamento. Env serve de default/fallback.

| Variável | Uso |
|---|---|
| `STORAGE_PATH` | Diretório local de arquivos quando o driver é `local` (default `./storage`). |
| `FILES_DRIVER` | Driver ativo: `local` (default), `s3` ou `gcs`. |
| `FILES_KEY_PREFIX` | Prefixo das chaves/objetos no bucket (default `kunk/`). |
| `S3_BUCKET` | Nome do bucket S3 (ou compatível). |
| `S3_REGION` | Região S3 (default `us-east-1`). |
| `S3_ACCESS_KEY_ID` | Access key; também fallback da credencial `storage_s3`. |
| `S3_SECRET_ACCESS_KEY` | Secret key; também fallback da credencial `storage_s3`. |
| `GCS_BUCKET` | Bucket Google Cloud Storage. |
| `GCS_PROJECT_ID` | Project ID do GCP. |
| `GCS_CLIENT_EMAIL` | E-mail da service account; fallback da credencial `storage_gcs`. |
| `GCS_PRIVATE_KEY` | Private key PEM (`\n` escapados); fallback `storage_gcs`. |
| `GCS_CREDENTIALS_JSON` | JSON completo da service account (alternativa a e-mail + key). |

### Fallbacks de módulos externos

A ativação do módulo é só pelo Admin. As envs abaixo preenchem `system_api_credentials` quando o campo correspondente no banco está vazio. Documentação operacional: [módulos](/referencia-api/modules/).

#### Pagar.me

| Variável | Uso |
|---|---|
| `PAGARME_SECRET_KEY` | Chave secreta da API v5. Alias legado: `PAGARME_TOKEN`. |
| `PAGARME_PUBLIC_KEY` | Chave pública (checkout / front). |
| `PAGARME_URL_API` | Base URL da API (default `https://api.pagar.me/core/v5`). |
| `PAGARME_WEBHOOK_USER` | Usuário HTTP Basic do webhook — o mesmo cadastrado no painel Pagar.me. |
| `PAGARME_WEBHOOK_PASS` | Senha HTTP Basic do webhook. |

#### Loggi

| Variável | Uso |
|---|---|
| `LOGGI_CLIENT_ID` | OAuth client_id. |
| `LOGGI_CLIENT_SECRET` | OAuth client_secret. |
| `LOGGI_COMPANY_ID` | Company id Loggi. |
| `LOGGI_URL_API` | Base URL da API Loggi. |
| `LOGGI_TOKEN_URL` | URL do token OAuth. |
| `LOGGI_EXTERNAL_SERVICE_IDS` | Lista CSV de SISUs Loggi quando a config de frete no Admin estiver vazia. |

#### Melhor Envio

| Variável | Uso |
|---|---|
| `MELHOR_ENVIO_CLIENT_ID` | OAuth client_id. |
| `MELHOR_ENVIO_CLIENT_SECRET` | OAuth client_secret. |
| `MELHOR_ENVIO_REDIRECT_URI` | Redirect URI do OAuth (a API também deriva a partir de `PUBLIC_API_URL`). |
| `MELHOR_ENVIO_API_URL` | Base URL da API Melhor Envio. |
| `MELHOR_ENVIO_ENVIRONMENT` | `production` (padrão) ou `sandbox`. |
| `MELHOR_ENVIO_USER_AGENT` | User-Agent nas chamadas HTTP (default genérico com contato da associação). |

#### Geoapify

| Variável | Uso |
|---|---|
| `GEOAPIFY_API_KEY` | Chave da API de geocoding. |

#### Google Calendar

| Variável | Uso |
|---|---|
| `GOOGLE_CLIENT_ID` | OAuth Client ID. |
| `GOOGLE_CLIENT_SECRET` | OAuth Client Secret. |
| `GOOGLE_REDIRECT_URI` | Redirect do callback; opcional — a API grava a partir de `PUBLIC_API_URL`. |
| `GOOGLE_REFRESH_TOKEN` | Refresh token após o fluxo OAuth (access token fica só no banco). |

#### E-mail (SMTP)

| Variável | Uso |
|---|---|
| `SMTP_HOST` | Servidor SMTP. |
| `SMTP_PORT` | Porta (ex.: `587` ou `465`). |
| `SMTP_SECURE` | TLS implícito (`true` tipicamente na 465). |
| `SMTP_USER` | Usuário SMTP. |
| `SMTP_PASS` | Senha SMTP. |
| `SMTP_FROM` | Remetente (`From`). |
| `SMTP_FROM_NAME` | Nome exibido do remetente. |

#### Utalk

| Variável | Uso |
|---|---|
| `UTALK_API_TOKEN` | Bearer de um usuário da organização (chats/transfer no OSS). |
| `UTALK_ORG_ID` | ID da organização Umbler Utalk. |
| `UTALK_FROM_PHONE` | Telefone do canal no formato `+55…`. |
| `UTALK_API_URL` | Base URL da API Utalk. |

#### SouCannabis Orders

| Variável | Uso |
|---|---|
| `SOUCANNABIS_ORDERS_BASE_URL` | Base URL do serviço de pedidos SouCannabis. |
| `SOUCANNABIS_ORDERS_CLIENT_ID` | OAuth client_id. |
| `SOUCANNABIS_ORDERS_CLIENT_SECRET` | OAuth client_secret. |
| `SOUCANNABIS_ORDERS_TOKEN_URL` | URL de obtenção do token. |

### Operação (backup e install)

Uso interno de scripts/containers; raramente necessárias no dia a dia local.

| Variável | Uso |
|---|---|
| `PG_DUMP_PATH` | Caminho do binário `pg_dump` para backups. |
| `PSQL_PATH` | Caminho do binário `psql` (imagem Docker da API já define um default). |
| `SCHEMA_SQL_PATH` | Caminho alternativo do SQL de schema no fluxo de install. |

---

## Frontends (Vite)

### Comum a todos os apps

Arquivo típico: `apps/<app>/.env` (veja `.env.example` quando existir). Em produção as `VITE_*` são **embutidas no build**.

| Variável | Uso |
|---|---|
| `VITE_API_URL` | Base da API no browser. Default `/api/v1` (mesmo host + proxy). Bootstrap: não vem do Admin. |
| `VITE_URL` | URL pública deste app (links absolutos, cookies de contexto). Bootstrap: não vem do Admin. |
| `VITE_API_PROXY_TARGET` | Só desenvolvimento/Docker: destino do proxy Vite para a API (ex.: `http://localhost:8056` ou `http://kunk-api:4250` no compose unificado). |

### `apps/registration` (cadastramento · :4255)

Arquivo de referência: `apps/registration/.env.example`.

| Variável | Uso |
|---|---|
| `VITE_DOC_SIGN_URL` | URL do doc-sign para redirecionar assinatura de termos. |
| `VITE_KUNK_URL` / `VITE_KUNK_PUBLIC_URL` | URL do app Kunk (links de consulta/contato). |
| `VITE_CONTACT_URL` | URL externa ou rota de contato (ex.: agendar consulta). |
| `VITE_ASSOCIATION_NAME` | Nome curto da associação na UI. |
| `VITE_ASSOCIATION_FULL_NAME` | Razão social / nome completo. |
| `VITE_ASSOCIATION_EMAIL` | E-mail de contato exibido. |
| `VITE_ASSOCIATION_PHONE` | Telefone de contato. |
| `VITE_ASSOCIATION_SITE` | Site institucional. |
| `VITE_ASSOCIATION_CNPJ` | CNPJ exibido onde aplicável. |
| `VITE_ASSOCIATION_CITY` / `VITE_ASSOCIATION_STATE` | Cidade e UF da associação. |
| `VITE_ASSOCIATION_LOGO` | Logo principal (path ou URL). |
| `VITE_ASSOCIATION_LOGO_MENU` | Logo do menu (fallback: logo principal). |
| `VITE_ASSOCIATION_LOGO_SIZE` | Tamanho CSS do logo (ex.: `180px`). |
| `VITE_ASSOCIATION_LOGO_SQUARE` / `VITE_ASSOCIATION_LOGO_RECTANGULAR` | Variantes de asset do logo. |
| `VITE_ASSOCIATION_LOGO_FORMAT` | Formato ativo: `square` ou `rectangular`. |
| `VITE_ASSOCIATION_LOGO_PLACEMENTS` | Onde cada formato aparece (serializado). |
| `VITE_WELCOME_TEXT` | Texto de boas-vindas do funil. |
| `VITE_COMPLETION_TEXT` | Texto da tela de conclusão. |
| `VITE_SHOW_TRIAGE_BUTTON` | Exibe botão de triagem (`true`/`1`/`yes`). |
| `VITE_TRIAGE_FORM_URL` | URL do formulário/fluxo de triagem. |

A maior parte do branding acima pode ser gerida no Admin (`system_configs`, system `registration`) sem redeploy; a env cobre bootstrap e desenvolvimento local.

### `apps/admin` (Admin · :4256)

Arquivo de referência: `apps/admin/.env.example` (bootstrap mínimo).

| Variável | Uso |
|---|---|
| `VITE_API_URL` / `VITE_URL` | Ver seção comum. |
| `VITE_KUNK_URL` / `VITE_KUNK_PUBLIC_URL` | Usadas em fluxos que precisam abrir/apontar o app Kunk (ex.: configuração de triagem). |

Configs de aparência e serviços ficam no próprio Admin (banco), não em um conjunto grande de envs deste app.

### `apps/kunk` (painel operacional · :4257)

Não há `.env.example` dedicado hoje; o mínimo é o bootstrap comum. Tema/aparência também resolve via Admin (`system=kunk`) com fallback nestas envs:

| Variável | Uso |
|---|---|
| `VITE_KUNK_TITLE` | Título do app. |
| `VITE_KUNK_LOGO` | Logo do painel. |
| `VITE_KUNK_BG_MODE` | Modo de fundo (`color`, `image`, etc., conforme o tema). |
| `VITE_KUNK_BG_COLOR` / `VITE_KUNK_BG_IMAGE` | Cor ou imagem de fundo. |
| `VITE_KUNK_MENU_BG` / `VITE_KUNK_MENU_TEXT` | Cores do menu lateral. |
| `VITE_KUNK_MENU_HOVER_BG` / `VITE_KUNK_MENU_HOVER_TEXT` | Hover do menu. |
| `VITE_KUNK_DEFAULT_THEME` | Tema inicial (`dark` / `light`). |
| `VITE_KUNK_DARK_BG` / `VITE_KUNK_DARK_PRIMARY` / `VITE_KUNK_DARK_ACCENT` / `VITE_KUNK_DARK_ACCENT_HOVER` | Tokens do tema escuro. |
| `VITE_KUNK_LIGHT_BG` / `VITE_KUNK_LIGHT_PRIMARY` / `VITE_KUNK_LIGHT_ACCENT` / `VITE_KUNK_LIGHT_ACCENT_HOVER` | Tokens do tema claro. |

### `apps/doc-sign` (termos · :4258)

Arquivo de referência: `apps/doc-sign/.env.example`.

| Variável | Uso |
|---|---|
| `VITE_API_URL` / `VITE_URL` | Ver seção comum. |
| `VITE_REGISTRATION_URL` | Origem permitida/retorno para o cadastramento após assinatura. |
| `VITE_KUNK_URL` / `VITE_KUNK_PUBLIC_URL` | Origens alternativas de retorno para o painel Kunk. |

---

## Deploy SPA

Imagem em `deploy/spa`: build Vite + nginx.

| Variável | Momento | Uso |
|---|---|---|
| `VITE_API_URL`, `VITE_URL`, `VITE_DOC_SIGN_URL`, `VITE_KUNK_URL`, `VITE_REGISTRATION_URL`, `VITE_CONTACT_URL`, `VITE_ASSOCIATION_NAME`, `VITE_ASSOCIATION_LOGO`, `VITE_ASSOCIATION_LOGO_MENU`, `VITE_ASSOCIATION_LOGO_SIZE` | **Build** (args / variáveis do serviço) | Embutidas no bundle no `npm run build`. |
| `PORT` | **Runtime** | Porta em que o nginx escuta (default `8080`). |
| `KUNK_API_PUBLIC_HOST` | **Runtime** | Host público da API usado no template nginx para proxy de `/api` (sem esquema). |

No Docker de desenvolvimento unificado (`docker-compose.kunk.yml`), os apps recebem `VITE_API_PROXY_TARGET=http://kunk-api:4250` e a API publica `PUBLIC_API_URL` / `CORS_ORIGIN` conforme o compose.

---

## Testes (Playwright)

Variáveis `E2E_*`, `DEMO_*` e afins existem apenas nas suítes Playwright dos apps. Não são necessárias para rodar a aplicação localmente ou em produção.
