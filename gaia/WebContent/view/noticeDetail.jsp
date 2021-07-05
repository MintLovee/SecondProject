<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.notice.NoticeBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	NoticeBean detailNotice = (NoticeBean) request.getAttribute("detailNotice");
	String nowPage = (String) request.getAttribute("page");
	if(nowPage == null) nowPage="1";
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script>
function check() {
	if (confirm("정말 삭제하시겠습니까?") == true) {
		alert("삭제 완료되었습니다.");
	} else {
		return false;
 	}
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
  width: 350px;
  padding: 10px;
  font-size: 0.9em;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}
tbody td.td_left {font-weight: bold;}
tbody td.td_content {
  padding: 50px;
  text-align: left;
  white-space: pre;
}
form{display:inline;}
#button{text-align: center;}
</style>

<title>캠핑카장</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true" />
	<br>
	<br>
	<div class="wrap">

		<div class="container">
	<section class="top">
	<h2>공지사항</h2>
	<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
	</section><br>
	<hr><br><br>
	<div class="row">
	<section class="middle">
	<div id="noticeDetail">
		<table class="noticeDetail">
		<thead>
		<tr><th scope="col" colspan="4"><%= detailNotice.getNOTICE_TITLE()%></th></tr>
		</thead>
		<tbody>
		<tr><td class="td_left">작성자</td>
			<td class="td_right"><%=detailNotice.getNOTICE_NAME()%></td>
			<td class="td_left">등록일</td>
			<td class="td_right"><%=detailNotice.getNOTICE_DATE()%></td></tr>
		<tr>
			<td colspan="4" style="min-height: 350px; white-space:pre;"><textarea name="NOTICE_CONTENT" class="form-control" id="NOTICE_CONTENT" style="border: 0; resize: none; background-color: #fff;" readonly><%=detailNotice.getNOTICE_CONTENT()%></textarea></td>
			<script>
    			var textarea = $("#NOTICE_CONTENT");
    				if (textarea) {
        				textarea.each(function(){
            				$(this).height(this.scrollHeight);
        				});
    				}
			</script>	
		</tr>		
		</tbody>
		</table><br>
		
		<div id="button">
			<c:if test="${authUser.MEM_ID == 'admin'}">
			<button type="button" class="btn btn-outline-dark" onclick="location.href='noticeModifyForm.camp?notice_num=<%=detailNotice.getNOTICE_NUM()%>&page=<%=nowPage%>'">수정</button>&nbsp;&nbsp;
			<form action="/gaia/noticeDelete.camp" method="POST" onsubmit="return check();">
			<input type="hidden" id="page" name="page" value="<%=nowPage%>"/>
			<input type="hidden" id="notice_num" name="notice_num" value="<%=detailNotice.getNOTICE_NUM()%>"/>
			<input type="submit" class="btn btn-outline-dark" id="noticeDeleteBt" value="삭제"/>&nbsp;&nbsp;
			</form>
			</c:if>
			<button type="button" class="btn btn-dark" onclick="location.href='noticeList.camp?page=<%=nowPage%>'">목록</button>
		</div>
	</div>
	</section>
	</div>
</div>

<br>
<jsp:include page="footer.jsp" flush="true" />
</div>
</body>
</html>