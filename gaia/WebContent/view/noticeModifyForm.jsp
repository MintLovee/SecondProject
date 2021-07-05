<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.notice.NoticeBean"%>

<%
	request.setCharacterEncoding("UTF-8");
	NoticeBean detailNotice = (NoticeBean) request.getAttribute("detailNotice");
	String nowPage = (String) request.getAttribute("page");
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
  padding: 15px;
  font-weight: bold;
  vertical-align: top;
  color: #369;
  border-bottom: 3px solid #036;
  background: #f3f6f7;
}
tbody td {
  width: 200px;
  padding: 10px;
  font-size: 0.9em;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}
tbody td.td_left {font-weight: bold;}

#NOTICE_CONTENT{height: 350px; resize: none;}
#button{text-align: center;}
</style>

<title>캠핑카장</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true"/>
<br><br>
<div class="container">

	<section class="top">
	<h2>공지사항</h2>
	<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
	</section><br>
	<hr><br><br>
	
	<section class="middle">
		<form action="noticeModifySuccess.camp" method="POST" name="modifyform">
			<input type="hidden" name="page" value="<%=nowPage%>"/>
			<input type="hidden" name="NOTICE_NUM" value="<%=detailNotice.getNOTICE_NUM()%>"/>
			<input type="hidden" name="NOTICE_NAME" id="NOTICE_NAME" value="<%=detailNotice.getNOTICE_NAME()%>"/>
			<table>
			<thead>
			<tr><th scope="row" colspan="4">글 수정</th></tr>
			</thead>
			<tbody>
			<tr><td class="td_left" colspan="1">작성자</td>
				<td class="td_right" align="left" colspan="3"><%=detailNotice.getNOTICE_NAME()%></td></tr>
			<tr><td class="td_left" colspan="1"><label for="NOTICE_TITLE">제목</label></td>
				<td class="td_right" colspan="3">
				<input name="NOTICE_TITLE" class="form-control" type="text" id="NOTICE_TITLE"
					   value="<%=detailNotice.getNOTICE_TITLE()%>"/></td></tr>
			<tr><td class="td_left" colspan="1"><label for="NOTICE_CONTENT">내용</label></td>
				<td colspan="3"><textarea id="NOTICE_CONTENT" class="form-control" name="NOTICE_CONTENT"><%=detailNotice.getNOTICE_CONTENT()%></textarea></td></tr>
			</tbody>
			</table><br>
				
			<div id="button">
				<button type="button" class="btn btn-outline-dark" onclick="history.go(-1);">뒤로가기</button>&nbsp;&nbsp;
				<input type="submit" class="btn btn-dark" value="수정완료">
			</div>
		</form>
	</section>
	
</div>

<br>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>