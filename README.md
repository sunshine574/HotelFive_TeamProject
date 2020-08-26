# 호텔예약사이트 - 팀프로젝트

## 목적
- 신입 웹 개발자로서 기본 소양을 갖추기 위한 연습
- 학습한 내용을 실전에 응용하여 실제 웹 구축 과정 학습

-------------------------------------------------------------------------
## 개발환경
> Front-End
- HTML
- CSS
- JAVASCRIPT
> Back-End
- Spring 3.1
- JDK 1.6
- Oracle 11g
- Mybatis 3.2
- Tomcat 9
- Maven 2.9

--------------------------------------------------------------------------
## 제작기간 - 2020/07/20 ~ 2020/08/06 ( 작업기간 : 14일, 주말 4일 제외 )
> 1주차 (7/20 ~ 7/24), View페이지 및 DB 모델링
- 개발환경 설정 및 프로젝트 주제 설정
- View 페이지 설계 및 생성
- Oracle DB Model 설계 및 생성
- View (index, login, sign, admin, user, reservation, board) 완성
- View 코드 검사 및 유효성 검사 (JAVASCRIPT) 적용
> 2주차 (7/27 ~ 7/31), spring MVC 디자인 패턴 적용 및 웹 기본 기능 완성
- MVC 디자인 패턴을 고려하여 프로젝트 패키지 설계 및 생성
- 회원가입, 로그인 기능 구현 및 게시판 CRUD 기능 구축
- 회원가입, 로그인 기능 보완 및 게시판 CRUD 기능 보완
- 지도 API, 캡차 API, 캘린더 API 기능 추가
- admin view 설계 및 생성
- 예약기능 구현
> 3주차 (8/3 ~ 8/6), 세부 기능 구현 및 CSS 작업
- 게시판 조회수, 페이징, 댓글수정, 댓글삭제, 검색 등 세부 기능 구현
- 예약기능 보완 (금액계산, SQL문)
- 구현된 기능들 보완 및 코드 정리
- 전체 CSS 작업

--------------------------------------------------------------------------
## 패키지 구조
![package1](https://user-images.githubusercontent.com/67766249/91014897-31afba80-e625-11ea-80e6-3c4f24d898f3.jpg)
![package2](https://user-images.githubusercontent.com/67766249/91015021-6d4a8480-e625-11ea-9464-9b10f9a98281.jpg)
![package3](https://user-images.githubusercontent.com/67766249/91015081-881cf900-e625-11ea-81f1-ecb2db90b378.jpg)

--------------------------------------------------------------------------
## 데이터베이스 모델링
![DBModel(Member)](https://user-images.githubusercontent.com/67766249/91015163-a4209a80-e625-11ea-8f0d-8247058ac790.jpg)
![DBModel(Nonmember)](https://user-images.githubusercontent.com/67766249/91015206-bf8ba580-e625-11ea-8de3-eaa327bd0aec.jpg)
  
--------------------------------------------------------------------------
## Front-End 주요 기능
> 카카오 지도 API
- 지도 API를 이용한 호텔 위치 소개
~~~c
// 지도에 표시할 마커를 아래와 같이 배열로 넣어주면 여러개의 마커를 표시할 수 있습니다
var mapContainer = document.getElementById('map'); // 지도를 표시할 div
mapOption = {
center : new kakao.maps.Lating(37.554042, 126.935764), // 지도의 중심좌표
level : 3 // 지도의 확대레벨
};
~~~
![map](https://user-images.githubusercontent.com/67766249/91257041-dce67e00-e7a3-11ea-83cd-ef4d5d926047.jpg)

--------------------------------------------------------------------------
## 보완점

