# syntax=docker/dockerfile:1

FROM python:3.11-alpine

# 1. System preparation: update & install build‐time and runtime dependencies
RUN apk update && \
    apk add --no-cache \
    build-base \
    libffi-dev \
    zlib-dev \
    jpeg-dev \
    curl && \ 
    rm -rf /var/cache/apk/*

# 2. Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && mv /root/.local/bin/poetry /usr/local/bin/poetry

# 3. Create and switch to the application directory
WORKDIR /app
COPY pyproject.toml poetry.lock ./

# 4. Install only the gateway’s Python dependencies
RUN poetry config virtualenvs.create false \
    && poetry install --no-root --only main

# 5. Copy the FastAPI application code
COPY api-gateway.py ./

# 6. Declare the port the gateway listens on
EXPOSE 8001

# 7. Default command: start Uvicorn with our FastAPI app
CMD ["uvicorn", "api-gateway:app", "--host", "0.0.0.0", "--port", "8001"]
