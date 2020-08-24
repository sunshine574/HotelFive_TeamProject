<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp" />


<!-- 관리자가 로그인하면 "관리자메뉴"를 표시한다. -->
<c:if test="${loginDTO.mId == 'admin' }">
	회원관리<br/>
	게시글관리<br/>
</c:if>


<h1> 로그인 처리 페이지 </h1>
<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>