# FROM python:3.11-slim
# WORKDIR /app
# COPY . .
# RUN pip install -r requirements.txt
# CMD ["python", "app.py"] 
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Update OS packages to reduce vulnerabilities
RUN apt-get update && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

# Copy only requirements first (better caching)
COPY requirements.txt .

# Install dependencies without cache
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Run application
CMD ["python", "app.py"]