layout: true
.top-line[]

---
class: center, middle
# 모바일 백앤드서비스(Firebase)
## Notification, Messaging


---
## Notification
* 특정 대상에게 알림을 보낼 수 있음
* 특정 시간을 정해서 보낼 수 있음
* 사용자에게 앱의 사용을 유도하는 용도
    - 이벤트 알림 등

<img src="images/firebasenoti.png">
<img src="images/firebasenoti2.png">

---
## Notification
* AndroidManifest.xml 에 서비스와 인텐트 필터 추가

```xml
<service
    android:name=".MyFirebaseMessagingService">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT"/>
    </intent-filter>
</service>
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/AndroidManifest.xml#L19-L23]

---
## Notification
* 메시지 수신 서비스

```java
public class MyFirebaseMessagingService extends FirebaseMessagingService {
    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        Log.d(TAG, "From: " + remoteMessage.getFrom());

        // Check if message contains a data payload.
        if (remoteMessage.getData().size() > 0) {
            Log.d(TAG, "Message data payload: " + remoteMessage.getData());
        }

        // Check if message contains a notification payload.
        if (remoteMessage.getNotification() != null) {
            msgBody = remoteMessage.getNotification().getBody();
            Log.d(TAG, "Message Notification Body: " + msgBody);
        }
    }
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MyFirebaseMessagingService.java#L12-L35]

---
## Notification
* Firebase 콘솔에서 알림 보내기
    - Firebase 콘솔에서 Notification 메뉴 선택
<img src="images/firebaseconsolenoti.png" width=80%>

---
## Notification (앱에서 알림 받기)
* 액티비티가 활성화 된 상태일 때
    - FirebaseMessagingService의onMessageReceived()가 호출됨
* 액티비티가 비활성화 된 상태일 때
    - 시스템이 자체적으로 알림을 표시함
    - 알림을 선택하면 액티비티를 활성화 시킴

    <img src="images/firebasereceivenoti.png">

---
## Cloud Messaging
* 일반적으로 푸시 알림으로 알려진 서비스
* 클라이언트가 서버로부터 업데이트된 정보를 가져오려면
    - 주기적으로 서버에 접속해서 확인하는 방법
    - 서버가 클라이언트에 접속해서 알려주는 방법(이 방법은 일반적이지 못함, 클라이언트가 접속을 허용하지 않는 경우가 대부분)
* 누가 서버에 접속하는가?
    - 스마트폰의 여러 앱이 각자 알아서 주기적으로 서버에 접속하면?
    - 하나의 알림 서버에 시스템이 접속해서 모든 앱이 필요한 업데이트 정보를 확인해준다면? -> Firebase Cloud Messaging

---
## Cloud Messaging
* Firebase Cloud Messaging (FCM)
    - 옛날엔 Google Cloud Messaging (GCM)

<img src="https://i.imgur.com/9XzwPqc.png" width=80%>

.footnote[출처: https://guides.codepath.com/android/Google-Cloud-Messaging]

---
## Cloud Messaging
&nbsp;1. Firebase 서버에 접속하여 토큰을 받음

<img src="http://imgur.com/5UPxP3n.png" width=80%>

.footnote[출처: https://guides.codepath.com/android/Google-Cloud-Messaging]

---
## Cloud Messaging
&nbsp;2. 받은 토큰을 가지고 3rd party 서버에 접속

<img src="http://imgur.com/ItRPQ7N.png" width=80%>

.footnote[출처: https://guides.codepath.com/android/Google-Cloud-Messaging]

---
## Cloud Messaging
&nbsp;3. 3rd party 서버가 Firebase 서버를 통해 앱으로 푸시 알림 보냄

<img src="http://imgur.com/adiFo8w.png" width=80%>

.footnote[출처: https://guides.codepath.com/android/Google-Cloud-Messaging]

---
## Cloud Messaging (안드로이드 앱)

<img src="images/firebasecm.png">

<img src="images/firebasecm2.png">

---
## Cloud Messaging (안드로이드 앱)
* AndroidManifest.xml 에 서비스와 인텐트 필터 추가
    - **Notification의 MyFirebaseMessagingService와 동일**

```xml
<service
    android:name=".MyFirebaseMessagingService">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT"/>
    </intent-filter>
</service>

<service
    android:name=".MyFirebaseInstanceIDService">
    <intent-filter>
        <action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
    </intent-filter>
</service>
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/AndroidManifest.xml#L24-L28]

---
## Cloud Messaging (안드로이드 앱)
* 토큰 업데이트 서비스
    - 토큰은 사용자가 앱을 다시 설치하는 등의 이유로 재 생성될 수 있음
* FCM SDK가 생성한 토큰을 받기
    - FirebaseInstanceId.getInstance().getToken();
* 토큰 생성 모니터링을 위한 서비스 – **변경될 때만** 호출됨

```java
public class MyFirebaseInstanceIDService extends FirebaseInstanceIdService {
    private static final String TAG = "MyFirebaseIIDService";

    @Override
    public void onTokenRefresh() {
        // Get updated InstanceID token.
        String refreshedToken = FirebaseInstanceId.getInstance().getToken();
        Log.d(TAG, "Refreshed token: " + refreshedToken);

        // sendRegistrationToServer(refreshedToken);
    }
}
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/LoginActivity.java#L37-L38
https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MyFirebaseInstanceIDService.java#L12-L24]

---
## Cloud Messaging (3rd Party 서버)
* 3rd Party 서버 만들기
    - 앱이 접속하여 메시지를 주고받는 서버
    - 앱은 구글 서버에서 받은 토큰을 이용하여 서버에 등록
    - 서버는 앱에게 푸시 메시지를 보낼 필요가 있을 때(앱이 접속이 안되어 있는 경우 등) 구글 서버를 통해 푸시(앱이 등록한 토큰 이용)를 보냄

---
## Cloud Messaging (3rd Party 서버)
* Curl을 이용하여 서버 없이 메시징 테스트

<small>
curl --header "Authorization: key=**AIzaSyC3-Rz5MiJmWxBy78io0SG4HYHwPJbTsL0"**
      --header Content-Type:"application/json"
       https://fcm.googleapis.com/fcm/send
      -d "{ \"notification\": { \"title\": \“title here\",  \"text\": \“message body here\"  },  \"to\" : \"*edGuBDxqN4o:APA91bG3pEr0EOIZcSskSvPviMm0yzvulS-DehnaN16wGeGqoMCbt-ZLgZn26fe0S4PVKluJOZDVkYsZecA_VeDvT0Fe-6XI8MZsM5FqN3XJX6o_LnSmAbXt3JwVGCiYuWP9ioyTk8lO*\"}"
</small>

* **Authorization: key**는 firebase console (https://console.firebase.google.com) 에서 프로젝트 설정 > 클라우드 메시징에서 확인 가능 (Firebase Cloud Messaging 토큰)
* *To*의 값은 앱에서 등록한 토큰
    - FirebaseInstanceId.getInstance().getToken()의 리턴 값
