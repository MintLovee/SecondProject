<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.reservation.*"%>
<%@ page import="service.reservation.RezMgtListService" %>
<%@ page import="java.util.*"%>
<%@ page import="util.MyCalendar"%>
<%@ page import="util.PageInfo"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	ArrayList<ReservationListBean> rezList = (ArrayList<ReservationListBean>)request.getAttribute("rezList");
    PageInfo rezPageInfo = (PageInfo)request.getAttribute("pageInfo");
	int nowPage = rezPageInfo.getPage();
	int maxPage = rezPageInfo.getMaxPage();
	int startPage = rezPageInfo.getStartPage();
	int endPage = rezPageInfo.getEndPage();
	int listCount = rezPageInfo.getListCount();
%>
<%
	Date date = new Date();
	int year = date.getYear() + 1900;
	int month = date.getMonth() + 1;
	int day = date.getDay();
	try{
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		
		if (month >= 13) {
			year++;
			month = 1;
		} else if (month <= 0) {
			year--;
			month = 12;
		}
	} catch (Exception e){}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
h2{text-align: center;}
#rezListButton form{display: inline;}
#rezListButton{text-align: right;}
	
.rezListTable {
  width: 100%;
  border-collapse: collapse;
  text-align: center;
  line-height: 1.5;
}
.rezListTable th {
  padding: 9px;
  font-weight: bold;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
  background: #f3f6f7;
}
.rezListTable td {
  padding: 9px;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}
#cTitle{font-size: 1.5em;}
.rezInfo{cursor: pointer;}
.clearfix{clear: both;}
#pageList{margin: auto; width: 70%; text-align: center;}
#emptyArea{margin: auto; width: 70%; text-align: center;}
</style>
<style type="text/css">
.calendarButton{text-align: center;}
.cButtonL{text-align: right;}
.cButtonR{text-align: left;}

#calendar{
  width: 80%; 
  margin: auto;
  text-align: center;
  line-height: 1.5;
}
#calendar tr.yoil{border-bottom: 1px solid #ccc; background: #f3f6f7;}
#calendar td{width: 50px; text-align: right; font-size: 11pt; padding: 10px; border-bottom: 1px solid #ccc;}

#calendar td.sunday{text-align: center; font-weight: bold; color: red;}
#calendar td.saturday{text-align: center; font-weight: bold; color: blue;}
#calendar td.etcday{text-align: center; font-weight: bold; color: black;}
#calendar td.yoil{font-size: 13pt;}

#calendar td.sun{text-align: center; color: red; vertical-align: middle;}
#calendar td.sat{text-align: center; color: blue; vertical-align: middle;}
#calendar td.etc{text-align: center; color: black; vertical-align: middle;}
#calendar td.redbefore{text-align: right; color: red; vertical-align: top;}
#calendar td.before{text-align: right; color: gray; vertical-align: top;}
#calendar td.bDays{opacity: 0.3;}
</style>

<script>
$(function() {
	<%if ((request.getParameter("inDate") != "" && request.getParameter("inDate") != null) || (request.getParameter("month") != "" && request.getParameter("month") != null)) {%>
	location.href="#cBookMark";
	<% }%>
	if (window.location.pathname != "/gaia/managePageRez.camp") {
		location.href="managePageRez.camp";
	}
	$('.rezInfo').click(function() {
		$('.rezInfo').css("background-color", "transparent");
		selectTr = $(this);
		selectTd = selectTr.children();
		rezNum = selectTd.eq(0).text();
		pNum = selectTd.eq(4).text();
		$('#rezNumA').val(rezNum);
		$('#pNum').val(pNum);
		$('#rezNumB').val(rezNum);
		$('#'+rezNum).css("background-color", "#FFFFDE");
	});
});
</script>
<script>
function check() {
	if ($('#rezNumB').val() == "") {
		alert("삭제할 항목을 선택해주세요.");
		return false;
	} else if($('#rezNumB').val() != "") {
		if (confirm("정말 삭제하시겠습니까?") == true) {
		} else {
			return false;
 		}
	}
}
function lcSubmit() {
	if ($('#rezNumB').val() == "") {
		alert("수정할 항목을 선택해주세요.");
		return false;
	}
  }
</script>

<title>예약관리</title>
</head>

<body>

