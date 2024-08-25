sudo apt update -y
sudo apt upgrade -y
pip install keystone-engine
cd loaders/attacker
mkdir temp
python generate_sample.py
