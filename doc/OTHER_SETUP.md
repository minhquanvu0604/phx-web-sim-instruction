# Build the Docker image

The build script requires an image version to be specified.

```bash
# Usage: ./build.sh IMG_VERSION [TEMP_SRC] [IMAGE_NAME] [PX4_SRC]

# Examples:
./build.sh 1.0
./build.sh latest
./build.sh 2.1

# The built image will be tagged as: phx-web-image:IMG_VERSION
```

# Launching PX4 and ROS 2 Nodes Manually (alternative)
Change the last layer in `Dockerfile`
```dockerfile
# from
ENTRYPOINT ["/entrypoint_phx_sim.sh"]
# to
CMD ["sleep", "infinity"]
```
## 1. Run Docker containers
```bash
# container name: phx-sim-d1-b1
DRONE_ID=d1 BOX_ID=b1 COMPOSE_PROJECT_NAME=phx-sim-d1-b1 docker compose up -d   

# container name: phx-sim-d10-b10
DRONE_ID=d10 BOX_ID=b10 COMPOSE_PROJECT_NAME=phx-sim-d10-b10 docker compose up -d   
```

To stop the container
```bash
DRONE_ID=d10 BOX_ID=b10 COMPOSE_PROJECT_NAME=phx-sim-d10-b10 docker compose down
```

## 2. Exec into the container
```bash
docker exec -it phx-sim-d1-b1 bash
```

## 3. In the container shell
Launch `PX4-Autopilot`
```bash
# in PX4-Autopilot/
make px4_sitl gz_standard_vtol
```
Launch `ros2_telemetry`
```bash
source /opt/ros/humble/setup.bash
source /ros2_ws/install/setup.bash
ros2 launch ros2_telemetry plan_upload_phx.launch.py drone_id:=d1
```
Launch `box_manager`
```bash
source /opt/ros/humble/setup.bash
source /ros2_ws/install/setup.bash
ros2 launch box_manager box_manager_sim.launch box_id:=1
```

Launch DDS Router
```bash
source /opt/ros/humble/setup.bash
source /DDS-Router-3.2/install/setup.bash
install/ddsrouter_tool/bin/ddsrouter -c dds_config_runtime.yaml
```