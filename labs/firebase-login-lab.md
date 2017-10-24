# Firebase Login

## 실습 개요
* Firebase의 Login을 실습한다.

## Firebase 준비
* 구글 계정이 없으면 만든다.
* Firebase console(https://console.firebase.google.com/)
    - Authentication에서 사용자를 추가한다.

## LoginActivity
* 앱을 실행하면 ID, PASSWORD를 입력 받을 수 있는 EditText와 로그인 Button을 갖는 LoginActivity가 실행된다.
* 로그인 Button을 누르면 ID, PASSWORD를 읽어서 로그인 요청을 하고
    - 성공하면 MainActivity를 실행한다.
    - 실패하면 로그인 오류 메시지를 Toast로 보여준다.

## MainActivity
* 로그인이 성공할 경우 나타나는 액티비티임
* 여기에서 백 버튼을 누르면 로그 아웃을 하게 한다.
```java
@Override
public void onBackPressed() {
    // your code.
}
```
