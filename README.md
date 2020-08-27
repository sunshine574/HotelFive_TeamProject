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

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성
var mapTypeControl = new kakao.maps.MapTypeControl(); // 일반지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤러 생성
var zoomControl = new kakao.maps.ZoomControl(); // 지도 확대 축소를 제어할 수 있는 줌컨트롤 생성
var markerPosition = new kakao.maps.Lating(37.554042, 126.935764); // 마커가 표시될 위치 저장

map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT); // 지도에 컨트롤러 추가
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT); // 지도에 줌컨트롤 추가
var maker = new kakao.maps.Marker({ 
  position : markerPosition 
}); // 마커 생성
marker.setMap(map); // 마커가 지도 위에 표시되도록 설정

var iwContent = '<p style="width:200px"><b>Hotel Five</b><br/>서울특별시 노고산동</p>'; // infowindow에 표출될 내용으로 HTML이나 document element 가능
var iwPosition = new kakao.maps.Lating(37.554042, 126.935764); // infowindow 표시 위치
var iwRemoveable = true; // infowindow를 닫을 수 있는 x버튼 표시
var infowindow = new kakao.maps.InfoWindow({
  position : iwPosition,
  content : iwContent,
  removeable : iwRemoveable
}); // infowindow 생성

kakao.maps.envent.addListener(marker, 'click', function(){
  infowindow.open(map, marker);
}); // marker click 이벤트 추가

