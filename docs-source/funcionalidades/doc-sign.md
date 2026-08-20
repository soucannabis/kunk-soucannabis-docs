# Doc-sign — mapa de funcionalidades

> Termos e assinaturas nativos (`apps/doc-sign`, porta **4258**).
> Índice: [README.md](./README.md)

**Auth:** operador Administrador (gestão); assinatura pública por token.

## Gestão (admin)

| Módulo | Página | Descrição |
|---|---|---|
| Login | `/login` | Entrada Administrador |
| Nova senha | `/nova-senha` | Reset operador |
| Lista de termos | `/termos` | Contratos emitidos |
| Detalhe do termo | `/termos/:id` | Ver / reenviar termo |
| Auditoria | `/termos/:id/audit` | Log de visualização/assinatura |
| Modelos | `/modelos` | Templates `self` / `with_patient` |
| Editor TipTap | `/modelos/:kind` | Editar e publicar modelo |

## Assinatura (público)

| Módulo | Página | Descrição |
|---|---|---|
| Assinar | `/assinar/:token` | Draw / type / upload + concluir |

## Transversais

| Módulo | Página | Descrição |
|---|---|---|
| Storage cloud | (anexos / PDF) | Upload com bucket ativo |
| Web Vitals / error boundary | (transversal) | Telemetria e falhas UI |

## Redirects

| De | Para |
|---|---|
| `/contratos` | `/termos` |
| `/contratos/:id` | `/termos/:id` |
