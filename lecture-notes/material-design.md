layout: true
.top-line[]

---
class: center, middle
# 머티리얼 디자인

---
## 머티리얼 디자인
* 머티리얼 디자인은 플랫폼 및 기기 전반의 표현 방식, 모션 및 상호 작용 디자인에 대한 종합적인 지침

머티리얼 테마 | 벡터 드로어블 | 뷰 그림자
-----------|-----------|-------------
<img src="images/material1.png" width=200px><img src="images/material2.png" width=200px> | <img src="images/vectordrawable.png" width=300px> | <img src="images/viewshadow.png" width=150px>


.footnote[https://developer.android.com/design/material/index.html?hl=ko]

---
## 머티리얼 디자인

목록 및 카드 | 애니메이션
----------|---------
<img src="images/materiallist.png" width=200px><img src="images/materialcard.png" width=200px> | <img src="images/materialani.png" width=200px>[애니메이션 보기](https://developer.android.com/design/material/videos/ContactsAnim.mp4?hl=ko)

---
## 머티리얼 테마 적용
* res/values/styles.xml

```xml
<resources>
  <!-- inherit from the material theme -->
  <style name="AppTheme" parent="android:Theme.Material">
    <!-- Main theme colors -->
    <!--   your app branding color for the app bar -->
    <item name="android:colorPrimary">@color/primary</item>
    <!--   darker variant for the status bar and contextual app bars -->
    <item name="android:colorPrimaryDark">@color/primary_dark</item>
    <!--   theme UI controls like checkboxes and text fields -->
    <item name="android:colorAccent">@color/accent</item>
  </style>
</resources>
```

<img src="images/materialtheme.png" width=200px style="top:150px; right:100px; position:absolute;">

* Theme editor  
<img src="images/themeeditor.png" width=500px>

---
## 머티리얼 테마 적용(AppCompat인 경우)
* res/values/styles.xml

```xml
<resources>

    <!-- Base application theme. -->
    <style name="AppTheme" parent="Theme.AppCompat.Light.DarkActionBar">
        <!-- Customize your theme here. -->
        <item name="colorPrimary">@color/colorPrimary</item>
        <item name="colorPrimaryDark">@color/colorPrimaryDark</item>
        <item name="colorAccent">@color/colorAccent</item>
      </style>

</resources>
```

