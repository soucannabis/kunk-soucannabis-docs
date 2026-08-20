# Catálogo de rotas

Inventário canônico alinhado a `kunk-api/src/contract/inventory.js` e `src/routes/`.
Prefixo de todas as rotas de negócio: **`/api/v1`**.

> As páginas deste site de documentação ficam em `/referencia-api/`.
> A API REST responde em `/api/v1/` — caminhos distintos (o menu "API" do site **não** chama a API).

## Envelope

Sucesso:

```json
{ "data": {}, "meta": null, "errors": null }
```

Erro:

```json
{
 "data": null,
 "meta": null,
 "errors": [{ "code": "NOT_FOUND", "message": "Rota não encontrada: GET /…", "details": null }]
}
```

## Autenticação (resumo)

| Cliente | Como |
|---|---|
| Operador (Admin / Kunk / Doc-sign) | Cookie de sessão + header `X-Kunk-App`, ou `Authorization: Bearer` (API token) |
| Associado (cadastro) | Cookie `associate_session` |
| Webhooks Pagar.me | HTTP Basic |
| Pedidos SouCannabis (outbound) | Bearer obtido via client credentials |

Detalhes: [authentication](./authentication) e [authorization](./authorization).

## Auth

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/auth/me` | Retorna o operador autenticado pela sessão do painel. |
| `/api/v1/auth/tokens` | Lista as API keys da instância para administradores. |
| `/api/v1/auth/associate/me` | Retorna o associado autenticado pela sessão de cadastro. |
| `/api/v1/auth/system-invite/preview` | Pré-visualiza um convite de operador a partir do token público. |
| `/api/v1/auth/install-status` | Informa se a instância já foi instalada / estado do bootstrap. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/auth/login` | Autentica operador (`system_users`) e define o cookie de sessão. |
| `/api/v1/auth/logout` | Encerra a sessão atual do operador. |
| `/api/v1/auth/forgot-password` | Solicita e-mail de redefinição de senha do operador (resposta genérica). |
| `/api/v1/auth/reset-password` | Redefine a senha do operador com o token enviado por e-mail. |
| `/api/v1/auth/tokens` | Cria uma API key Bearer (token em plaintext só na criação). |
| `/api/v1/auth/associate/register-email` | Cria a conta do associado na fase 1 e inicia a sessão de cadastro. |
| `/api/v1/auth/associate/login` | Autentica o associado e define o cookie `associate_session`. |
| `/api/v1/auth/associate/logout` | Encerra a sessão do associado. |
| `/api/v1/auth/associate/forgot-password` | Solicita e-mail de redefinição de senha do associado. |
| `/api/v1/auth/associate/reset-password` | Redefine a senha do associado e invalida sessões ativas. |
| `/api/v1/auth/system-invite/accept` | Aceita o convite: define senha e ativa o operador `pending`. |
| `/api/v1/auth/install-schema` | Aplica o schema do banco no fluxo de install da instância. |
| `/api/v1/auth/install` | Conclui o bootstrap da instância (admin inicial / configuração base). |
| `/api/v1/auth/install-sample` | Carrega dados de exemplo para exploração local / seed. |

</details>

<details>
<summary><span class="http-method">PATCH</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/auth/tokens/:id` | Atualiza metadados ou escopos de uma API key existente. |

</details>

<details>
<summary><span class="http-method">DELETE</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/auth/tokens/:id` | Revoga e remove o uso de uma API key. |

</details>

## Collections (`/items`)

<details>
<summary><span class="http-method">CRUD</span></summary>

Métodos `GET`, `POST`, `PATCH` e `DELETE` em `/api/v1/items/:collection` (e `/:id` quando aplicável).

Collections: `files`, `users`, `system_users`, `orders`, `orders_files`, `institutional_clients`, `products`, `professionals`, `reception`, `reports`, `services`, `services_files`, `tags`, `users_api`, `users_files`.

Ver [items](./items), [collections](./collections), [query-parameters](./query-parameters).

</details>