~~~
![map](https://user-images.githubusercontent.com/67766249/91257041-dce67e00-e7a3-11ea-83cd-ef4d5d926047.jpg)



> JAVASCRIPT를 이용한 유효성 검사
- 예약페이지 객실 투숙 인원수에 따른 실시간 금액 정보 변동
~~~c
<html>
  <!-- select태그를 이용한 투숙인원선택 옵션 -->
  <body>
    <c:if test="${gDTO.gNo eq 1}">
      <select id="selectPeople${gDTO.gNo}" name="rPeople" onchange="fn_change()">
        <option selected>::인원선택::</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        ...
        <option value="10">10</option>
      </select>
    <c:if>
    <label>기본요금 : </label>
    <div id="basicPrice"></div>
    <label>추가요금 : </label>
    <div id="addPrice"></div>
    <label>총 요금 : </label>
    <div id="totalPrice"></div>
  </body>
</html>

<script>

var basicPrice = 0;
var nights = 0;
var addPrice = 0;
var totalPrice = 0;

  window.onload = function(){
    // 숙박일수 및 기본요금 계산
    var gPrice = '${gDTO.gPrice}';
    var rCheckIn = '${rCheckIn}';
    var rCheckOut = '${rCheckOut}';
    var arrCheckIn = rCheckIn.split('-');
    var arrCheckOut = rCheckOut.split('-');
    var datCheckIn = new Date(arrCheckIn[0], arrCheckIn[1], arrCheckIn[2]);
    var datCheckOut = new Date(arrCheckOut[0], arrCheckOut[1], arrCheckOut[2]);
    
    var diff = datCheckOut - datCheckIn;
    var currDay = 24 * 60 * 60 * 1000;
    nights = parseInt(diff / currDay);
    basicPrice = gPrice * nights;
    $('#basicPrice').html(basicPrice);
  
  }
  
  function fn_change(){
    var selectItem = $("#selectPeople"+${gDTO.gNo}).val();
    var gNo = ${gDTO.gNo};
    var ConditionA = selectItem - 3; // 객실별 기본 투숙인원에 따른 조건 저장
    var ConditionB = selectItem - 1; // 객실별 기본 투숙인원에 따른 조건 저장
    var ConditionC = selectItem - 5; // 객실별 기본 투숙인원에 따른 조건 저장
    var addPricePerPeople = 20000; // 초과인원에 대한 추가 요금
    
    if (gNo == 1 || gNo == 2) {
      if (conditionA <= 0) {
        addPrice = 0;
      } else {
        for (var i=0; i<conditionA; i++) {
          addPrice = i * nights * addPricePerPeople;
        }
      }
    }
    
    if (gNo == 3 || gNo == 4) {
      if (conditionB <= 0) {
        addPrice = 0;
      } else {
        for (var i=0; i<conditionB; i++) {
          addPrice = i * nights * addPricePerPeople;
        }
      }
    }
    
    if (gNo == 5) {
      if (conditionC <= 0) {
        addPrice = 0;
      } else {
        for (var i=0; i<conditionC; i++) {
          addPrice = i * nights * addPricePerPeople;
        }
      }
    }
    
    totalPrice = basicPrice + addPrice;
    
    $('#addPrice').html(addPrice);
    $('#totalPrice').html(totalPrice);
    document.getElementById('rPrice').value = totalPrice;
    
  }

</script>
~~~
![price1](https://user-images.githubusercontent.com/67766249/91267340-250a9e00-e7ae-11ea-87c7-b219ef9cd599.jpg)
![price2](https://user-images.githubusercontent.com/67766249/91267385-381d6e00-e7ae-11ea-9c85-672146363165.jpg)

> jstl 'c'를 이용한 데이터 뿌리기
- QNA게시판 답변완료표시, 잠금표시 기능
~~~c
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <body>
    <!-- 각 게시글의 댓글 개수를 불러와서 0이 아니면 '[답변등록완료]' 표시 -->
    <c:if test="${qDTO.count ne 0}">
      <span style="color:BBCCDD">[답변등록완료]</span>
    </c:if>
    
    <!-- session의 로그인 정보를 불러와서 관리자면 게시글의 lock 해제, 아니면 lock (프라이버시 보호) -->
    <form>
      <c:if test="${loginDTO.mId == 'admin'}">
        <!-- 관리자면 lock 해제 -->
        <a href="qnaBoardView?qNo=${qDTO.qNo}">${qDTO.qTitle}</a>
        <i class="fas fa-lock-open"></i>
      </c:if>
      <c:if test="${loginDTO.mId != 'admin'}">
        <!-- 관리자가 아니면 게시글의 비밀번호 묻는 메소드 실행 -->
        <input class="title_btn" type="button" value="${qDTO.qTitle}" onclick="fn_viewCheck(this.form)"/>
        <i class="fas fa-lock"></i>
      </c:if>
    </form>
  </body>
</html>
~~~
![board_admin](https://user-images.githubusercontent.com/67766249/91270948-669e4780-e7b4-11ea-9ed5-78b3d680c014.jpg)
![board_member](https://user-images.githubusercontent.com/67766249/91270953-6a31ce80-e7b4-11ea-808e-bad13701e809.jpg)

--------------------------------------------------------------------------
## Back-End 주요 기능
> 메소드 처리 과정
- request -> controller -> command -> DAO -> Mybatis -> DB -> response

> 게시판 CRUD 및 댓글 기능
- QNA게시판 List
~~~c
@Controller
public class BoardController {
  
  @Autowired // Automatic Dependency Injection
  private SqlSession sqlSession; // Mybatis 연동 객체
  private Command command;
  
  @RequestMapping(value="qnaBoardList", method=RequestMethod.GET)
  public String qnaBoardList (HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    command = new QNABoardListCommand();
    command.execute(sqlSession, model);
    return "qnaBoard/qnaBoardListPage";
  }
  
}
~~~
- ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
~~~c
public class QNABoardListCommand implements Command {

  @Override
  public void execute (SqlSession sqlSession, Model model) {
  
    Map<String, Object> requestMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) requestMap.get("request");
    
    int page = 1; // 게시판을 처음 들어왔을때 1페이지를 보여준다
    if (request.getParameter("page") != null) {
      page = Integer.parseInt(request.getParameter("page"));
    } // 현재 page가 null일 경우 page를 해당 페이지로 이동
    
    int recordPerPage = 10;
    int beginRecord = ( page - 1 ) * recordPerPage + 1;
    int endRecord = beginRecord + recordPerPage - 1;
    
    Map<String, Integer> map = new HashMap<String, Integer>();
    map.put("beginRecord", beginRecord);
    map.put("endRecord", endRecord);
    
    HotelFiveDAO qDAO = sqlSession.getMapper(HotelFiveDAO.class);
    ArrayList<QNADTO> list = qDAO.selectQNABorad(map);
    
    int totalRecord = qDAO.getTotalRecord();
    String pageView = PageMaker.getPageView("qnaBoardList", page, recordPerPage, totalRecord); // 게시판 페이징을 위한 파라미터 전달
    
    model.addAttribute("list", list);
    model.addAttribute("page", page);
    model.addAttribute("pageView", pageView);
    model.addAttribute("totalRecord", totalRecord);
  
  }

}

~~~

> 게시판 페이징
- QNA게시판 페이징
~~~c


~~~

--------------------------------------------------------------------------
## 보완점
- 게시판 댓글 기능 AJAX로 구현.
- 회원 및 비회원이 체크아웃 후에 DB에서 정보를 삭제해야 함.


## 프로젝트 중 실수 List
- 첫 팀프로젝트여서 팀원들간에 공통된 규정(변수명, 메소드명, CSS컨셉 등)에 대해 미흡한 부분 있음.
  - 변수명, 메소드명, CSS컨셉 등 전체 수정 진행
- java class DTO 변수 갯수 문제
  - DB Table과 DTO간의 변수가 일치하지 않아 문제 발생
  - DB Table 수정으로 문제 해결
- 게시판 댓글 수정 및 삭제시 무조건 첫번째 댓글이 수정 및 삭제되는 문제
  - HTML "<form>"태그가 댓글을 뿌려주는 "<c:forEach>"태그보다 바깥에 있어서 문제 발생
  - "<form>"태그를 "<c:forEach>"태그 안으로 넣어줌
- 관리자 페이지 예약현황 검색시 비회원 예약이 불러와지지 않는 문제
  - 비회원 예약 시 DB RESERVATION Table에 예약정보가 저장되지 않음
  - 비회원 전용 Table 생성 후 RESERVATION Table과 관계 설정 후 SQL문 수정
