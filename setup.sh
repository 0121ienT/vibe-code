#!/bin/bash

echo "==================================================="
echo "      VibeCode System Setup and Launch Script"
echo "==================================================="
echo ""

# Check if Docker SDK is installed
if ! command -v docker &> /dev/null; then
    echo "[ERROR] Docker is not installed or not in PATH. Please install Docker and start it."
    exit 1
fi

# Check if Docker daemon is running
if ! docker info >/dev/null 2>&1; then
    echo "[ERROR] Docker daemon is not running. Please start Docker and try again."
    exit 1
fi

echo "[OK] Docker is running."

# Check for FastCode config files
if [ ! -f "FastCode/.env" ]; then
    if [ -f "FastCode/env.example" ]; then
        echo "[INFO] Creating FastCode/.env from template..."
        cp "FastCode/env.example" "FastCode/.env"
    else
        echo "[WARNING] FastCode/.env not found and no template exists."
    fi
fi

if [ ! -f "FastCode/nanobot_config.json" ]; then
    echo "[WARNING] FastCode/nanobot_config.json not found. The nanobot service might fail to start correctly."
fi

echo ""
echo "==================================================="
echo "      Starting VibeCode Services via Docker"
echo "==================================================="
echo "[INFO] Pulling images and building containers..."

docker-compose up -d --build

if [ $? -ne 0 ]; then
    echo ""
    echo "[ERROR] Failed to start Docker containers. Check the error messages above."
    exit 1
fi

echo ""
echo "==================================================="
echo "      System started successfully!"
echo "==================================================="
echo ""
echo "You can access the services at the following URLs:"
echo ""
echo "- Vibe Kanban Frontend : http://localhost:3000"
echo "- OmniRoute Dashboard  : http://localhost:20128"
echo "- FastCode API         : http://localhost:8001"
echo "- Nanobot Gateway      : http://localhost:18791 (internal)"
echo ""
echo "To view real-time logs, run: docker-compose logs -f"
echo "To stop the system, run:     docker-compose down"
echo ""