## Users

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/users` | Lista associados com filtros, sort e limit. |
| `/api/v1/users/exists` | Indica se o e-mail já tem conta (none / in_progress / associado). |
| `/api/v1/users/search` | Busca por nome, CPF, e-mail ou telefone. |
| `/api/v1/users/by-code/:user_code` | Busca associado pelo `user_code`. |
| `/api/v1/users/import/fields` | Lista campos aceitos na importação em lote. |
| `/api/v1/users/me/patients` | Lista pacientes do associado autenticado (funil). |
| `/api/v1/users/me/documents/status` | Completude dos documentos de identidade (fase 3). |
| `/api/v1/users/me/extras/status` | Completude de dados extras do funil. |
| `/api/v1/users/:id/patients` | Lista pacientes do associado no painel. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/users/import/validate` | Pré-valida o arquivo de importação de associados. |
| `/api/v1/users/import` | Importa associados em lote. |
| `/api/v1/users` | Cria associado pelo painel/admin. |
| `/api/v1/users/me/patients` | Cria paciente no funil do associado autenticado. |
| `/api/v1/users/me/advance` | Avança a fase do funil se as pré-condições forem atendidas. |
| `/api/v1/users/me/complete` | Finaliza o cadastro e define status Associado. |
| `/api/v1/users/:id/handbook` | Atualiza o prontuário (`handbook`) do associado. |

</details>

<details>
<summary><span class="http-method">PATCH</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/users/me` | Persiste dados parciais do associado autenticado. |
| `/api/v1/users/me/patients/:id` | Atualiza paciente no funil do associado autenticado. |
| `/api/v1/users/:id` | Atualiza dados cadastrais do associado no painel. |

</details>

## Orders

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/orders` | Lista pedidos com filtros e paginação. |
| `/api/v1/orders/facets` | Contagens de facets (status, tags) para filtros da listagem. |
| `/api/v1/orders/status-config` | Configuração de status de pedido da instância. |
| `/api/v1/orders/by-user/:userCode` | Lista pedidos de um associado pelo `user_code`. |
| `/api/v1/orders/stats` | Contagens agregadas de pedidos por status. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/orders` | Cria pedido (itens, totais e baixa de estoque quando aplicável). |
| `/api/v1/orders/bulk` | Aplica ações em lote (status, tags, etiquetas, etc.). |
| `/api/v1/orders/:id/payment` | Registra pagamento ou link/código de pagamento do pedido. |

</details>

<details>
<summary><span class="http-method">PATCH</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/orders/:id` | Atualiza campos editáveis do pedido. |
| `/api/v1/orders/:id/status` | Transiciona o status do pedido (máquina de estados). |
| `/api/v1/orders/:id/production` | Atualiza produção (`production_owner` / finalização). |

</details>

<details>
<summary><span class="http-method">DELETE</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/orders/:id` | Exclui o pedido quando a regra de negócio permitir. |

</details>

## Freight

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/freight/service-options` | Lista opções de frete disponíveis na instância. |
| `/api/v1/freight/default-option` | Retorna a opção de frete padrão configurada. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/freight/quote` | Cotação de frete para o carrinho/pedido. |

</details>

<details>
<summary><span class="http-method">PUT</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/freight/default-option` | Define a opção de frete padrão da instância. |

</details>

