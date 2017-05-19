# 안드로이드 강의 자료(Android Lecture)
android lecture notes powered by [Remarkjs](https://github.com/gnab/remark)

Sorry, we have Korean version only! If you interested in other language, please, make an issue!

## 왜 강의 자료를 오픈 소스로?
안드로이드는 너무 빨리 변하고, 이런 빠른 변화를 따라가는 교재는 찾기가 어렵습니다. 그래서 많은 강의자들이 함께 협력하면서 같이 개발하면 어떨까 하는 생각을 하여 오픈 소스로 강의 자료를 공개하게 되었습니다.

## 왜 Markdown으로?
원래 강의 자료는 지난 학기에 저희 학교 다른 교수님과 같이 PPT로 만들었었는데, 오픈 소스로 하기엔 PPT가 적절하지 않아서 markdown으로 다시 만들었습니다. PPT는 바이너리라서 git으로 버전관리와 협업이 쉽지 않기 때문에 텍스트 형식인 Markdown을 이용하였습니다.
작성된 Markdown 형식의 파일은 remarkjs와 decktape 을 이용하여 각각 html, pdf 버전으로 슬라이드가 생성됩니다.
다만 여기에서 사용하는 Markdown은 GFM(Github Flavored Markdown)으로 소스 코드를 보여주기 용이합니다.
그리고 추가로 remarkjs에서 사용하는 HTML 클래스 지정 방식을 사용합니다.

## 최종 목표?
최종 목표는 Markdown 파일 하나에서 슬라이드와 학생들이 참고할 교재도 생성해 내는 것입니다. 지금은 슬라이드 수준의 내용과 실습 자료만 있습니다.

## How to make and view lecture notes
```
$ git clone https://github.com/jyheo/android-lecture.git
$ cd lecture-notes
$ make
```
* Open .html with your web browser.

## Lecture notes & Labs
* The files are **NOT UP-TO-DATED!**

Lecture Notes | Labs
[Android Intro](https://jyheo.github.io/android-lecture/lecture-notes/android-intro.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/android-intro-lab.md)
[Android UI](https://jyheo.github.io/android-lecture/lecture-notes/android-ui.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/android-ui-lab.md)
[Adapter View](https://jyheo.github.io/android-lecture/lecture-notes/adapter-view.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/adapter-view-lab.md)
[Activity and Intent](https://jyheo.github.io/android-lecture/lecture-notes/activity-intent.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/activity-intent-lab.md)
[Fragment](https://jyheo.github.io/android-lecture/lecture-notes/fragment.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/fragment-lab.md)
[ActionBar and Navigation](https://jyheo.github.io/android-lecture/lecture-notes/actionbar-navigation.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/actionbar-navigation-lab.md)
[Data Storage](https://jyheo.github.io/android-lecture/lecture-notes/data-storage.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/data-storage-lab.md)
[SQLite](https://jyheo.github.io/android-lecture/lecture-notes/sqlite.html)  | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/sqlite-lab.md)
[Animation](https://jyheo.github.io/android-lecture/lecture-notes/animation.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/animation-lab.md)
[Custom View](https://jyheo.github.io/android-lecture/lecture-notes/custom-view.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/custom-view-lab.md)
[Multimedia](https://jyheo.github.io/android-lecture/lecture-notes/multimedia.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/multimedia-lab.md)
[Graphics](https://jyheo.github.io/android-lecture/lecture-notes/graphics.html) | Lab
[Location based service](https://jyheo.github.io/android-lecture/lecture-notes/location.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/location-lab.md)
[Material Design](https://jyheo.github.io/android-lecture/lecture-notes/material-design.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/material-design-lab.md)
[Mobile Backend Service](https://jyheo.github.io/android-lecture/lecture-notes/mobile-backend.html) | [Lab](https://github.com/jyheo/android-lecture/blob/master/labs/mobile-backend-lab.md)

## Contributor
* Junyoung Heo
* Kwanwoo Lee
* Jae Moon Lee
