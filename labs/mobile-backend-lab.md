# 모바일 백앤드 서비스 실습

## 실습 개요

Firebase의 Notification과 RemoteConfig, Stroage를 실습한다.


## Firebase 준비
* 구글 계정이 없으면 만든다.
* Firebase console(https://console.firebase.google.com/)에 접속해본다.
* Stroage에 겨울 풍경 이미지와 여름 풍경 이미지를 등록한다.
* 인증(Authentication) 없이도 이미지를 가져올 수 있도록 '규칙'을 수정한다.
* RemoteConfig에 season변수를 추가하고 값은 winter로 한다.

## 앱 만들기
* 액티비티 레이아웃에 ImageView 위젯을 하나 만든다.
* 액티비티가 실행되면 RemoteConfig에서 설정을 가져와서 season=winter이면 Storage에서 겨울 이미지를 가져와서 ImageView에 표시하고, winter가 아니면 여름 이미지를 보여준다.
    - RemoteConfig 초기화 부분  
      https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L45-L58분
    - 설정을 로컬로 가져오는 부분  
      https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L90-L113
    - 설정을 읽는 부분  
      https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L83-L88
    - Storage에서 이미지 읽어서 표시하는 부분  
      https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L62-L81

## Notification 보내서 앱 실행하기
* 앱을 실행 한 후 홈 버튼을 눌러서 비활성화 시킨다.
* Firebase console의 Notification에서 메시지를 보낸다.
* 시스템 상단에 알림이 뜨면 해당 알림을 클릭하여 앱을 실행(활성화) 시킨다.

## 참고
* 에뮬레이터를 이용할 경우 build.gradle (app) 파일에서 firebase 버전을 최신 버전으로 할 경우 에뮬레이터의 구글 서비스 버전이 낮아서 실행이 제대로 안될 수 있음. 그럴 때에는 버전을 낮춰서(예를 들어 9.6.1) 빌드하여 실행하면 됨.

```java
dependencies {
    ...
    compile 'com.google.firebase:firebase-auth:9.6.1'
    compile 'com.google.firebase:firebase-storage:9.6.1'
    compile 'com.google.firebase:firebase-config:9.6.1'
    compile 'com.google.firebase:firebase-messaging:9.6.1'
    ...
}
```
