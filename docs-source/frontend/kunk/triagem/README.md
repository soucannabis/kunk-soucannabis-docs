# Triagem (Reception) — Documentação

> Fila de acolhimento no produto (`apps/kunk` + `apps/admin` + `kunk-api`).
> Schema: tabela `reception`.

## Objetivo

Triagem operacional com:

1. Lógica de fila (lista de `reception`, sidebar de status, redirecionamento para pedidos/serviços)
2. Fila operacional com formulário público configurável; chat externo e afiliados são módulos separados ou fora do produto
3. **Formulário público configurável** no admin (campos padrão + personalizados via `system_configs`)
4. **Status configuráveis** no admin (padrão: Espera + Concluído; demais criados pela associação)
5. **Vínculo automático por e-mail** com associado existente
6. **Módulo opcional** de documentos/dados do associado (desabilitado por padrão)

## Limites do produto

| Item | Detalhe |
|---|---|
| Chat / WhatsApp | Integração opcional via módulo Utalk (serviços externos) |
| Afiliados / `bvid` | Não disponível neste produto |
| Histórico de doações na triagem | Não disponível neste produto |
| Formulário embutido no site WordPress | Substituído por formulário público servido pelo produto (rota/app configurável) |
