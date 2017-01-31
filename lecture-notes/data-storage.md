layout: true
.top-line[]

---
class: center, middle
# 데이터 저장과 관리

---
## Contents
* Files
* SharedPreferences
* SQLite

---
class: center, middle
# Files

---
## 안드로이드 파일 시스템
* Linux 파일 시스템과 java.io의 입출력 스트림에 대한 이해 필수

.left-column-50[
* 내부 저장소
    - 내장 메모리
    - 항상 사용 가능
    - 기본적으로 자신의 앱에서만 액세스 할 수 있음
    - 사용자와 다른 앱이 앱의 파일에 직접 액세스하는 것을 원치 않을 때 적합
]

.right-column-50[
* 외부 저장소
    - 이동식 저장장치 (SD 카드)
    - 외부 저장소의 마운트 여부에 따라 사용 가능
    - 모든 사람이 읽을 수 있음
    - 다음 경우에 적합
        + 액세스 제한이 필요치 않은 파일
        + 다른 앱과 공유하기를 원하는 파일
        + 사용자가 컴퓨터에서 액세스 할 수 있도록 허용하는 파일
]

---
## 내부 저장소의 파일 입출력
* 보안상의 제약으로 인해 Context 클래스에서 보안이 적용된 파일 관리 메서드를 별도로 제공
```java
FileOutputStream openFileOutput (String name, int mode)
FileInputStream openFileInput (String name)
```
    - name
        + 파일의 이름으로 경로를 표시하는 '/' 문자가 들어가면 에러
        + 파일의 위치는 /data/data/패키지명/files 디렉토리로 지정
    - mode

모드          | 설명
-------------|---------------------------------------------------
MODE_RPIVATE | 혼자만 사용하는 배타적인 모드로 파일을 생성. (디폴트)
MODE_APPEND  | 파일이 이미 존재할 경우 덮어쓰기 모드가 아닌 추가 모드로 Open.

---
## OpenFileOuput

```java
package com.example.kwanwoo.filetest;
... 생략 ...

    iSave.setOnClickListener(new View.OnClickListener() {    
        public void onClick(View view) {
            String data = input.getText().toString();

            try {
*               FileOutputStream fos = openFileOutput
*                                           ("myfile.txt",             // 파일명 지정
*                                             Context.MODE_APPEND);    // 저장모드
             PrintWriter out = new PrintWriter(fos);
                 out.println(data);
                 out.close();

                 result.setText("file saved");
            } catch (Exception e) {
                 e.printStackTrace();
            }
        }
    });
```

**myfile.txt** 는 data/data/com.example.kwanwoo.filetest/files/ 에 위치

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/FileTest/app/src/main/java/com/example/kwanwoo/filetest/MainActivity.java]

---
## OpenFileInput

```java
    iLoad.setOnClickListener(new View.OnClickListener() {
        public void onClick(View view) {
            try {
                // 파일에서 읽은 데이터를 저장하기 위해서 만든 변수
                StringBuffer data = new StringBuffer();
*               FileInputStream fis = openFileInput("myfile.txt");  //파일명
                BufferedReader buffer = new BufferedReader(new InputStreamReader(fis));
                String str = buffer.readLine(); // 파일에서 한줄을 읽어옴
                while (str != null) {
                    data.append(str + "\n");
                    str = buffer.readLine();
                }
                result.setText(data); // 파일에서 읽은 데이터를 출력
                buffer.close();
            } catch (FileNotFoundException e) {
                result.setText("File Not Found");
            }
        }
    });
```

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/FileTest/app/src/main/java/com/example/kwanwoo/filetest/MainActivity.java]

---
## res/raw 폴더 파일 이용하기
* 대용량의 읽기 전용 데이터 파일은 리소스에 포함시켜 두는 것이 좋다.
    - ( ex: 게임의 지도 맵 데이터, 우편 번호부, 영한사전 데이터 등 )
* 포함시킬 파일은 res/raw에 복사해 둔다
* 리소스의 파일을 읽을 때는 Resources 객체의 메서드를 사용하며, id로는 확장자를 뺀 파일명을 부여한다.
    - InputStream openRawResource (int id)
    - 모든 file resource는 접미사(확장자)를 제외하고 유일한 이름을 가져야 한다.
    - res/raw에 file1.txt 와 file1.dat가 동시에 존재하면 안됨

---
## 외부 저장소 사용하기
1. 외부 저장소 접근 권한 설정
2. 외부 저장소 상태 확인
3. 외부 저장소 사용
    - 다른 앱과 공유되는 파일 입출력
    - 앱 전용 파일 입출력