## Admin

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/admin/external-services` | Lista serviços externos e estado de ativação. |
| `/api/v1/admin/external-services/:service` | Detalha um serviço externo específico. |
| `/api/v1/admin/external-services/:service/credentials` | Lê metadados das credenciais do serviço (sem secrets em plaintext). |
| `/api/v1/admin/storage` | Configuração atual de armazenamento de arquivos. |
| `/api/v1/admin/storage/branding-migration` | Status da migração de branding entre storages. |
| `/api/v1/admin/sample-data` | Indica se há dados de exemplo instalados. |
| `/api/v1/admin/system-errors/summary` | Totais de erros de sistema em aberto / janelas recentes. |
| `/api/v1/admin/system-errors/top` | Ranking dos erros mais frequentes. |
| `/api/v1/admin/system-errors` | Lista agrupada de erros de sistema. |
| `/api/v1/admin/system-errors/:errorHash/samples` | Amostras de ocorrências de um erro. |
| `/api/v1/admin/web-vitals/summary` | Percentis (p50/p75/p95) das métricas Web Vitals. |
| `/api/v1/admin/web-vitals/series` | Séries temporais de Web Vitals. |
| `/api/v1/admin/web-vitals/by-page` | Agregação de Web Vitals por página. |
| `/api/v1/admin/cache` | Configuração e estado do cache da API. |
| `/api/v1/admin/webhooks/catalog` | Catálogo de eventos disponíveis para webhooks. |
| `/api/v1/admin/webhooks` | Lista webhooks cadastrados. |
| `/api/v1/admin/webhooks/:id/deliveries` | Histórico de entregas de um webhook. |
| `/api/v1/admin/support-credentials` | Credenciais de suporte da instância (metadados). |
| `/api/v1/admin/system-health` | Saúde operacional da instância (deps, jobs, etc.). |
| `/api/v1/admin/schema` | Visão do schema/collections expostas ao admin. |
| `/api/v1/admin/roles` | Lista roles/permissões disponíveis para operadores. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/admin/external-services/:service/test` | Testa conectividade/credenciais do serviço externo. |
| `/api/v1/admin/storage/test` | Testa o backend de storage configurado. |
| `/api/v1/admin/storage/activate` | Ativa a configuração de storage validada. |
| `/api/v1/admin/storage/migrate-branding` | Migra arquivos de branding para o storage ativo. |
| `/api/v1/admin/system-errors/resolve` | Marca erros de sistema como resolvidos. |
| `/api/v1/admin/cache/clear` | Limpa o cache da API (admin). |
| `/api/v1/admin/webhooks` | Cria um webhook outbound. |
| `/api/v1/admin/webhooks/:id/rotate-secret` | Rotaciona o secret de assinatura do webhook. |
| `/api/v1/admin/webhooks/:id/test` | Dispara entrega de teste do webhook. |
| `/api/v1/admin/support-credentials` | Cria ou regenera credenciais de suporte. |

</details>

<details>
<summary><span class="http-method">PATCH</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/admin/external-services/:service` | Atualiza enable/config do serviço externo. |
| `/api/v1/admin/cache` | Atualiza parâmetros do cache. |
| `/api/v1/admin/webhooks/:id` | Atualiza URL, eventos ou estado do webhook. |

</details>

<details>
<summary><span class="http-method">PUT</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/admin/external-services/:service/credentials` | Grava/atualiza credenciais do serviço externo. |
| `/api/v1/admin/storage` | Salva a configuração de storage. |

</details>

<details>
<summary><span class="http-method">DELETE</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/admin/external-services/:service/credentials/:fieldKey` | Remove um campo de credencial do serviço. |
| `/api/v1/admin/sample-data` | Remove dados de exemplo da instância. |
| `/api/v1/admin/webhooks/:id` | Remove um webhook. |
| `/api/v1/admin/support-credentials` | Remove as credenciais de suporte. |

</details>

## Cache e telemetria

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/cache/status` | Status do cache visível ao cliente autenticado. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/cache/clear` | Limpa cache do cliente/sessão (uso operacional). |
| `/api/v1/web-vitals` | Ingere métricas Web Vitals dos frontends. |
| `/api/v1/system-errors` | Ingere erro de sistema reportado pelo cliente. |

</details>

## Services

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/services` | Lista serviços/agendamentos com includes opcionais. |
| `/api/v1/services/by-professional/:id` | Lista serviços de um profissional. |
| `/api/v1/services/exists` | Verifica existência de vínculo associado+profissional. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/services` | Cria serviço/agendamento. |

</details>

<details>
<summary><span class="http-method">PATCH</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/services/:id` | Atualiza dados do serviço. |

</details>

## Reception

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/reception/form-schema` | Schema do formulário público de triagem. |
| `/api/v1/reception/status-counts` | Contagens por status da fila de acolhimento. |
| `/api/v1/reception/attendants` | Lista atendentes disponíveis para a fila. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/reception/public` | Cria lead/triagem anônima pelo formulário público. |
| `/api/v1/reception` | Cria registro de triagem pelo painel. |

