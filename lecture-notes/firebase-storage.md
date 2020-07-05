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

# Firebase
<!-- _class: lead -->
### Storage, RemoteConfig
### 허준영(jyheo@hansung.ac.kr)


## Storage
* 이미지, 오디오, 비디오, 사용자가 생성한 데이터 등을 저장하기 위한 공간
    - 유료로 사용하면 백업 기능도 제공
* Firebase Assistant에서 Storage
    - Upload and download a file with Firebase Storage 선택
![](images/firebasestorage.png)


## Storage
* 한번 Firebase에 연결했다면, Connected로 나옴
![](images/firebasestorageadd.png)
* Add Firebase Storage to your app 버튼 클릭


## Storage
* Accept Changes
![](images/firebasestorageaccept.png)


## Storage
* 스토리지 객체 가져오기
    ```java
    private FirebaseStorage mFirebaseStorage;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityMainBinding.inflate(getLayoutInflater());                                 
        setContentView(binding.getRoot());

        mAuth = FirebaseAuth.getInstance();
        if (mAuth.getCurrentUser() == null) {
            finish();
            return;
        }

        mFirebaseStorage = FirebaseStorage.getInstance();        
    }
    ```
    * [github.com/jyheo/android-java-examples/.../FirebaseTest/.../MainActivity.java#L40](https://github.com/jyheo/android-java-examples/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L40)


## Storage
* 스토리지에서 이미지 가져와서 표시하기
    ```java
    private void displayImage() {
        StorageReference storageRef = mFirebaseStorage.getReferenceFromUrl("gs://myfirebase-332e8.appspot.com/3.jpg");
        storageRef.getBytes(Long.MAX_VALUE).addOnSuccessListener(new OnSuccessListener<byte[]>() {
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
    * [github.com/jyheo/android-java-examples/.../FirebaseTest/.../MainActivity.java#L67](https://github.com/jyheo/android-java-examples/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L67)


## Storage
* Firebase 콘솔을 이용하여 스토리지에 파일 업로드
![w:800px](images/firebaseconsolestorage.png)


## Storage
* 스토리지의 파일 접근 권한 설정
    - 기본적으로 인증 후에 Storage에 접근이 가능함
    - 공개로 하려면 allow read, write; 로 수정
![](images/firebaseconsolestoragerule.png)


## Remote Config
* 앱의 동작을 원격 클라우드에서 변경할 수 있음
![](images/firebaserc.png)
![](images/firebaserc2.png)


## Remote Config
* 
    ```java
    private FirebaseRemoteConfig mFirebaseRemoteConfig;
    private ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        mAuth = FirebaseAuth.getInstance();
        if (mAuth.getCurrentUser() == null) {
            finish();
            return;
        }

        mFirebaseRemoteConfig = FirebaseRemoteConfig.getInstance();
        FirebaseRemoteConfigSettings configSettings = new FirebaseRemoteConfigSettings.Builder()
                .setMinimumFetchIntervalInSeconds(3600) // For development only not for production!, default is 12 hours
                .build();
        mFirebaseRemoteConfig.setConfigSettingsAsync(configSettings);
        mFirebaseRemoteConfig.setDefaultsAsync(R.xml.remote_config_defaults);        
    }
    ```
    * [github.com/jyheo/android-java-examples/.../FirebaseTest/.../MainActivity.java#L54](https://github.com/jyheo/android-java-examples/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L54)


## Remote Config
* 기본 설정 파일 만들기
    - New > Android Resource File
    - R.xml.remote_config_defaults
    ![w:700px](images/firebasercdefault.png)


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
    * [github.com/jyheo/android-java-examples/.../FirebaseTest/.../remote_config_defaults.xml](https://github.com/jyheo/android-java-examples/blob/master/FirebaseTest/app/src/main/res/xml/remote_config_defaults.xml)


## Remote Config
* Firebase에서 설정 가져와서 적용
    ```java
    public void onFetchButton(View v) {
        mFirebaseRemoteConfig.fetchAndActivate()
                .addOnCompleteListener(this, new OnCompleteListener<Boolean>() {
                    @Override
                    public void onComplete(@NonNull Task<Boolean> task) {
                        if (task.isSuccessful()) {
                            boolean updated = task.getResult();
                            Log.d(TAG, "Config params updated: " + updated);
                        } else {
                            Log.d(TAG, "Fetch failed");
                        }
                        displayConfig();  // 가져온 설정 읽기(다음 슬라이드)
                    }
                });
    }
    ```
    * [github.com/jyheo/android-java-examples/.../FirebaseTest/.../MainActivity.java#L95](https://github.com/jyheo/android-java-examples/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L95)


## Remote Config
* 가져온 설정 읽기
    ```java
    private void displayConfig() {
        boolean cheat_enabled = mFirebaseRemoteConfig.getBoolean("cheat_enabled");
        binding.textViewCheat.setText("cheat_enabled=" + cheat_enabled);
        long price = mFirebaseRemoteConfig.getLong("your_price");
        binding.textViewPrice.setText("your_price is " + price);
    }
    ```
    * [github.com/jyheo/android-java-examples/.../FirebaseTest/.../MainActivity.java#L88](https://github.com/jyheo/android-java-examples/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L88)


## Remote Config
* Firebase 콘솔에서 설정 만들기
![](images/firebaseconsolerc.png)


