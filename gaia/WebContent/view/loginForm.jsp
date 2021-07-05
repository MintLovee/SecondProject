<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String getreferer = request.getHeader("Referer").substring(26);

%>

<!DOCTYPE html>
<html>
<head>

</head>
<body>
<jsp:include page="header.jsp" flush="true"/>
<br><br><br><br>

<div class="wrap">
	<div class="container" style="max-width: 500px">
		<div class="col"></div>
		
		<div class="col">
			<div class="jumbotron" style="padding-top: 20px;">

				<form method="post" action="loginSuccess.camp">
					<% if(getreferer != null && !getreferer.contains("Success")) { %>
						<input type="hidden" id="referer" name="referer" value="<%= getreferer %>" />
						
					<%} %>
					<% if(getreferer.equals("/joinSuccess.camp")) { %>
						<input type="hidden" id="referer" name="referer" value="" />
						
					<%} %>
					<br>
					<h3 style="text-align: center;">로그인</h3>

					<br>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="id" value="${param.id}" maxlength="20" autofocus>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="password" maxlength="20">
					</div>
					<c:if test="${errors.idOrPwNotMatch}">
						<div class="text-center">
						아이디와 비밀번호가 일치하지 않습니다.<br><br>
						</div>
					</c:if>
					<input type="submit" class="btn btn-dark form-control" value="로그인">
				</form>
				<div style="text-align: center; color: #ddd;">
				<br><br>
					<a title="회원가입 링크" href="join.camp">아직 회원이 아니신가요?</a>
				</div>
			</div>
		</div>
	</div>

<jsp:include page="footer.jsp" flush="true"/>
</div>
</body>
</html>