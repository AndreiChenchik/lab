#!/bin/bash

# Usage:
# ./run_jupyter.sh [image]
#
# Parameters:
#   image - optional. A custom image to use instead of default. If it is given, 
#           we will not attemp to pull the latest image. This allows local image development.

IMAGE=${1:-docker.pkg.github.com/gumlooter/lab/jupyter}

#custom port
PORT=4544

# If we are called without a parameter to specify a new image, 
# let's make sure we are on the latest image
if [ $# -eq 0 ]; then
    echo "Will check for the latest image on the docker hub."
    docker pull $IMAGE
fi

exec docker run \
	--rm \
	-p "$PORT":8888 \
	-v "$PWD":/home/jovyan/work \
	"$IMAGE" start-notebook.sh \
    		--notebook-dir=/home/jovyan/work \
    		--NotebookApp.ip=0.0.0.0 \
    		--NotebookApp.password_required=False \
    		--NotebookApp.token='' \
    		--NotebookApp.custom_display_url="http://localhost:$PORT" &

sleep 5
xdg-open "http://localhost:$PORT"

wait
echo "Container stopped for some reason. Shutting down in 10 sec..."
sleep 10
