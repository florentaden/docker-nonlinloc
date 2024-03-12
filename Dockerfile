FROM ubuntu:22.04

# -- create user 
ARG DUSER="linus"
ARG DUID="1000"
ARG DGID="1000"
ENV DUSER=$DUSER DUID=$DUID HOME=/home/$DUSER DGID=$DGID
RUN groupadd -g $DGID $DUSER \
        && useradd -m -s /bin/bash -N -u $DUID -g $DUSER $DUSER

# -- install essential and necessary commands
RUN apt-get update && apt-get install -y build-essential git vim sudo cmake make gcc

# -- switch root to user 
USER $DUSER
WORKDIR /home/$DUSER

# -- install NonLinLoc, return to working commit (temporary hopefully) use correct gcc compiler and comment flag in Vel2Grid3D
RUN git clone https://github.com/alomax/NonLinLoc.git \
    && cd NonLinLoc \
    && git reset --hard f938a5f \
    && cd src \
    && sed -i "s@/usr/local/bin/gcc-13@/usr/bin/gcc-11@" CMakeLists.txt \
    && sed -i '72 s@.@//&@' Vel2Grid3D.c \ 
    && mkdir bin \
    && cmake . \
    && make \
    && echo 'export PATH=$PATH:$HOME/NonLinLoc/src/bin' >> ~/.bashrc

WORKDIR /home/$DUSER/docker-nll

# ENTRYPOINT [ "./entrypoint.sh" ]
