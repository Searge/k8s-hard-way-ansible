# Provisioning of Kubernetes the hard way with Ansible

This repository contains an Ansible playbook to provision a Kubernetes cluster the hard way.
The hard way is a manual way to provision a Kubernetes cluster, as described by Kelsey Hightower in his repository [kelseyhightower/kubernetes-the-hard-way](https://github.com/kelseyhightower/kubernetes-the-hard-way).

## Prerequisites

### Working with `uv`

```bash
uv venv -p $(cat .python-version) # Create a virtual environment
source .venv/bin/activate # Activate the virtual environment
uv pip install -r requirements.txt # Install the requirements
```
