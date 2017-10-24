layout: true
.top-line[]

---
class: center, middle
# Firebase(모바일 백앤드서비스)
## Login

---
## 모바일 백앤드 서비스
* 직접 서버를 설치하여 운영
    - 아파치 usergrid: http://usergrid.apache.org
    - BAASBOX: http://www.baasbox.com


* BaaS(Backend as a Service) 사용
    - Google의 백앤드 서비스 - Firebase
    - https://firebase.google.com

---
## Firebase 기능(개발->성장->수익)

<img src="images/firebase.png">

---
## Firebase 시작하기
* Android Studio 2.2 이상 필요
    - 구글 계정 필요!


* Tools > Firebase 메뉴 선택
    - 오른쪽 같은 Assistant가 생김


* Authentication 을 선택하고
    - Email and password authentication
    - 선택

<img src="images/firebase1.png" width=400px style="top:100px; right:100px; position:absolute;">

---
## Firebase 시작하기
* Connect to Firebase 버튼
* 권한 요청 페이지가 뜨면 ‘허용＇  
<img src="images/firebase_perm.png" width=300px>

<img src="images/connectfirebase.png" width=400px style="top:150px; right:100px; position:absolute;">

---
## Firebase 시작하기
* 새 프로젝트 이름 입력 하거나
* 기존 프로젝트에서 선택

<img src="images/firebase_new.png" width=500px style="top:150px; right:100px; position:absolute;">

---
## Firebase 시작하기
* Project 보기로 바꾼 후 app 폴더 밑에 보면
* google-services.json 이란 파일이 추가되었음  
<img src="images/firebasejson.png" width=300px>

---
## Firebase Authentication
* Add Firebase Authentication to your app 버튼

<img src="images/firebaseauth.png" width=400px>
<img src="images/firebaseauth2.png" width=400px>

---
## Authentication
* 인증 객체 가져오기, 인증 상태 리스너

```java
private FirebaseAuth mAuth;
private FirebaseAuth.AuthStateListener mAuthListener;

@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_login);

*   mAuth = FirebaseAuth.getInstance();   // 인증 객체 가져오기

*   mAuthListener = new FirebaseAuth.AuthStateListener() {  // 인증 상태 리스너
        @Override
*       public void onAuthStateChanged(@NonNull FirebaseAuth firebaseAuth) {
            FirebaseUser user = firebaseAuth.getCurrentUser();
            if (user != null) {
                Log.d(TAG, "onAuthStateChanged:signed_in:" + user.getUid());
            } else {
                Log.d(TAG, "onAuthStateChanged:signed_out");
            }
        }
    };
}
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/LoginActivity.java#L40-L58]

---
## Authentication
* 인증 상태 리스너 시작/멈춤

```java
@Override
public void onStart() {
    super.onStart();
    mAuth.addAuthStateListener(mAuthListener);
}

@Override
public void onStop() {
    super.onStop();
    if (mAuthListener != null) {
        mAuth.removeAuthStateListener(mAuthListener);
    }
}
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/LoginActivity.java#L84-L96]

---
## Authentication
* 로그인 시작

```java
public void onButtonLogin(View v) {
    String email = ((EditText)findViewById(R.id.etEmail)).getText().toString();
    String password = ((EditText)findViewById(R.id.etPassword)).getText().toString();
*   mAuth.signInWithEmailAndPassword(email, password)  // Task 객체 리턴
*       .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
            @Override
*           public void onComplete(@NonNull Task<AuthResult> task) {
                Log.d(TAG, "signInWithEmail:onComplete:" + task.isSuccessful());
*               if (!task.isSuccessful()) { // 로그인 실패
                    Log.w(TAG, "signInWithEmail", task.getException());
                    Toast.makeText(LoginActivity.this, "Authentication failed.",
                                Toast.LENGTH_SHORT).show();
                }
            }
        });
}
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/LoginActivity.java#L61-L82]

---
## Authentication
* 로그 아웃

```java
    FirebaseAuth.getInstance().signOut();
```

.footnote[https://github.com/jyheo/AndroidTutorial/blob/master/FirebaseTest/app/src/main/java/com/example/jyheo/firebasetest/MainActivity.java#L115-L118]

---
## Authentication
* 테스트를 위해 콘솔에서 계정 생성 가능(https://console.firebase.google.com)

<img src="images/firebaseconsoleauth.png" width=90%>

---
## Authentication
* 사용자 추가

<img src="images/firebaseconsoleauth2.png" width=90%>


    - FirebaseInstanceId.getInstance().getToken()의 리턴 값
