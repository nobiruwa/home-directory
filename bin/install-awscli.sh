#!/usr/bin/env bash

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip /tmp/awscliv2.zip -d /tmp/awscliv2

mkdir -p ~/opt/aws/bin
/tmp/awscliv2/aws/install --update --install-dir ${HOME}/opt/aws/bin --bin-dir ${HOME}/.local/bin
