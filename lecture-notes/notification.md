layout: true
.top-line[]

---
class: center, middle

# 알림(Notification)

---
## 알림(Notification)
* 단말기의 상단 부분에, 앱의 UI와 별도로 사용자에게 메시지를 표시

<img src="images/noti.png" style="position:absolute;left:200px;top:200px;">
<img src="images/noti_expand.png" style="position:absolute;right:200px;top:200px;">

---
## 알림 생성
* NotificationCompat.Builder 객체에서 알림에 대한 UI 정보와 작업을 지정
* NotificationCompat.Builder.build() 호출
    - Notification 객체를 반환
* NotificationManager.notify()를 호출해서 시스템에 Notification 객체를 전달


---
## 단순 알림 생성

```java
NotificationCompat.Builder mBuilder = new NotificationCompat.Builder(this);

mBuilder.setSmallIcon(R.drawable.ic_alarm_on_black_24dp);
mBuilder.setContentTitle(getResources().getString(R.string.notif_title));
mBuilder.setContentText(getResources().getString(R.string.notif_body));

NotificationManager mNotificationManager =
    (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);
// MY_NOTIFICATION_ID allows you to update the notification later on.

mNotificationManager.notify(MY_NOTIFICATION_ID, mBuilder.build());
```

<img src="images/noti_simple.png">

.footnote[https://github.com/jyheo/AndroidTutorial/tree/master/Notification
]
---
## 알림에 액티비티 연결하기
* 알림을 터치하면 연결된 액티비티가 실행되도록 하는 것
    - PendingIntent 사용

```java
NotificationCompat.Builder mBuilder = new NotificationCompat.Builder(this);
mBuilder.setSmallIcon(R.drawable.ic_alarm_on_black_24dp);
mBuilder.setContentTitle(getResources().getString(R.string.notif_title));
mBuilder.setContentText(getResources().getString(R.string.notif_body));

*// PendingIntent
*Intent intent = new Intent(this, TempActivity.class);
*int requestID = (int) System.currentTimeMillis(); //unique requestID
*int flags = PendingIntent.FLAG_CANCEL_CURRENT;
*PendingIntent pIntent =
*                 PendingIntent.getActivity(this, requestID, intent, flags);
*mBuilder.setContentIntent(pIntent);
mBuilder.setAutoCancel(true);NotificationManager mNotificationManager =
        (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
mNotificationManager.notify(MY_NOTIFICATION_ID, mBuilder.build());
```

.footnote[https://github.com/jyheo/AndroidTutorial/tree/master/Notification
]
---
## 알림에 버튼 추가
* 앞의 코드에 아래 코드를 추가하면 버튼이 추가됨

```java
Intent callintent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:1234"));
requestID++; //unique requestID
flags = PendingIntent.FLAG_CANCEL_CURRENT;
pIntent = PendingIntent.getActivity(this, requestID, callintent, flags);
*mBuilder.addAction(R.drawable.ic_phone_black_24dp, "Call", pIntent);
```

<img src="images/noti_button.png">

.footnote[https://github.com/jyheo/AndroidTutorial/tree/master/Notification
]
---
## 알림에 확장 뷰
* 그림이나 장문을 추가하여 확장 뷰를 알림에 넣을 수 있음

```java
NotificationCompat.BigTextStyle btStyle =
        new NotificationCompat.BigTextStyle().bigText(
             getResources().getString(R.string.long_notification_body));
mBuilder.setStyle(btStyle);
```

<img src="images/noti_text.png">

.footnote[https://github.com/jyheo/AndroidTutorial/tree/master/Notification
]
---
## 알림에 확장 뷰
* 그림 넣은 확장 뷰

```java
Bitmap largeIcon = BitmapFactory.decodeResource(getResources(),
                                                R.mipmap.ic_launcher);
NotificationCompat.BigPictureStyle bpStyle =
                new NotificationCompat.BigPictureStyle().bigPicture(largeIcon);
mBuilder.setStyle(bpStyle);
```

<img src="images/noti_picture.png">

.footnote[https://github.com/jyheo/AndroidTutorial/tree/master/Notification
]
