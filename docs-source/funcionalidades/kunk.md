# Kunk — mapa de funcionalidades

> App operacional (`apps/kunk`, porta **4257**). Roles staff: Administrador, Acolhimento, Produção (+ portal Profissional).
> Índice: [README.md](./README.md)

**Auth:** operador (`system_users`).

## Auth e páginas públicas

| Módulo | Página | Descrição |
|---|---|---|
| Login | `/login` | Entrada de operador |
| Nova senha | `/nova-senha` | Reset de senha |
| Convite operador | `/cadastro` | Aceite de invite |
| Portal profissional | `/relatorio/servicos` | Relatório do próprio profissional |
| Formulário público | `/contato` | Formulário de triagem / contato |
| Não autorizado | `/unauthorized` | Sem permissão de página |
| Não conectado | `/not-connected` | Sem sessão / offline |

## Acolhimento

| Módulo | Página | Descrição |
|---|---|---|
| Associados | `/app/acolhimento/associados` | Lista e edição de associados |
| Serviços | `/app/acolhimento/servicos` | Agenda / serviços |
| Triagem | `/app/acolhimento/triagem` | Fila e atendimento |
| Clientes institucionais | `/app/acolhimento/clientesinstitucionais` | Empresas / CNPJ |

## Loja

| Módulo | Página | Descrição |
|---|---|---|
| Pedidos | `/app/loja/pedidos` | Listagem, status, bulk, rastreio |
| Novo pedido (carrinho) | `/app/loja/novo-pedido` | Carrinho, frete, totais |
| Produtos | `/app/loja/produtos` | Catálogo, estoque, import CSV |

## Profissionais e relatórios

| Módulo | Página | Descrição |
|---|---|---|
| Profissionais | `/app/profissionais` | Cadastro e saldo de doação |
| Dashboard analytics | `/app/relatorios/dashboard` | Gráficos operacionais |
| Relatório de serviços | `/app/relatorios/servicos` | Serviços / payable |

## Sistema

| Módulo | Página | Descrição |
|---|---|---|
| Histórico | `/app/historico` | Activity / auditoria leve |
| Tags | `/app/tags` | Etiquetas reutilizáveis |

## Shell e transversais

| Módulo | Página | Descrição |
|---|---|---|
| Menu / sidebar | `/app/*` | Seções e permissões por role |
| Busca global | (header) | Search multi-entidade |
| Limpar cache | (sidebar) | Invalidação de cache do app |
| Storage cloud | (uploads) | Upload com bucket ativo |
| Web Vitals / error boundary | (transversal) | Telemetria e falhas UI |
| Rotas / redirect por role | (router) | Home conforme papel |

## Redirect de compatibilidade

| De | Para |
|---|---|
| `/app/prescritores` | `/app/profissionais` |
