# Provisioning of Kubernetes the hard way with Ansible

[![OpenSSF best practices badge](https://www.bestpractices.dev/projects/8684/badge)](https://www.bestpractices.dev/en/projects/8684)

This repository contains an Ansible playbook to provision a Kubernetes cluster the hard way.
And based on these two repositories:

- [kelseyhightower/kubernetes-the-hard-way](https://github.com/kelseyhightower/kubernetes-the-hard-way)
- [mmumshad/kubernetes-the-hard-way](https://github.com/mmumshad/kubernetes-the-hard-way)

But for a better understanding of the material, I decided to redo everything in my own way.

## Prerequisites

### Tools

- [Vagrant](https://www.vagrantup.com)
- [Taskfile](https://taskfile.dev)
- [uv](https://astral.sh/blog/uv)
- [pyenv](https://github.com/pyenv/pyenv/wiki#suggested-build-environment) or compatible Python version >= 3.10

#### Working with Taskfile

```bash
# List all tasks
task --list

# Describe a task
task --summary <task-name>
```

All tasks have a short description of what they do.
And long summaries are available with the `--summary` flag.

#### Working with uv

```bash
# Install all python dependencies
task install

# To run the playbook you can use the following command
task play -- ansible/connection.yml
# It's using venv inside the script, so you don't need to activate it

# To run another ansible command you need to activate the venv and run the command
source .venv/bin/activate
# For example
ansible-inventory --list all | bat -l json
```
