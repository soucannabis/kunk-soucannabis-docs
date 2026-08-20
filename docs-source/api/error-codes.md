# Códigos de erro

Inventário dos valores usados em `errors[].code` nas respostas da API.

Formato do envelope e boas práticas: [errors](./errors).

| Código | Descrição |
|---|---|
| `VALIDATION_ERROR` | Payload ou query inválidos (campos, formato, FK ou regras de validação). |
| `UNAUTHORIZED` | Sem sessão/token ou credencial inválida/expirada. |
| `FORBIDDEN` | Autenticado, mas sem permissão para a ação ou recurso. |
| `NOT_FOUND` | Recurso solicitado não existe. |
| `UNKNOWN_COLLECTION` | Collection fora da whitelist de `/items`. |
| `CONFLICT` | Estado incompatível com a operação (status, unicidade, regra de negócio). |
| `RATE_LIMITED` | Limite de tentativas/requisições excedido. |
| `MODULE_DISABLED` | Módulo opt-in desligado nesta instância. |
| `INTERNAL_ERROR` | Erro inesperado no servidor. |
| `INVALID_CREDENTIALS` | E-mail ou senha incorretos no login. |
| `USER_INACTIVE` | Usuário/operador inativo e não pode autenticar. |
| `AUTH_CONFLICT` | Conflito de canal de autenticação (ex.: Bearer e cookie no mesmo request). |
| `ACCOUNT_EXISTS` | Já existe conta de associado para o e-mail informado. |
| `ACCOUNT_IN_PROGRESS` | Cadastro já iniciado para o e-mail (funil em andamento). |
| `PHASE_LOCKED` | Fase do funil bloqueada; pré-condições não atendidas. |
| `TERMS_MODULE_IN_DEVELOPMENT` | Módulo de termos ainda não disponível nesta instância. |
| `CONTRACT_ALREADY_COMPLETED` | Contrato/termo já foi assinado e não pode ser alterado. |
| `CONTRACT_NOT_PENDING` | Contrato não está pendente de assinatura. |
| `TOKEN_INVALID` | Token (reset, convite ou assinatura) inválido ou expirado. |
| `SIGNATURE_REQUIRED` | Assinatura obrigatória não foi enviada. |
| `CONSENT_REQUIRED` | Consentimento obrigatório não foi aceito. |
| `TEMPLATE_NOT_PUBLISHED` | Template de termo ainda não publicado. |
| `TEMPLATE_INVALID_VARIABLES` | Variáveis do template inválidas ou incompletas. |
| `PDF_RENDER_FAILED` | Falha ao gerar o PDF a partir do conteúdo do termo. |
| `LAST_ADMIN` | Operação bloquearia a remoção do último administrador. |
| `ALREADY_INSTALLED` | Instância já foi instalada; bootstrap não pode repetir. |
| `CONFIG_ERROR` | Configuração da instância inválida ou inconsistente. |
| `TOTAL_MISMATCH` | Totais do pedido não conferem com os itens/cálculo. |
| `INSUFFICIENT_STOCK` | Estoque insuficiente para concluir a operação. |
| `PRODUCT_NOT_FOUND` | Produto informado não foi encontrado. |
| `CONFIG_INCOMPLETE` | Configuração necessária incompleta para a operação. |
| `CREDENTIAL_MISSING` | Credencial de serviço externo ausente. |
| `CREDENTIAL_INVALID` | Credencial de serviço externo inválida. |
| `FREIGHT_NO_QUOTE` | Nenhuma cotação de frete disponível para o pedido. |
| `LABEL_NOT_ALLOWED` | Geração/cancelamento de etiqueta não permitido no estado atual. |
| `OAUTH_REQUIRED` | É necessário concluir OAuth do provedor externo. |
| `SCHEDULING_DISABLED` | Agendamento por calendário está desabilitado. |
| `CALENDAR_NOT_CONFIGURED` | Agenda Google não configurada para o profissional/serviço. |
| `CALENDAR_NOT_FOUND` | Agenda Google não encontrada. |
| `CALENDAR_FORBIDDEN` | Sem permissão para acessar a agenda Google. |
| `EVENT_NOT_FOUND` | Evento de calendário não encontrado. |
| `EVENT_DATE_CONFIRMATION_REQUIRED` | Confirmação de data do evento é obrigatória. |
| `GOOGLE_API_ERROR` | Erro genérico na API do Google Calendar. |
| `GOOGLE_VALIDATION_ERROR` | Dados inválidos enviados à API do Google Calendar. |
| `GOOGLE_CONFLICT` | Conflito de horário/evento na agenda Google. |
| `WEBHOOK_TEST_FAILED` | Falha ao testar a entrega do webhook outbound. |
