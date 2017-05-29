# Thread와 SurfaceView 실습

SurfaceView를 사용하여 터치하는 곳에 ball이 그려지고 움직이도록 하라. 그리고 볼이 충돌하면 두 볼 중에 하나를 사라지게 하라.
TextView에는 현재 볼의 수를 표시하라.

<img src="images/custom-view-lab2.png">

## 1. Ball 클래스를 다음과 같이 구현하라.

```java
public class Ball {
    final   int RAD = 24;     	// 볼의 반지름
    int x, y, dx, dy;         	// 볼의 중심 좌표
    int width, height;    	// 볼의 넓이와 높이
    int color;

    public Ball(int x, int y) {
        this.x = x;
        this.y = y;

        Random Rnd = new Random();
        do {
            dx = Rnd.nextInt(11)-5;
            dy = Rnd.nextInt(11)-5
        } while(dx==0 || dy==0); //  0은 제외

        width=height=RAD*2
        color = Color.rgb(Rnd.nextInt(256),Rnd.nextInt(256),
		                      Rnd.nextInt(256));
    }

    public void draw(Canvas canvas) {

        Paint paint = new Paint();

        for (int r = RAD, alpha = 1; r > 4; r--, alpha += 5)
        { // 바깥쪽은 흐릿하게 안쪽은 진하게 그려지는 원
            paint.setColor(Color.argb(alpha, Color.red(color),
                    Color.green(color), Color.blue(color)));
            canvas.drawCircle(x + RAD, y + RAD, r, paint);
        }
    }
    void move(int width, int height) {
        x += dx;       // x 좌표값을 dx 만큼 증가
        y += dy;       // y 좌표값을 dy 만큼 증가

        if (x<0 || x > width- this.width)
            dx *= -1;                       // 좌우 방향 반전
        }
        if (y<0  || y > height- this.height)
            dy *= -1;                      // 상하 방향 반전

        }
    }
}
```

## 2. SurfaceView를 상속받은 BallsView를 만들고 onTouch이벤트를 받아서 터치하는 곳에 ball이 그려지도록 하라.
* SurfaceView 상속 참고: https://github.com/kwanu70/AndroidExamples/blob/master/chap9/GraphicsTest/app/src/main/java/com/example/kwanwoo/graphicstest/AnimatedSurfaceView.java#L17
* 레이아웃에 BallsView 넣기 참고: https://github.com/kwanu70/AndroidExamples/blob/master/chap9/GraphicsTest/app/src/main/res/layout/activity_main.xml#L17-L20
* 터치 이벤트 처리 참고: https://github.com/kwanu70/AndroidExamples/blob/master/chap9/GraphicsTest/app/src/main/java/com/example/kwanwoo/graphicstest/AnimatedSurfaceView.java#L65

## 3. SurfaceView에서 스레드를 생성하고, 스레드에서 Ball 클래스의 move와 draw메소드를 호출하여 볼 애니메이션을 프로그램하라. 이때 볼이 충돌하면 둘 중 하나를 제거하라.
* 참고:
https://github.com/kwanu70/AndroidExamples/blob/master/chap9/GraphicsTest/app/src/main/java/com/example/kwanwoo/graphicstest/AnimatedSurfaceView.java#L65
* 주의!:
    - 터치 시 동작(메인 스레드)과 SurfaceView의 스레드(워커 스레드)간에 볼 리스트를 공유하므로 경쟁 조건에 조심!
    - 볼 제거할 때 워크 스레드가 TextView의 내용을 직접 변경하지 않도록! 메인 스레드만 View를 변경할 수 있음!