</details>

<details>
<summary><span class="http-method">PATCH</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/reception/:id/complete` | Conclui a triagem com motivo de finalização. |
| `/api/v1/reception/:id/attendant` | Atribui ou altera o atendente. |
| `/api/v1/reception/:id/status` | Atualiza o status na fila. |
| `/api/v1/reception/:id/link` | Vincula a triagem a um associado. |
| `/api/v1/reception/:id/unlink` | Remove o vínculo com associado. |

</details>

## Activity

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/activity` | Feed de atividades da instância (escopo do operador). |
| `/api/v1/activity/mine` | Atividades do usuário autenticado. |
| `/api/v1/activity/mine/unread-count` | Contagem de atividades não lidas. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/activity/mine/read` | Marca atividades do usuário como lidas. |

</details>

## Products

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/products/export.csv` | Exporta o catálogo de produtos em CSV. |
| `/api/v1/products/:id/movements` | Histórico de movimentações de estoque do produto. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/products/sync-batches` | Sincroniza lotes de produtos. |
| `/api/v1/products/import/validate` | Pré-valida importação CSV de produtos. |
| `/api/v1/products/import` | Importa/upsert produtos por SKU. |
| `/api/v1/products/:id/stock` | Ajuste manual de estoque (`delta`). |

</details>

<details>
<summary><span class="http-method">PATCH</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/products/:id/batch` | Atualiza dados de lote do produto. |

</details>

## Institutional clients

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/institutional-clients` | Lista clientes institucionais. |
| `/api/v1/institutional-clients/search` | Busca clientes institucionais. |
| `/api/v1/institutional-clients/by-code/:client_code` | Busca pelo código do cliente. |
| `/api/v1/institutional-clients/:id` | Detalha um cliente institucional. |
| `/api/v1/institutional-clients/:id/history` | Histórico vinculado ao cliente. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/institutional-clients` | Cria cliente institucional. |

</details>

<details>
<summary><span class="http-method">PATCH</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/institutional-clients/:id` | Atualiza cliente institucional. |

</details>

<details>
<summary><span class="http-method">DELETE</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/institutional-clients/:id` | Remove cliente institucional quando permitido. |

</details>

## Professionals

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/professionals` | Lista profissionais com filtros de agenda/operação. |

</details>

<details>
<summary><span class="http-method">PATCH</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/professionals/:id/donation-balance` | Ajusta o saldo de doação do profissional. |

</details>

## Reports

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/reports` | Salva definição de relatório. |
| `/api/v1/reports/:id/run` | Executa o relatório (sandbox/regras da instância). |
| `/api/v1/reports/:id/favorite` | Alterna favorito do relatório. |

</details>

## Analytics

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/analytics/associates` | KPIs e séries de associados para o dashboard. |
| `/api/v1/analytics/services` | KPIs e séries de serviços (inclui payable/taxa). |
| `/api/v1/analytics/orders` | KPIs e séries de pedidos. |
| `/api/v1/analytics/reception` | KPIs e séries de triagem/acolhimento. |

</details>

## Tags

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/tags` | Lista tags disponíveis na instância. |

</details>

## System users

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/system-users` | Lista operadores do painel. |
| `/api/v1/system-users/:id` | Detalha um operador. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/system-users` | Cria operador (convite `pending` quando sem senha). |
| `/api/v1/system-users/:id/resend-invite` | Reenvia o e-mail de convite do operador. |

</details>

<details>
<summary><span class="http-method">PATCH</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/system-users/:id` | Atualiza dados e permissões do operador. |

</details>

<details>
<summary><span class="http-method">DELETE</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/system-users/:id` | Remove operador (bloqueia se for o último admin). |

</details>

## Files

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/files` | Lista arquivos com filtros permitidos. |
| `/api/v1/files/:id` | Metadados de um arquivo. |
| `/api/v1/files/:id/download` | Download/proxy do conteúdo do arquivo. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/files` | Faz upload de arquivo. |
| `/api/v1/files/:id/attach` | Anexa o arquivo a uma entidade (users, orders, etc.). |

</details>

<details>
<summary><span class="http-method">DELETE</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/files/:id` | Remove o arquivo. |
| `/api/v1/files/:id/attach` | Remove o vínculo de anexo do arquivo. |

