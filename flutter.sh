#!/bin/bash
sudo docker run --rm --network host --mount type=bind,source=$PWD,target=/project flutter "$@"