<div class="container">
	
	<section class="rezList" class="col-xs-12">
	<h2>예약 현황</h2><br>
	
	<div id="rezListButton">
		<button type="button" class="btn btn-dark" onClick="location.href='rezMgtInsertForm.camp'">예약추가</button>
		<form action="/gaia/rezMgtUpdate.camp" method="POST" onsubmit="return lcSubmit();">
		<input type="hidden" id="rezNumA" name="rezNumA"/>
		<input type="hidden" id="pNum" name="pNum"/>
		<input type="submit" class="btn btn-dark" id="mgtUpdateBt" value="예약수정"/>
		</form>
		<form action="/gaia/rezMgtDelete.camp" method="POST" onsubmit="return check();">
		<input type="hidden" id="rezNumB" name="rezNumB"/>
		<input type="submit" class="btn btn-dark" id="mgtDeleteBt" value="예약삭제"/>
		</form>
		<input type="submit" class="btn btn-info" value="전체보기" onClick="location.href='managePageRez.camp'"/>
	</div>
	<div class="clearfix"></div><br>
	
	<div id="rezListTable">
		<table class="rezListTable">
		<% if (rezList != null && listCount > 0) {%>
		<tr id="tr_top">
		<th scope="col">예약번호</th>
		<th scope="col">아이디</th>
		<th scope="col">이름</th>
		<th scope="col">연락처</th>
		<th scope="col">상품번호</th>
		<th scope="col">입실일</th>
		<th scope="col">퇴실일</th>
		<th scope="col">이용일수</th>
		<th scope="col">가격</th>
		<th scope="col">합계</th>
		</tr>
		
		<% for (int i = 0; i < rezList.size() ; i++) {%>
		<tr id=<%=rezList.get(i).getREZ_NUM()%> class="rezInfo">
		<td><%= rezList.get(i).getREZ_NUM()%></td>
		<td><%= rezList.get(i).getREZ_ID() %></td>
		<td><%= rezList.get(i).getREZ_NAME() %></td>
		<td><%= rezList.get(i).getREZ_TEL() %></td>
		<td><%= rezList.get(i).getREZ_PNUM() %></td>
		<td><%= rezList.get(i).getREZ_INDATE() %></td>
		<td><%= rezList.get(i).getREZ_OUTDATE() %></td>
		<td><%= rezList.get(i).getREZ_DIFFDAYS() %></td>
		<c:set var="price" value="<%= rezList.get(i).getREZ_PRICE()%>"/>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${price}"/></td>
		<c:set var="total" value="<%=rezList.get(i).getREZ_TOTAL()%>"/>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${total}"/></td>
		</tr>
		<% }%>
		</table>
	</div><br><br>

	<div id="pageList">
	<ul class="pagination justify-content-center">
	<% if(nowPage<=1 || nowPage<11){ %>
	<li class="page-item"><a title="이전" class="page-link" href="#"
		style="pointer-events: none; cursor: default; color: #000;">&#11164;</a></li>
	<% } else if(nowPage>=11) { %>
		<c:if test = "${param.searchWord != null}">
			<li class="page-item"><a title="이전" class="page-link"
				href="managePageRez.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%= nowPage-1%>">&#11164;</a>
		</c:if>
		<c:if test = "${param.searchWord == null}">
			<li class="page-item"><a title="이전" class="page-link"
				href="managePageRez.camp?page=<%= nowPage-1%>">&#11164;</a>
		</c:if>
	<%} %>				

	<% for(int a=startPage; a<=endPage;a++) {
		if(a==nowPage){ %>
	<li class="page-item"><a class="page-link" href="#"
		style="pointer-events: none; cursor: default; color: #000;"><%=a %></a></li>
	<% } else { %>
		<c:if test = "${param.searchWord != null}">
			<li class="page-item"><a class="page-link"
				href="managePageRez.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%= a%>"><%= a%></a>
		</c:if>
		<c:if test = "${param.searchWord == null}">
			<li class="page-item"><a class="page-link"
				href="managePageRez.camp?page=<%= a%>"><%= a%></a>
		</c:if>
	<%} %>	
	<%} %>
	
	<% if (nowPage>=maxPage) { %>
	<li class="page-item"><a title="다음" class="page-link" href="#"
		style="pointer-events: none; cursor: default; color: #000;">&#11166;</a></li>
	<% } else if ((nowPage+10)>=maxPage) { %>
		<c:if test = "${param.searchWord != null}">
			<li class="page-item"><a title="다음" class="page-link"
				href="managePageRez.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=maxPage %>">&#11166;</a>
		</c:if>
		<c:if test = "${param.searchWord == null}">
			<li class="page-item"><a title="다음" class="page-link"
				href="managePageRez.camp?page=<%=maxPage %>">&#11166;</a>
		</c:if>
	<% } else { %>
		<c:if test = "${param.searchWord != null}">
			<li class="page-item"><a title="다음" class="page-link"
				href="managePageRez.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=nowPage+10 %>">&#11166;</a>
		</c:if>
		<c:if test = "${param.searchWord == null}">
			<li class="page-item"><a title="다음" class="page-link"
				href="managePageRez.camp?page=<%=nowPage+10 %>">&#11166;</a>
		</c:if>
	<%} %></ul><br><br>
	
	<form>
		<div class="form-row">
		<div class="form-group col-md-1"></div>
		<div class="form-group col-md-3">
			<select name="fieldName" id="fieldName" class="form-control">
	    		<option ${(param.fieldName == "rez_num")? "selected" : ""} value = "rez_num">예약번호</option>
    			<option ${(param.fieldName == "rez_id")? "selected" : ""} value = "rez_id">아&nbsp;&nbsp;이&nbsp;&nbsp;디</option>
    			<option ${(param.fieldName == "rez_nickName")? "selected" : ""} value = "rez_nickName">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</option>
			</select>
		</div>
		<div class="form-group col-md-6">
			<input type="text" class="form-control" placeholder="Search" name="searchWord" value = "${param.searchWord}"/>
		</div>
		<div class="form-group col-md-1">
			<button class="btn btn-dark" type="submit">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
				 fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  				<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
			</svg>
			
			</button>
		</div>
		<div class="form-group col-md-1"></div>
		</div>
	</form>
	</div>
	
<% } else { %>
<section id="emptyArea">예약 현황이 없습니다.</section>
<% } %>
</section><a id="cBookMark"></a><br>
<hr><br>

