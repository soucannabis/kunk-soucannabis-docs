# Cadastramento — mapa de funcionalidades

> App público de onboarding do associado (`apps/registration`, porta **4255**).
> Índice: [README.md](./README.md)

**Auth:** sessão de associado (`users`).

## Módulos / páginas

| Módulo | Página | Descrição |
|---|---|---|
| Cadastro (e-mail) | `/cadastro` | Criar conta de associado |
| Login | `/login` | Entrar na sessão |
| Nova senha | `/nova-senha` | Reset de senha |
| Shell / home | `/` | Redirect conforme fase |
| Bem-vindo | `/bem-vindo` | Fase 1 — boas-vindas |
| Dados do responsável | `/cadastro-associado` | Fase 1–2 — formulário do associado |
| Dados do paciente | `/cadastro-paciente` | Fase 2 — paciente / vínculo |
| Documentos | `/documentos` | Fases 3–4 — RG/CNH, comprovantes, termos |
| Consulta | `/consulta` | Fase 5 — receita / conclusão |
| Cadastro concluído | `/cadastro-concluido` | Tela final do funil |
| Guards de fase | (todas autenticadas) | Redireciona conforme `associate_status` |
| Storage cloud | `/documentos` (upload) | Upload com bucket ativo |
| Web Vitals | (transversal) | Envio de métricas ao backend |
| Erros de sistema | (boundary) | Captura e reporte de falhas UI |

## Serviços de API usados (referência)

Ver [kunk-api.md](./kunk-api.md).

| Serviço | Uso no app |
|---|---|
| Auth associado | register / login / reset / me |
| Users (me / patients) | formulários do funil |
| Files | upload de documentos |
| Doc-sign / terms | fase 4 (redirect / status) |
| Web vitals | telemetria |
| System errors | boundary |
