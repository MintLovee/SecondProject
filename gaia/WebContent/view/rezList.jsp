<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.product.ProductBean"%>
<%@ page import="service.reservation.RezListService" %>
<%@ page import="java.util.*"%>
<%@ page import="util.MyCalendar"%>
<%@ page import="java.math.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% ArrayList<ProductBean> productList = (ArrayList<ProductBean>)request.getAttribute("productList");%>
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
<%
   String inD = "";
   String outD = ""; 
   String inDay = "";
   String outDay = "";
   int reCount = 0;
   int moveDay = 0;
   int paramMonth = 0;
   if (request.getParameter("inDate") != null && request.getParameter("outDate") != null) { 
      inD = request.getParameter("inDate");   
      outD = request.getParameter("outDate");
      inDay = inD.substring(inD.length()-6, inD.length());
      if (request.getParameter("outDate") != "") {
         outDay = outD.substring(outD.length()-6, outD.length());
         reCount = Integer.parseInt(outDay) - Integer.parseInt(inDay);
      }
      moveDay = Integer.parseInt(inD.substring(inD.length()-6, inD.length()));
      paramMonth = Integer.parseInt(inD.substring(4, 6));
   }
%>
<!DOCTYPE html>
<html><head><meta charset="UTF-8">
<style type="text/css">
/* 기본스타일  */   
   table{align: "center"; cellpadding: "5"; cellspacing: "0";}
   tr{height: 50px;}
   td{width: 60px; text-align: right; font-size: 15pt; font-family: D2coding;}
   table tr td{border: 1px solid #333;}
   td:hover{color:#333;}
   .cButton{text-align: center;}
   .noListItem{opacity: 0.3; padding: 0px 15px;}
   .listItem{padding: 0px 15px;}
   .calendarText{display: inline-block; color: #333; font-size: 1.2em; text-align: center;}
/* 타이틀 스타일 */
   th#title{font-size: 20pt; font-weight: bold; color: #333; D2coding; text-align: center;}
/* 요일 스타일 */
   td.sunday{ text-align: center; font-size: 12pt; font-weight: bold; color: red; font-family: D2coding; background: #f3f6f7; border: 0px;}
   td.saturday{ text-align: center; font-size: 12pt; font-weight: bold; color: blue; font-family: D2coding; background: #f3f6f7; border: 0px;}
   td.etcday{ text-align: center; font-size: 12pt; font-weight: bold; color: black; font-family: D2coding; background: #f3f6f7; border: 0px;}
/* 날짜 스타일 */
   td.sun{ text-align: center; font-size: 15pt; color: red; font-family: D2coding; vertical-align: middle;}
   td.sat{ text-align: center; font-size: 15pt; color: blue; font-family: D2coding; vertical-align: middle;}
   td.etc{ text-align: center; font-size: 15pt; color: black; font-family: D2coding; vertical-align: middle;}
   td.redbefore{ text-align: right; font-size: 10pt; color: red; font-family: D2coding; vertical-align: top;}
   td.before{ text-align: right; font-size: 10pt; color: gray; font-family: D2coding; vertical-align: top;}
   td.bDays{opacity: 0.3;}
   td.aDays{cursor: pointer;}
</style>
<style>
#inOutInfo{text-align: center;}
.clearfix{clear: both;}
.top{text-align: center;}
.top p{font-size: 0.8em; color: gray;}
.listItems{display: inline-block; color: #333;}
.listPrice{padding-top:6%; vertical-align: bottom; text-align: right;}
#rezList{border: 1px solid #ccc;}
#information{border: 1px solid #ccc; background-color: #f5f5f5; padding: 0px 30px;}
#mTitle{}
.cpcjImg{
    border-radius: 8%;
    overflow: hidden;}
table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
  line-height: 1.5;
}
thead th {
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  color: #369;
  border-bottom: 3px solid #036;
}
tbody th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
  border-top: 1px solid #ccc;
  background: #f3f6f7;
}
td {
  width: 350px;
  padding: 10px;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}
.hyphen{
  margin:0;
  padding:0;
  list-style: none
}
.hyphen li{
  position: relative;
  margin: 2px 0 0 0;
  padding: 0 0 4px 16px;
  font-size:16px;
  color: #000;
}
.hyphen li:before{
  content: "";
  position: absolute;
  top: 10px;
  left: 6px;  
  width: 4px;
  height: 1px;
  background: #262626;
}
#rezButton{text-align: center;}
</style>
<title>캠핑카장</title>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function() {
   <%if ((request.getParameter("inDate") != "" && request.getParameter("inDate") != null) || (request.getParameter("month") != "" && request.getParameter("month") != null)) {%>
      location.href="#cBookMark";
   <% }%>
   <%if (request.getParameter("inDate") != "" && request.getParameter("outDate") == "") {%>
      $('#inDate').val(<%=inD%>);
   <% } else {%>
      pMonth = <%=paramMonth%>;
      nMonth = <%=month%>;
      if (pMonth != 0 && pMonth != nMonth) {
         location.href="?year=<%=year%>&month=<%=paramMonth%>&inDate=<%=inD%>&outDate=<%=outD%>";
      }
   <% }%>
   $('#inDate').val(<%=inD%>);
   $('#outDate').val(<%=outD%>);
   if ($('#inDate').val() != null && $('#outDate').val() != null) {
      $('#date<%=inDay%>').css("background-color", "#FF8C00");
      $('#date<%=outDay%>').css("background-color", "#FF8C00");
      count = <%=reCount%>;   mDay = <%=moveDay%>;
      for (i = 1; i < count; i++) {
         ++mDay;
         $('#date'+mDay).css("background-color", "#FFA500");
      }
   }
   
   $('.aDays').hover(function() {
      $(this).css("opacity", "0.3");
   }, function(){
      $(this).css("opacity", "1");
   });
    $('.aDays').click(function() {
       selectDate = $(this).html();
       if (selectDate < 10)   selectDate = "0"+selectDate;
        if (<%=month%> < 10)   fullDate = <%=year%>+"0"+<%=month%>;
        else               fullDate = <%=year%><%=month%>;
        fullDate += selectDate;
        fDate = fullDate.substring(2, 8);
       if ($('#inDate').val() == "") {
          insertInDate(fullDate);   startDate = fDate;
          $('#date'+fDate).css("background-color", "#FF8C00");
          inDate = fullDate;      fullDate = "";
       } else {
          if ($('#outDate').val() != "") {
             $('.aDays').css("background-color", "transparent");
             insertInDate(fullDate);   startDate = fDate;
                $('#date'+fDate).css("background-color", "#FF8C00");
                inDate = fullDate;      fullDate = "";
             $('#outDate').val("");
          } else if (fullDate < $('#inDate').val()) {
             alert("퇴실일은 입실일보다 뒤에 선택해주세요.");
             $('#inDate').val("");
             $('#outDate').val("");
             $('.aDays').css("background-color", "transparent");
          } else if (fullDate == $('#inDate').val()) {
             alert("날짜를 다르게 선택해주세요.");
          } else if (fullDate > $('#inDate').val()) {
             y1 = $('#inDate').val().substring(0, 4);
             m1 = $('#inDate').val().substring(4, 6);
             d1 = $('#inDate').val().substring(6, 8);
             y2 = fullDate.substring(0, 4);
             m2 = fullDate.substring(4, 6);
             d2 = fullDate.substring(6, 8);
             beforeDate = new Date(y1, m1, d1);
             afterDate = new Date(y2, m2, d2);
             dateDiff = Math.ceil((afterDate.getTime()-beforeDate.getTime())/(1000*60*60*24));
             if (dateDiff > 6) {
                alert("최대 예약가능일수는 6박 7일입니다.");
             } else {
               insertOutDate(fullDate);   
                if ($('#inDate').val().substring(4, 6) == $('#outDate').val().substring(4, 6)) {
                   endDate = fDate;   count = endDate - startDate;
                    $('#date'+fDate).css("background-color", "#FF8C00");
                    for (i = 1; i < count; i++) {
                       ++startDate;
                       $('#date'+startDate).css("background-color", "#FFA500");
                    }
                    outDate = fullDate;      fullDate = "";
                    location.href="rezList.camp?inDate="+inDate+"&outDate="+outDate;
                } else {
                   endDate = fDate;   newMonthDay = fDate.substring(4, 6);
                   $('#date'+fDate).css("background-color", "#FF8C00");
                   for (i = 1; i < newMonthDay; i++) {
                       --endDate;
                       $('#date'+endDate).css("background-color", "#FFA500");
                    }
                }
             }
          }
      }
   });
    $('.listItem').click(function() {
       if ($('#inDate').val() != "" && $('#outDate').val() != "") {
          var pNum = $($(this)).attr("id");
          inDate = $('#inDate').val();
          outDate = $('#outDate').val();
           yid = $('#inDate').val().substring(0, 4);
          mid = $('#inDate').val().substring(4, 6);
          did = $('#inDate').val().substring(6, 8);
          yod = $('#outDate').val().substring(0, 4);
          mod = $('#outDate').val().substring(4, 6);
          dod = $('#outDate').val().substring(6, 8);
          bDate = new Date(yid, mid, did);
          aDate = new Date(yod, mod, dod);
          diffDays = Math.ceil((aDate.getTime()-bDate.getTime())/(1000*60*60*24));
          location.href="/gaia/rezDetail.camp?p_num="+pNum+"&inDate="+inDate+"&outDate="+outDate+"&diffDays="+diffDays;
       } else {
          alert("일정을 선택하고 상품을 선택해주세요.");   return;
       }
    });
});
function insertInDate(fullDate) {$('#inDate').val(fullDate);}
function insertOutDate(fullDate) {$('#outDate').val(fullDate);}
function nextMonth() {
   if ($('#inDate').val() != "" && $('#outDate').val() == "") {
      if (<%=month%> < 10)   cFullDate = <%=year%>+"0"+<%=month%>;
        else               cFullDate = <%=year%><%=month%>;
      lDay = <%=MyCalendar.lastDay(year, month)%>;
        cFullDate += lDay;
        nextInDate = $('#inDate').val();
      if (cFullDate - $('#inDate').val() <= 6) {
         location.href="?year=<%=year%>&month=<%=month+1%>&inDate="+nextInDate+"&outDate=";
      } else {
         location.href="?year=<%=year%>&month=<%=month+1%>";
      }
   } else {
      location.href="?year=<%=year%>&month=<%=month+1%>";
   }
}
</script>

</head>
<body>
<jsp:include page="header.jsp" flush="true"/><br><br>

<div class="container">
   
   <section class="top"><div class="col-sm-12">
   <h2>예약 일정 정보</h2>
   <p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
   </div></section><br><hr><br>
   
   <section class="middle">
   <div class="row">
    <div id="main" class="mainBox col-lg-6 order-lg-1" ><br>
       <div><img title="캠핑카장 지도" alt="캠핑카장의 사이트와 편의시설 위치가 그려져있는 일러스트 지도" id="mainPohto" class="img-responsive" src="/gaia/images/Map.png" width="100%"><br></div>
    <div><br>
       <h3 id="mTitle">캠핑카장</h3>
      <p>대구광역시 수성구 진밭길 112(대구 수성구 범물동 951)<br>관리사무소 053-000-0000</p></div>
     </div>
     
    <div id="table-responsive" class="mainBox col-lg-6 order-lg-2"><a id="cBookMark"></a>
    <br>
   <table id="calendar">
   <tr>
      <th scope="row">
      <div class="cButton"><input type="button" value="&lt;" onclick="location.href='?year=<%=year%>&month=<%=month-1%>'"></div>
      </th>
      
      <th scope="row" id = "title" colspan = "5">
      <%=year%>년  <%=month%>월
      </th>
         
      <th scope="row">
      <div class="cButton"><input type="button" value="&gt;" onclick="nextMonth()"></div>
      
      </th>
   </tr>
   <tr>
      <td class = "sunday">일</td>
      <td class = "etcday">월</td>
      <td class = "etcday">화</td>
      <td class = "etcday">수</td>
      <td class = "etcday">목</td>
      <td class = "etcday">금</td>
      <td class = "saturday">토</td>
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
            switch(MyCalendar.weekDay(year, month, i)){
            case 0 :
               out.println("<td id='date" + MyCalendar.printDay(year, month, i) + "' class='sun bDays'>" + i +"</td>");
               break;
            case 6 :
               out.println("<td id='date" + MyCalendar.printDay(year, month, i) + "' class='sat bDays'>" + i +"</td>");
               break;
            default :
               out.println("<td id='date" + MyCalendar.printDay(year, month, i) + "' class='etc bDays'>" + i +"</td>");
               break;
            }
         } else {
            switch(MyCalendar.weekDay(year, month, i)){
            case 0 :
               out.println("<td id='date" + MyCalendar.printDay(year, month, i) + "' class='sun aDays'>" + i +"</td>");
               break;
            case 6 :
               out.println("<td id='date" + MyCalendar.printDay(year, month, i) + "' class='sat aDays'>" + i +"</td>");
               break;
            default :
               out.println("<td id='date" + MyCalendar.printDay(year, month, i) + "' class='etc aDays'>" + i +"</td>");
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
   </tr></table><br>
      <div id="inOutInfo">
         <div class="calendarText">입실일<br>
            <input type="text" id="inDate" required maxlength="10" placeholder="20210101" size="8"></div>
         <div class="calendarText">&nbsp;&nbsp;~&nbsp;&nbsp;</div>
         <div class="calendarText">퇴실일<br>
            <input type="text" id="outDate" required maxlength="10" placeholder="20210102" size="8"></div>
      </div><br>
    </div></div><hr><br>
    
    <div id="rezList">
    <% for (int i = 0; i < productList.size(); i++) { %>
       <% if (request.getParameter("inDate") != null && request.getParameter("outDate") != null) { %>
          <% if (RezListService.rezCheck(productList.get(i).getP_NUM(), request.getParameter("inDate"), request.getParameter("outDate"))) { %>
             <% if (i == 0) {%>
                <div class="clearfix"></div><br>
             <% } else {%>
                <div class="clearfix"></div><hr>
             <% } %>
             <div id="<%= productList.get(i).getP_NUM() %>" class="listItem row" style="cursor:pointer;">
             <div id="listImg" class="col-sm-2 order-sm-1 listItems">
             <img title="사이트 사진" alt="캠핑카장 사이트 메인 사진" class="img-responsive cpcjImg" src="<%= productList.get(i).getP_IMG() %>" width="100%"></div>
             <div id="listContent" class="col-sm-8 order-sm-2 listItems"><p>
             <%= productList.get(i).getP_NAME() %>(<%= productList.get(i).getP_NUM()%>)<br>&nbsp;●<%= productList.get(i).getP_SERVICE() %><br>&nbsp;●<%= productList.get(i).getP_NOTES() %></p></div>
             <div class="col-sm-2 order-sm-3 listItems listPrice"><p><fmt:formatNumber type="number" maxFractionDigits="3" value="<%= productList.get(i).getP_PRICE() %>"/>원</p></div>
            </div>
          <% } else {%>
             <% if (i == 0) {%>
                <div class="clearfix"></div><br>
             <% } else {%>
                <div class="clearfix"></div><hr>
             <% } %>
             <div id="<%= productList.get(i).getP_NUM() %>" class="noListItem row">
             <div id="listImg" class="col-sm-2 order-sm-1">
             <img title="사이트 사진" alt="캠핑카장 사이트 메인 사진" class="img-responsive cpcjImg" src="<%= productList.get(i).getP_IMG() %>" width="100%"></div>
             <div id="listContent" class="col-sm-8 order-sm-2"><p>
             <%= productList.get(i).getP_NAME() %>(<%= productList.get(i).getP_NUM()%>)<br>&nbsp;●<%= productList.get(i).getP_SERVICE() %><br>&nbsp;●<%= productList.get(i).getP_NOTES() %></p></div>
             <div class="col-sm-2 order-sm-3 listPrice"><p><fmt:formatNumber type="number" maxFractionDigits="3" value="<%= productList.get(i).getP_PRICE() %>"/>원</p></div>
            </div>
         <% } %>
       <% } else if (request.getParameter("inDate") == null && request.getParameter("outDate") == null){ %>
          <% if (i == 0) {%>
             <div class="clearfix"></div><br>
          <% } else {%>
             <div class="clearfix"></div><hr>
          <% } %>
          <div id="<%= productList.get(i).getP_NUM() %>" class="listItem row" style="cursor:pointer;">
          <div id="listImg" class="col-sm-2 order-sm-1">
          <img title="사이트 사진" alt="캠핑카장 사이트 메인 사진" class="img-responsive cpcjImg" src="<%= productList.get(i).getP_IMG() %>" width="100%"></div>
          <div id="listContent" class="col-sm-8 order-sm-2"><p>
          <%= productList.get(i).getP_NAME() %>(<%= productList.get(i).getP_NUM()%>)<br>&nbsp;●<%= productList.get(i).getP_SERVICE() %><br>&nbsp;●<%= productList.get(i).getP_NOTES() %></p></div>
          <div class="col-sm-2 order-sm-3 listPrice"><p><fmt:formatNumber type="number" maxFractionDigits="3" value="<%= productList.get(i).getP_PRICE() %>"/>원</p></div>
         </div>
      <% } %>
   <% } %>   
   <br></div><br>
    
    <div id="information" class="mainBox col-sm-12"><br>
       <div><h5>캠핑카장 부대시설</h5>
       <ul class="hyphen">
          <li>공용 화장실, 샤워장, 취사장 사용 가능</li>
          <li>각 사이트별 전기 사용 가능 (단, 최대 3Kw이하로 사용, 전력소비량이 높은 제품은 사용불가)</li>
          <li>야외 평상(2m X 2m) (계곡, 목교건너편 위치)</li>
       </ul></div><hr>
       <div><h5>이용 시 주의사항</h5>
       <ul class="hyphen">
         <li>캠핑장비(텐트, 화로 등 모든장비)는 직접 가져오셔야 합니다. (화로가 제공되지 않습니다.)</li>
         <li>상시 바람이 많이 부는 장소이므로 팩 고정과 텐트시설 설치와 안전에 유의하시기 바랍니다.</li>
         <li>1개 사이트에는 1개의 숙박장비(텐트시설)만 입장할 수 있습니다.</li>
         <li>산불 등 화재예방을 위하여 숯과 장작만 사용 가능하며, 흡연구역을 제외한 흡연은 절대 금지합니다.</li>
         <li>화로 사용시 내부에 솔방울이나 나뭇가지 등을 넣을 경우 불씨가 날릴 수 있으며,<br>불씨가 인근 텐트나 산림에 떨어지면 큰 사고와 화재로 이어질 수 있으므로 금지합니다.</li>
         <li>공용샤워장의 전기온수기는 400L입니다.<br>과도한 온수 사용시 온수지속 시간이 단축될 수 있으며, 전기온수기 특성상 물을 데우는데 시간이 걸리는 점 참고바랍니다.</li>
         <li>개인 캠핑카, 카라반, 캠핑트레일러는 입장이 불가합니다.</li>
         <li>발생 된 쓰레기는 출구 쪽 분리수거장에 분리배출 해주시고, 음식물쓰레기와 폐기름은 취사장 옆 각 통에 배출하여 주시기 바랍니다.</li>
         <li>이용객의 과실로 인한 시설이나 비품의 파손 및 분실에 대한 사항은 이용객에게 비용이 청구됩니다.</li>
         <li>한번에 많은 전기 및 소비전력이 높은 제품 사용은 자제해 주시기 바랍니다.(최대 3Kw이하로 사용).</li>
       </ul></div><br>
   </div>
</section>
</div><br>

<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>