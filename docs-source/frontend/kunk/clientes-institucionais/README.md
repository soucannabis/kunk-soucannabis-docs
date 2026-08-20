# Clientes institucionais — Documentação

> Cadastro de clientes que **não são associados** mas podem fazer pedidos (outras associações / empresas / pessoas).
> Página: `/app/acolhimento/clientesinstitucionais` · tabela `institutional_clients`.

## Objetivo

1. Tabela própria (não subset de `users`)
2. Empresa opcional + representante com CPF sempre obrigatório
3. Pedidos e etiquetas com CNPJ (empresa) ou CPF (pessoa)
4. Página CRUD no painel Kunk + novo pedido via `?ic=`

## Limites do produto

- Login/portal próprio do cliente institucional — não disponível
- Triagem / serviços / acolhimento para este tipo de cliente — não disponível
- Importação automática de bases externas — não faz parte do produto
