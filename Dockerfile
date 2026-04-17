# Use Python 3.11 as the base image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Create a user to match Hugging Face's requirements
RUN useradd -m -u 1000 user

# Set working directory
WORKDIR /app

# Install system dependencies for OpenCV and curl
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install dependencies
COPY --chown=user requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Create Model directory and set permissions
RUN mkdir -p Model && chown -R user:user /app

# Switch to the non-root user
USER user

# PRE-DOWNLOAD THE MODEL (This makes startup instant!)
RUN curl -L -o Model/colorization_deploy_v2.prototxt https://storage.openvinotoolkit.org/repositories/datumaro/models/colorization/colorization_deploy_v2.prototxt && \
    curl -L -o Model/colorization_release_v2.caffemodel https://storage.openvinotoolkit.org/repositories/datumaro/models/colorization/colorization_release_v2.caffemodel && \
    curl -L -o Model/pts_in_hull.npy https://storage.openvinotoolkit.org/repositories/datumaro/models/colorization/pts_in_hull.npy

# Copy the rest of the application code
COPY --chown=user . .

# Expose the Hugging Face standard port
EXPOSE 7860

# Start the application using Gunicorn on port 7860
CMD ["gunicorn", "--bind", "0.0.0.0:7860", "app:app", "--timeout", "120"]
