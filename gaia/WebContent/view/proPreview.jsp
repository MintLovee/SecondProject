
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">
body {
	background-image: url("/gaia/images/preViewBack2.png");
	background-size: cover;
	background-repeat: no-repeat;
}

#caravan {
	padding: 30px;
	margin: auto;
	cursor: pointer;
}

#deck {
	padding: 30px;
	margin: auto;
	cursor: pointer;
}

#stone {
	padding: 30px;
	margin: auto;
	cursor: pointer;
}

#viewtext {
	color: black;
	display: inline;
	text-align: center;
	font-family: Century Gothic, sans-serif;
	font-weight: 550;
}

.spe_a1 img {
	margin-top: 15px;
}

.spe_a2 img {
	margin-top: -20px;
}

.spe_a3 img {
	margin-top: -25px;
}

.textspan em {
	font-size: 1.2em;
	font-weight: 600;
}

.forimg {
	width: 300px;
	height: 400px;
	margin: auto;
}

.scale {
	transform: scale(1);
	transition: 1.5s;
}

.scale:hover {
	transform: scale(1.05);
}

#item {
	display: inline-block;
	color: black;
	text-decoration: none;
	width: 391px;
	height: 465px;
	padding-left: 22px;
}

#item:hover {
	text-decoration: none;
}

h1 {
	text-align: center;
	font-size: 370%;
	font-family: Century Gothic, sans-serif;
}

h4 {
	font-family: Century Gothic, sans-serif;
	display: inline;
	padding-top: 5px;
	position: relative;
	text-align: center;
	font-weight: 520;
}

.h_line {
	display: block;
	text-align: center;
	width: 100%;
	height: 100px;
}

.h_line span {
	width: 1px;
	transition: padding-bottom 1s;
	background: #000;
	display: inline-block
}

.h_line.on span {
	padding-bottom: 100px;
}

.foot {
	position: absolute;
	left: 0;
	bottom: -25%;
	width: 100%;
	padding: 15px 0;
	text-align: center;
}
​
</style>
<script>
	$(function() {
		$('#caravan').click(function() {
			location.href = 'proCRV.camp?name=카라반';
		});
		$('#deck').click(function() {
			location.href = 'proDEC.camp?name=데크';
		});
		$('#stone').click(function() {
			location.href = 'proGRA.camp?name=천연자갈';
		});
	});
</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />

	<br>
	<br>
	<div class="wrap">
	<div class="container-fluid" style="text-align: center;" title="미리보기">
		<h4>Go Camping</h4>
		<br />
		<h1 id="viewtext">Preview</h1>
	</div>
	<div class="container-fluid" style="margin: auto;">
		<div class="h_line on">
			<span></span>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="row mb-3">



				<div class="col-sm-6 col-md-4 themed-grid-col" title="카라반 사이트" style="bottom: 0px;">
					<<br /> <br /> <br /> <a href="proCRV.camp?name=카라반" id="item"
						class="spe_a1 scale"><img id="caravan"
						class="img-responsive forimg scale"
						alt="카라반사이트 모습"
						src="/gaia/images/CrvPreView.PNG">
						<p class="textspan" style="bottom: 40px; left: 76px; padding-left: 30px;"><strong>한옥 카라반</strong> <br>
							최대 인원 4 <br> 캠핑 카라반, 한옥형(침대+화장실+주방) </p> </a>
				</div>
				<div class="col-sm-6 col-md-4 themed-grid-col" title="데크 사이트">
					<br /> <br /> <br /> <a href="proDEC.camp?name=데크" id="item"
						class="spe_2 scale"><img id="deck"
						class="img-responsive forimg"
						alt="데크사이트 모습"
						 src="/gaia/images/DeckPreView.png"><br />
						<p class="textspan" style="bottom: 40px; left: 76px; padding-left: 30px;"><strong>편안
								데크</strong> <br> 최대 인원 4 <br> 규모: 4m x 5m </p> </a>
				</div>

				<div class="col-sm-6 col-md-4 themed-grid-col"  title="자갈 사이트">
					<br /> <br /> <br /> <a href="proGRA.camp?name=천연자갈" id="item"
						class="spe_3 scale"><img id="stone"
						class="img-responsive forimg scale"
						alt="자갈사이트 모습"
						src="/gaia/images/GraPreView.png">
						<p class="textspan" style="bottom: 40px; left: 76px; padding-left: 30px;"><strong>천연 자갈</strong> <br>
							최대 인원 4 <br> 규모: 6m x 8m </p> </a>
				</div>

			</div>

		</div>
	</div>
	<jsp:include page="footer.jsp" flush="true" />
	</div>
</body>
</html>