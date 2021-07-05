<%@page import="javaBean.member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="dao.member.MemberDAO"%>
<%@ page import="javaBean.auth.AuthBean"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
.top{text-align: center;}
.top p{font-size: 0.8em; color: gray;}
#button{text-align: center;}
</style>

<title>캠핑카장</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true"/>
<br><br>
	<div class="wrap">
	<div class="container">
	
	<section class="top">
	<h2>탈퇴가 정상적으로 처리되었습니다.</h2>
	<p>그동안 캠핑카장을 이용해주셔서 감사합니다.</p>
	</section><br>
	<hr><br><br>
	
	<div id="button">
	<button type="button" class="btn btn-dark" onclick="location.href='/gaia'">메인으로 가기</button>
	</div>
	
	</div>

<br>
<jsp:include page="footer.jsp" flush="true"/>
</div>
</body>
</html> 