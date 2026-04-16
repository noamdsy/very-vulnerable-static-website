# NexaCloud — Nuclei Test Target

A deliberately vulnerable static site for testing Nuclei scanner coverage.
Deploy to Azure Static Web Apps, then point Nuclei at the URL.

---

## Expected Nuclei Findings

| Finding | Severity | Template tag | Where |
|---|---|---|---|
| Missing Content-Security-Policy | Medium | misconfig | Every page (no CSP header) |
| Missing X-Frame-Options | Medium | misconfig | Every page |
| Missing X-Content-Type-Options | Low | misconfig | Every page |
| Missing Strict-Transport-Security | Low | misconfig | Every page |
| Missing Permissions-Policy | Info | misconfig | Every page |
| Missing Referrer-Policy | Info | misconfig | Every page |
| Exposed .env file | High | exposure | `/.env` |
| Exposed .git/config | High | exposure | `/.git/config` |
| Exposed DB backup | High | exposure | `/backup/db.sql` |
| Exposed admin panel | Medium | exposure | `/admin/` |
| Exposed JS source map | Low | exposure | `/assets/js/app.js.map` |
| AWS Access Key in body | Critical | token | `index.html` JS block |
| AWS Secret Key in body | Critical | token | `index.html` JS block |
| GitHub token in body | Critical | token | Terminal widget in index.html |
| Stripe live key in body | Critical | token | `index.html` + `.env` |
| SendGrid API key | High | token | `.env` + `app.js` |
| Internal IP disclosure | Medium | exposure | `index.html` + `.env` |
| Email disclosure | Info | exposure | Footer + `.env` |
| robots.txt sensitive path disclosure | Info | exposure | `/robots.txt` |
| Password field autocomplete=on | Low | misconfig | Login form |
| Form without CSRF token | Medium | misconfig | Login form |
| Open redirect (JS) | Medium | redirect | `/?redirect=` |
| Hardcoded creds in HTML comment | High | exposure | `index.html` + `admin/index.html` |

---

## Deploy to Azure Static Web Apps

```bash
# Option 1: Azure CLI
az staticwebapp create \
  --name nuclei-test-target \
  --resource-group your-rg \
  --source . \
  --location westeurope \
  --branch main \
  --app-location "/" \
  --output-location "/"

# Option 2: GitHub Actions (SWA auto-creates workflow)
# Push this folder to a GitHub repo, connect via Azure Portal > Static Web Apps > New
```

---

## Scan commands

```bash
# Full default scan
nuclei -u https://YOUR-SITE.azurestaticapps.net -o results.txt

# Focus on high/critical only
nuclei -u https://YOUR-SITE.azurestaticapps.net -severity high,critical

# Target exposures and misconfigs specifically
nuclei -u https://YOUR-SITE.azurestaticapps.net -tags exposure,misconfig,token

# Include all severity levels for maximum findings
nuclei -u https://YOUR-SITE.azurestaticapps.net -severity info,low,medium,high,critical
```

---

## File structure

```
/
├── index.html                  ← main page (most triggers here)
├── robots.txt                  ← path disclosure
├── .env                        ← exposed secrets
├── .git/config                 ← exposed git config
├── staticwebapp.config.json    ← Azure SWA routing (makes sensitive files accessible)
├── admin/
│   └── index.html              ← exposed admin panel
├── backup/
│   └── db.sql                  ← exposed DB backup
└── assets/
    ├── css/app.css
    └── js/
        ├── app.js              ← more secrets + open redirect
        └── app.js.map          ← exposed source map
```
"# very-vulnerable-static-website for testing scanners" 
