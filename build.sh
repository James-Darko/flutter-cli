#!/bin/bash
sudo docker build . --tag flutter
FLUTTER=/usr/local/bin/flutter.sh
sudo rm $FLUTTER
sudo cp flutter.sh $FLUTTER
sudo chmod +x $FLUTTER
