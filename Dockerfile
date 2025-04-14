FROM ubuntu:20.04

ARG USERNAME=ubuntu
ARG LIB_PATH=/home/libs

ENV DEBIAN_FRONTEND=nointeractive
RUN apt update && apt upgrade -y
RUN apt install -y cmake build-essential libgflags-dev libgoogle-glog-dev libatlas-base-dev git
RUN apt install -y python3 python3-pip

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# for opencv
RUN apt install -y ffmpeg libsm6 libxext6

RUN mkdir $LIB_PATH

WORKDIR $LIB_PATH
RUN git clone https://gitlab.com/libeigen/eigen
RUN cd eigen && git checkout 3.4.0 && mkdir build && \
    cd build && cmake .. && \
    make install

WORKDIR $LIB_PATH
RUN git clone https://ceres-solver.googlesource.com/ceres-solver
RUN cd ceres-solver && git checkout 2.1.0 && mkdir build && cd build && \
    cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF -DBUILD_BENCHMARKS=OFF && \
    make -j4 && make install

RUN apt install -y libopenimageio-dev
COPY . /home/$USERNAME/3DSceneRecon/external/pyTheiaSfM
RUN cd /home/$USERNAME/3DSceneRecon/external/pyTheiaSfM && sh build_and_install.sh

RUN pip install scikit-learn numpy scipy opencv-contrib-python open3d
