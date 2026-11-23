#!/usr/bin/env bash
set -e

# Go to the repository root
cd "$(dirname "$0")"

echo "Setting up CDSpecCollab..."

# Check Python version via pyenv
if ! command -v pyenv >/dev/null 2>&1; then
    echo "Error: pyenv is not installed."
    exit 1
fi

export PYENV_VERSION=3.10.22

if [[ "$(python --version)" != "Python 3.10.22" ]]; then
    echo "Error: Python 3.10.22 is required."
    exit 1
fi

# Create virtual environment if it does not exist
if [[ ! -d ".venv" ]]; then
    python -m venv .venv
fi

# Check the virtual environment Python version
if [[ "$(.venv/bin/python --version)" != "Python 3.10.22" ]]; then
    echo "Error: The virtual environment must use Python 3.10.22."
    echo "Please remove .venv and run $0 again."
    exit 1
fi

# Activate virtual environment
source .venv/bin/activate

# Upgrade pip and install application dependencies
python -m pip install --upgrade pip
python -m pip install -r cd_spec_viewer_web/requirements.txt

# Verify Django is installed before starting
if ! python -m django --version >/dev/null 2>&1; then
    echo "Error: Django failed to install properly."
    exit 1
fi

echo "CDSpecCollab setup complete."
echo "----------------------------------------"

# Move to the Django application directory
cd cd_spec_viewer_web

echo "Starting CDSpecCollab..."
echo "Open http://127.0.0.1:8000 in your browser."
echo "Press Ctrl+C to stop the server."

python manage.py runserver 0.0.0.0:8000
