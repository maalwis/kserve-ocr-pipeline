# syntax=docker/dockerfile:1

FROM python:3.11-slim

# 1. Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    zlib1g-dev \
    libjpeg-dev \
    tesseract-ocr \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 2. Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && mv /root/.local/bin/poetry /usr/local/bin/poetry

# 3. Set working directory
WORKDIR /app
COPY pyproject.toml poetry.lock ./

# 4. Install Python dependencies
RUN poetry config virtualenvs.create false \
    && poetry install --no-root --only main

# 5. Copy model code
COPY model.py ./

# 6. Expose ports
EXPOSE 8080
EXPOSE 8081

# 7. Start service
CMD ["python", "model.py"]
