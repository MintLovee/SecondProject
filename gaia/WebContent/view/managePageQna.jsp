<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자페이지</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<style type="text/css">
.panel-info{position: sticky; top: 85px;}
.logout{font-weight: bold;}
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>

<div class="container-fluid">
  <div class="row">
  <div class="col-md-2">
<!-- 사이드 바 메뉴-->
<div class="panel panel-info">
  <div class="panel-heading">
  <h5 class="panel-title">
  <i class="glyphicon glyphicon-leaf"></i>
    <span>관리자페이지</span>
  </h5>
</div>
<ul class="list-group">
  <li class="list-group-item"><a href="managePageRez.camp">예약관리</a></li>
  <li class="list-group-item"><a href="managePageMem.camp">회원관리</a></li>
  <li class="list-group-item"><a href="managePagePro.camp">상품관리</a></li>
  <li class="list-group-item"><a href="managePageQna.camp">문의관리</a></li>
</ul><br>
<ul class="list-group">
  <li class="list-group-item logout"><a href="mgtLogout.camp">로그아웃</a></li>
</ul>
</div>

</div>

<!-- 9단길이의 첫번째 열 -->
  <div class="col-md-10">
    <div class="jumbotron">
    	<jsp:include page="qnaManager.jsp" flush="true"/>
    </div>
    </div>
  </div>
</div>
  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="js/bootstrap.min.js"></script>
  
  <jsp:include page="footer.jsp" flush="true"/>
  </div>
</body>
</html>