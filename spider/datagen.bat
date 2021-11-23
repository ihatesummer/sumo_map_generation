@echo off
set nVehicle=10
set duration=600
netgenerate --spider --spider.arm-number=7 --spider.circle-number=3 --spider.space-radius=100 --output-file=spider.net.xml
randomTrips.py -n spider.net.xml -o flows.xml --begin 0 --end 1 --period 1 --flows %nVehicle%
jtrrouter --route-files=flows.xml --net-file=spider.net.xml --output-file=spider.rou.xml --begin 0 --end %duration% --accept-all-destinations
generateContinuousRerouters.py -n spider.net.xml --end %duration% -o rerouter.add.xml
echo ^<configuration^> > spider.sumocfg
echo     ^<input^> >> spider.sumocfg
echo         ^<net-file value="spider.net.xml"/^> >> spider.sumocfg
echo         ^<route-files value="spider.rou.xml"/^> >> spider.sumocfg
echo         ^<additional-files value="rerouter.add.xml"/^> >> spider.sumocfg
echo     ^</input^> >> spider.sumocfg
echo     ^<time^> >> spider.sumocfg
echo         ^<begin value="0"/^> >> spider.sumocfg
echo         ^<end value="%duration%"/^> >> spider.sumocfg
echo     ^</time^> >> spider.sumocfg
echo     ^<output^> >> spider.sumocfg
echo         ^<fcd-output value="spider.output.xml"/^> >> spider.sumocfg
echo     ^</output^> >> spider.sumocfg
echo ^</configuration^> >> spider.sumocfg
sumo -c spider.sumocfg --fcd-output mobility_data.xml
python .\xml2csv.py "mobility_data.xml"
echo Data generation completed.
pause