<div class="calendarBox">
	<section class="calendarTop">
		<div class="calendarButton">
			<button type="button" class="btn btn-dark" onclick="location.href='?year=<%=year%>&month=<%=month-1%>'">&lt;</button>
			&nbsp;&nbsp;&nbsp;&nbsp;<span id="cTitle"><%=year%>. <%=month%></span>&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" class="btn btn-dark" onclick="location.href='?year=<%=year%>&month=<%=month+1%>'">&gt;</button>
		</div>
	</section>
	
<div id="table-responsive" class="col-xs-12"><br>
	<table id="calendar">
	<tr class="yoil">
		<td class = "sunday yoil">일</td>
		<td class = "etcday yoil">월</td>
		<td class = "etcday yoil">화</td>
		<td class = "etcday yoil">수</td>
		<td class = "etcday yoil">목</td>
		<td class = "etcday yoil">금</td>
		<td class = "saturday yoil">토</td>
	</tr>
	
	<tr>
	<%
		int first = MyCalendar.weekDay(year, month, 1);
	
		int start = 0 ;
		start = month ==1? MyCalendar.lastDay(year-1, 12)- first : MyCalendar.lastDay(year, month-1)- first;
	
		for(int i= 1; i<= first; i++){
			if(i==1){
				out.println("<td class = 'redbefore'>"+(month ==1? 12 : month-1)+"/"+ ++start +"</td>");
			}else{
				out.println("<td class = 'before'>"+(month ==1? 12 : month-1)+"/"+ ++start +"</td>");
				
			}
		}

		for(int i = 1; i <= MyCalendar.lastDay(year, month); i++){
			if (MyCalendar.printDay(year, month, i) < MyCalendar.today() || 
					MyCalendar.printDay(year, month, i) >  MyCalendar.afterWeeks()) {
				int mpDay = MyCalendar.printDay(year, month, i);
				switch(MyCalendar.weekDay(year, month, i)){
				case 0 :
					out.println("<td id='date" + i + "' class='sun bDays'>" + i + "<br>카라반&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("A",mpDay)+"<br>데&nbsp;&nbsp;&nbsp;크&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("B",mpDay)+"<br>파쇄석&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("C",mpDay)+"</td>");
					break;
				case 6 :
					out.println("<td id='date" + i + "' class='sat bDays'>" + i + "<br>카라반&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("A",mpDay)+"<br>데&nbsp;&nbsp;&nbsp;크&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("B",mpDay)+"<br>파쇄석&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("C",mpDay)+"</td>");
					break;
				default :
					out.println("<td id='date" + i + "' class='etc bDays'>" + i + "<br>카라반&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("A",mpDay)+"<br>데&nbsp;&nbsp;&nbsp;크&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("B",mpDay)+"<br>파쇄석&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("C",mpDay)+"</td>");
					break;
				}
			} else {
				int mpDay = MyCalendar.printDay(year, month, i);
				switch(MyCalendar.weekDay(year, month, i)){
				case 0 :
					out.println("<td id='date" + i + "' class='sun aDays'>" + i +"<br>카라반&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("A",mpDay)+"<br>데&nbsp;&nbsp;&nbsp;크&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("B",mpDay)+"<br>파쇄석&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("C",mpDay)+"</td>");
					break;
				case 6 :
					out.println("<td id='date" + i + "' class='sat aDays'>" + i +"<br>카라반&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("A",mpDay)+"<br>데&nbsp;&nbsp;&nbsp;크&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("B",mpDay)+"<br>파쇄석&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("C",mpDay)+"</td>");
					break;
				default :
					out.println("<td id='date" + i + "' class='etc aDays'>" + i +"<br>카라반&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("A",mpDay)+"<br>데&nbsp;&nbsp;&nbsp;크&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("B",mpDay)+"<br>파쇄석&nbsp;&nbsp;&nbsp;&nbsp"
								+RezMgtListService.rezMgtCheck("C",mpDay)+"</td>");
					break;
				}
			}
			
			if(MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)){
				out.println("</tr><tr>");			
			}
		}
		if(MyCalendar.weekDay(year, month, MyCalendar.lastDay(year, month)) !=6){
			for(int i = MyCalendar.weekDay(year, month, MyCalendar.lastDay(year, month))+1; i < 7; i++){
				out.println("<td></td>");	
			}
		}
	%>
	</tr></table><br></div>
	</div>
</div>

</body>
</html>