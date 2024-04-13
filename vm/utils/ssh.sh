#!/bin/bash

# Enable password auth in sshd so we can use ssh-copy-id
sed -i --regexp-extended 's/#?PasswordAuthentication (yes|no)/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i --regexp-extended 's/#?Include \/etc\/ssh\/sshd_config.d\/\*.conf/#Include \/etc\/ssh\/sshd_config.d\/\*.conf/' /etc/ssh/sshd_config
sed -i 's/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/#MaxAuthTries 6/MaxAuthTries 30/' /etc/ssh/sshd_config
systemctl restart sshd

# Create the .ssh directory if it doesn't exist
if [ ! -d /home/vagrant/.ssh ]
then
    mkdir /home/vagrant/.ssh
    chmod 700 /home/vagrant/.ssh
    chown vagrant:vagrant /home/vagrant/.ssh
fi

# If hostname is controlplane01, check if ssh is created, if not create it
if [ "$(hostname)" = "controlplane01" ]
then
    if [ ! -f /vagrant/.vagrant/ssh/id_ed25519 ]
    then
        ssh-keygen -q -t ed25519 -C "vagrant@k8s" -N "" -f /home/vagrant/.ssh/id_ed25519 <<<y >/dev/null 2>&1
        chown vagrant:vagrant /home/vagrant/.ssh/id_ed25519
        chown vagrant:vagrant /home/vagrant/.ssh/id_ed25519.pub
    fi

    # Copy the keys to the shared folder `/vagrant/.vagrant/ssh/`
    if [ ! -d /vagrant/.vagrant/ssh ]
    then
        mkdir -p /vagrant/.vagrant/ssh
    fi

    # Copy the keys to the shared folder `/vagrant/.vagrant/ssh/`
    if [[ -f /home/vagrant/.ssh/id_ed25519 && ! -f /vagrant/.vagrant/ssh/id_ed25519 ]]
    then
        cp /home/vagrant/.ssh/id_* /vagrant/.vagrant/ssh/
    fi
fi

# Add the public key to the authorized_keys file on all nodes
cat /vagrant/.vagrant/ssh/id_ed25519.pub >> /home/vagrant/.ssh/authorized_keys

echo "SSH keys were added to the authorized_keys file at $(hostname)"
cat /home/vagrant/.ssh/authorized_keys

# Install sshpass on controlplane01
if [ "$(hostname)" = "controlplane01" ]
then
    sh -c 'sudo apt update' &> /dev/null
    sh -c 'sudo apt-get install -y sshpass' &> /dev/null
fi

