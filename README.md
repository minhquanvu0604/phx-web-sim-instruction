# phx-web-sim-instruction
Instruction to run the Docker for Phenikaa-X UAV simulation stack

## Docker Container for UAV Sim 
A package wrapping the Phenikaa-X UAV simulation stack 

This package requires Linux (tested on Ubuntu)

## Setup 
### Set up Wireguard VPN
Must be able to access the server via VPN

If not yet setup
- Contact thongtd for assistance
- For Team Drone: [DDS-Router - HƯỚNG DẪN KẾT NỐI ROS2 CHO SERVER–DEVICE](http://10.20.14.2:8090/x/ngexAw)

### Install Dependencies
Dependencies related to display should be installed on the host OS

- **QGroundControl:** https://docs.qgroundcontrol.com/master/en/qgc-user-guide/getting_started/download_and_install.html

- **Gazebo Simulator:** https://gazebosim.org/docs/harmonic/install_ubuntu/

### Pull the image from DockerHub
The image is available at [DockerHub](https://hub.docker.com/r/minhquanvu0604/phx-web-uav-sim). Occupies ~3.3 GB of space.
```bash
docker pull minhquanvu0604/phx-web-uav-sim:1.0
```

## Bringup 
Run QGroundControl 
```bash
# Grant execution permission (do only once)
cd your-path-to-QGroundControl/
chmod +x QGroundControl-x86_64.AppImage

# Run QGroundControl
./QGroundControl-x86_64.AppImage
```

Run Gazebo in host
```bash
# Set env var to allow gz in host and PX4 in container to communicate
export GZ_IP=127.0.0.1
export GZ_PARTITION=px4_standalone # Optional: Set a specific partition name to avoid conflicts

python3 simulation-gazebo.py
```

Change the IP in [fastdds_udp_only.xml](fastdds_udp_only.xml) to your VPN subnet 
```xml
<interfaceWhiteList>
    <address>10.22.0.12</address> <!-- Your VPN subnet -->
</interfaceWhiteList>
```

Run the container. The whole stack should execute immediately upon running the Docker container.
```bash
# Usage: ./start_container.sh [drone_id] [box_id] [img_version]
./start_container.sh d10 b10 1.0
```