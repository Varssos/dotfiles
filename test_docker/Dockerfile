FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Basic packages
RUN apt-get update && apt-get install -y \
    sudo \
    openssh-server \
    curl \
    ca-certificates \
    git \
    wget \
    nano \
    python3 \
    python3-pip \
    ansible-core \
    passwd \
    && rm -rf /var/lib/apt/lists/*


# Create a user for SSH access
RUN useradd -m -s /bin/bash sw && \
    echo "sw ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    mkdir -p /home/sw/.ssh && \
    chmod 700 /home/sw/.ssh && \
    chown -R sw:sw /home/sw/.ssh

# # SSH config
# RUN mkdir -p /run/sshd && \
#     sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
#     sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# # Set passwrd for sw (sw:sw)
# RUN echo "sw:sw" | chpasswd


# Set empty passwrd for sw 
RUN usermod -p "" sw

# SSH without auth(it's local for test only!)
RUN mkdir -p /run/sshd && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config

EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]


RUN git clone https://github.com/Varssos/dotfiles.git /home/sw/dotfiles && \
    chown -R sw:sw /home/sw/dotfiles