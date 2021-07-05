<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">
<head>
</head>

<body style="overflow-x: hidden;">
	<jsp:include page="view/header.jsp" flush="true" />

	<div id="carouselExampleCaptions" class="carousel slide"
		data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleCaptions" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
			<li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="img/slide-01.jpg" class="d-block w-100" title="캠핑사진" alt="조용한 가을 밤 캠핑사진">
				<div class="carousel-caption d-none d-md-block">
					<h5>가족과 함께</h5>
					<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 야영장, 캠핑카장입니다.</p>
				</div>
			</div>
			<div class="carousel-item">
				<img src="img/slide-02.jpg" class="d-block w-100" title="캠핑사진" alt="겨울 숲속 캠핑사진">
				<div class="carousel-caption d-none d-md-block">
					<h5>친구와 함께</h5>
					<p>캠핑카장에서 힐링가득한 여행을 즐기러 오세요!</p>
				</div>
			</div>
			<div class="carousel-item">
				<img src="img/slide-03.jpg" class="d-block w-100" title="캠핑카장 전경" alt="위에서 바라본 캠핑카장 전체 모습">
				<div class="carousel-caption d-none d-md-block">
					<h5>연인과 함께</h5>
					<p>캠핑카장 곳곳에 있는 정원과 연못을 벗삼아 하룻밤을 보내며 가족, 친구들과 잊지 못할 추억을 담아가세요</p>
				</div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleCaptions"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleCaptions"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>


	<div class="container">
		<br> <br>

		<div class="row">
			<div class="col-md-4">
				<div class="card-deck">
					<div class="card mb-4">
						<a title="카라반 상품 둘러보기" href="proCRV.camp?name=카라반"><img src="images/CaravanView2.png" class="card-img-top"
							alt="카라반 안에서 바라보는 숲속 풍경사진" width=300>
						<div class="card-body">
							<h5 class="card-title">카라반</h5>
							<p class="card-text">해돋이 명소에서 즐기는 캠핑!</p>
							<p class="card-text">
								<small class="text-muted">최대 4인 가능</small>
							</p>
						</div>
						</a>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card-deck">
					<div class="card mb-4">
						<a title="데크 상품 둘러보기" href="proDEC.camp?name=데크"><img src="images/deck03.png" class="card-img-top"
							alt="어두운 저녁 텐트 앞에 피워둔 화로" width=300>
						<div class="card-body">
							<h5 class="card-title">데크</h5>
							<p class="card-text">계곡과 인접해있어 계곡까지 1분!</p>
							<p class="card-text">
								<small class="text-muted">최대 4인 가능</small>
							</p>
						</div>
						</a>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card-deck">
					<div class="card mb-4">
						<a title="천연자갈 상품 둘러보기" href="proGRA.camp?name=천연자갈"><img src="images/MainGra01.jpg" class="card-img-top"
							alt="숲속에서 바라보는 일출" width=300>
						<div class="card-body">
							<h5 class="card-title">천연자갈</h5>
							<p class="card-text">각종편의시설로 즐거운 휴식을!</p>
							<p class="card-text">
								<small class="text-muted">최대 4인 가능</small>
							</p>
						</div>
						</a>
					</div>
				</div>
			</div>
		</div>

		<br>

		<div class="row">
			<div class="col-lg-4 order-lg-2" id="qrez">
				<a title="빠른예약 바로가기" href="rezList.camp"><img alt="캠핑카장 빠른예약 일러스트 아이콘" src="img/qrez.jpg" class="img-fluid rounded" alt=""></a>
				<div class="card mb-4"></div>
			</div>
			<div class="col-lg-8 order-lg-1">

				<div class="card mb-4">
					<div class="card-body">
						<h4>
							NOTICE
							<button type="button" class="ml-2 mb-1 close">
								<a title="공지사항 더보기" href="noticeList.camp" style="text-decoration: none;">&#43;</a>
							</button>
						</h4>
						<small class="text-muted">캠핑카장의 새로운 소식입니다.</small><br><br>
						<jsp:include page="view/noticeRecently.jsp" flush="true" />
					</div>
				</div>
			</div>


		</div>


		<div class="row">
			<div class="col-lg-6">
				<div class="card mb-4">
					<div class="card-body">
						<h4>
							<strong>고객후기</strong>
							<button type="button" class="ml-2 mb-1 close">
								<a title="고객후기 더보기" href="reviewList.camp" style="text-decoration: none;">&#43;</a>
							</button>
						</h4>
						<small class="text-muted">생생한 이용 후기를 확인해보세요.</small><br><br>
						<jsp:include page="view/reviewRecently.jsp" flush="true" />
					</div>
				</div>
			</div>

			<div class="col-lg-6">
				<div class="card mb-4">
					<div class="card-body">
						<h4>
							QNA
							<button type="button" class="ml-2 mb-1 close">
								<a title="문의사항 더보기" href="qnaList.camp" style="text-decoration: none;">&#43;</a>
							</button>
						</h4>
						<small class="text-muted">궁금한 사항을 남겨주세요.</small><br><br>
						<jsp:include page="view/qnaRecently.jsp" flush="true" />
					</div>
				</div>
			</div>
		</div>
	</div>
		
<jsp:include page="view/footer.jsp" flush="true" />
</body>
</html>