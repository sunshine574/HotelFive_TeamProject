<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<style type="text/css">
	table{
		margin: 0 auto;
		border-collapse: collapse;
		text-align: center;
	}
	th,td{
		border: 1px solid black;
	}
</style>
<script type="text/javascript">
	var basicPrice = 0;
	var nights = 0;
	var addPrice = 0;
	var totalPrice = 0;
	
	window.onload = function(){
		
		var gPrice = '${gDTO.gPrice}';
		var rCheckIn = '${rCheckIn}';
		var rCheckOut = '${rCheckOut}';
		var arr1 = rCheckIn.split('-');
		var arr2 = rCheckOut.split('-');
		var dat1 = new Date(arr1[0], arr1[1], arr1[2]);
		var dat2 = new Date(arr2[0], arr2[1], arr2[2]);
		
		var diff = dat2 - dat1;
		var currDay = 24*60*60*1000;
		nights = parseInt(diff/currDay);
		basicPrice = gPrice * nights;
		$('#basicPrice').html(basicPrice);
		
	}
	
	function fn_change(){
		var selectItem = $("#selectPeople"+${gDTO.gNo}).val();
		var gNo = ${gDTO.gNo};
		var standardPeopleA = 4;
		var standardPeopleB = 2;
		var standardPeopleC = 6;
		var conditionA = selectItem - standardPeopleA + 1;
		var conditionB = selectItem - standardPeopleB + 1;
		var conditionC = selectItem - standardPeopleC + 1;
		var pricePerPeople = 20000;
		
		if(gNo == 1 || gNo == 2){
			if(conditionA <= 0){
				addPrice = 0;
			}else{
				for(var i=0; i<conditionA; i++){
					addPrice = i * nights * pricePerPeople;			
				}
			}
		}
		if(gNo == 3 || gNo == 4){
			if(conditionB <= 0){
				addPrice = 0;
			}else{
				for(var i=0; i<conditionB; i++){
					addPrice = i * nights * pricePerPeople;
				}
			}
		}
		if(gNo == 5){
			if(conditionC <= 0){
				addPrice = 0;
			}else{
				for(var i=0; i<conditionC; i++){
					addPrice = i * nights * pricePerPeople;
				}
			}
		}
			
		totalPrice = basicPrice + addPrice;
		
		$('#addPrice').html(addPrice);
		$('#totalPrice').html(totalPrice);
		document.getElementById('rPrice').value = totalPrice;
	}
	function fn_pay(f){
		if(addPrice == 0){
			alert('인원을 선택해주세요');
			return;
		}else{
			if(confirm('예약하시겠습니까?')){
				alert(totalPrice+'원'+' 결제 완료되었습니다');
				f.action = 'pay';
				f.submit();	
			}
		}
	}
</script>
<h1>인원선택</h1>
<div class="selectedRoomContainer">
	<h2>선택객실목록</h2>
	<form name="form">
		<table>
			<thead>
				<tr>
					<th>객실명</th>
					<th>이용일</th>
					<th>인원선택</th>
					<th>기본이용요금</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty gDTO }">
					<tr>
						<td>선택된 객실이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty gDTO }">
					<tr>
						<td>${gDTO.gName }</td>
						<td>${rCheckIn } ~ ${rCheckOut }</td>
						<td>
							기준인원 ${gDTO.gMinPeople }명, 1명 추가될때마다 2만원이 가산됩니다.
							<br/>최대 ${gDTO.gMaxPeople }명 선택 가능합니다.<br/>
							<c:if test="${gDTO.gNo eq 1 }">
								<select id="selectPeople${gDTO.gNo }" name="rPeople" onchange="fn_change()">
									<option selected>::인원선택::</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
								</select>
							</c:if>
							<c:if test="${gDTO.gNo eq 2 }">
								<select id="selectPeople${gDTO.gNo }" name="rPeople" onchange="fn_change()">
									<option selected>::인원선택::</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
								</select>
							</c:if>
							<c:if test="${gDTO.gNo eq 3 }">
								<select id="selectPeople${gDTO.gNo }" name="rPeople" onchange="fn_change()">
									<option selected>::인원선택::</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
								</select>
							</c:if>
							<c:if test="${gDTO.gNo eq 4 }">
								<select id="selectPeople${gDTO.gNo }" name="rPeople" onchange="fn_change()">
									<option selected>::인원선택::</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
								</select>
							</c:if>
							<c:if test="${gDTO.gNo eq 5 }">
								<select id="selectPeople${gDTO.gNo }" name="rPeople" onchange="fn_change()">
									<option selected>::인원선택::</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
								</select>
							</c:if>
						</td>
						<td>
							<div id="basicPrice"></div>
						</td>
					</tr>
					<tr>
						<th colspan="4" style="text-align: center;">
							<label>인원수에 따른 추가 요금 : </label><div id="addPrice"></div>
							<br/>
							<label>총 합계 요금 : </label><div id="totalPrice"></div>
						</th>
					</tr>
				</c:if>
			</tbody>
			<tfoot>
				<tr>
					<th colspan="4">
						<input type="hidden" name="gNo" value="${gDTO.gNo }"/>
						<input type="hidden" name="gName" value="${gDTO.gName }"/>
						<input type="hidden" name="rPrice" id="rPrice" value=""/>
						<input type="hidden" name="rCheckIn" value="${rCheckIn }"/>
						<input type="hidden" name="rCheckOut" value="${rCheckOut }"/>
						<input type="button" value="예약하기" onclick="fn_pay(this.form)"/>
					</th>
				</tr>
			</tfoot>
		</table>
	</form>
</div>

<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>