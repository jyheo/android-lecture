# 액티비티와 인텐트 실습

## 1. 액티비티 라이프사이클 실습
### 실습 내용
* FirstActivity와 SecondActivity를 만든다.
* FirstActivity에 버튼을 하나 만들고 버튼을 누르면 SecondActivity를 시작한다.
* 두 액티비티 모두 라이프 사이클 메소드를 오버라이드하고 각 메소드에서 Log.i 를 이용하여 해당 메소드 호출되었음을 알 수 있도록 로그를 출력한다.
* 각 액티비티 전환 시 호출되는 라이프 사이클 콜백을 확인한다.

### 실습 확인
* FirstActivity에서 버튼 눌러서 SecondActivity를 생성한 후 백(Back) 버튼을 누른다. 이 때 표시된 로그를 확인한다.

* 로그 출력 방법:

```java
Log.i(“tag string”, “message”);
// 실제 사용 예:
protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_first);
        Log.i(TAG, getLocalClassName() + ".onCreate");
}
```

* 로그에 대한 한글 블로그: http://m.blog.naver.com/eominsuk55/220229760263

### 참고 소스:
https://github.com/jyheo/AndroidTutorial/tree/master/ActivityIntent

## 2. 액티비티간 정보 교환하기 실습
### 실습 내용
* FirstActivity와 ThirdActivity 를 만든다.
* FirstActivity에 버튼을 하나 만들고 버튼을 누르면 ThirdActivity를 시작한다.
* 이때 FirstActivity는 intent에 putExtra를 이용하여 문자열을 추가
* ThirdActivity는 onCreate에서 getIntent()로 전달 받은 인텐트를 가져온다.
* 받은 인텐트에서 getStringExtra를 이용하여 문자열을 받아 EditText에 표시한다.
* ThirdActivity의 onBackPressed에서 인텐트를 만들어서 setResult 호출
* 이때 인텐트에 putExtra를 이용하여 EditText에 입력된 문자열을 포함시킨다.
* FirstActivity의 onActivityResult에서 전달 받은 인텐트에 포함된 문자열을 Log.i 로 보인다.

### 실습 확인
* 위의 각 단계에 해당하는 소스 코드의 위치에 주석으로 해당 내용을 적어 둔다.

### 참고 소스:
https://github.com/jyheo/AndroidTutorial/tree/master/ActivityIntent
