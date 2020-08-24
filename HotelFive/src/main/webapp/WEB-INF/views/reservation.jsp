<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<style type="text/css">
.cal_top{
    text-align: center;
    font-size: 30px;
}
.cal{
    text-align: center;    
}
table.calendar{
	width : 1500px;
    border: 1px solid black;
    display: inline-table;
    text-align: left;
}
table.calendar td{
    vertical-align: top;
    border: 1px solid skyblue;
    width: 100px;
}
</style>
<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp" />
  <div class="cal_top">
    	<form>
	    	<input type="text" name="rCheckIn" id="rCheckIn" placeholder="입실 날짜"/>
    		<input type="text" name="rCheckOut" id="rCheckOut" placeholder="퇴실 날짜"/>
    		<input type="button" value="검색"  onclick="fn_go(this.form)" />
    		<input type="reset" value="취소"  onclick="fn_reset()" />
    	</form>
    	
        <a href="#" id="movePrevMonth"><span id="prevMonth" class="cal_tit">&lt;</span></a>
        <span id="cal_top_year"></span>
        <span id="cal_top_month"></span>
        <a href="#" id="moveNextMonth"><span id="nextMonth" class="cal_tit">&gt;</span></a>
    </div>
    <div id="cal_tab" class="cal">
    </div>
    <div id="select_info" class="sel">
    	리스트 출력
    </div>
 
<script type="text/javascript">
    
    var today = null;
    var year = null;
    var month = null;
    var firstDay = null;
    var lastDay = null;
    var $tdDay = null;
    var $tdSche = null;
    var count = null;
 	var checkinBtn1 = false;
 	var checkinBtn2 = false;
    var checkInDate = null;
    var checkOutDate = null;
    var checkInDate = null;
    var checkOutDate = null;
    var checkinDay =null
    var checkOutDay =null
		

    	
    	
    
    $(document).ready(function() {
        drawCalendar();
        initDate();
        drawDays();
        $("#movePrevMonth").on("click", function(){movePrevMonth();});
        $("#moveNextMonth").on("click", function(){moveNextMonth();});
    });
    
    //calendar 그리기
    function drawCalendar(){
        var setTableHTML = "";
        setTableHTML+='<table class="calendar">';
        setTableHTML+='<tr><th>SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th>SAT</th></tr>';
        for(var i=0;i<6;i++){
            setTableHTML+='<tr height="100">';
            for(var j=0;j<7;j++){
                setTableHTML+='<td id="day_check" onclick="fn_du(this)" style="text-overflow:ellipsis;overflow:hidden;white-space:nowrap">';
                setTableHTML+='    <div class="cal-day"></div>';
                setTableHTML+='    <div class="cal-schedule"></div>';
                setTableHTML+='</td>';
            }
            setTableHTML+='</tr>';
        }
        setTableHTML+='</table>';
        $("#cal_tab").html(setTableHTML);
        
    }
 
    //날짜 초기화
    function initDate(){
        $tdDay = $("td div.cal-day")
        $tdSche = $("td div.cal-schedule")
        dayCount = 0;
        today = new Date();
        year = today.getFullYear();
        month = today.getMonth()+1;
        firstDay = new Date(year,month-1,1);
        lastDay = new Date(year,month,0);
    }
    
    //calendar 날짜표시
    function drawDays(){
        $("#cal_top_year").text(year);
        $("#cal_top_month").text(month);
      
        
        for(var i=firstDay.getDay();i<firstDay.getDay()+lastDay.getDate();i++){
            $tdDay.eq(i).text(++dayCount);
       	//  $tdSche.eq(i).text(dayCount);
      
        }
        for(var i=0;i<42;i+=7){
            $tdDay.eq(i).css("color","red");
        }
        for(var i=6;i<42;i+=7){
            $tdDay.eq(i).css("color","blue");
        }
        
    }
 
    //calendar 월 이동
    function movePrevMonth(){
        month--;
        if(month<=0){
            month=12;
            year--;
        }
        if(month<10){
            month=String("0"+month);
        }
        getNewInfo();
        }
    
    function moveNextMonth(){
        month++;
        if(month>12){
            month=1;
            year++;
        }
        if(month<10){
            month=String("0"+month);
        }
        getNewInfo();
    }
    
    function getNewInfo(){
        for(var i=0;i<42;i++){
            $tdDay.eq(i).text("");
            $tdSche.eq(i).text("");
        }
        dayCount=0;
        firstDay = new Date(year,month-1,1);
        lastDay = new Date(year,month,0);
        drawDays();
    }
    
    function fn_go(f) {
    	f.rCheckIn.value = new Date(f.rCheckIn.value);
    	f.rCheckOut.value = new Date(f.rCheckOut.value);
		alert(f.rCheckIn.value+ " 부터 " +f.rCheckOut.value );
	}
	function fn_reset() {
		checkinBtn1 = false;
		checkinBtn2 = false;
		getNewInfo();
	}
	function fn_du(f) {
	var text = f.innerHTML;
	var pos1 = text.indexOf('>');
	var pos2= text.indexOf('</div>');
    pos1 = pos1 + 1;
   	var checkDay =  text.substring(pos1,pos2);
    var checkDate = new Date(year+"-"+month+"-"+text.substring(pos1,pos2));
	if(checkDay != ''){
	    if (!checkinBtn1){
		    	$('#rCheckIn').val(year+"-"+month+"-"+text.substring(pos1,pos2));
		    	checkinBtn1=true;
				checkInDate = checkDate;
				checkInDay =  checkDay;
				$tdSche.eq(firstDay.getDay()+Number(checkDay)-1).text('입실');
				//$(day_check).eq(firstDay.getDay()+Number(checkDay)-1).css("background","orange");
		    }else if(!checkinBtn2) {
		        var diff = checkDate.getTime() - checkInDate.getTime();
		        diff = Math.ceil(diff / (1000 * 3600 * 24));
				
		    	if ( diff > 0){
		    	$('#rCheckOut').val(year+"-"+month+"-"+text.substring(pos1,pos2)) ;
		    	checkOutDay =  checkDay;
		    	checkinBtn2=true;
				$tdSche.eq(firstDay.getDay()+Number(checkDay)-1).text('퇴실');
				//$(day_check).eq(firstDay.getDay()+Number(checkDay)-1).css("background","orange");
			
				
		    	}else {
		    		alert('퇴실 날짜 오류');
		    	}
		    }
		}else {
			alert('x');
		}
	}
</script>


<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>