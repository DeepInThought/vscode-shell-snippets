FROM ubuntu:latest as ubuntu_builder
RUN apt-get -y update && apt-get install curl -y

### FROM deepinthought/vscode-shell-snippets:latest
COPY . /vscode-shell-snippets
LABEL Name=vscode-shell-snippets Version=0.1.0
CMD [ "/bin/bash", "cd /vscode-shell-snippets" ]