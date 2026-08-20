# Kunk API — Documentação

> Especificação da **API REST** do Kunk open source (`kunk-api/`).
> Camada de dados, autenticação e módulos opcionais do produto.

## Site vs API (importante)

| O quê | URL |
|---|---|
| **Estas páginas de documentação** (HTML Starlight) | `https://kunksoucannabis.ong.br/referencia-api/…` |
| **API REST** (JSON) | `https://{host-da-api}/api/v1/…` |

O menu **API** deste site aponta para `/referencia-api/`.
Chamadas HTTP à API usam sempre o prefixo **`/api/v1`**. Não são o mesmo caminho.

## Índice

| Documento | Conteúdo |
|---|---|
| [Catálogo de rotas](./routes-catalog.md) | Inventário método + path (auth, domínio, items, módulos) |
| [architecture.md](./architecture.md) | Visão geral, camadas, princípios |
| [authentication.md](./authentication.md) | Sessão (frontend) + Bearer (API) |
| [authorization.md](./authorization.md) | RBAC, roles, permissões por collection |
| [items.md](./items.md) | CRUD genérico `/items/:collection` |
| [query-parameters.md](./query-parameters.md) | `filter`, `sort`, `fields`, `limit`, `meta` |
| [collections.md](./collections.md) | Collections permitidas e notas de domínio |
| [domain-routes.md](./domain-routes.md) | Rotas de negócio (orders, services, auth…) |
| [doc-sign.md](./doc-sign.md) | Termos e assinaturas nativos |
| [files.md](./files.md) | Upload, download e metadados de arquivos |
| [files-cloud-storage.md](./files-cloud-storage.md) | Drivers local / S3 / GCS + migração + lock |
| [storage-s3-setup.md](./storage-s3-setup.md) | Bucket S3 privado + IAM |
| [storage-gcs-setup.md](./storage-gcs-setup.md) | Bucket GCS privado + service account |
| [modules.md](./modules.md) | Módulos opcionais |
| [modules/credentials.md](./modules/credentials.md) | `system_api_credentials` + política de secrets |
| [modules/loggi.md](./modules/loggi.md) | Cotação, etiqueta, teste Loggi |
| [modules/melhorenvio.md](./modules/melhorenvio.md) | Cotação Correios, OAuth, etiqueta |
| [modules/pagarme.md](./modules/pagarme.md) | Checkout, recipients, webhooks, split |
| [modules/soucannabis_orders.md](./modules/soucannabis_orders.md) | Cliente API externa SC + sync |
| [modules/utalk.md](./modules/utalk.md) | WhatsApp / triagem |
| [modules/email.md](./modules/email.md) | SMTP |
| [modules/geoapify.md](./modules/geoapify.md) | Geocoding |
| [modules/google_calendar.md](./modules/google_calendar.md) | Agenda |
| [modules/webhooks.md](./modules/webhooks.md) | Webhooks outbound (Admin) |
| [errors.md](./errors.md) | Formato de erros e códigos |
| [system-errors.md](./system-errors.md) | Observabilidade (`system_errors`) |
| [web-vitals.md](./web-vitals.md) | Core Web Vitals |
| [cache.md](./cache.md) | Memory cache operacional |
| [openapi.yaml](./openapi.yaml) | Esboço OpenAPI 3.0 (também em `/openapi.yaml` no site) |

## Base URL (API)

```
https://{host}/api/v1
```

Local (Docker / npm do monorepo):

```
http://localhost:4250/api/v1
```

## Autenticação (resumo)

| Cliente | Método | Header / Cookie |
|---|---|---|
| Painéis (browser) | Sessão | Cookie HttpOnly + `X-Kunk-App` |
| Integrações / scripts | API token | `Authorization: Bearer <token>` |
| Associado (cadastro) | Sessão | Cookie `associate_session` |

Detalhes: [authentication.md](./authentication.md).

## Envelope JSON

```json
{ "data": {}, "meta": null, "errors": null }
```

Erro:

```json
{
 "data": null,
 "meta": null,
 "errors": [{ "code": "NOT_FOUND", "message": "…", "details": null }]
}
```

## Princípios

- PostgreSQL nativo
- API REST padronizada (`/api/v1`)
- Módulos de terceiros desabilitados por padrão

## Código e testes

```bash
cd kunk-api && npm test
```

Monorepo: [soucannabis/kunk-soucannabis](https://github.com/soucannabis/kunk-soucannabis).
