# Maxex UI Automation — High‑Level Guide (Robot Framework + Playwright)

This repository is a **lightweight starter** for UI tests that use **Robot Framework** with the **Browser library (Playwright)**.
It’s intentionally simple so we can plug in our Maxex URLs, selectors, and credentials and start running smoke tests in minutes.

---

## What we can do with this repo
- Write readable, keyword‑driven tests in `.robot` files.
- Run against **Chromium/Firefox/WebKit** via Playwright.
- Switch **dev / qa / prod** by passing an `ENV` variable.
- Parallelize suites with **Pabot**.
- Get HTML logs, screenshots, and optional videos.
---


## Quick Start (Windows PowerShell)

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1

pip install -U pip
# Option A (no system Node): 
pip install robotframework robotframework-browser[bb] robotframework-pabot pyyaml
rfbrowser install

# Option B (with system Node):
# pip install robotframework robotframework-browser robotframework-pabot pyyaml
# rfbrowser init

# Set environment
$env:MAXEX_USERNAME="you@example.com"
$env:MAXEX_PASSWORD="••••••••"

robot -d results -v ENV:dev tests
# Parallel:
# pabot --processes 4 -d results -v ENV:dev tests
```

---

## Where to edit first
- **Environment files:** `variables/environments/*.yaml` (set `BASE_URL`, `BROWSER`, `HEADLESS`, viewport, video directory).
- **Locators:** `resources/locators/*.yaml` (replace placeholder selectors with real, stable selectors from Maxex).
- **Keywords:** `resources/keywords/` (extend the provided keywords and add feature‑specific ones).
- **Tests:** `tests/` (copy the smoke test and grow suites by feature/module).

---

## Common commands
```bash
# Install Playwright browser binaries (run once per environment/container)
rfbrowser install         # or: rfbrowser init

# Run everything
robot -d results tests

# Run only smoke tests
robot -d results -i smoke tests

# Parallel run
pabot --processes 4 -d results tests
```

---

## Project layout (short)
```text
tests/                       # .robot tests (start with smoke)
resources/keywords/          # higher‑level keywords
resources/locators/          # selectors per page (YAML)
variables/environments/      # dev/qa/prod configs (YAML)
ci/github/workflows/robot.yml
requirements.txt, Dockerfile, Makefile
```

---

## CI & Containers
- **GitHub Actions** workflow provided at `ci/github/workflows/robot.yml`.
- **Dockerfile** builds a runner with the Browser library and Playwright browsers pre‑installed.
  ```bash
  docker build -t maxex/robot-browser .
  docker run --rm -e ENV=dev         -e MAXEX_USERNAME -e MAXEX_PASSWORD         -v "$PWD/results:/work/results" maxex/robot-browser
  ```

---

## Notes
- Python **3.10+** is recommended for recent `robotframework-browser` releases.
- We don’t need `pip install playwright` for this stack; the **Browser** library bundles the Node.js Playwright layer.
- If `rfbrowser` isn’t found, ensure your virtual environment is activated.
- For headless/non‑headless, adjust the YAML env files.
