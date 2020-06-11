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

# File, Preferences
<!-- _class: lead -->
### 허준영(jyheo@hansung.ac.kr)


## 데이터 저장 방법
* 데이터 저장 방법
    - 특정 앱 전용 파일: 내부 또는 외부 저장소 사용
    - 공유 파일: MediaStore API 이용, 외부 저장소 사용
    - Preference: 키-값 형식으로 저장, 내부 저장소 사용
    - 데이터베이스: SQLite 또는 Room 라이브러리를 이용하여 구조화된 형태로 데이터 저장
* 내부 저장소(Internal Storage)
    - 기본적으로 자신의 앱에서만 액세스
    - 사용자와 다른 앱이 앱의 파일에 직접 액세스하는 것을 원치 않을 때 적합
    - 상대적으로 크기가 작음
* 외부 저장소(External Storage)
    - 여러 파티션으로 나누어져 있기도 함
    - SD카드도 여기에 포함됨


## 특정 앱 전용 파일
* Context의 저장소 경로 알아오는 메소드 사용
* 내부 저장소에서 사용할 때
    - getFilesDir()
    - getCacheDir(), 임시 파일용
* 외부 저장소에서 사용할 때
    - getExternalFilesDir()
    - getExternalCacheDir(), 임시 파일용
    - API level 19 이상에서는 별도의 권한 없어도 사용 가능


## 특정 앱 전용 파일
* File 객체 생성하여 자바의 파일 입출력 API 사용
    ```java
    final String filename = "appfile.txt";
    File f1 = new File(getFilesDir(), filename);
    // f1은 내부 저장소의 앱 전용 파일
    FileOutputStream fos = new FileOutputStream(f1);
    fos.write( 저장할 데이터 );
    fos.close();

    File f2 = new File(getExternalFilesDir(null), filename);
    // f2는 외부 저장소의 앱 전용 파일
    FileInputStream fis = new FileInputStream(f2);
    byte[] data = new byte[fis.available()];
    fis.read(data);
    fis.close();
    ```

## 외부 저장소 사용 가능 여부 확인
* 외부 저장소는 마운트 되지 않은 경우도 고려해야 함
    - SD카드인데 카드가 제거된 경우
    ```java
    public boolean isExternalStorageMounted() {
        String state = Environment.getExternalStorageState();
        return Environment.MEDIA_MOUNTED.equals(state);
    }
    ```
* 전체 소스 코드
    - https://github.com/jyheo/android-java-examples/tree/master/FileExample



## Preference
* **프로그램의 설정 정보** (사용자의 옵션 선택 사항 이나 프로그램의 구성 정보)를 영구적으로 저장하는 용도로 사용
* XML 포맷의 텍스트 파일에 정보를 저장
* **SharedPreferences** 클래스
    - 프레프런스의 데이터를 관리하는 클래스
    - 응용 프로그램 내의 액티비티 간에 공유하며, 한쪽 액티비티에서 수정 시 다른 액티비티에서도 수정된 값을 읽을 수 있음
    - 응용 프로그램의 고유한 정보이므로 외부에서는 읽을 수 없음


## SharedPreferences 객체 얻기
* SharedPreferences 객체를 얻는 방법
    - public SharedPreferences **getSharedPreferences** (String name, int mode)
        + 첫 번째 인수 : 프레프런스를 저장할 XML 파일의 이름
        + 두 번째 인수 : 동작 모드, 0이나 MODE_PRIVATE으로 쓰면 됨



## 프레퍼런스의 데이터 읽기
* 프레퍼런스에 저장된 여러 타입의 정보를 SharedPreferences 객체의 다음 메서드를 이용하여 읽을 수 있음
    - int getInt (String key, int defValue)
    - String getString (String key, String defValue)
    - boolean getBoolean (String key, boolean defValue)
    - *key* 인수 : 데이터의 이름 지정
    - *defValue* 인수 : 값이 없을 때 적용할 디폴트 지정.


## 프레퍼런스의 데이터 읽기
* 액티비티의 onCreate에서 preference를 읽어서 위젯 내용 변경
    ```java
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        SharedPreferences pref = getSharedPreferences(pref_name, MODE_PRIVATE);
        binding.editName.setText(pref.getString(pref_key_name, ""));
        binding.editAddress.setText(pref.getString(pref_key_address, ""));
        binding.switchMode.setChecked(pref.getBoolean(pref_key_airplane, false));
    }
    ```
* 전체 코드
    - https://github.com/jyheo/android-java-examples/tree/master/Preferences

