# Erros

## Envelope

Toda resposta de erro segue:

```json
{
 "data": null,
 "meta": null,
 "errors": [
 {
 "code": "FORBIDDEN",
 "message": "Sem permissão para update em orders",
 "details": null
 }
 ]
}
```

`details` pode carregar campos de validação:

```json
{
 "code": "VALIDATION_ERROR",
 "message": "Payload inválido",
 "details": {
 "email": ["obrigatório"],
 "limit": ["deve ser <= 250"]
 }
}
```

## Códigos

Inventário completo: [códigos de erro](./error-codes).

### Validação de write

Campos fora do schema da collection:

```json
{
 "code": "VALIDATION_ERROR",
 "message": "Campos desconhecidos no payload",
 "details": { "unknown_fields": ["legacy_field", "delivery_problem"] }
}
```

Violação de foreign key (ex.: `professional_id` apontando para UUID inexistente):

```json
{
 "code": "VALIDATION_ERROR",
 "message": "Referência inválida: valor não existe na tabela relacionada",
 "details": {
 "constraint": "fk_services_professional_id",
 "table": "services",
 "detail": "..."
 }
}
```

## Boas práticas

1. Não vazar stack traces em produção
2. Logar `request_id` / correlation id
3. Mensagens em português para o produto BR (ou i18n depois)
4. Mesmo envelope em sucesso e erro (`errors: null` no sucesso)
