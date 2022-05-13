# Build a Docker image based on the Amazon Linux 2 Docker image.
FROM fedora:36

RUN echo "%_install_langs all" > /etc/rpm/macros.image-language-conf
RUN yum update -y
RUN yum install -y sudo bash curl wget git man-db nano vim bash-completion tmux  gcc gcc-c++ make tar "@Development and Creative Workstation"

# Enable the Docker container to communicate with AWS Cloud9 by
# installing SSH.
#RUN yum install -y openssh-server

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install && rm -rf awscliv2.zip aws

# Ensure that Node.js is installed.
RUN yum install -y nodejs python2

# Create user and enable root access
RUN useradd --uid 1000 --shell /bin/bash -m --home-dir /home/user user && \
    sed -i 's/%wheel\s.*/%wheel ALL=NOPASSWD:ALL/' /etc/sudoers && \
    usermod -a -G wheel user

# Add the AWS Cloud9 SSH public key to the Docker container.
# This assumes a file named authorized_keys containing the
# AWS Cloud9 SSH public key already exists in the same
# directory as the Dockerfile.
RUN mkdir -p /home/user/.ssh
ADD ./authorized_keys /home/user/.ssh/authorized_keys
RUN chown -R user /home/user/.ssh /home/user/.ssh/authorized_keys && \
chmod 700 /home/user/.ssh && \
chmod 600 /home/user/.ssh/authorized_keys

# Update the password to a random one for the user user.
RUN echo "user:$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)" | chpasswd

# Script below requires this...
RUN yum -y install libevent-devel

# pre-install Cloud9 dependencies
#USER user
#RUN curl https://d2j6vhu5uywtq3.cloudfront.net/static/c9-install.sh | bash
#RUN curl -L https://raw.githubusercontent.com/c9/install/master/install.sh | bash


#USER root
# Start SSH in the Docker container.
CMD ssh-keygen -A && /usr/sbin/sshd -D
