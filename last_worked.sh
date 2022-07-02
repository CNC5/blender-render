apt update
wget https://raw.githubusercontent.com/CNC5/blender-scenes-to-render/main/preparation_selectel.sh
chmod +x preparation_selectel.sh
./preparation_selectel.sh
cp /var/cuda-repo-ubuntu2204-11-7-local/cuda-46B62B5F-keyring.gpg /usr/share/keyrings/
apt-get update
apt-get install -y cuda
apt install nvidia-cuda-toolkit
apt install nvidia-utils-515
apt install nvidia-cuda-toolkit
apt-get -y install cuda
ls /usr/local/
wget https://766730.selcdn.ru/scene_storage/highway_scene.blend
apt install nvidia-cuda-toolkit
apt-get install -y cuda
apt-get install -y nvidia
apt-get install -y nvidia-driver
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb
dpkg -i cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb
cp /var/cuda-repo-ubuntu2204-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/
apt-get update
apt-get -y install cuda
add-apt-repository ppa:graphics-drivers/ppa
apt-get update
apt-get install nvidia-410
apt-get install linux-headers-$(uname -r)
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb
dpkg -i cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb
cp /var/cuda-repo-ubuntu2204-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/
apt-get update
apt-get install -y cuda
./blender -b /root/highway_scene.blend -E CYCLES -o /render/output -noaudio -s 1 -e 200 -a -- --cycles-device CUDA
