#!/bin/bash
docker run \
 -it \
 --rm \
 -p "5050:5000" \
 ubuntu-node-fastify-app:latest
