IMAGE="nonlinloc"
TAG="latest"

# -- build 
docker build -t $IMAGE:$TAG \
    --build-arg DUSER=$(whoami) \
    --build-arg DUID=$(id -u) \
    --build-arg DGID=$(id -g) \
    -f Dockerfile . 

# -- deploy 
mkdir -p VEL TIME OUT

docker run -it \
    -u $(id -u):$(id -g) \
    -v ${PWD}:/home/$(whoami)/docker-nll \
    --rm $IMAGE:$TAG \
    /bin/bash