---
## 1. 외부 저장소의 접근 권한 설정
* 외부 저장소에 데이터를 쓰려면 Manifest 파일에서 **WRITE_EXTERNAL_STORAGE** 권한을 요청해야 합니다.

```xml
<manifest ...>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
</manifest>
```

* Android 6.0 (API level 23) 이상부터는
    - 앱 실행 중에 사용하려는 권한(permission)을 반드시 요청
    - 앱 사용자는 권한의 승인/거부를 결정
    - 앱의 환경설정에서 권한 설정을 언제든지 변경할 수 있음

<img src="images/permission.png" width=150 style="bottom:50px; right: 150px; position:absolute;">

???
오른쪽 그림은 Storage권한을 변경하는 예를 보여주는 것임.

---
## 앱 실행 시 접근 권한 검사 및 요청

```java
void requestPermission() {
    final int REQUEST_EXTERNAL_STORAGE = 1;
    String[] PERMISSIONS_STORAGE = {    // 요청할 권한 목록을 설정
            Manifest.permission.READ_EXTERNAL_STORAGE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE
    };

*   int permission = ActivityCompat.checkSelfPermission(this, 			
			Manifest.permission.WRITE_EXTERNAL_STORAGE);

    if (permission != PackageManager.PERMISSION_GRANTED) {
*       ActivityCompat.requestPermissions(
                this,			// this는 현재 액티비티 객체 인스턴스를 나타냄
                PERMISSIONS_STORAGE,
                REQUEST_EXTERNAL_STORAGE  // 사용자 정의 int 상수.  
        );			// 권한 요청 결과를 받을 때 사용하나, 여기서는 사용되지 않고 있음.
    }
}
```

<img src="images/permissionreq.png" width=200 style="top:150px; right:100px; position:absolute;">

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/FileTest/app/src/main/java/com/example/kwanwoo/filetest/MainActivity.java]

---
## 2. 외부 저장소의 상태 확인
* 외부 저장소를 사용하기 전에 *사용 가능성* 검사
    - static String Environment.getExternalStorageState()
        + 반환값
            - MEDIA_MOUNTED: 미디어가 읽기/쓰기 권한으로 마운트 됨
            - MEDIA_MOUNTED_READ_ONLY: 미디어가 읽기 권한으로 마운트 됨
            - MEDIA_REMOVED: 미디어가 존재하지 않음
            - MEDIA_UNMOUNTED: 미디어가 마운트 안됨

```java
    public boolean isExternalStorageWritable() {
*       String state = Environment.getExternalStorageState();
*       if (Environment.MEDIA_MOUNTED.equals(state)) {
            result.setText("외부메모리 읽기 쓰기 모두 가능");
            return true;
        }
        return false;
    }
```

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/FileTest/app/src/main/java/com/example/kwanwoo/filetest/MainActivity.java]

---
## 3. 외부 저장소 사용 - 다른 앱과 공유되는 파일 입출력
* 공유 디렉토리 (Music, Pictures, Ringtones) 접근하기
    - static File Environment.getExternalStoragePublicDirectory(String type)
        + Type
            - DIRECTORY_MUSIC, DIRECTORY_PICTURES, DIRECTORY_RINGTONES, 등
        + 반환값: 외부저장소의 루트 디렉토리의 지정된 타입의 서브 디렉토리 (예,sdcard/Pictures)

```java
*   File path = Environment.getExternalStoragePublicDirectory
*                           (Environment.DIRECTORY_DOWNLOADS);
    File f = new File(path, "external.txt");      // 경로, 파일명
    FileWriter write = new FileWriter(f, true);   // 지정된 파일에 문자 스트림 쓰기

    PrintWriter out = new PrintWriter(write);     // formatted 출력 스트림
    out.println(data);
    out.close();
```

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/FileTest/app/src/main/java/com/example/kwanwoo/filetest/MainActivity.java]

---
## 3. 외부 저장소 사용 - 앱 전용 파일 입출력
* 외부 저장소의 앱 전용(private) 저장소 디렉토리 접근하기
    - File getExternalFilesDir(String type)    [Context 클래스 메소드]
        + Type
            - DIRECTORY_MUSIC, DIRECTORY_PICTURES, DIRECTORY_RINGTONES, 등
        + 반환값: 외부저장소의 Android/data/패키지명/files 디렉토리 아래의 지정된 타입의 서브 디렉토리
            - (예,sdcard/Android/data/com.example.kwanwoo.filetest/files/Pictures)

