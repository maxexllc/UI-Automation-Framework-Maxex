FROM python:3.11-slim

# System deps that Playwright browsers need
RUN apt-get update && apt-get install -y --no-install-recommends \
    libnss3 libatk-bridge2.0-0 libgtk-3-0 libdrm2 libgbm1 libasound2 \
    libxshmfence1 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libxkbcommon0 \
    ca-certificates curl git unzip && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /work

COPY requirements.txt /work/requirements.txt
RUN pip install --no-cache-dir -U pip && pip install --no-cache-dir -r requirements.txt

# Install Playwright browser binaries (Chromium/Firefox/WebKit)
RUN rfbrowser install

COPY . /work

# Default command runs tests; override with `docker run ... robot ...` if needed
CMD ["bash", "-lc", "robot -d results -v ENV:${ENV:-dev} tests"]
