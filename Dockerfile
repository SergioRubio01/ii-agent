# Use Python 3.10 as required by the project
FROM tiangolo/uvicorn-gunicorn-fastapi:python3.10

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the proxy server application
COPY proxy_server/ ./proxy_server/

# Install additional dependencies needed by the proxy server
RUN pip install --no-cache-dir aiohttp

# Set environment variables
ENV PYTHONPATH=/app

# Expose port 8000
EXPOSE 8000

# Override the default CMD from the base image to directly run our app
CMD ["uvicorn", "proxy_server.main:app", "--host", "0.0.0.0", "--port", "8000"] 