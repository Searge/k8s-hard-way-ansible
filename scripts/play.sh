#!/usr/bin/env bash
# This script is used to play the ansible playbook with venv activated
set -e

# Change to the project root directory.
cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd
WD=$(pwd)

ARGS=("$@")
export ANSIBLE_CONFIG=./ansible.cfg
PYTHON_PATH=$(which python3)

# Activate the virtual environment
echo "Check if the virtual environment exists..."
if [ ! -d .venv ]; then
  echo "Virtual environment not found."
  echo "Creating virtual environment..."
  task install
fi
echo "Check if the virtual environment is activated..."
if [[ $PYTHON_PATH == *"$WD/.venv"* ]]; then
  echo "Virtual environment is activated."
else
  echo "Activating virtual environment..."
  source .venv/bin/activate
fi

# Run the playbook
ansible-playbook "${ARGS[@]}"
