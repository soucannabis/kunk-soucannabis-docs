# kunk-api — mapa de módulos e serviços

> Backend REST (`kunk-api`, base `/api/v1`).
> Índice: [README.md](./README.md) · Spec detalhada: [`../api/`](../api/)

## Domínio (rotas)

| Módulo | Rota principal | Descrição |
|---|---|---|
| Health | `/health` | Liveness |
| Auth operador | `/auth` | Login, me, tokens, logout, reset |
| Auth associado | `/auth/associate` | Funil de cadastro |
| Config | `/config` | `system_configs` |
| Items CRUD | `/items/:collection` | CRUD genérico whitelist |
| Users | `/users` | Associados / pacientes |
| Orders | `/orders` | Pedidos, status, bulk, facets |
| Freight | `/freight` | Cotação de frete |
| Products | `/products` | Produtos, estoque, import |
| Services | `/services` | Serviços / agenda |
| Reception | `/reception` | Triagem pública e staff |
| Institutional clients | `/institutional-clients` | Clientes CNPJ |
| Professionals | `/professionals` | Profissionais |
| Reports | `/reports` | Relatórios salvos |
| Analytics | `/analytics` | Agregados do dashboard |
| Tags | `/tags` | Etiquetas |
| System users | `/system-users` | Operadores |
| Files | `/files` | Upload / download / attach |
| Search | `/search` | Busca global |
| Doc-sign | `/doc-sign` | Templates, contratos, sign |
| Terms | `/terms` | Status / bridge do cadastro |
| Activity | `/activity` | Histórico do sistema |
| System errors | `/system-errors` | Report de erros (apps) |
| Web vitals | `/web-vitals` | Report de métricas |
| Cache | `/cache` | Flag / clear operacional |

## Admin

| Módulo | Rota | Descrição |
|---|---|---|
| Schema / roles | `/admin/schema`, `/admin/roles` | Meta para UI Admin |
| External services | `/admin/external-services` | Credenciais e enable |
| Storage | `/admin/storage` | Drivers local/S3/GCS |
| Sample data | `/admin/sample-data` | Limpeza de fixtures |
| System errors | `/admin/system-errors` | Triagem de erros |
| Web vitals | `/admin/web-vitals` | Consulta agregada |
| Cache | `/admin/cache` | Admin do memory cache |
| Webhooks | `/admin/webhooks` | Endpoints outbound + outbox |

## Módulos externos (`/modules`)

| Módulo | Status | Descrição |
|---|---|---|
| Listagem / flags | ativo | Enable por módulo |
| pagarme | implementado | Checkout, webhooks, split |
| soucannabis_orders | implementado | Sync e outbound de pedidos |
| loggi | implementado | Cotação / etiqueta |
| melhorenvio | implementado | Cotação / OAuth / etiqueta |
| geoapify | implementado | Validação de endereço |
| google_calendar | implementado | Eventos / OAuth |
| utalk | implementado | WhatsApp / triagem |
| ciap2 | implementado | Status / catálogo |
| email | config / indisponível sem SMTP | Envio SMTP |

## Serviços internos (amostra)

| Serviço | Descrição |
|---|---|
| `ordersService` / `orderTotals` / `orderStatusesService` | Pedidos e totais |
| `productsService` / `stockService` | Produtos e estoque |
| `servicesService` / `servicesReportsService` | Serviços e relatório |
| `receptionService` | Triagem |
| `webhooks` (emit/worker/dispatch) | Outbound configurável + outbox |
| `usersService` / `registrationService` | Associados / funil |
| `systemUsersService` | Operadores |
| `itemsService` + parsers (filter/sort/fields) | CRUD genérico |
| `searchService` / `analyticsService` / `reportsService` | Busca e analytics |
| `docSign*` | Termos / PDF |
| `freight*` / `storeFreightConfig` | Frete |
| `pagarme/*` | PSP |
| `soucannabis_orders/*` | Pedidos SC |
| `geoapify/*` | Endereço |
| `google_calendar/*` | Agenda |
| `utalk/*` | WhatsApp |
| `loggi/*` / `melhorenvio/*` | Frete carriers |
| `email/*` | Templates SMTP |
| `systemErrorsService` | Observabilidade |
| `webVitalsService` | Web Vitals |
| `institutionalClientsService` | Institucionais |
| `credentialsService` | Secrets |
| `professionalTypesConfig` | Tipos profissional |
| `storageAdminService` / `cacheAdminService` | Admin infra |
| `sampleDataService` | Sample data |
| `activityService` | Histórico |
| `ciap2Config` | CIAP-2 |
| `systemInviteService` / `professionalPortalAccess` | Convite / portal |
| `linkGuards` / `recipientContact` / `orderAddressTracking` | Auxiliares pedido |

## Storage

| Driver | Descrição |
|---|---|
| local | Disco local |
| s3 | AWS S3 / compatível |
| gcs | Google Cloud Storage |

## Cache

| Peça | Descrição |
|---|---|
| `memoryCache` | TTL em memória |
| Rotas admin/operacionais | Enable / clear |
