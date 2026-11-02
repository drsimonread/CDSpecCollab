#!/usr/bin/env bash
set -e

# Go to the repository root
cd "$(dirname "$0")"

echo "Setting up CDSpecCollab..."

# Check Python version
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
    echo "Please remove .venv and run ./setup.sh again."
    exit 1
fi

# Activate virtual environment
source .venv/bin/activate

# Upgrade pip
python -m pip install --upgrade pip

# Install application dependencies
python -m pip install -r cd_spec_viewer_web/requirements.txt

echo "CDSpecCollab setup complete."
echo "To start the application, run ./start.sh"
