# 센서 실습

가속도(Accelerometer) 센서를 이용하여 기기를 위아래로 3번 흔들면 토스트 메시지가 나타나도록 한다.

## 가속도 센서 사용
* 가속도 센서에 SensorEventListener 등록
    - https://github.com/jyheo/AndroidTutorial/blob/master/SensorTest/app/src/main/java/com/example/jyheo/sensortest/MainActivity.java#L53-L59
    - https://github.com/jyheo/AndroidTutorial/blob/master/SensorTest/app/src/main/java/com/example/jyheo/sensortest/MainActivity.java#L91-L97
* onSensorChanged() 에서 값 확인
    - Y축 방향으로 값이 일정 범위내료 바뀌고 있으면 토스트를 보인다.
    - https://github.com/jyheo/AndroidTutorial/blob/master/SensorTest/app/src/main/java/com/example/jyheo/sensortest/MainActivity.java#L117-L129

## 추가 실습
* 탄산 거품이 나는 애니메이션을 보여준다.
* 흔드는 속도에 따라 메시지 내용을 다르게 보여준다.
