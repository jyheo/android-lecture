layout: true
.top-line[]

---
class: center, middle

# 안드로이드 개요

---
## Contents
* 학습목표

  * 모바일 운영체제의 일반적인 특징과 새롭게 등장한 안드로이드의 주요 특징 및 전체적인 아키텍처를 알아본다.

  * 안드로이드 앱 개발을 위한 개발 환경을 설치하고, HelloAndroid 앱을 생성하고 실행해 본다.

---
## 모바일 환경 SW 개발
* 모바일 환경
  * 기존의 핸드폰은 통화 기능만 제공함.
  * 스마트폰은  음악감상, 동영상 감상, DMB 시청, 카메라 촬영 등의 다양한 기능을 제공함
  * 다양한 모바일 디바이스: 태블릿, 웨어러블 디바이스(스마트 와치, 구글 글래스 등)

* 모바일 환경 SW 개발의 발달 배경
  * 작은 부피로도 많은 데이터의 저장이 가능한 메모리
  * 프로세서 파워의 향상
  * 배터리 효율의 향상

---
## 모바일 운영체제
* 모바일 기기에서 실행되는 운영체제.
* 모바일 하드웨어 자원을 직접 제어하고 관리하는 시스템 소프트웨어.
* 데스크톱 운영체제에 비해 부피가 작고 상대적으로 쉽게 개발 가능함.
* 모바일 운영체제의 종류
  * BlackBerry
  * IOS (Apple)
  * Symbian (Nokia)
  * Android
  * Window Phone
  * Java ME

<img src="images/marketshare.png" width=500 style="bottom: 100px; right: 150px; position: absolute">

.footnote[http://www.netmarketshare.com/operating-system-market-share.aspx?qprid=8&qpcustomd=1]

---
## 안드로이드 개요
* 안드로이드 란?
  * 스마트폰과 태블릿을 위한 모바일 플랫폼
    - 안드로이드 앱 실행을 위한 Linux 커널 기반 모바일 운영체제
    - 안드로이드 앱 개발을 위한 강력한 개발 프레임워크(Libraries, Application Framework)

<img src="images/androidplatform.png" style="display:block; margin: auto;">

---
## 안드로이드 개요
* 안드로이드 버전
  * 2008년 9월 **A**ndroid 1.0 (API level 1)출시
  * ...
  * 2015년 10월 **M**arshmallow 6.0 (API level 23)
  * 2016년 9월 **N**ougat 7.0 (API level 24)

* 안드로이드 오픈 소스 프로젝트
  * https://source.android.com/index.html

---
## 안드로이드 아키텍처
![Android Framework](https://source.android.com/images/android_framework_details.png)
.footnote[https://source.android.com/source/index.html]

---
## 개발환경 설치
1. Java SE Development Kit 8 설치
	http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

2. Android Studio를 다운로드 하여 설치.
	https://developer.android.com/studio/index.html

3. SDK Manager를 이용하여 최신 SDK 도구와 플랫폼을 설치

---
## 실제 디바이스에서 실행하기
1. PC에 해당 디바이스용 USB 드라이버 설치
  - 삼성: http://local.sec.samsung.com/comLocal/support/down/kies_main.do?kind=usb
  - LG: http://www.lgmobile.co.kr/lgmobile/front/download/retrieveDownloadMain.dev

2. 디바이스와 PC를 연결하고, 설정 변경하기
  - '환경설정(Settings) > 개발자 옵션(Developer Options)' 선택 후, **'USB 디버깅'** 허용
    - (개발자 옵션이 안보이는 경우) '환경설정(Settings) > 디바이스 정보' 선택 후, 빌드번호 정보를 손가락으로 7번 터치하면, '환경설정>개발자옵션' 메뉴가 나타남

---
## 실제 디바이스에서 실행하기
3. 툴바에서 실행(<img src="images/run.png">) 버튼 클릭 후 나타나는 화면에서 연결된 실제 다비이스를  선택
.center[
<img src="images/selectdeploytarget.png" width=500>
==>
<img src="images/target.png" width=200>
]