## 프레퍼런스에 데이터 저장하기
* 프레프런스는 키와 값의 쌍으로 데이터를 저장
    - 키는 정보의 이름이며 값은 정보의 실제값
* **SharedPreferences.Editor** 이용하여 프레프런스에 값을 저장
    - 데이터 저장 시 프레퍼런스의 **edit() 메서드를 호출하여 Editor 객체를 먼저 얻음.**
    - SharedPreferences.Editor 객체에는 값을 저장하고 관리하는 메서드가 제공됨
        + putInt(String key, int value)
        + putBoolean(String key, int value)
        + putString(String key, String value)
        + remove(String key)
        + clear()
        + apply()
    - Editor는 모든 변경을 모아 두었다가 **apply() 메소드를 통해 한꺼번에 적용**

## 프레퍼런스에 데이터 저장하기
* 액티비티의 onDestroy에서 위젯의 값을 preference로 저장
    ```java
    @Override
    protected void onDestroy() {
        super.onDestroy();

        SharedPreferences.Editor pref = 
            getSharedPreferences(pref_name, MODE_PRIVATE).edit();

        pref.putString(pref_key_name, binding.editName.getText().toString());
        pref.putString(pref_key_address, binding.editAddress.getText().toString());
        pref.putBoolean(pref_key_airplane, binding.switchMode.isChecked());
        pref.apply();
    }
    ```
* 전체 코드
    - https://github.com/jyheo/android-java-examples/tree/master/Preferences


## Preference Fragment
* 앱의 설정 UI를 쉽게 만들 수 있는 방법
    - XML로 작성된 설정 구성을 읽어서 UI 프래그먼트를 생성
    - Preference를 이용하여 설정 값을 읽거나 저장, 디폴트 프레퍼런스 사용
    ``` SharedPreferences pref = PreferenceManager.getDefaultSharedPreferences(context); ```
* 안드로이드 스튜디오에서
    - File > New > Activity > Settings Activity를 하면 프래그먼트와 액티비티를 생성
    - File > New > Fragment > Settings Fragment를 하면 프래그먼트만 생성
    - Build.gradle에 preference library dependency도 자동으로 추가됨
    ``` implementation 'androidx.preference:preference:1.1.0' ```
    - res/xml/root_preferences.xml 은 설정 구성 파일, 원하는 내용으로 변경 필요
* 참고: https://developer.android.com/guide/topics/ui/settings


## Preference Fragment
* PreferenceFragmentCompat를 상속하여 프레퍼런스 프래그먼트가 생성됨
    ```java
    class SettingsFragment extends PreferenceFragmentCompat {
        public SettingsFragment() { }

        @Override
        public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
            setPreferencesFromResource(R.xml.root_preferences, rootKey);
        }
    }
    ```


## Preference Fragment
* res/xml/root_preferences.xml
    ```xml
    <PreferenceScreen xmlns:app="http://schemas.android.com/apk/res-auto">
        <PreferenceCategory app:title="@string/messages_header" app:icon="@drawable/ic_baseline_mail_outline_24">
            <EditTextPreference
                app:key="signature"
                app:title="@string/signature_title"
                app:useSimpleSummaryProvider="true" />
            <ListPreference
                app:defaultValue="reply"
                app:entries="@array/reply_entries"
                app:entryValues="@array/reply_values"
                app:key="reply"
                app:title="@string/reply_title"
                app:useSimpleSummaryProvider="true" />
        </PreferenceCategory>
        <PreferenceCategory app:title="@string/sync_header" app:icon="@drawable/ic_baseline_sync_24">
            <SwitchPreferenceCompat
                app:key="sync"
                app:title="@string/sync_title" />
            <SwitchPreferenceCompat
                app:dependency="sync"
                app:key="attachment"
                app:summaryOff="@string/attachment_summary_off"
                app:summaryOn="@string/attachment_summary_on"
                app:title="@string/attachment_title" />
        </PreferenceCategory>
    </PreferenceScreen>
    ```
    

## Preference Fragment
* Preference Fragment가 저장한 프레퍼런스 읽기
    ```java
    SharedPreferences pref = PreferenceManager.getDefaultSharedPreferences(this);
    String str = "signature: " + pref.getString("signature", "") + "\n" +
        "reply: " + pref.getString("reply", "") + "\n" +
        "sync: " + pref.getBoolean("sync", false) + "\n" +
        "attachment: " + pref.getBoolean("attachment", false);
    ```

* 전체 코드
    - https://github.com/jyheo/android-java-examples/tree/master/Preferences