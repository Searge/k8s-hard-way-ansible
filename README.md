# Provisioning of Kubernetes the hard way with Ansible

[![OpenSSF best practices badge](https://www.bestpractices.dev/projects/8684/badge)](https://www.bestpractices.dev/en/projects/8684)

## Description

This educational project is a comprehensive toolkit designed to automate and simplify the process of
provisioning a Kubernetes cluster "the hard way".
It combines the use of Vagrant, Ansible, and Taskfile to create a streamlined workflow for
setting up and managing Kubernetes clusters.

The project includes a Vagrantfile for setting up the necessary virtual machines,
a directory full of Ansible playbooks and tasks for installing and managing Kubernetes,
and a Taskfile for orchestrating these processes.
The Ansible playbooks are based on the Kubernetes setup guides by Kelsey Hightower and Mumshad Mannambeth,
but have been adapted and expanded upon for this project.

This toolkit is particularly useful for developers or system administrators who are
learning about Kubernetes and want a hands-on approach, or who frequently need to
set up Kubernetes clusters for testing or deployment purposes.

### Credits

This educational project is based on these two repositories:

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

## CPE Name

The Common Platform Enumeration (CPE) name for this project is:

`cpe:2.3:a:searge:k8s_hard_way_ansible:*:*:*:*:*:*:*:*`
