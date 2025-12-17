# Troubleshooting

## WARN [mission_feasibility_checker] Mission rejected: Landing waypoint/pattern required.
Autopilot param MIS_TKO_LAND_REQ is by default set to 2, which means the mission must have a landing waypoint/pattern. Set it to 0 to disable this check.

### Launch the container (version 1.1)
[Bringup components manually (version 1.1)](../README.md#bringup-components-manually-version-11) 

### Change the param in PX4 shell
In PX4 shell (the same terminal that runs `make px4_sitl gz_standard_vtol`), there is a shell session that looks like this
```
pxh>
```
Set the param in this session
```
pxh> param set MIS_TKO_LAND_REQ 0
```

### Check the MIS_TKO_LAND_REQ param 
#### Using QGroundControl
- click on the QGC logo in the top-left corner   
- Vehicle Configuration
- Parameters
- Find MIS_TKO_LAND_REQ and set it to No requirements
#### Using the PX4 shell
```bash
param show MIS_TKO_LAND_REQ
```

### Change the param before launching the Autopilot - Not working 
We are launching gz_standard_vtol, which uses the config file
```
/PX4-Autopilot/ROMFS/px4fmu_common/init.d-posix/4004_gz_standard_vtol
```
Add `param set-default MIS_TKO_LAND_REQ 0` to the end of the config file


