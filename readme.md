# Prerequisites
- [SUMO](https://www.eclipse.org/sumo/)
- [Python](https://www.python.org/)
# 이동성 데이터 생성 방법
## 원하는 실제 지도 기반
1. SUMO의 osmWebWizard로 원하는 영역 선택 후 export
   - 날짜가 박힌 폴더와,
   - 그 폴더 안에 지도 파일 osm.net.xml이 생성됨
2. datagen.bat 스크립트에서 nVehicle 변수와 duration 변수를 조정
   - nVehicle: 시뮬레이션 시작 단계에서 지도 내에 생성되는 차 대수
   - duration: 시뮬레이션 시간 [seconds]
3. datagen.bat 실행
	- 이 bat 파일과 같은 폴더에 다음 두 파일이 함께 있어야 함
     1. 'osm.net.xml' (지도 파일)
     2. 'xml2csv.py' (parsing script) 
4. mobility_data.csv(결과 파일) 확인

## Grid, spider 등 기본 제공 topology 기반
- 각 폴더에 그에 상응하는 datagen.bat을 생성해둠
- 변수 선언 바로 밑에 osmWebWizard을 대신하는 netgenerate 명령(도로 생성 command line)을 넣어 둠
  - 구체적인 사용법은 [netgenerate API 문서](https://sumo.dlr.de/docs/netgenerate.html) 활용