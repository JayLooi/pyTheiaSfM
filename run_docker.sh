xhost +si:localuser:root
DIR=$(pwd)
docker run -it --rm \
    --name=3d_recon \
    --gpus all \
    --env="DISPLAY=$DISPLAY" \
    --volume="/tmp/.X11-unix/:/tmp/.X11-unix:rw" \
    --volume="$DIR/application:/home/ubuntu/3DSceneRecon/application" \
    --volume="$DIR/data:/home/ubuntu/3DSceneRecon/data" \
    --net=host \
    --privileged \
    3d_scene_recon_sfm
