layout: true
.top-line[]

---
class: center, middle
# 모바일 백앤드서비스(Firebase)
## Storage, RemoteConfig

---
## Storage
* 이미지, 오디오, 비디오, 사용자가 생성한 데이터 등을 저장하기 위한 공간
    - 유료로 사용하면 백업 기능도 제공

* Firebase Assistant에서 Storage
    - Upload and download a file with Firebase Storage 선택

    <img src="images/firebasestorage.png" width=500px>

---
## Storage
* 한번 Firebase에 연결했다면, Connected로 나옴

<img src="images/firebasestorageadd.png">

* Add Firebase Storage to your app 버튼 클릭

---
## Storage
* Accept Changes

<img src="images/firebasestorageaccept.png">

---
## Storage
* 스토리지 객체 가져오기

```java
private FirebaseStorage mFirebaseStorage;

@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);

    mAuth = FirebaseAuth.getInstance();
    FirebaseUser user = mAuth.getCurrentUser();

*   if (user == null)  // 인증이 정상적으로 된 사용자만…
        finish();

*   mFirebaseStorage = FirebaseStorage.getInstance();

    ...생략...
}
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L36-L44]

---
## Storage
* 스토리지에서 이미지 가져와서 표시하기

```java
private void displayImage() {
*   StorageReference storageRef = mFirebaseStorage.getReferenceFromUrl("gs://myfirebase-332e8.appspot.com/3.jpg");
*   storageRef.getBytes(Long.MAX_VALUE).addOnSuccessListener(new OnSuccessListener<byte[]>() {
        @Override
        public void onSuccess(byte[] bytes) {
            Log.d(TAG, "getBytes Success");
            // Use the bytes to display the image
            Bitmap bmp = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
            ImageView iv = (ImageView)findViewById(R.id.imageView);
            iv.setImageBitmap(bmp);
        }
    }).addOnFailureListener(new OnFailureListener() {
        @Override
        public void onFailure(@NonNull Exception exception) {
            Log.d(TAG, "getBytes Failed");
        }
    });
}
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L62-L81]

---
## Storage
* Firebase 콘솔을 이용하여 스토리지에 파일 업로드

<img src="images/firebaseconsolestorage.png" width=70%>

---
## Storage
* 스토리지의 파일 접근 권한 설정
    - 기본적으로 인증 후에 Storage에 접근이 가능함
    - 공개로 하려면 allow read, write; 로 수정

<img src="images/firebaseconsolestoragerule.png" width=90%>

---
## Remote Config
* 앱의 동작을 원격 클라우드에서 변경할 수 있음

<img src="images/firebaserc.png">

<img src="images/firebaserc2.png">

---
## Remote Config

```java
private FirebaseRemoteConfig mFirebaseRemoteConfig;

@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);

    mFirebaseRemoteConfig = FirebaseRemoteConfig.getInstance();

    FirebaseRemoteConfigSettings configSettings = new FirebaseRemoteConfigSettings.Builder()
*           .setDeveloperModeEnabled(BuildConfig.DEBUG)  // 개발자 모드로.
            .build();
    mFirebaseRemoteConfig.setConfigSettings(configSettings);
    mFirebaseRemoteConfig.setDefaults(R.xml.remote_config_defaults);

    displayConfig();
}

private void displayConfig() {
    Boolean cheat_enabled = mFirebaseRemoteConfig.getBoolean("cheat_enabled");
    ((TextView)findViewById(R.id.textView_cheat)).setText("cheat_enabled=" + cheat_enabled);
    long price = mFirebaseRemoteConfig.getLong("your_price");
    ((TextView)findViewById(R.id.textView_price)).setText("your_price is " + price);
}
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L45-L58]

---
## Remote Config
* 기본 설정 파일 만들기
    - New > Android Resource File
    - R.xml.remote_config_defaults
    <img src="images/firebasercdefault.png" width=80%>

---
## Remote Config
* res/xml/remote_config_defaults.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<defaultsMap xmlns:android="http://schemas.android.com/apk/res/android">
    <entry>
        <key>your_price</key>
        <value>100</value>
    </entry>
    <entry>
        <key>cheat_enabled</key>
        <value>false</value>
    </entry>
</defaultsMap>
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/res/xml/remote_config_defaults.xml]

---
## Remote Config
* Firebase에서 설정 가져오기

```java
public void onFetchButton(View v) {
    long cacheExpiration = 3600; // 1 hour in seconds.
*   // 개발자 모드에서는 cacheExpiration을 0으로 해서 매번 서버로부터 가져오게 함.
*   // 개발자 모드가 아니면 자주 RemoteConfig를 가져올 수 없음.
    if (mFirebaseRemoteConfig.getInfo().getConfigSettings().isDeveloperModeEnabled()) {
        cacheExpiration = 0;
    }

*   mFirebaseRemoteConfig.fetch(cacheExpiration)
            .addOnCompleteListener(new OnCompleteListener<Void>() {
                @Override
                public void onComplete(@NonNull Task<Void> task) {
                    if (task.isSuccessful()) {
                        Log.d(TAG, "Fetch Succeeded");
                        // Once the config is successfully fetched it must be activated
                        //  before newly fetched values are returned.
*                       mFirebaseRemoteConfig.activateFetched();
                    } else {
                        Log.d(TAG, "Fetch failed");
                    }
                    displayConfig();
                }
            });
}
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L90-L113]

---
## Remote Config
* Firebase 콘솔에서 설정 만들기

<img src="images/firebaseconsolerc.png" width=90%>


    - FirebaseInstanceId.getInstance().getToken()의 리턴 값
