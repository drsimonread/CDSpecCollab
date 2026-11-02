#!/usr/bin/env bash
set -e

# Go to the repository root
cd "$(dirname "$0")"

# Check that setup has been completed
if [[ ! -f ".venv/bin/activate" ]]; then
    echo "Error: Virtual environment not found."
    echo "Please run ./setup.sh first."
    exit 1
fi

# Activate virtual environment
source .venv/bin/activate

# Check that Django is installed
if ! python -m django --version >/dev/null 2>&1; then
    echo "Error: Django is not installed."
    echo "Please run ./setup.sh first."
    exit 1
fi

# Move to the Django application directory
cd cd_spec_viewer_web

echo "Starting CDSpecCollab..."
echo "Open http://127.0.0.1:8000 in your browser."
echo "Press Ctrl+C to stop the server."

python manage.py runserver 0.0.0.0:8000
