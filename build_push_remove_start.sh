set -e
TAG=$1

echo "#### Building airconnect ${TAG} ####"
docker build -t airconnect:${TAG} . &&

echo "### Tagging airconnect ${TAG} ####"
docker image tag airconnect:${TAG} brucewillke/airconnect:${TAG} &&

echo "####Pushing airconnect ${TAG} ####"
docker push brucewillke/airconnect:${TAG} &&

echo "#### Removing running airconnect container ####"
docker rm -f airconnect &&

echo "#### Creating new container to run ####"
sh ../docker-scripts/airconnect.sh &&

echo "#### Starting airconnect container ####"
docker start airconnect
