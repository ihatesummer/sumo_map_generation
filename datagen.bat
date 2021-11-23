@echo off
set nVehicle=100
set duration=3600
randomTrips.py -n osm.net.xml -o flows.xml --begin 0 --end 1 --period 1 --flows %nVehicle%
jtrrouter --route-files=flows.xml --net-file=osm.net.xml --output-file=osm.rou.xml --begin 0 --end %duration% --accept-all-destinations
generateContinuousRerouters.py -n osm.net.xml --end %duration% -o rerouter.add.xml
echo ^<configuration^> > custom.sumocfg
echo     ^<input^> >> custom.sumocfg
echo         ^<net-file value="osm.net.xml"/^> >> custom.sumocfg
echo         ^<route-files value="osm.rou.xml"/^> >> custom.sumocfg
echo         ^<additional-files value="rerouter.add.xml"/^> >> custom.sumocfg
echo     ^</input^> >> custom.sumocfg
echo     ^<time^> >> custom.sumocfg
echo         ^<begin value="0"/^> >> custom.sumocfg
echo         ^<end value="%duration%"/^> >> custom.sumocfg
echo     ^</time^> >> custom.sumocfg
echo     ^<output^> >> custom.sumocfg
echo         ^<fcd-output value="custom.output.xml"/^> >> custom.sumocfg
echo     ^</output^> >> custom.sumocfg
echo ^</configuration^> >> custom.sumocfg
sumo -c custom.sumocfg --fcd-output mobility_data.xml
python .\xml2csv.py "mobility_data.xml"
echo Data generation completed.
pause