#!/usr/bin/env bash
### @File   : docker-builder.sh.sh
### @Author : Luke Penrod - support@deepinthought.io
### @Company : DeepInThought
### @Link   : https://deepinthought.io
### @Date   : Saturday,September 29 2018 01:53:45
###-

docker build . -t deepinthought/vscode-shell-snippets:latest
docker push deepinthought/vscode-shell-snippets:latest