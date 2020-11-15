#!/bin/bash
sudo docker rmi flutter || true
sudo docker build . --tag flutter
FLUTTER=/usr/local/bin/fl
sudo rm -f $FLUTTER
sudo cp flutter.sh $FLUTTER
sudo chmod +x $FLUTTER
