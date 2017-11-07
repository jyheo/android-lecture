# Firebase Storage, RemoteConfig

## 실습 개요

Firebase의 RemoteConfig, Stroage를 실습한다.


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
