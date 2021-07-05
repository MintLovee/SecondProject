<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script>
function clearInput(){
	var el = document.getElementsByClassName("input-text");
	for (var i=0; i<el.length; i++){
		el[i].value = '';
	}
	window.history.back();
}
</script>

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
		<form action="noticeWriteSuccess.camp" method="POST" name="writeform">
			<table>
			<thead>
			<tr><th scope="col" colspan="4">글 작성</th></tr>
			</thead>
			<tbody>
			<tr><td class="td_left" colspan="1">작성자</td>
			<td class="td_right" colspan="3" align="left">${authUser.MEM_NICKNAME}</td></tr>
			<tr><td class="td_left" colspan="1"><label for="NOTICE_TITLE">제 목</label></td>
				<td class="td_right" colspan="3"><input type="text" class="input-text form-control" name="NOTICE_TITLE" id="NOTICE_TITLE" maxlength="50" placeholder="* 제목을 입력하세요." required autofocus></td></tr>
			<tr><td class="td_left" colspan="1"><label for="QNA_CONTENT">내 용</label></td>
				<td colspan="3"><textarea name="NOTICE_CONTENT" class="input-text form-control" name="NOTICE_CONTENT" id="NOTICE_CONTENT" style="height: 350px; resize: none;" placeholder="* 내용을 입력하세요." required></textarea></td></tr>
			</tbody>
			</table><br>
			
			<div id="button">
				<button class="btn btn-outline-dark" onclick="clearInput()">뒤로가기</button>&nbsp;&nbsp;
				<input type="hidden" name="NOTICE_NAME" id="NOTICE_NAME" value="${authUser.MEM_NICKNAME}">
				<input type="submit" class="btn btn-dark" value="작성완료">
			</div>
		</form>
	</section>
</div>

<br>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>