```java
*   File f = new File(getExternalFilesDir(null), "demofile.jpg"); // 경로, 파일명
*   InputStream in = getResources().openRawResource(R.raw.ballons);
    OutputStream out = new FileOutputStream(f);

    byte[] data = new byte[in.available()]; //in 스트림으로부터 읽을 바이트 수만큼 배열 생성
    in.read(data);                          // in 스트림으로부터 data를 읽고
    out.write(data);                        // out 스트림에 data를 저장
```

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/FileTest/app/src/main/java/com/example/kwanwoo/filetest/MainActivity.java]

---
class: center, middle
# SharedPreferences

---
## 프레퍼런스
* **프로그램의 설정 정보 (사용자의 옵션 선택 사항 이나 프로그램의 구성 정보)를** 영구적으로 **저장**하는 용도로 사용
* XML 포맷의 텍스트 파일에 정보를 저장.

* **SharedPreferences** 클래스
    - 프레프런스의 데이터를 관리하는 클래스
    - **응용 프로그램 내의 액티비티 간에 공유**하며, 한쪽 액티비티에서 수정 시 다른 액티비티에서도 수정된 값을 읽을 수 있다.
    - 응용 프로그램의 고유한 정보이므로 **외부에서는 읽을 수 없다.**

---
## SharedPreferences 객체 얻기
* **SharedPreferences** 객체를 얻는 2 가지 방법
    - **public SharedPreferences getSharedPreferences (String name, int mode)**
        + 첫 번째 인수 : 프레프런스를 저장할 XML 파일의 이름이다.
        + 두 번째 인수 : 파일의 공유 모드
            - MODE_PRIVATE: 읽기 쓰기가 가능

    - **public SharedPreferences getPreferences(int mode)**
        + 생성한 액티비티 전용이므로 같은 패키지의 다른 액티비티는 읽을 수 없다.
        + 액티비티와 동일한 이름의 XML 파일 생성

---
## 프레퍼런스의 데이터 읽기
* 프레퍼런스에 저장된 여러 타입의 정보를 **SharedPreferences 객체의 다음 메서드**를 이용하여 읽을 수 있다
    - int getInt (String key, int defValue)
    - String getString (String key, String defValue)
    - boolean getBoolean (String key, boolean defValue)    
        + *key* 인수 : 데이터의 이름 지정
        + *defValue* 인수 : 값이 없을 때 적용할 디폴트 지정.

---
## 프레퍼런스에 데이터 저장하기
* 프레프런스는 키와 값의 쌍으로 데이터를 저장
    - 키는 정보의 이름이며 값은 정보의 실제값

* **SharedPreferences.Editor** 이용하여 프레프런스에 값을 저장
    - 데이터 저장 시 프레퍼런스의 **edit() 메서드를 호출하여 Editor 객체를 먼저 얻음.**
    - Editor 객체에는 값을 저장하고 관리하는 메서드가 제공됨
        + SharedPreferences.Editor putInt(String key, int value)
        + SharedPreferences.Editor putBoolean(String key, int value)
        + SharedPreferences.Editor putString(String key, String value)
        + SharedPreferences.Editor remove(String key)
        + SharedPreferences.Editor clear()
        + Boolean commit()
    - Editor는 모든 변경을 모아 두었다가 **commit() 메소드를 통해 한꺼번에 적용**

---
## SharedPreferences Example

```java
public class MainActivity extends AppCompatActivity {
*   public static final String	PREFERENCES_GROUP = "MyPreference";
    public static final String 	PREFERddENCES_ATTR = "TextInput";
*   SharedPreferences	setting;

    public void onCreate(Bundle savedInstanceState) {
        ... 생략 ...
*       setting = getSharedPreferences(PREFERENCES_GROUP, MODE_PRIVATE);
        final EditText textInput = (EditText) findViewById(R.id.textInput1);
*       textInput.setText(retrieveText());

        Button btn = (Button) findViewById(R.id.button1);
        btn.setOnClickListener( new View.OnClickListener() {
            public void onClick(View v) {
                String name = textInput. getText().toString();
*               saveText(name);
            }    
        });
    }
```

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/SharedPreferenceTest/app/src/main/java/com/example/kwanwoo/sharedpreferencetest/MainActivity.java]

---
## SharedPreferences Example (계속)

