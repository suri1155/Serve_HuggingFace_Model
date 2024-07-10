# Stage 1: Build Dependencies (slim Python image)
FROM python:3.12-slim AS builder

# Set working directory for clarity
WORKDIR /app

# Copy requirements.txt for dependency installation
COPY requirements.txt ./

# Install dependencies without cache
RUN pip install --no-cache-dir -r requirements.txt

# Copy your application source code
COPY . .

# Stage 2: Create final image (slim Python image)
FROM python:3.12-slim

# Set working directory for clarity
WORKDIR /app

# Copy the installed dependencies from the builder stage
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy the compiled application code from the builder stage
COPY --from=builder /app /app

# Expose the application port
EXPOSE 80

# Command to run the application (using uvicorn)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]

# Optional: Add labels for identification (if needed)
LABEL authors="Sur"
