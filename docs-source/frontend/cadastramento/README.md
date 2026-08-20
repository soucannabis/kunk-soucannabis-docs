# Cadastramento — Documentação do app

> Cadastro público de associados (`apps/registration`, subdomínio `cad.`).

## Objetivo

Fluxo de inscrição de associados com:

1. Etapas, status, paciente, documentos e consulta alinhados ao funil de fases 1–5
2. Campos do schema do produto
3. API `kunk-api` (`/api/v1`)
4. Estrutura compatível com painel e termos (ver [`../structure.md`](../structure.md))

## Limites deste app

- Não inclui o painel interno completo de acolhimento (há alinhamento mínimo às fases 1–5)
- Assinatura de termos: na fase 4 o cadastro informa que o módulo está indisponível até a assinatura via [doc-sign](../doc-sign/); ver [flow.md](./flow.md) e [api.md](./api.md)
- Não inclui loja / pedidos