</details>

## Search, health e modules

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/search` | Busca global unificada (associados, pedidos, etc.). |
| `/api/v1/health` | Liveness da API. |
| `/api/v1/modules` | Lista módulos registrados e estado de ativação. |

</details>

## Doc-sign

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/doc-sign/status` | Status do módulo de termos/assinaturas. |
| `/api/v1/doc-sign/templates` | Lista templates de termos. |
| `/api/v1/doc-sign/templates-logos` | Logos disponíveis para templates. |
| `/api/v1/doc-sign/templates/:kind` | Obtém o template de um tipo (`kind`). |
| `/api/v1/doc-sign/templates/:kind/sample-variables` | Variáveis de exemplo para preview do template. |
| `/api/v1/doc-sign/contracts` | Lista contratos/termos gerados. |
| `/api/v1/doc-sign/contracts/me` | Contratos do associado autenticado. |
| `/api/v1/doc-sign/contracts/:id` | Detalha um contrato. |
| `/api/v1/doc-sign/sign/:token` | Carrega a sessão pública de assinatura pelo token. |
| `/api/v1/terms/status` | Alias deprecado de `/doc-sign/status`. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/doc-sign/templates` | Cria template de termo. |
| `/api/v1/doc-sign/templates/reset-defaults` | Restaura templates padrão da instância. |
| `/api/v1/doc-sign/templates/:kind/reset` | Restaura o template de um `kind` ao padrão. |
| `/api/v1/doc-sign/templates/:kind/publish` | Publica o draft do template. |
| `/api/v1/doc-sign/templates/:kind/preview-pdf` | Gera PDF de preview a partir do JSON do template. |
| `/api/v1/doc-sign/contracts` | Gera/envia um contrato para assinatura. |
| `/api/v1/doc-sign/contracts/:id/resend-email` | Reenvia o e-mail do contrato. |
| `/api/v1/doc-sign/sign/:token/view` | Registra visualização do termo (audit). |
| `/api/v1/doc-sign/sign/:token/complete` | Conclui a assinatura com o token público. |
| `/api/v1/terms/contracts` | Alias deprecado de `/doc-sign/contracts`. |

</details>

<details>
<summary><span class="http-method">PUT</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/doc-sign/templates/:kind/draft` | Salva o draft JSON do template. |

</details>

<details>
<summary><span class="http-method">DELETE</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/doc-sign/templates/:kind` | Remove o template customizado do `kind`. |
| `/api/v1/doc-sign/contracts/:id` | Cancela/remove contrato pendente quando permitido. |

</details>

## Config

<details>
<summary><span class="http-method">GET</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/config/public` | Configuração pública para apps (sem secrets). |
| `/api/v1/config/systems` | Lista sistemas/grupos de `system_configs`. |
| `/api/v1/config` | Lista configurações autenticadas. |
| `/api/v1/config/:id` | Obtém uma configuração por id. |

</details>

<details>
<summary><span class="http-method">POST</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/config` | Cria uma entrada de configuração. |
| `/api/v1/config/:id/clear` | Limpa o valor da configuração. |

</details>

<details>
<summary><span class="http-method">PATCH</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/config/:id` | Atualiza valor/metadados da configuração. |

</details>

<details>
<summary><span class="http-method">DELETE</span></summary>

| Path | Descrição |
|---|---|
| `/api/v1/config/:id` | Remove a entrada de configuração. |

</details>

## Módulos

<details>
<summary><span class="http-method">IDs</span></summary>

IDs com implementação HTTP documentada:

- `pagarme`
- `soucannabis_orders`
- `loggi`
- `melhorenvio`
- `google_calendar`
- `utalk`
- `geoapify`
- `ciap2`
- `email`

Prefixo operacional: `/api/v1/modules/{module}/…`

Documentação detalhada: [modules](./modules).

</details>

Códigos de erro da API: [códigos de erro](./error-codes).
