layout: true
.top-line[]

---

class: center, middle
# 커스텀 뷰

---
## 커스텀 뷰
<img src="images/cv1.jpg" style="position:absolute; left:100px; top:200px; width:200px;">
<img src="images/cv2.png" style="position:absolute; left:300px; top:300px; width:200px;">
<img src="images/cv3.png" style="position:absolute; left:400px; top:200px; width:200px;">
<img src="images/cv4.png" style="position:absolute; left:650px; top:250px; width:200px;">
<img src="images/cv5.png" style="position:absolute; left:750px; top:200px; width:400px;">

---
## 뷰의 계층도
<img src="images/view-hierarchy.png" width=100%>

---
## 커스텀 뷰
<img src="images/custom-view-hierarchy.png" width=100%>

---
## 커스텀 뷰
* View를 상속받는 클래스 만들기
* 주요 override 함수 작성하기  
<img src="images/view-methods.png" width=100%>

---
## onDraw

```java
public class MyView extends View {
    Rect    rect;
    public MyView(Context context) {
        super(context);
        rect= new Rect(10, 10, 110, 110);
    }
    public MyView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }
    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);

        Paint paint= new Paint();
        paint.setColor(Color.BLUE);
        canvas.drawRect(rect, paint);
    }
}

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.activity_main);
*       setContentView(new MyView(this));
    }
}
```

<img src="images/ondraw.png" style="position:absolute; top:100px; right: 50px; width: 300px;">

---
## onDraw, invalidate
<img src="images/ondraw-invalidate.png" width=80%>

---
## onDraw, onTouch, invalidate

```java
@Override
public boolean onTouchEvent(MotionEvent event) {
    if(event.getAction()==MotionEvent.ACTION_DOWN){
        rect.left=(int)event.getX();
        rect.top=(int)event.getY();
        rect.right= rect.left+100;
        rect.bottom= rect.top+100;
        invalidate();
    }
    return super.onTouchEvent(event);
}
```

<img src="images/ondraw.png" style="position:absolute; top:100px; right:250px; width: 200px">

<img src="images/ondraw2.png" style="position:absolute; top:250px; right:100px; width: 200px">

---
## 커스텀 뷰 + xml

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/activity_custom_view"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context="kr.ac.hansung.jmlee.ch11_customview.CustomViewActivity">

*   <kr.ac.hansung.jmlee.ch11_customview.MyView
        android:text="TextView"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:id="@+id/textView" />
</RelativeLayout>
```

```java
public class CustomViewActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
*       setContentView(R.layout.activity_custom_view);
        //setContentView(new MyView(this));
    }
}
```

<img src="images/ondraw.png" style="position:absolute; top:100px; right: 50px; width: 300px;">

---
## 커스텀 뷰 + xml + AttributeSet

```xml
<kr.ac.hansung.jmlee.ch11_customview.MyView
    android:text="TextView"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
*   mycolor="#ff0000"
    android:id="@+id/textView"
    />
```

```java
int color= Color.BLUE;
*public MyView(Context context, AttributeSet attrs) {
    super(context, attrs);
    rect= new Rect(10, 10, 110, 110);
*   for(int i=0;i<attrs.getAttributeCount();i++){
*       if(attrs.getAttributeName(i).equals("mycolor")){
*           color= attrs.getAttributeIntValue(i, Color.GREEN);
*       }
*   }
}
@Override
protected void onDraw(Canvas canvas) {
    super.onDraw(canvas);
    Paint paint= new Paint();
*   paint.setColor(color);
    canvas.drawRect(rect, paint);
}
```

<img src="images/ondraw-red.png" style="position:absolute; top:100px; right: 50px; width: 300px;">

---
## Styleable의 사용

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
*   <declare-styleable name="JmleeStyle">
*       <attr name="color" format="color"/>
    </declare-styleable>
</resources>
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
*   xmlns:jmlee="http://schemas.android.com/apk/res/kr.ac.hansung.jmlee.ch11_customview"
	...>

    <kr.ac.hansung.jmlee.ch11_customview.MyView
        ...
*       jmlee:color="#FFFF0000"
        android:id="@+id/textView"
        />
</RelativeLayout>
```

---
## Styleable의 사용

```java
public MyView(Context context, AttributeSet attrs) {
    super(context, attrs);
    rect= new Rect(10, 10, 110, 110);
    /*
    for(int i=0;i<attrs.getAttributeCount();i++){
        if(attrs.getAttributeName(i).equals("xcolor")){
            color= attrs.getAttributeIntValue(i, Color.GREEN);
        }
    }
    */
*   TypedArray typedArray= context.obtainStyledAttributes(attrs, R.styleable.JmleeStyle, 0, 0);
*   color= typedArray.getInteger(R.styleable.JmleeStyle_color, Color.BLUE);
    typedArray.recycle();
}
```

---
## 그래픽 애니메이션: 볼 애니메이션

```java
public class AnimatedView extends View {
    private ArrayList<Ball> arBall = new ArrayList<Ball>();
    ...
*   public void updateAnimation() {
        for (int idx=0; idx<arBall.size(); idx++) {
            Ball B = arBall.get(idx);    // 3. arBall 리스트에서 볼을 추출
*           B.move(getWidth(),getHeight());  // 4. 추출된 볼을 애니메이트
        }
*       invalidate();  // 5. 다시 onDraw() 간접 호출 (무한 반복)
    }

    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        // 1. arBall 리스트에 있는 모든 Ball 객체 그리기
        for (int idx=0; idx<arBall.size(); idx++) {
            Ball B = arBall.get(idx);
            B.draw(canvas);
        }
*       updateAnimation(); // 2. updateAnimation 메소드 호출
    }
```

**주의** 볼 애니메이션 루프와 터치 입력시 볼 생성 및 추가 작업이 *메인 스레드에서 모두 수행됨*
**(뷰는 메인스레드만 접근 가능)**

.footnote[https://github.com/kwanu70/AndroidExamples/blob/master/chap9/GraphicsTest/app/src/main/java/com/example/kwanwoo/graphicstest/AnimatedView.java]
