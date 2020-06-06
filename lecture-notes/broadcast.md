---
marp: true
theme: my-theme
paginate: true
headingDivider: 2
header: 
footer: https://github.com/jyheo/android-lecture
backgroundColor: #fff
backgroundImage: url('images/background.png')
---

# 브로드캐스트 리시버
<!-- _class: lead -->
### 허준영(jyheo@hansung.ac.kr)


## 목차
* 브로드캐스트
    - 시스템 브로드캐스트
* 브로드캐스트 리시버
    -  Manifest로 브로드캐스트 리시버
    - 컨텍스트에 리시버 정의하기
* SMS 수신하기


## 브로드캐스트(Broadcast)
* 브로드캐스트 메시지 송수신
    - 안드로이드 시스템이나 다른 앱과 통신
* 브로드캐스트
    - 시간 변경
    - Airplane 모드 온/오프
    - 충전 시작
    - 문자 수신
    - 커스텀 브로드캐스트
* 앱에서 특정 브로드캐스트를 받기 위해서
    - 시스템에 특정 브로드캐스트 수신을 등록(register)
    - 해당 브로드캐스트가 발생하면 시스템은 등록된 앱들에게 전달
* https://developer.android.com/guide/components/broadcasts.html


## 시스템 브로드캐스트
* 시스템에서 특정 이벤트 발생시 보내는 브로드캐스트
    - 브로드캐스트는 Intent로 만들어져서 전달됨
        + Intent에 extra 데이터가 있기도 함
        + Intent를 받기 위해 IntentFilter가 필요함
    - 시스템 브로드캐스트 전체 목록
      + Sdk/platforms/android-##/data/broadcast_actions.txt


## 브로드캐스트 리시버(받기)
* 두 가지 방법이 가능
    - Manifest에 리시버 정의하기
    - 컨텍스트에 리시버 정의하기


## Manifest로 브로드캐스트 리시버
* AndroidManifest.xml
    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <manifest >
        <application
            … 생략 >
            <activity android:name=".MainActivity">
                … 생략
            </activity>
            <receiver
                android:name=".MyBroadcastReceiver"
                android:enabled="true"
                android:exported="true">
                <intent-filter>
                    <action android:name="android.intent.action.TIME_SET" />                                
                </intent-filter>
            </receiver>
        </application>
    </manifest>
    ```
* TIME_SET (시간 변경)이 발생하면 MyBroadcastReceiver의 onReceive 호출됨
* exported 속성은 해당 리시버가 앱 외부에서도 호출 가능한지를 나타냄


## Manifest로 브로드캐스트 리시버(계속)
* MyBroadcastReceiver.java
    ```java
    public class MyBroadcastReceiver extends BroadcastReceiver {
        private static final String TAG = "MyBroadcastReceiver";

        @Override
        public void onReceive(Context context, Intent intent) {
            String log = "Action: " + intent.getAction() + "\n" +
                    "URI: " + intent.toUri(Intent.URI_INTENT_SCHEME);
            Log.d(TAG, log);
        }
    }
    ```
* 실행 결과: 설정에서 시간을 변경하면 Log가 출력됨


## 컨텍스트에 리시버 정의하기
1. BroadcastReceiver를 상속 받은 MyBroadcastReceiver 클래스 생성
2. MyBroadcastReceiver 객체 생성
3. IntentFilter생성하고 registerReceiver()로 등록
4. 등록을 취소하려면 unregisterReceiver() 호출
    - 보통 onCreate()나 onStart()에서 등록
    - onDestroy()나 onStop()에서 등록 취소


## 컨텍스트에 리시버 정의하기(계속)
```java
public class MainActivity extends AppCompatActivity {
    private MyBroadcastReceiver mReceiver;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        final ActivityMainBinding binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());
        mReceiver = new MyBroadcastReceiver();        
    }

    @Override
    protected void onStart() {
        super.onStart();
        registerReceiver(mReceiver, new IntentFilter(Intent.ACTION_TIME_CHANGED));
    }

    @Override
    protected void onStop() {
        super.onStop();
        unregisterReceiver(mReceiver);
    }
