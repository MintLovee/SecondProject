<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.PageInfo"%>
<%@ page import="javaBean.review.ReviewBean"%>
<%@ page import="javaBean.reservation.ReservationBean"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

	ReservationBean article = (ReservationBean)request.getAttribute("article");
	ArrayList<ReviewBean> articleList=(ArrayList<ReviewBean>)request.getAttribute("articleList");
    PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
.top{text-align: center;}
.top p{font-size: 0.8em; color: gray;}

table {
  width: 100%;
  border-collapse: collapse;
  text-align: center;
  line-height: 1.5;
}
thead th {
  padding-top: 15px;
  padding-bottom: 15px;
  font-weight: bold;
  vertical-align: top;
  color: #369;
  border-bottom: 3px solid #036;
  background: #f3f6f7;
}
tbody td {
  width: 350px;
  padding: 10px;
  font-size: 0.9em;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}
tbody tr #num{width: 80px;}
tbody tr #title{width: 420px; text-align: left;}
tbody tr #name{width: 100px;}
tbody tr #date{width: 100px;}
tbody tr #readc{width: 80px;}

#writeButton{text-align: right;}
#pageList{margin: auto; width: 70%; text-align: center;}
#emptyArea{margin: auto; width: 70%; text-align: center;}

</style>


<title>캠핑카장 </title>
</head>

<body>
<jsp:include page="header.jsp" flush="true"/>
 <br><br>
 <div class="wrap">
 <div class="container">
	
	<section class="top">
	<h2>고객후기</h2>
	<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
	</section><br>
	<hr><br><br>
	
      
    
	<section id="listForm">
	<div id="main_article">
		<table class="revList">
			<thead>
			<% if(articleList != null && listCount > 0){ %>
			<tr id="tr_top">
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col" width=20%>작성자</th>
				<th scope="col">등록일</th>
				<th scope="col">조회수</th></tr>
			</thead>
			<tbody>
			<% for(int i=0;i<articleList.size();i++){ %>
			<tr>
				<td id="num"><%=articleList.get(i).getREV_NUM()%></td>

				<td id="title">
					<%if(articleList.get(i).getREV_RE_DEPTH()!=0){ %> <%for(int a=0;a<=articleList.get(i).getREV_RE_DEPTH()*2;a++){ %>
					&nbsp; <%} %><%}else{ %><%} %> <a title="상세보기" 
									href="reviewDetail.camp?rev_num=<%=articleList.get(i).getREV_NUM()%>&page=1&listPage=<%=nowPage%>">
					                  <%=articleList.get(i).getREV_SUBJECT()%>
                  <% if(articleList.get(i).getCOMMENT() > 0) { 
                     int comment = articleList.get(i).getCOMMENT();
                     out.print("[" + comment + "]");}%> 
				</a>
				</td>
				<td id="name">
					<% 
							String name = articleList.get(i).getREV_NAME();
							StringBuffer sb = new StringBuffer();
							if (!name.equals("관리자")) {
								sb.append(name);
								sb.replace(1, 2, "*");
						
							} else{	sb.append("관리자"); }
					
							out.print(sb);
					%>					
				
				</td>
				<td id="date"><%=articleList.get(i).getREV_DATE()%></td>
				
				<td id="readc" style="padding: 15 0 15 0;"><%=articleList.get(i).getREV_READC() %></td>
			</tr>
			<%} %>
			</tbody>
		</table>
			<br>
	

			<div id="writeButton">
			<c:if
			test="${authUser.MEM_ID != 'admin'}">
			<button type="button"  class="btn btn-dark" onclick="location.href='reviewWriteForm.camp'">글쓰기 </button>
			</c:if>
			</div>
			<br>
		
		
			<div id="pageList" align="center">
				<ul class="pagination pagination-sm justify-content-center">
					<%
						if (nowPage <= 1 || nowPage < 11) {
					%>

					<li class="page-item"><a title="이전" class="page-link" href="#"
						style="pointer-events: none; cursor: default; color: #000;">&#11164;</a></li>

					<%
						} else if (nowPage >= 11) {
					%>
					<c:if test="${param.searchWord != null}">
						<li class="page-item"><a title="이전" class="page-link"
							href="reviewList.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=nowPage-10 %>">&#11164;</a></li>
					</c:if>
					<c:if test="${param.searchWord == null}">
						<li class="page-item"><a title="이전" class="page-link"
							href="reviewList.camp?&page=<%=nowPage - 10%>">&#11164;</a></li>
					</c:if>
					<%
						}
					%>

					<%
						for (int a = startPage; a <= endPage; a++) {
								if (a == nowPage) {
					%>
					<li class="page-item"><a class="page-link" href="#"
						style="pointer-events: none; cursor: default; color: #000;"><%=a%></a></li>
					<%
						} else {
					%>

						<li class="page-item"><a class="page-link"
							href="reviewList.camp?page=<%=a%>"><%=a%></a></li>

					<%
						}

						}
					%>

					<%
						if (nowPage >= maxPage) {
					%>
					<li class="page-item"><a title="다음" class="page-link" href="#"
						style="pointer-events: none; cursor: default; color: #000;">&#11166;</a></li>
					<%
						} else if ((nowPage + 10) >= maxPage) {
					%>


						<li class="page-item"><a title="다음" class="page-link"
							href="reviewList.camp?page=<%=maxPage%>">&#11166;</a></li>

					<%
						} else {
					%>


						<li class="page-item"><a title="다음" class="page-link"
							href="reviewList.camp?page=<%=nowPage + 10%>">&#11166;</a></li>

					<%
						}
					%>
				</ul>
			</div>
	
	
	<% } else { %>
	
	
	
	
	<section id="emptyArea">등록된 글이 없습니다.</section>
	<button type="button" onclick="location.href='reviewWriteForm.camp'">후기작성</button>
	<%
	}
	%>
 </div>
 </section>
 </div>

<jsp:include page="footer.jsp" flush="true"/>
</div>
</body>
</html>