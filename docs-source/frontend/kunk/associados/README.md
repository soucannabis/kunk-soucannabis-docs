# Associados (Cadastramento) — Documentação

> Área de associados / cadastramento no painel (`apps/kunk` + `kunk-api`).
> Funil público (app de cadastramento): [`../../cadastramento/`](../../cadastramento/README.md).
> Search global: [`../search-global/README.md`](../search-global/README.md).

## Objetivo

Área de **associados** com:

1. Layout e visual de `/app/acolhimento/associados`
2. Lista dos **últimos cadastros** + cards/filtros de status do funil de cadastramento
3. Resultados vindos do **search global** (deep link `?a=`)
4. **Modal do associado** com abas (Prescritor; sem aba Parceiro)
5. Edição de dados do associado e pacientes; criação de pacientes
6. Anotações da equipe de acolhimento
7. Documentos via **FileUpload** (`documentKinds` + `users_files`)
8. Histórico de pedidos e serviços
9. UI de **termo de adesão** — ações exibem indisponibilidade enquanto o módulo de termos não estiver ativo
10. Beneficiário do atendimento em Serviços (sem “paciente ativo” global)

## Limites do produto

| Item | Detalhe |
|---|---|
| Assinatura real de termo (app **doc-sign**) | Spec [`../doc-sign/`](../doc-sign/README.md) — UI do painel trata o módulo como indisponível até haver contrato válido |
| Parceiro no modal | Aba só **Prescritor** |
| Afiliados / `bvid` | Não disponível neste produto |
| Chat / WhatsApp | Módulo Utalk (serviços externos), quando ativo |
| Gráficos avançados (`AssociatesChart`, etc.) | Não fazem parte desta área; cards de contagem de status **sim** |
| App público de cadastramento | Documentado em `frontend/cadastramento/` — esta doc é o **painel** |

Docs relacionadas:

| Documento | Conteúdo |
|---|---|
| [`../search-global/README.md`](../search-global/README.md) | FAB + modal de busca global |
| [`../servicos/README.md`](../servicos/README.md) | Serviços — seleção associado/paciente |
| [`../../cadastramento/flow.md`](../../cadastramento/flow.md) | Fases `associate_status` 1–5 |