```


## SMS 수신하기
* 인텐트 필터
    ```java
    new IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION);
    ```
* 권한 부여 필요
    - AndroidManifest.xml
        ```xml
        <uses-permission android:name="android.permission.RECEIVE_SMS" />
        ```
    - 안드로이드 6.0부터는 권한 확인/요청 코드 추가 필요
        ```java
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.RECEIVE_SMS) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.RECEIVE_SMS}, RC_SMS_RECEIVED);
        }
        ```
* BroadcastReceiver에서 Activity로 수신 메시지 전달, 리스너(콜백) 사용
    ```java
    interface OnSmsReceived {
        void onReceived(String msg);
    }
    ```


## SMs 수신하기 (계속)
* AndroidManifest.xml - 권한 추가
    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
        package="com.example.broadcastapp">

        <uses-permission android:name="android.permission.RECEIVE_SMS" />

        <application
    ```


## SMS 수신하기 (계속)
* MainActivity.java
    ```java
    public class MainActivity extends AppCompatActivity {
        private MySMSReceiver mReceiver;
        private final int RC_SMS_RECEIVED = 1;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            final ActivityMainBinding binding = ActivityMainBinding.inflate(getLayoutInflater());
            setContentView(binding.getRoot());

            mReceiver = new MySMSReceiver();
            mReceiver.setOnSmsReceived(new SmsReceiver.OnSmsReceived() {
                @Override
                public void onReceived(String msg) {
                    binding.textview.setText(msg);
                }
            });

            if (ActivityCompat.checkSelfPermission(this, Manifest.permission.RECEIVE_SMS) != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.RECEIVE_SMS}, RC_SMS_RECEIVED);
            }
        }

        @Override
        protected void onStart() {
            super.onStart();
            registerReceiver(mReceiver, new IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION));
        }
    ```

## SMS 수신하기 (계속)
* MainActivity.java (계속)
    ```java
        @Override
        protected void onStop() {
            super.onStop();
            unregisterReceiver(mReceiver);
        }

        // 권한 요청 결과를 받는 메소드
        @Override
        public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
            super.onRequestPermissionsResult(requestCode, permissions, grantResults);

            if (requestCode == RC_SMS_RECEIVED) {
                if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    // permission granted
                } else {
                    new AlertDialog.Builder(this).setTitle("Permission!")
                            .setMessage("RECEIVE_SMS permission is required to receive SMS.\nPress OK to grant the permission.")
                            .setPositiveButton("OK", ((dialog, which) -> ActivityCompat.requestPermissions(this,
                                    new String[]{Manifest.permission.RECEIVE_SMS}, RC_SMS_RECEIVED)))
                            .setNegativeButton("Cancel", null)
                            .create().show();
                }
            }
        }
    }
    ```

## SMS 수신하기 (계속)
* MySMSReceiver.java
    ```java
    public class MySMSReceiver extends BroadcastReceiver {

        interface OnSmsReceived {
            void onReceived(String msg);
        }

        private OnSmsReceived onSmsReceived = null;

        public void setOnSmsReceived(OnSmsReceived smsReceived) {
            onSmsReceived = smsReceived;
        }

        @Override
        public void onReceive(Context context, Intent intent) {
            if (Telephony.Sms.Intents.SMS_RECEIVED_ACTION.equals(intent.getAction())) {
                SmsMessage[] messages = Telephony.Sms.Intents.getMessagesFromIntent(intent);
                if (messages != null) {
                    if (messages.length == 0)
                        return;
                    StringBuilder sb = new StringBuilder();
                    for (SmsMessage smsMessage : messages) {
                        sb.append(smsMessage.getMessageBody());
                    }
                    String sender = messages[0].getOriginatingAddress();
                    String message = sb.toString();
                    //Toast.makeText(context, message, Toast.LENGTH_SHORT).show();
                    if (onSmsReceived != null)
                        onSmsReceived.onReceived(message);
                    // prevent any other broadcast receivers from receiving broadcast
                    // abortBroadcast();
                }
            }
        }
    }
    ```

## 전체 소스 코드
* https://github.com/jyheo/android-java-examples/tree/master/BroadcastApp
