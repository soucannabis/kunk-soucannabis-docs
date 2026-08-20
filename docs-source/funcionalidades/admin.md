# Admin — mapa de funcionalidades

> Administração da instância (`apps/admin`, porta **4256**). Role **Administrador**.
> Índice: [README.md](./README.md)

**Auth:** operador (`system_users`).

## Dados

| Módulo | Página | Descrição |
|---|---|---|
| Registros (CRUD) | `/dados`, `/dados/:collection` | CRUD nas collections whitelist |
| Item novo/editar | `/dados/:collection/novo`, `…/:id` | Formulário de registro |
| Arquivos | `/arquivos`, `/arquivos/:id` | Listar / ver arquivos |
| Dados de exemplo | `/dados` (painel) | Excluir sample data |

## Configurações do sistema

| Módulo | Página | Descrição |
|---|---|---|
| Variáveis | `/configs`, `/configs/:system` | `system_configs` por sistema |
| Cache (atalho) | `/configs/cache` | Mesma tela de cache |
| Armazenamento | `/armazenamento` | Driver local / S3 / GCS |
| Cache | `/cache` | Ligar/desligar cache operacional |
| Aparência | `/aparencia` | Logo, título, cores do Kunk |

## Kunk

| Módulo | Página | Descrição |
|---|---|---|
| Configuração de profissionais | `/kunk/configuracao-profissionais` | Taxas / preço padrão / relatório |
| Permissões de acesso | `/kunk/permissoes` | Quais páginas cada role vê |
| CIAP-2 | `/kunk/ciap2` | Catálogo / módulo CIAP-2 |

## Loja

| Módulo | Página | Descrição |
|---|---|---|
| Status dos pedidos | `/loja/status-pedidos` | Labels / fluxo de status |

## Webmaster

| Módulo | Página | Descrição |
|---|---|---|
| Operadores | `/usuarios`, `/usuarios/novo`, `/usuarios/:id` | CRUD `system_users` |
| Credenciais de suporte | `/credenciais-suporte` | Conta temporária de suporte |
| API | `/acesso-api` | Tokens Bearer |
| Webhooks | `/webhooks` | URLs outbound por tabela/ação |
| Erros do sistema | `/erros-sistema` | Grupos de `system_errors` |
| Web Vitals | `/web-vitals` | Métricas Core Web Vitals |

## Triagem (config)

| Módulo | Página | Descrição |
|---|---|---|
| Índice triagem | `/triagem` | Hub de config |
| Formulário público | `/triagem/formulario` | Campos e publicação |
| Status da fila | `/triagem/status` | Status customizados |
| Módulos | `/triagem/modulos` | Docs/dados do associado |

## Serviços externos

| Módulo | Página | Descrição |
|---|---|---|
| Índice | `/servicos-externos` | Lista e enable de módulos |
| Envio (Dados de envio) | `/servicos-externos/envio` | Remetente, caixa, declaração |
| Loggi | `/servicos-externos/loggi` | Credenciais e teste |
| Melhor Envio | `/servicos-externos/melhorenvio` | OAuth e cotação |
| Validador de endereço | `/servicos-externos/geoapify` | Validação de endereço (Geoapify) |
| Google Calendar | `/servicos-externos/google_calendar` | OAuth e calendários |
| E-mail | `/servicos-externos/email` | SMTP / templates |
| Pagar.me | `/servicos-externos/pagarme` | PSP, webhooks, split |
| Pedidos SouCannabis | `/servicos-externos/soucannabis_orders` | Sync externo de pedidos |
| Utalk | `/servicos-externos/utalk` | WhatsApp / triagem |

## Auth / guards

| Módulo | Página | Descrição |
|---|---|---|
| Login | `/login` | Entrada Administrador |
| Nova senha | `/nova-senha` | Reset operador |
| Sem permissão | `/sem-permissao` | Bloqueio de não-admin |
| Storage cloud (upload) | (arquivos / probe) | Upload com bucket ativo |
| Web Vitals / error boundary | (transversal) | Telemetria e falhas UI |
