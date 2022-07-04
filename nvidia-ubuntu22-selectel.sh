# Warning
echo 'Warning: this script is designed to work with selectel infrastructure only, input anything if you understand'
read sane
#
if [ -z "$sane" ]
then
  echo 'Quit'
  exit 1
fi

# User input
echo 'Script will now try loading the scene from storage container(scene must be in the root of the container), input the name(for example "scene_storage")'
read cont_name
echo 'Enter the scene filename(*.blend) and other render params'
read scene_name
echo 'Start frame:'
read s_frame
echo 'End frame'
read e_frame
echo 'Render engine(CYCLES)'
read rend_eng
echo 'Render using(CUDA,OPTIX(+CPU)):'
read rend_with
#
if [ -z "$cont_name" ] | [ -z "$scene_name" ] | [ -z "$s_frame" ] | [ -z "$e_frame" ] | [ -z "$rend_with" ]
then
  echo 'Missing input parameter'
  exit 1
fi
#
echo 'Please wait for the aws to install and enter credentials'
sleep 3

# Basic utils install
apt-get update -y
apt-get install -y blender tmux htop awscli

# AWS configuration
aws configure --endpoint-url=https://s3.storage.selcloud.ru

# Blender 'installation'
wget https://mirrors.dotsrc.org/blender/release/Blender3.2/blender-3.2.0-linux-x64.tar.xz
tar -xpvf blender-3.2.0-linux-x64.tar.xz
rm blender-3.2.0-linux-x64.tar.xz

# Nvidia drivers installation
add-apt-repository ppa:graphics-drivers/ppa
apt-get update -y
apt-get install -y linux-headers-$(uname -r)
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb
dpkg -i cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb
cp /var/cuda-repo-ubuntu2204-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/
apt-get update -y
apt-get install -y cuda

# Render preparations
mkdir -p /render/output
cd /root
aws --endpoint-url=https://s3.storage.selcloud.ru s3 cp "s3://$cont_name/$scene_name" "$scene_name"

# Render
/root/blender-3.2.0-linux-x64/blender -b "/root/$scene_name" -E "$rend_eng" -o /render/output/ -noaudio -s "$s_frame" -e "$e_frame" -a -- --cycles-device "$rend_with"

# Uploading the output
echo 'Output frames will be packed in an archive and uploaded to the container'
tar -zcvf render_output.tar.gz /render/output/
aws --endpoint-url=https://s3.storage.selcloud.ru s3 cp render_output.tar.gz "s3://$cont_name/" && echo 'Done'
