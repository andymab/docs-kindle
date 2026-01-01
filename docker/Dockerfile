# Используем Debian-based образ Python
FROM python:3.12-slim

# Устанавливаем необходимые пакеты
RUN apt-get update && apt-get install -y \
    pandoc \
    texlive \
    ca-certificates \
    bash \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем MkDocs и тему Material
RUN pip install --no-cache-dir mkdocs mkdocs-material

# Рабочая директория
WORKDIR /app
