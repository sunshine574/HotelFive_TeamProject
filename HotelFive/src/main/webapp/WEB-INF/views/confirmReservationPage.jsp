<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<div>
	<div>
		<h1>예약이 완료되었습니다</h1>
		<br/><hr/><br/>
	</div>
	<div>
		<div>
			<h3>예약정보</h3>
			<p>
				<c:if test="${loginDTO eq null }">
					예약자명 : 비회원<br/>
				</c:if>
				<c:if test="${loginDTO ne null }">
					예약자명 : ${loginDTO.mName}<br/>
				</c:if>
				예약객실 : ${gName }<br/>
				투숙기간 : ${rCheckIn } ~ ${rCheckOut }<br/>
			</p>
		</div>
		<br/><hr/><br/>
		<div>
			<h3>입금정보</h3>
			<p>
				입금자명 : (주)호텔파이브<br/>
				입금계좌 : 302-0040-9885-71<br/>
				은행명 : 농협중앙회<br/>
				입금금액 : ${rPrice }원<br/>
			</p>
		</div>
	</div>
</div>
<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>