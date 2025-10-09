FROM python:3.9-slim

# Install system utilities required by Nextflow
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*

# Install Biopython
RUN pip install --no-cache-dir biopython

WORKDIR /data
