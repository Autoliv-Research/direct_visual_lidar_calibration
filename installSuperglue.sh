#!/bin/sh

sudo apt install python3-pip
python3 -m pip install numpy opencv-python torch matplotlib==3.5.2
git clone https://github.com/magicleap/SuperGluePretrainedNetwork.git
echo 'export PYTHONPATH=$PYTHONPATH:/workspace/SuperGluePretrainedNetwork' >> ~/.bashrc