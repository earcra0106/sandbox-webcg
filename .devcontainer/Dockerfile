ARG BASE_IMAGE=node:24.16.0
FROM $BASE_IMAGE

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    vim \
    tree \
    bubblewrap \
    sudo && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# sudoを実行可能にする
RUN usermod -aG sudo node
RUN echo 'node ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN echo 'alias ll="ls -al"' >> /home/node/.bashrc

RUN sed -i.bak 's/#\s*\(force_color_prompt=yes\)/\1/' ~/.bashrc

RUN echo "PS1='\[\e[1;35m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '" >> /home/node/.bashrc

RUN echo "clear -x" >> /home/node/.bashrc
RUN echo "echo -e '\n\e[1;37mWelcome to Devcontainer!\e[0m\n'" >> /home/node/.bashrc
