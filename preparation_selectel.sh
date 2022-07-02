apt-get update
apt-get install blender tmux htop awscli
wget https://mirrors.dotsrc.org/blender/release/Blender3.2/blender-3.2.0-linux-x64.tar.xz
tar -xpvf blender-3.2.0-linux-x64.tar.xz
rm blender-3.2.0-linux-x64.tar.xz
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb
dpkg -i cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb
cp /var/cuda-repo-ubuntu2204-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/sudo
apt-get update
apt-get -y install cuda && reboot
