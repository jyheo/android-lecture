layout: true
.top-line[]

---
class: center, middle
# 브로드캐스트 리시버

---
## 목차
* 브로드캐스트
    - 시스템 브로드캐스트
* 브로드캐스트 리시버
* 인텐트 필터
* 인텐트 필터 – SMS 수신

---
## 브로드캐스트(Broadcasts)
* 브로드캐스트 메시지 송수신
    - 안드로이드 시스템이나 다른 앱과 통신
* 브로드캐스트
    - Airplane 모드 온/오프
    - 충전 시작
    - 문자 수신
    - 커스텀 브로드캐스트
* 앱에서 특정 브로드캐스트를 받기 위해서
    - 시스템에 특정 브로드캐스트 수신을 등록(register)
    - 해당 브로드캐스트가 발생하면 시스템은 등록된 앱들에게 전달

.footnote[https://developer.android.com/guide/components/broadcasts.html]

---
## 시스템 브로드캐스트
* 시스템에서 특정 이벤트 발생시 보내는 브로드캐스트
    - 브로드캐스트는 Intent로 만들어져서 전달됨
        + Intent에 extra 데이터가 있기도 함
        + Intent를 받기 위해 IntentFilter가 필요함
    - 시스템 브로드캐스트 전체 목록
      + Sdk/platforms/android-25/data/broadcast_actions.txt

---
## 브로드캐스트 리시버(받기)
* 두 가지 방법이 가능
    - Manifest에 리시버 정의하기
    - 컨텍스트에 리시버 정의하기

---
## Manifest로 브로드캐스트 리시버
* AndroidManifest.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest >
    <application
        … 생략
        <activity android:name=".MainActivity">
            … 생략
        </activity>
        <receiver
*           android:name=".MyBroadcastReceiver" android:enabled="true" android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.AIRPLANE_MODE"/>
                <action android:name="android.intent.action.BATTERY_CHANGED"/>
            </intent-filter>
        </receiver>
    </application>
</manifest>
```

* exported 속성은 해당 리시버가 앱 외부에서도 호출 가능한지를 나타냄

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/BroadcastApp/app/src/main/AndroidManifest.xml]

---
## Manifest로 브로드캐스트 리시버(계속)
* MyBroadcastReceiver.java

```java
public class MyBroadcastReceiver extends BroadcastReceiver {
    private static final String TAG = "MyBroadcastReceiver";

    @Override
    public void onReceive(Context context, Intent intent) {
        StringBuilder sb = new StringBuilder();
        sb.append("Action: " + intent.getAction() + "\n");
        sb.append("URI: " + intent.toUri(Intent.URI_INTENT_SCHEME).toString() + "\n");
        String log = sb.toString();
        Log.d(TAG, log);
        Toast.makeText(context, log, Toast.LENGTH_LONG).show();
    }
}
```

* 실행 결과: 에어플래인 모드를 켜고 끌때마다 토스트 메시지와 로그가 출력됨

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/BroadcastApp/app/src/main/java/com/example/jyheo/broadcastapp/MyBroadcastReceiver.java]

---
## 컨텍스트에 리시버 정의하기
1. 앞의 경우와 마찬가지로
    - BroadcastReceiver를 상속 받은 MyBroadcastReceiver 클래스 생성
    - Manifest에 MyBroadcastReceiver를 위한 &lt; receiver&gt; 추가(단, &lt; intent-filter&gt; 는 제외)
2. MyBroadcastReceiver 객체 생성
3. IntentFilter생성하고 registerReceiver()로 등록
4. 등록을 취소하려면 unregisterReceiver() 호출
    - 보통 onCreate()나 onResume()에서 등록
    - onDestroy()나 onPause()에서 등록 취소

---
## 컨텍스트에 리시버 정의하기(계속)

```java
public class MainActivity extends AppCompatActivity {

    BroadcastReceiver br = new MyBroadcastReceiver();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        IntentFilter intentFilter = new IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION);
        intentFilter.addAction(Intent.ACTION_AIRPLANE_MODE_CHANGED);
        // CONNECTIVITY_ACTION과 AIRPLANE_MODE_CHANGED 두개의 브로드캐스트를 받기 위한 인텐트 필터

        registerReceiver(br, intentFilter);
    }

    @Override
    protected void onDestroy() {
        unregisterReceiver(br);
        super.onDestroy();
    }
}
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/BroadcastApp/app/src/main/java/com/example/jyheo/broadcastapp/MainActivity.java]

---
## 인텐트 필터
* 앱이 수신할 수 있는 암시적(implicit) 인텐트가 무엇인지 시스템에 통보함
    - Manifest 파일에 &lt; intent-filter&gt; 요소
* &lt; intent-filter&gt;
    - &lt; action&gt; : name 속성에 인텐트 작업 명시
    - &lt; data&gt; : extra 데이터, URI, MIME
    - &lt; category&gt; : 인텐트 카테고리

```xml
<intent-filter>
    <action android:name="android.intent.action.SEND"/>
    <category android:name="android.intent.category.DEFAULT"/>
    <data android:mimeType="text/plain"/>
</intent-filter>
```

---
## 인텐트 필터 – SMS 수신
* 인텐트 필터
    - IntentFilter intentFilter = new IntentFilter(  
      **Telephony.Sms.Intents.SMS_RECEIVED_ACTION**);
* 권한 부여 필요
    - AndroidManifest.xml
    - &lt; uses-permission android:name="android.permission.RECEIVE_SMS" /&gt;
    - 안드로이드 6.0부터는 권한 확인/요청 코드 추가 필요
        + 이전 강의 자료 참고

---
## 인텐트 필터 – SMS 수신 (계속)

```java
public class MySMSReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent.getAction().equals(Telephony.Sms.Intents.SMS_RECEIVED_ACTION)) {
            SmsMessage[] messages = Telephony.Sms.Intents.getMessagesFromIntent(intent);
            if (messages != null) {
                if (messages.length == 0)
                    return;
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < messages.length; i++) {
                    sb.append(messages[i].getMessageBody());
                }
                String sender = messages[0].getOriginatingAddress();
                String message = sb.toString();
                Toast.makeText(context, message, Toast.LENGTH_SHORT).show();
                // prevent any other broadcast receivers from receiving broadcast
                // abortBroadcast();
            }
        }
    }
}
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/BroadcastApp/app/src/main/java/com/example/jyheo/broadcastapp/MySMSReceiver.java]
