<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
.top{text-align: center;}
.top p{font-size: 0.8em; color: gray;}
  h2 {text-align: center;}
  h4 {text-align: center;}
  table{margin: auto;}
  tr{text-align: center;}
  #button{text-align: center;}
  td.td_right{text-align:left;}
</style>

<title>캠핑카장</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true" />
<br><br>
	<div class="wrap">
	<div class="container">
	
	<section class="top">
	<h2>회원가입 성공</h2>
	<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
	</section><br>
	<hr><br><br>
	
	<section class="middle">
		<h4>${param.NAME}님 환영합니다.</h4>
		<h4>캠핑카장에서의 행복한 추억을 기원합니다.</h4>
		<br><br>
		
		<div id="button">
		<input type="submit" class="btn btn-dark" value="메인으로" onclick="location.href='index.jsp'">&nbsp;&nbsp;
		<input type="reset" class="btn btn-dark" value="로그인" onclick="location.href='login.camp'">
		</div><br><br>
			
	</section>
	
	</div>
	
<br>
<jsp:include page="footer.jsp" flush="true" />
</div>
</body>
</html>