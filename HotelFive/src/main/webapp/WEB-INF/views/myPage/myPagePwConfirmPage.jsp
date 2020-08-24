<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="비밀번호확인" name="title"/>
</jsp:include>

<style>
	
	

	
	
	.myPagePwConfirm-wrap{
		background-image: url("resources/assets/myMain_img/myMainBackground.jpg");
		height: 1200px;
	}
	.idPw-input-wrap, .centered{
		
		padding-top: 300px;
		text-align: center;
	}
	.idPw-input-wrap {
		background-color: rgba( 255, 255, 255, 0.5 );
		box-sizing: border-box;
		margin: 0 450px 0 450px;
        border: 1px inset #dddddd;
        padding: 20px;
   
        
	}
	span {color: #ffebcd; font-size: 20px;}
	h2, h4 {
		color: #ffebcd
	}
	
	.gradient-btn {
		 display: inline-block;
		 padding: 1em 2em;
		 border-radius: 0;
		 color: #b2876f;
		 margin-top:2rem;
		 font-weight: bold;
		 font-size: 0.678rem;
		 letter-spacing: 2px;
		 text-transform: uppercase;
		 text-decoration: none;
		 background: linear-gradient(to right, rgba(#b2876f, 0) 25%, rgba(#b2876f, .8) 75%);
		 background-position: 1% 50%;
		 background-size: 400% 300%;
		 border: 1px solid #b2876f;
	}
	
</style>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script><!-- alert 꾸미기 -->
<script type="text/javascript">

	
	// 비밀번호 검사
	// 세션에 등록된 회원비번이랑 페이지에 입력된 비번을 비교한다.
	function fn_pwConfirm(f){
		var mPw = '${loginDTO.mPw}';
		//비밀번호 입력유무 검사
		  if( f.mPw.value == '' ){
			alert('비밀번호를 입력하세요');
			// swal("비밀번호를 입력하세요.","", 'error');
			f.mPw.focus();
			return;
		}
		
		if( mPw != f.mPw.value ){
			alert('가입된 비밀번호와 일치하지 않습니다');
			// swal("가입된 비밀번호와 일치하지 않습니다.","", 'error');
			f.mPw.focus();
			return;
		}
		
		// 비밀번호가 일치할 시 
		if( mPw == f.mPw.value ){ 
			alert('인증완료 개인정보를 수정할 수 있는 페이지로 이동합니다');
			f.action = 'myUpdatePage';
			f.submit();
			/* swal("인증완료", "개인정보를 수정할 수 있는 페이지로 이동합니다.", {
			      icon: "success",
			    });
			    setTimeout(function(){
			    	f.action = 'myUpdatePage';
					f.submit();
			    }, 1000); */
		}
		
		 
	}
	
</script>

<div class="myPagePwConfirm-wrap">

		<form>
			<div class="centered">
				<h2>회원정보 변경</h2>
				<h4>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해 주세요.</h4>
			</div>
			
			<div class="idPw-input-wrap">
				<div>
					 <span style="color: black;">아이디</span> &nbsp;&nbsp; <span style="color: black; font-size: 25px; font-weight: bold">${loginDTO.mId}</span> &emsp;&emsp;&emsp; 
					<span style="color: black;">비밀번호 </span> &nbsp;&nbsp; <input type="password" name="mPw" ><br><br>
					<input class="gradient-btn" type="button" value="취소" onclick="location.href='goMyPage'">
					<input type="hidden" name="mId" value="${loginDTO.mId}">
					<input class="gradient-btn" type="button" value="인증하기" onclick="fn_pwConfirm(this.form)">
				</div>
			</div>
		</form>
</div>

	
	
	
<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>