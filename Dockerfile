# Start from the code-server Debian base image
ARG NGROK
FROM codercom/code-server:latest

USER coder

# Apply VS Code settings
COPY deploy-container/settings.json .local/share/code-server/User/settings.json

# Use bash shell
ENV SHELL=/bin/bash

# Install unzip + rclone (support for remote filesystem)
RUN sudo apt-get update && sudo apt-get install unzip -y
RUN curl https://rclone.org/install.sh | sudo bash

# Copy rclone tasks to /tmp, to potentially be used
COPY deploy-container/rclone-tasks.json /tmp/rclone-tasks.json

# Fix permissions for code-server
RUN sudo chown -R coder:coder /home/coder/.local

# You can add custom software and dependencies for your environment below
# -----------

# Install a VS Code extension:
# Note: we use a different marketplace than VS Code. See https://github.com/cdr/code-server/blob/main/docs/FAQ.md#differences-compared-to-vs-code
# RUN code-server --install-extension esbenp.prettier-vscode

# Install apt packages:
# RUN sudo apt-get install -y ubuntu-make

# Copy files: 
# COPY deploy-container/myTool /home/coder/myTool

# -----------

# Port
ENV PORT=8080


## END

USER coder

RUN sudo curl -sSL https://dot.net/v1/dotnet-install.sh | sudo bash /dev/stdin -Channel 6.0 -InstallDir /usr/share/dotnet \
    && sudo ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
RUN git config --global user.email "tommy@terribledev.io"
RUN git config --global user.name "Tommy Parnell"
RUN sudo apt-get install libicu-dev -y && sudo apt-get install build-essential -y

RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
              echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && \
              sudo apt update && sudo apt install ngrok   
RUN ngrok config add-authtoken ${NGROK}   
# Use our custom entrypoint script first
COPY deploy-container/entrypoint.sh /usr/bin/deploy-container-entrypoint.sh
ENTRYPOINT ["/usr/bin/deploy-container-entrypoint.sh"]
