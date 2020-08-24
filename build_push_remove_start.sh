#!/bin/bash

set -e
TAG=$1

echo "#### Building airconnect ${TAG} ####"
docker build -t airconnect:${TAG} . --no-cache &&

echo "### Tagging airconnect ${TAG} ####"
docker image tag airconnect:${TAG} brucewillke/airconnect:${TAG} &&

echo "####Pushing airconnect ${TAG} ####"
docker push brucewillke/airconnect:${TAG} &&

echo "#### Removing running airconnect container ####"
docker rm -f airconnect &&

echo "#### Creating new container to run ####"
##sh ../docker-scripts/airconnect.sh &&
docker create --net="host" --name="airconnect" --restart="always" brucewillke/airconnect:latest &&

echo "#### Starting airconnect container ####"
docker start airconnect
