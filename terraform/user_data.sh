#!/usr/bin/env bash
set -x

yum --assumeyes install git docker
service docker start
curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
PATH=$PATH:/usr/local/bin

usermod -aG docker ec2-user

[[ -e ~/prediction-io ]] || git clone https://github.com/spring-media/rbbt-prediction-io.git ~/prediction-io
eval $(aws ecr get-login --region eu-west-1 --no-include-email)
docker-compose --file ~/prediction-io/docker-compose.prod.yml up --build