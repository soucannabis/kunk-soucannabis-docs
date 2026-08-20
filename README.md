# Kunk — site de documentação

Site oficial: **[https://kunksoucannabis.ong.br/](https://kunksoucannabis.ong.br/)**

Site institucional e documentação pública do **Kunk** (Astro + Starlight).

Código do produto: [soucannabis/kunk-soucannabis](https://github.com/soucannabis/kunk-soucannabis).

## Desenvolvimento

```bash
npm install
npm run dev
```

Abre em [http://localhost:4260](http://localhost:4260):

- CSS / páginas em `src/` → HMR
- Markdown em `docs-source/` → sync automático + reload
- Docs curadas em `src/content/docs/{introducao,instalacao,...}` → reload direto

## Sync da documentação técnica

```bash
npm run sync-docs
```

Copia `api/`, `frontend/` e `funcionalidades/` de `docs-source/` para o content layer do Starlight.

## Deploy

Build Docker na raiz (`Dockerfile` + `railway.json`). Healthcheck: `/health`.

Produção: [https://kunksoucannabis.ong.br/](https://kunksoucannabis.ong.br/).
