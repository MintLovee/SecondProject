<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javaBean.member.MemberBean"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberBean memberBean = (MemberBean)request.getAttribute("memberBean");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script>
function check() {
	if (deleteform.MEM_PW.value == "${memberBean.getMEM_PW()}") {
		return true;
	} else {
		alert("비밀번호가 일치하지 않습니다.");
		deleteform.MEM_PW.focus();
		return false;
	}
}
</script>

<style type="text/css">
.top{text-align: center;}
.top p{font-size: 0.8em; color: gray;}
.middle p{color: #666;}
form{display: inline;}
</style>

<title>캠핑카장</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true"/>
<br><br>

	<div class="wrap">
	<div class="container">

		<section class="top">
		<h2>정말 탈퇴하시겠습니까?</h2>
		<p>저희 캠핑카장 이용에 아쉬운 점을 말씀해주시면 개선이 되도록 노력하겠습니다.</p>
		</section><br>
		<hr><br>

		<section class="middle">		
		<div class="col">
		<div class="" style="padding-top: 20px; text-align: center; max-width: 600px; margin: 0 auto;">
			<form name="deleteform" action="memberUserDeleteSuccess.camp" method="post" onsubmit="return check();">
			<input type="password" class="form-control" name="MEM_PW" placeholder=" * 탈퇴하시려면 비밀번호를 입력해주세요." size=50 required/>
			
			<br><br>
			<div id="button">
			<input type="hidden" name="MEM_ID" value="<%=memberBean.getMEM_ID()%>"/>
			<input type="submit" class="btn btn-dark" value="회원탈퇴"/>&nbsp;&nbsp;
			<input type="button" class="btn btn-dark" value="메인으로" onclick="window.location='index.jsp'"/>
			</div><br><br>
			</form>
		<p>※ 회원탈퇴는 예약한 내역이 없어야 가능합니다.</p>
		<p>※ 회원탈퇴시 작성한 댓글은 삭제되지만 작성된 게시글은 삭제되지 않습니다.</p>
		</div>
		</div>
		</section>
		
	</div>
<jsp:include page="footer.jsp" flush="true"/>	
	</div>	
</body>
</html>
