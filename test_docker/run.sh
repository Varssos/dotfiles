#!/bin/bash

docker rm -f ubuntu2404
docker build -t ubuntu2404-test .
docker run -d --name ubuntu2404 -p 2222:22 ubuntu2404-test
docker exec -it -u sw ubuntu2404 bash -lc "cd /home/sw/dotfiles && ./run_ansible.sh --no-password"