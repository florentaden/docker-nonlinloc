
## Build and deploy container

To get started run the command `bash buildnrun.sh` or manually enter these commands in the terminal to build a docker image with NonLinLoc and deploy it in a container on your local machine:

```bash
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
```

## How to use NonLinLoc functions once in the container

You can run `entrypoint.sh` or manually enter these commands in the terminal: 

```bash
# -- Generate NonLinLoc grid given velocity model (1D example)
Vel2Grid NonLinLoc.in

# changing from P- to S-wave type and generate grid
sed -i "s@VGTYPE P@VGTYPE S@" NonLinLoc.in && Vel2Grid NonLinLoc.in

# -- Generate NonLinLoc Travel Time grids (see NonLinLoc.in file for list of station)
Grid2Time NonLinLoc.in

# S-wave (watch-out if you change path or name of travel time grids)
sed -i "s@TIME/travel_times P@TIME/travel_times S@" NonLinLoc.in && Grid2Time NonLinLoc.in

# -- run NonLinLoc location algorithm 
NLLoc NonLinLoc.in
```