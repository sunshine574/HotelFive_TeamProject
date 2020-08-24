<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp" />


<!-- 관리자가 로그인하면 "관리자메뉴"를 표시한다. -->


<style type="text/css">
	.loginpage-box{display: flex;}
	.logo-box {width: 500px; display: inline-block;text-align: center; margin-left: 400px; margin-right: 100px}
	#logo-login{width:400px; margin-top: 100px;}
   .login-box {
      border: 2px solid lightgray;
      margin: 30px auto 30px 30px;
      width: 500px;
      padding: 20px 0 30px 70px;
   }
   .login-box table {
      border-collapse: collapse;
      width: 326px;
   }
   .login-box table td {
      padding: 5px;      
   }
   .login-text {border: none; padding:10px; border-bottom: 2px solid lightgray;width: 350px;}
   .login-text:focus {outline: none; border-bottom: 2px solid gray;}
   .find {float: right;}
   input[type=button] {border: none; width: 350px; padding: 10px 0; background: #E3EAF3;}
   input[type=button]:focus {outline: none; background: #A4CAED;}
   a {text-decoration: none; font-size: 0.9em; color: black;}
   
</style>

<script type="text/javascript">
   
   
   
      var beLogined = '${beLogined}';
      if (beLogined == 1) {  // 삽입 후에 페이지는 여는 것이다.
    	  var beDeleted = '${beDeleted}';
    	  var loginResult = '${loginResult}';
    	  
    	  if(beDeleted ==1 ){
    		  alert('탈퇴한 회원입니다.');
    	  }
    	  else if(loginResult == 1){
    		  alert('로그인 성공');
    		  location.href = 'main';
    	  }else {
    		  alert('로그인 실패');
          }
       }

   
   $(document).ready(function(){
      
      // 아이디 기억하기
      var savedID = getCookie("savedID");
      $('#mId').val(savedID);
      
      // savedID 가 있으면, 체크박스를 체크 상태로 유지
      if ( $('#mId').val() != '' ) {
         $('#saveIDCheck').attr('checked', true);
      }
      
      // 체크박스의 상태가 변하면,
      $('#saveIDCheck').change(function(){
         // 체크되어 있다
         if ( $('#saveIDCheck').is(':checked') ) {
            setCookie( "savedID", $('#mId').val(), 7 );  // 7일간 쿠키에 보관
         } 
         // 체크해제되어 있다.
         else {
            deleteCookie( "savedID" );
         }
      });
      
      // 아이디를 입력할 때
      $('#mId').keyup(function(){
         // 체크되어 있다
         if ( $('#saveIDCheck').is(':checked') ) {
            setCookie( "savedID", $('#mId').val(), 7 );  // 7일간 쿠키에 보관
         }
      });
   });
      
            
   function fn_login (f) {
      
          
               $.ajax({
                  url: 'loginCheck',
                  type: 'POST',
                  dataType: 'JSON',
                  data: 'input_key=' + $('#input_key').val(),
                  success: function( data ) {
                     if (  data.result == true ) {
                        f.action='login';
                          f.submit();
                     } else {
                        alert('그림의 인증번호와 입력하신 인증번호가 다릅니다.');
                         location.href='loginPage';
                     }
                  },
                  error: function() {
                     alert('AJAX 통신이 실패했습니다.');
                  }
               });
   
   }
   
   
   // 1. 쿠키 만들기
   function setCookie( cookieName, value, exdays ) {
       var exdate = new Date();
       exdate.setDate(exdate.getDate() + exdays);
       var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
       document.cookie = cookieName + "=" + cookieValue;
   }

   // 2. 쿠키 삭제
   function deleteCookie( cookieName ) {
       var expireDate = new Date();
       expireDate.setDate(expireDate.getDate() - 1);
       document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
   }

   // 3. 쿠키 가져오기
   function getCookie( cookieName ) {
       cookieName = cookieName + "=";
       var cookieData = document.cookie;
       var start = cookieData.indexOf(cookieName);
       var cookieValue = "";
       if ( start != -1 ){
           start += cookieName.length;
           var end = cookieData.indexOf(";", start);
           if(end == -1) {
               end = cookieData.length;
           }
           cookieValue = cookieData.substring(start, end);
       }
       return unescape(cookieValue);
   }
   
</script>
<div class="loginpage-box">
	<div class="logo-box">
		<img id="logo-login" alt="hotelLogo" src="resources/logo/logo1.jpg">
	</div>
	
	<div id="f" class="login-box">
	   <form method="POST">
	      <h1 style="color: #CAC2D1;">Hotel Five</h1>
	      <table>
	         <tbody>
	            <tr>
	               <td><input class="login-text" id="mId" type="text" name="mId" placeholder="아이디" autofocus /></td>
	            </tr>
	            <tr>
	               <td><input class="login-text" type="password" name="mPw" placeholder="비밀번호"/></td>
	            </tr>
	            <tr>
	               <td>
	                  <input id="saveIDCheck" type="checkbox" name="saveIDCheck" value="true" checked />아이디 기억하기
	                  <br/><br/>
	               </td>
	            </tr>
	            <tr>
	               <td>
	               <img src="resources/storage/${filename }"  style="width: 350px;"/>
	               위 이미지를 보이는 대로 입력해 주세요 .<br/>
	               <input id="input_key" type="text" name="input_key"/>
	               <a href="loginPage"><i class="fas fa-redo-alt"></i></a>
	               </td>
	            </tr>
	
	         </tbody>
	         <tfoot>
	            <tr>
	               <td colspan="2">
	                  <br/><input type="button" value="로그인"  onclick="fn_login(this.form)" />
	                  <br/>
	                  <div class="find">
	                     <a href="findIdPage">아이디 찾기</a>&nbsp;|&nbsp; 
	                     <a href="findPwPage">비밀번호 찾기</a><br/>
	                  </div>
	                  <a href="findReservationNumber">비회원 예약확인</a><br/>
	               </td>
	            </tr>
	         </tfoot>
	      </table>
	   </form>
	</div>
</div>





<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>