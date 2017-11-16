# Firebase Realtime Database

## 실습 개요

Firebase의 Realtime Database를 실습한다.


## Firebase Authentication, Realtime Database준비
* Firebase console(https://console.firebase.google.com/)에 접속
* Authentication(이메일 인증)과 Realtime Database를 사용한다.

## LoginActivity
* 앱을 실행하면 ID, PASSWORD를 입력 받을 수 있는 EditText와 로그인 Button을 갖는 LoginActivity가 실행된다.
* 로그인 Button을 누르면 ID, PASSWORD를 읽어서 로그인 요청을 하고
    - 성공하면 MainActivity를 실행한다.
    - 실패하면 로그인 오류 메시지를 Toast로 보여준다.

## MainActivity
* 로그인이 성공할 경우 나타나는 액티비티임
* 이름, 전화번호를 입력받을 EditText와 ADD Button을 보여준다.
	- ADD Button을 누르면 이름(name)과, 전화번호(phone)를 읽어서 DB에 추가한다.
	```java
	DatabaseReference myRef = database.getReference("contacts")
	key = myRef.push().getKey()
	myRef.child(key).child("name").setValue(name);
	myRef.child(key).child("phone").setValue(phone):
	```
* ADD Button 밑에 이름으로 정렬된 연락처 10개를 목록을 ListView나 TextView로 보여준다.
	```java
	Query contacts = myRef.orderByChild("name").limitToFirst(10);
	contacts.addValueEventListener(new ValueEventListener() {
		@Override
		public void onDataChange(DataSnapshot dataSnapshot) {
			 for (DataSnapshot snapshot: dataSnapshot.getChildren()) {
				snapshot.child("name").getValue(String.class);
				
			}
		}
		...
	});
	```
	
## 테스트
* 연락처를 몇 개 추가한다.
* Firebase console에서 전화번호를 임의로 고쳐본다.
* 앱에서 바뀐 번호가 변경되는지 확인한다.
