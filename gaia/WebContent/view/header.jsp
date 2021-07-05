<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<head>
<title>캠핑카장</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<script defer
	src="https://use.fontawesome.com/releases/v5.0.8/js/solid.js"
	integrity="sha384-+Ga2s7YBbhOD6nie0DzrZpJes+b2K1xkpKxTFFcx59QmVPaSA8c7pycsNaFwUK6l"
	crossorigin="anonymous"></script>
<script defer
	src="https://use.fontawesome.com/releases/v5.0.8/js/fontawesome.js"
	integrity="sha384-7ox8Q2yzO/uWircfojVuCQOZl+ZZBg2D2J5nkpLqzH1HY0C1dHlTKIbpRz/LG23c"
	crossorigin="anonymous"></script>
</head>
<style>

@media (max-width:500px){
html{font-size:0.9em;}}

a:link:not(.nav-item) { color: #000; }
a:visited:not(.nav-item) { color: #000; }
a:hover:not(.nav-item) { color: #369; }
a:active:not(.nav-item) { color: #000; }

html {
margin: 0;
height: 100vh;
}

div.wrap {
display: flex;
flex-direction: column;
height: 100vh;
}
div.wrap > div.container {
flex:1;
}

</style>
<body>
	<script>
		$(document).ready(function() { 
			$('#loginModal').modal('hidden');
			$(function () {
  				$('[data-toggle="tooltip"]').tooltip()
			})
		});
		
	</script>
	<nav class="navbar navbar-expand-lg navbar-dark sticky-top order-lg-2"
		style="background-color: rgba(0, 0, 0, 0.8); position: sticky;">
		<a class="navbar-brand" href="${pageContext.request.contextPath}"
			style="font-family: arial; font-weight: 800; color: #2cffee" title="메인페이지로 이동">CAMPINGCAJANG</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
			<c:if test="${authUser.MEM_ID != 'admin'}">
				<li class="nav-item"><a class="nav-link" href="proPreview.camp" title="캠핑상품으로 이동">캠핑상품</a></li>
				<li class="nav-item"><a class="nav-link" href="rezList.camp" title="예약하기로 이동">예약하기</a></li>
				<li class="nav-item"><a class="nav-link" href="reviewList.camp" title="고객후기로 이동">고객후기</a></li>
				<li class="nav-item"><a class="nav-link" href="qnaList.camp" title="문의하기로 이동">문의하기</a></li>
				<li class="nav-item"><a class="nav-link" href="noticeList.camp" title="공지사항으로 이동">공지사항</a></li>
			</c:if>	
				
			<c:if test="${authUser.getMEM_ID().equals('admin')}">
				<li class="nav-item"><a class="nav-link" href="reviewList.camp" title="고객후기로 이동">고객후기</a></li>
				<li class="nav-item"><a class="nav-link" href="qnaList.camp" title="문의하기로 이동">문의하기</a></li>
				<li class="nav-item"><a class="nav-link" href="noticeList.camp" title="공지사항으로 이동">공지사항</a></li>
	           	<li class="nav-item"><a class="nav-link" href="managePageRez.camp">관리자페이지</a></li>
	        </c:if>
			</ul>
			
		<c:if test="${empty authUser}">
			<ul class="nav navbar-nav navbar-right">
				<li><a class="nav-link" data-toggle="modal" href="#loginModal">로그인</a></li>
				<li><a class="nav-link" href="join.camp">회원가입</a></li>

			</ul>
		</c:if>
			
		<c:if test="${!empty authUser}">
			<ul class="nav navbar-nav navbar-right">
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> ${authUser.MEM_NICKNAME}님, 안녕하세요 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<c:if test="${authUser.getMEM_ID().equals('admin')}">
	           		<a class="dropdown-item" href="managePagePro.camp">관리자페이지</a>
	           		<a class="dropdown-item" href="mgtLogout.camp">로그아웃</a>
	      			</c:if>
					<c:if test="${authUser.MEM_ID != 'admin'}">
					<a class="dropdown-item" href="myPage.camp">내 정보</a>
					<a class="dropdown-item" href="qnaList.camp?fieldName=qna_id&searchWord=${authUser.MEM_ID}">내 문의현황</a>
					<a class="dropdown-item" href="logout.camp">로그아웃</a>
					</c:if>
					</div>
				</li>
			</ul>
		</c:if>
		</div>
	</nav>
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header border-bottom-0 text-center">

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="form-title text-center">
						<h3 style="font-family: arial; font-weight: 800; color: #000">CAMPINGCAJANG</h3>
					</div>
					<div class="d-flex flex-column text-center">
						<form method="post" action="loginSuccess.camp">
							<c:if test="${requestScope['javax.servlet.forward.servlet_path'].equals('/join.camp')}">
								<input type="hidden" id="referer" name="referer" value="" />
							</c:if>
							<c:if test="${!empty requestScope['javax.servlet.forward.query_string']}">
								<input type="hidden" id="referer" name="referer" value="${requestScope['javax.servlet.forward.servlet_path']}?${requestScope['javax.servlet.forward.query_string']}" />
							</c:if>
							<c:if test="${empty requestScope['javax.servlet.forward.query_string']}">
								<input type="hidden" id="referer" name="referer" value="${requestScope['javax.servlet.forward.servlet_path']}" />
							</c:if>
							<div class="form-group">
								<input type="text" class="form-control" placeholder="아이디"
									name="id" value="${param.id}">
							</div>
							<div class="form-group">
								<input type="password" class="form-control" placeholder="비밀번호"
									name="password" value="${param.id}">
							</div>
							<div class="warning">
								<c:if test="${errors.idOrPwNotMatch}">

								</c:if>
							</div>
							<div style="text-align: center; color: #eee;">
							<br>
								<a href="join.camp">아직 회원이 아니신가요?</a>
							</div>
							<br>
							<button type="submit" class="btn btn-secondary btn-block btn-round">로그인</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>