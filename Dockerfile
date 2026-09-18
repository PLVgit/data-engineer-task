FROM ghcr.io/astral-sh/uv:0.12.15-python3.12-trixie-slim

ENV PYTHONUNBUFFERED=1 \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    DUCKDB_PATH=/app/warehouse/staffing.duckdb

WORKDIR /app

COPY pyproject.toml uv.lock README.md ./
COPY src ./src
RUN uv sync --frozen --no-dev

COPY dbt_project.yml profiles.yml ./
COPY models ./models
COPY tests ./tests
COPY data ./data

RUN mkdir -p /app/warehouse

CMD ["sh", "-c", "uv run --no-sync ingest-staffing --database \"$DUCKDB_PATH\" && uv run --no-sync dbt build --profiles-dir . && uv run --no-sync dbt show --profiles-dir . --select project_staffing --limit 100 --output json"]
