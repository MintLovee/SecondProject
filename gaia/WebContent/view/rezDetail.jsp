<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.product.ProductBean"%> 
<%@ page import="javaBean.reservation.InfoUseBean"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("UTF-8");
	ProductBean proBean = (ProductBean) request.getAttribute("proBean");
	ProductBean productInfo = (ProductBean)request.getAttribute("productInfo");
	InfoUseBean infoUse = (InfoUseBean)request.getAttribute("infoUse");
	String inD = request.getParameter("inDate");
	String outD = request.getParameter("outDate");
	
	String inDate = null;
	if(inD != null) {
		String y = inD.substring(0, 4);
		String m = inD.substring(4, 6);
		String d = inD.substring(6, 8);
		inDate = y + "-" + m + "-" + d;
	}
	
	String outDate = null;
	if(outD != null) {
		String y = outD.substring(0, 4);
		String m = outD.substring(4, 6);
		String d = outD.substring(6, 8);
		outDate = y + "-" + m + "-" + d;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
.clearfix{clear: both;}
.top{text-align: center;}
.top p{font-size: 0.8em; color: gray;}
.middle p{font-weight: bold; color: #369;}
.middle p:after {
  content: "";
  display: block;
  width: 150px;
  border-bottom: 3.5px solid #036;
  margin: 10px 0px;
}
h4{text-align: right;}

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
  background: #f3f6f7;
}
td {
  width: 350px;
  padding: 10px;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}

#rezButton{text-align: center;}
</style>

<title>캠핑카장</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true"/>
<br><br>

<form action="/gaia/rezOk.camp" method="POST">
	<div class="container">
		
		<section class="top">
		
		<h2>예약 상세 정보</h2>
		<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
		</section><br>
		<hr><br>
		
		<section class=	"middle">
		<div class="row">
		<div class="col-sm-12">
		<h4><%=productInfo.getP_NAME()%>(<%=productInfo.getP_NUM()%>)</h4>
		</div>
		
		<div id="productImg" class="mainBox col-lg-6"><br>
			<p>&nbsp;&nbsp;사이트 전경</p>
			<img title="사이트 전경" alt="선택 한 사이트의 메인사진" id="productPhoto" class="img-responsive" src="<%=productInfo.getP_IMG()%>" width="100%"/><br>
		</div><br><br>
		
		<div id="productDetailImg" class="mainBox col-lg-6"><br>
			<p>&nbsp;&nbsp;사이트 상세 사진</p>
			<% if (request.getParameter("p_num").substring(0,1).equals("A")) {%>
				<div id="CRV">
	<div id="carouselExampleCaptions" class="carousel slide"
		data-ride="carousel">
		
		<div class="carousel-inner">
			<div class="carousel-item active" title="카라반">
				<img src="<%=productInfo.getP_IMG()%>" class="d-block w-100" alt="카라반 외부모습">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="침실">
				<img src="/gaia/images/CrvFour-2.png" class="d-block w-100" alt="카라반 침실">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="주방">
				<img  src="/gaia/images/CrvBasic1.png" class="d-block w-100" alt="카라반 주방">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="샤워실">
				<img  src="/gaia/images/CrvBasic4.png" class="d-block w-100" alt="카라반 샤워실">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="외부모습">
				<img   src="/gaia/images/CaravanView2.png" class="d-block w-100" alt="카라반 모습">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="캠핑장 배치도">
				<img  src="/gaia/images/Map.png" class="d-block w-100" alt="캠핑장 배치도">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleCaptions" title="이전"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon scale1" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleCaptions" title="다음"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon scale1" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
</div>

			<%} else if (request.getParameter("p_num").substring(0,1).equals("B")) {%>
				<div id="DEC">
<div id="carouselExampleCaptions" class="carousel slide"
		data-ride="carousel">
		
		<div class="carousel-inner">
			<div class="carousel-item active" title="데크">
				<img src="<%= productInfo.getP_IMG()%>" class="d-block w-100" alt="데크 사이트">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="데크">
				<img src="/gaia/images/deck03.png" class="d-block w-100" alt="데크 사이트">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="데크">
				<img  src="/gaia/images/deck04.png" class="d-block w-100" alt="데크 사이트">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="전체 풍경">
				<img  src="/gaia/images/deckView.png" class="d-block w-100" alt="데크 전체 풍경">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="육각정자">
				<img  src="/gaia/images/conv1.png" class="d-block w-100" alt="육각정자">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="캠핑장 배치도">
				<img  src="/gaia/images/Map.png" class="d-block w-100" alt="캠핑장 배치도">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleCaptions"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleCaptions"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
</div>
			<%} else if (request.getParameter("p_num").substring(0,1).equals("C")) {%>
				<div id="GRA">
<div id="carouselExampleCaptions" class="carousel slide"
		data-ride="carousel">
		
		<div class="carousel-inner">
			<div class="carousel-item active" title="자갈 사이트">
				<img src="<%= productInfo.getP_IMG()%>" class="d-block w-100" alt="자갈 야영장 모습">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="자갈 사이트">
				<img  src="/gaia/images/gra03.png" class="d-block w-100" alt="자갈 야영장 모습">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="자갈 사이트">
				<img  src="/gaia/images/gra04.jpg" class="d-block w-100" alt="자갈 야영장 모습">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="전체 풍경">
				<img  src="/gaia/images/view.jpg" class="d-block w-100" alt="캠핑장 풍경 모습">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="육각정자">
				<img  src="/gaia/images/conv1.png" class="d-block w-100" alt="육각정자">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="캠핑장 배치도">
				<img  src="/gaia/images/Map.png" class="d-block w-100" alt="캠핑장 배치도">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleCaptions"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleCaptions"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
</div>
			<%} %>
		</div>
		<div class="clearfix"></div>
		
		
		<div id="siteInfo" class="col-sm-12"><br><br>
			<table class="siteInfo">
			<thead>
			<tr><th scope="col" colspan="2">이용 안내</th></tr>
			</thead>
			<tbody>
			<tr><th scope="col">선택 사이트</th><td><%=infoUse.getSITE_NAME()%>(<%=infoUse.getSITE_NUM()%>)</td></tr>
			<tr><th scope="col">사이트 크기</th><td><%=infoUse.getSITE_SIZE()%></td></tr>		
			<tr><th scope="col">사이트 정보</th><td><%=infoUse.getSITE_INFO()%></td></tr>		
			</tbody>
			</table>
		</div><br><br>
		
		<div id="rezInfo" class="col-sm-12"><br>
			<table class="rezInfo">
			<thead>
			<tr><th scope="col" colspan="2">예약 정보</th></tr>
			</thead>
			<tbody>
			<c:if test="${empty authUser}">
				<tr><td rowspan="2" colspan="2" align="center"><strong>예약은 로그인 후 가능합니다.</strong></td></tr>
				<tr><tr>
				<tr><th scope="col">선택 구역</th><td><%=infoUse.getSITE_NAME()%>(<%=infoUse.getSITE_NUM()%>)</td></tr>
				<tr><th scope="col">선택 기간</th><td><%=inDate%> ~ <%=outDate%> (<%=infoUse.getDIFF()%>)</td></tr>
				<c:set var="total" value="<%=infoUse.getTOTAL()%>"/>
				<tr><th scope="col">결제 예정 금액</th><td><fmt:formatNumber type="number" maxFractionDigits="3" value="${total}"/>원</td></tr>	
			</c:if>
			
			<c:if test="${!empty authUser}">
				<tr><th scope="col">예약자 명</th><td>${authUser.MEM_NICKNAME}</td></tr>
				<tr><th scope="col">연락처</th><td>${authUser.MEM_TEL}</td></tr>
				<tr><th scope="col">선택 구역</th><td><%=infoUse.getSITE_NAME()%>(<%=infoUse.getSITE_NUM()%>)</td></tr>
				<tr><th scope="col">선택 기간</th><td><%=inDate%> ~ <%=outDate%> (<%=infoUse.getDIFF()%>)</td></tr>
				<c:set var="total" value="<%=infoUse.getTOTAL()%>"/>
				<tr><th scope="col">결제 예정 금액</th><td><fmt:formatNumber type="number" maxFractionDigits="3" value="${total}"/>원</td></tr>	
			</c:if>
			</tbody>
			</table>
		</div>
		</div>
		</section><br>
		
	</div>
	<input type="hidden" name="ProductBean" value="productInfo"/>
	<input type="hidden" id="p_num" name="p_num" value="<%=request.getParameter("p_num")%>"/>
	<input type="hidden" id="test" value="<%=productInfo.getP_NUM()%>"/>
	<input type="hidden" name="inDate" value="<%=request.getParameter("inDate")%>"/>
	<input type="hidden" name="outDate" value="<%=request.getParameter("outDate")%>"/>
	<input type="hidden" name="diffDays" value="<%=request.getParameter("diffDays")%>"/>
	<input type="hidden" name="p_name" value="<%=infoUse.getSITE_NAME()%>"/>
	<input type="hidden" name="diff" value="<%=infoUse.getDIFF()%>"/>
	<c:if test="${authUser.MEM_ID == null}">
		<div id="rezButton"><button class="btn btn-dark" type="button" onclick="alert('로그인 페이지로 이동합니다.'); location.href='login.camp'">예약확정</button></div>
	</c:if>	
	<c:if test="${authUser.MEM_ID != null}">
		<div id="rezButton"><input type="submit" class="btn btn-dark" value="예약확정 "/></div>
	</c:if>
	
</form>

<br>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>