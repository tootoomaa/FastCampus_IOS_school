# Weather Forecast App Goal

## 구현 목표

### [ 주제 ]

- 날씨 정보 앱

<img src="../image/200724_WeatherForecast/WeatherForecastExample.gif" alt="WeatherForecastExample" style="zoom:50%;" />

### [  구현 사항  ]

1. 기본 사항
   - API 를 이용한 날씨 데이터 표시
     - < API 문서 >
       - https://openweathermap.org/current  - 현재 날씨
       - https://openweathermap.org/forecast5 - 단기 예보: 최대 5일 (3시간 간격)
     - < API 주소 >
       - https://api.openweathermap.org/data/2.5/weather?<쿼리>
       - https://api.openweathermap.org/data/2.5/forecast5?<쿼리>
   - 스크롤 위치에 따라 배경이 흐려지는 정도나 이미지 위치가 달라지도록 구현
   - StatusBar 숨김 처리
   - 날씨 상태에 맞게 배경 이미지 변경
2. 화면 상단에 표시할 내용
   - 날씨 정보를 가져온 도시명 
   - 날씨 마지막 업데이트 시각
   - 리로드 버튼(↻) : 날씨 정보 갱신 
3. 현재 날씨 표시
   - 화면 좌하단 영역에 표시되는 날씨 정보
   - 날씨 아이콘 + 설명, 최저 온도, 최고 온도
   - 참고: 앱에서 온도와 함께 표시한 특수문자 (⤓ / ⤒ / °)
4. 단기 예보
   - 화면을 스크롤했을 때 표시
   - 날짜+시각, 날씨, 온도
   - 날씨 아이콘 아래에 흰 선 그리기