```java
    private String retrieveText() {
        String initText="";
        if (setting.contains(PREFERENCES_ATTR)) {
*           initText = setting.getString(PREFERENCES_ATTR, "");
        }
        return initText;
    }

    private void saveText(String text) {
*       SharedPreferences.Editor editor = setting.edit();
*       editor.putString(PREFERENCES_ATTR, text);
*       editor.commit();
    }
}
```

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/SharedPreferenceTest/app/src/main/java/com/example/kwanwoo/sharedpreferencetest/MainActivity.java]


---
class: center, middle
## SQLite

---
## SQLite
* SQLite 라이브러리
    - SQL (Structured Query Language) 문을 이용해 데이터를 조회하는 관계형 데이터베이스
    - 안정적 이며, 소규모 데이터베이스에 적합
    - 단순한 파일로 데이터를 저장 (별도의 서버 연결 및 권한 설정 불필요)
    - 복수 사용자는 지원되지 않음
    - 안드로이드의 일부로 포함됨

<img src="images/sqlite.png" style="display:block; margin: auto;">

---
## SQL 구문
* 데이터 정의 언어 (Data Definition Language)
    - CREATE   [https://ko.wikipedia.org/wiki/CREATE_(SQL)]
    - DROP     [https://ko.wikipedia.org/wiki/CREATE_(SQL)]
    - ALTER     [https://ko.wikipedia.org/wiki/ALTER_(SQL)]
* 데이터 조작 언어 (Data Manipulation Language)
    - INSERT INTO [https://ko.wikipedia.org/wiki/Insert_(SQL)]
    - UPDATE ~ SET [https://ko.wikipedia.org/wiki/Update_(SQL)]
    - DELETE FROM [https://ko.wikipedia.org/wiki/Delete_(SQL)]
    - SELECT ~ FROM ~ WHERE [https://ko.wikipedia.org/wiki/Select_(SQL)]

---
## SQLiteOpenHelper 클래스
* DB 생성 및 열기 담당
* SQLiteOpenHelper는 추상 클래스 이므로, 서브클래스에서 생성자와 아래의 메소드를 재정의함
    - 생성자
```java
SQLiteOpenHelper(
    Context context,                        // DB 생성 컨텍스트, 보통 메인 액티비티
    String name,	                          // DB 파일 이름
    SQLiteDatabase.CursorFactory factory,   // 표준커서 사용시 null
    int version)                            // DB 버전
```

메서드     | 설명
----------|--------------------------------
onCreate  | DB가 처음 만들어질 때 호출됨. 테이블을 생성하고 초기 레코드를 삽입한다.
onUpgrade | DB 업그레이드 시 호출됨. 기존 테이블 삭제 및 생성하거나 ALTER TABLE로 스키마 수정

---
## 예제 코드

```java
public class MyDBHelper extends SQLiteOpenHelper {
*   private static final String DB_NAME="schedule.db";
    private static final int DATABASE_VERSION = 1;

    public MyDBHelper(Context context) {
        super(context, DB_NAME, null, DATABASE_VERSION);
    }

    public void onCreate(SQLiteDatabase db) {
*       db.execSQL("CREATE TABLE schedule (" +
*               "_id INTEGER  NOT NULL PRIMARY KEY," +
*               "title TEXT  NULL," +
*               "datetime DATETIME  NULL" +
*               ");");
    }

    public void onUpgrade(SQLiteDatabase db, int i, int i1) {
*       db.execSQL("DROP TABLE IF EXISTS schedule");
        onCreate(db);
    }
```

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/SQLiteDBTest/app/src/main/java/com/example/kwanwoo/sqlitedbtest/MyDBHelper.java]

---
## SQLiteOpenHelper 클래스
* DB 접근 시 아래의 메서드를 호출하여 DB객체를 얻는다.

메서드               | 설명
--------------------|--------------------------------------------------------------------
getReadableDatabase | 읽기 위해 DB open. DB가 없거나 버전 변경 시 onCreate, onUpgrade가 호출됨.
getWritableDatabase | 읽고 쓰기 위해 DB open. 권한이 없거나 디스크 용량 부족 시 실패한다.
close               | DB를 닫는다.

* 쿼리 실행
    - **void execSQL (String sql)**
        + SELECT 명령을 제외한 대부분의 명령을 직접 실행
    - **Cursor rawQuery(String sql, String[] selectionArgs)**
        + SELECT sql 문을 실행

---
## 예제 코드 (INSERT)

```java
    button.setOnClickListener(new View.OnClickListener() {
          @Override
          public void onClick(View view) {
              EditText title = (EditText)findViewById(R.id.title1);
              try {
*                 String sql = String.format (
*                         "INSERT INTO schedule (_id, title, datetime)\n"+
*                         "VALUES (NULL, '%s', '%s')",
*                         title.getText(), getDateTime());                          
*                 helper.getWritableDatabase().execSQL(sql);
              } catch (SQLException e) {
                  Log.e(TAG,"Error inserting into DB");
              }
          }
    });
```

**getDateTime():** "yyyy-MM-dd HH:mm:ss" 형식의 문자열 반환

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/SQLiteDBTest/app/src/main/java/com/example/kwanwoo/sqlitedbtest/MainActivity.java]

---
## 예제 코드 (DELETE)

```java
    button1.setOnClickListener(new View.OnClickListener() {
          @Override
          public void onClick(View view) {
              EditText title2 = (EditText)findViewById(R.id.title2);
              try {
*                 String sql = String.format (
*                             "DELETE FROM schedule\n"+
*                             "WHERE title = '%s'",
*                             title2.getText());

*                 helper.getWritableDatabase().execSQL(sql);
              } catch (SQLException e) {
                  Log.e(TAG,"Error deleting recodes");
              }
          }
    });
```

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/SQLiteDBTest/app/src/main/java/com/example/kwanwoo/sqlitedbtest/MainActivity.java]

---
## 예제 코드 (UPDATE)

```java
    button2.setOnClickListener(new View.OnClickListener() {
          @Override
          public void onClick(View view) {
              EditText title3 = (EditText)findViewById(R.id.title3);
              EditText title4 = (EditText)findViewById(R.id.title4);
              try {
*                 String sql = String.format (
*                         "UPDATE  schedule\n"+
*                         "SET title = '%s'\n"+
*                         "WHERE title='%s'",
*                                title4.getText(), title3.getText()) ;
                  helper.getWritableDatabase().execSQL(sql);
              } catch (SQLException e) {
                  Log.e(TAG,"Error deleting recodes");
              }
          }
    });
```

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/SQLiteDBTest/app/src/main/java/com/example/kwanwoo/sqlitedbtest/MainActivity.java]

---
## 예제 코드 (SELECT)

```java
    button3.setOnClickListener(new View.OnClickListener() {
          @Override
          public void onClick(View view) {
              TextView result = (TextView)findViewById(R.id.result);
*             String sql = "Select * FROM schedule";
*             Cursor cursor = helper.getReadableDatabase().rawQuery(sql,null);
              StringBuffer buffer = new StringBuffer();
*             while (cursor.moveToNext()) {
*                 buffer.append(cursor.getString(1)+"\t");
*                 buffer.append(cursor.getString(2)+"\n");
              }
              result.setText(buffer);
          }
    });
```

<img src="images/sqliteselect.png" width=500>

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap7/SQLiteDBTest/app/src/main/java/com/example/kwanwoo/sqlitedbtest/MainActivity.java]

???
Cursor의 getString(int columnIndext) 메소드는 문자열 형태로 columnIndex에 해당하는 테이블의 속성 값을 리턴한다.
즉, cursor.getString(1)은 schedule 테이블의 title 속성을 리턴하고,
cursor.getString(2)는 schedule 테이블의 datetime 속성을 리턴한다.

---
## SQLite Cursor
* 쿼리 결과는 결과셋 자체가 리턴되지 않으며 위치를 가리키는 커서(Cursor)로 리턴된다
    - 커서의 메소드 목록

메서드          | 설명
---------------|-----------------------------------------------------------
close          | 결과셋을 닫는다.
getColumnCount | 컬럼의 개수를 구한다
getColumnIndex | 이름으로부터 컬럼 번호를 구한다.
getColumnName  | 번호로부터 컬럼 이름을 구한다.
getCount       | 결과셋의 레코드 개수를 구한다.
getInt         | 컬럼값을 정수로 구하며 인수로 컬럼 번호를 전달한다.
getDouble      | 컬럼값을 실수로 구한다.
getString      | 컬럼값을 문자열로 구한다.
moveToFirst    | 첫 레코드 위치로 이동하며, 결과셋이 비어있을 시 false를 리턴한다.
moveToLast     | 마지막 레코드 위치로 이동하며, 결과셋이 비어있을 시 false를 리턴한다.
moveToNext     | 다음 레코드 위치로 이동하며, 마지막 레코드이면 false를 리턴한다.
moveToPrevious | 이전 레코드로 이동하며, 첫 레코드이면 false를 리턴한다.
moveToPosition | 임의의 위치로 이동한다.
