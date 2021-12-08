#!/bin/bash
docker build --tag ubuntu-node-fastify-app:latest \
 --build-arg USERNAME=testuser \
 --build-arg NVM_DIR=/usr/local/nvm \
 --build-arg NODE_VERSION=14 \
 --build-arg NVM_VERSION=0.39.0 \
 .