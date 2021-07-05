<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="javaBean.product.ProductBean" %>
<%@ page import="java.util.*"%>
<%ProductBean proBean = (ProductBean) request.getAttribute("proBean");%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<!--  예약 이미지 아이콘 -->
<script src="https://kit.fontawesome.com/1eb6d3149b.js" crossorigin="anonymous"></script>
<script>

</script>


<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
   	
<!--  상세보기 시작 -->


 <!--  상세보기  끝 -->
<title>캠핑카장</title>
<style>

.modal.modal-center {
  text-align: center;
}

@media screen and (min-width: 768px) { 
  .modal.modal-center:before {
    display: inline-block;
    vertical-align: middle;
    content: " ";
    height: 100%;
  }
}

.modal-dialog.modal-center {
  display: inline-block;
  text-align: left;
  vertical-align: middle; 
}

/*모달 사이즈 조절..하자*/

#show{ position: absolute; top: 300px; left:auto; margin: auto; 
 	font-weight: 600;
 	font-size: 1.4em;  color:white;
    opacity:0.8;
    background-color: rgba(84,109,176,0.8); 
    border: 0; outline: 0; 
    padding:6px 30px; }
.background {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.3);
  z-index: 1000;
  
  /* 숨기기 */
  z-index: -1;
  opacity: 0;
}

.show {
  opacity: 1;
  z-index: 1000;
  transition: all .5s;
}

.window {
  position: relative;
  width: 100%;
  height: 100%;
}

.popup {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: #ffffff;
  box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);
  
  width: 100px;
  height: 100px;
  
  /* 초기에 약간 아래에 배치 */
  transform: translate(-50%, -40%);
}

.show .popup {
  transform: translate(-50%, -50%);
  transition: all .5s;
}


/*-- POPUP common style S ======================================================================================================================== --*/
body {
    font-family: "맑은 고딕"
}

/*-- POPUP common style S ======================================================================================================================== --*/
#mask {
    position: absolute;
    left: 0;
    top: 0;
    z-index: 999;
    background-color: #000000;
    display: none; }

.layerpop {
    display: none;
    z-index: 1000;
    border: 2px solid #ccc;
    background: #fff;
    cursor: move; }

.layerpop_area .title {
    padding: 10px 10px 10px 10px;
    border: 0px solid #aaaaaa;
    background: #f1f1f1;
    color: #3eb0ce;
    font-size: 1.3em;
    font-weight: bold;
    line-height: 24px; }

.layerpop_area .layerpop_close {
    width: 25px;
    height: 25px;
    display: block;
    position: absolute;
    top: 10px;
    right: 10px;
    background: transparent url('btn_exit_off.png') no-repeat; }

.layerpop_area .layerpop_close:hover {
    background: transparent url('btn_exit_on.png') no-repeat;
    cursor: pointer; }

.layerpop_area .content {
    width: 96%;    
    margin: 2%;
    color: #828282; }
    
    .button{font-size: 20px; margin-right:1%; width: 100%;  
    right: 48%; bottom: 200px;  }
    
   .Cancel{width: 25px; height: 25px; }
   .GoToRez{width: 25px; height: 25px; transition:background,color 2s; }
   .GoToRez:hover{color:#fff;background:#000} 
   
   .RezFont {padding:5px 10%;border:1px solid #000;transition:background,color 2s;}
   .RezFont:hover{color:#fff;background:#000} 
   	
   .img{position: absolute; top:600px; right: 100px}
   
   .rd_small{font-size:23px; font-weight: 650  !important}
   
 
	.scale:focus {
	 box-shadow: 0 0 0 2px #ffffff, 0 0 3px 5px #3a97f9;
	 outline: 2px dotted transparent;
  	 outline-offset: 2px;
   	 text-decoration: underline;
	}
	.scale1:focus{
	 box-shadow: 0 0 0 2px #ffffff, 0 0 3px 5px #3a97f9;
	 outline: 2px dotted transparent;
  	 outline-offset: 2px;
	}
	.
/*-- POPUP common style 끄 --*/

/*--메인 슬라이드 시작 --*//*-- 슬라이드 시작 --*//*-- 슬라이드 시작 --*//*-- 슬라이드 시작 --*/
body, section, ul, dl, dd {
  margin:0;
  padding:0;
}
.slider {
  list-style:none;
  background-size:cover;
}
.slider:after {
  content:'';
  display:block;
  clear:both;
}
.slider li {
  position:absolute;
  top:0;
  left:0;
  width:100%;
  height:100%;
  background-size:cover;
  opacity:0;
}
.slider li div {
  width:100%;
  height:100%;
  background-size:cover;
  position:relative;
}
.slider li dl {
  position:absolute;
  top:50%;
  transform:translateY(-50%);
  left:20px;
}
.slider li .right {
  left:auto;
  right:20px;
  text-align:right;
}
.slider li dt {
  color:#fff;
  font-size:3rem;
  text-shadow:1px 1px 10px #444;
}
.slider li dd {
  color:#fff;
  text-shadow:1px 1px 10px #444;
}
.btn {
  text-align:center;
}
.btn button {
  margin-top:10px;
  border:1px solid #ccc;
  background-color:#fff;
  color:#666;
  font-size:1.5rem;
  cursor:pointer;
}

#detail{margin: auto; 
 	font-weight: 600;
 	font-size: 1.9em;  color:white;
    opacity:0.8;
    background-color: rgba(29,69,191,0.8); 
    border: 0; outline: 0; 
    padding:6px 30px; }
    
#view{ position: absolute; top: 300px; left:auto; margin: auto; 
 	font-weight: 600;
 	font-size: 1.4em;  color:white;
    opacity:0.8;
    background-color: rgba(84,109,176,0.8); 
    border: 0; outline: 0; 
    padding:6px 30px; }
    .pro_btn1{
    	text-align: center;
    	width: 60%;
    	left: 20%; 
    }
    <!-- -->
.MainAcces{	
	background-position:  center; 
	width: 100%; height: 100%;
	display: flex; align-content: center;
	object-fit:cover;"
}    
 <!---->
 
.img-responsive{
	display: block;
	width: auto;
	max-height: 30%;    
    }
/*--메인 슬라이드 끝--*//*-- 슬라이드 끝--*//*-- 슬라이드 끝--*/
.main{position: relative; }
 #post1{ margin:auto;  position: sticky; top: 4px; color: black; text-decoration: none; font-family: Century Gothic, sans-serif;}
.modal-dialog img{position: relative; margin:auto; overflow: auto; }



</style>



<!--드래그 할수 있는 기능을 사용하기 위해서 draggable();-->

	<!-- header 스크립트 -->

	<!-- header 스크립트 -->
<script>
$(document).ready(function( $ ){     
  $(".openPopup").on("click", function(event) {  //팝업오픈 버튼 누르면
  $("#popup01").show();   //팝업 오픈
  $("body").append('<div class="backon"></div>'); //뒷배경 생성
  });
  
  $("body").on("click", function(event) { 
      if(event.target.className == 'close' || event.target.className == 'backon'){
          $("#popup01").hide(); //close버튼 이거나 뒷배경 클릭시 팝업 삭제
            $(".backon").hide();
      }
    });

});
</script>
<script>

    function wrapWindowByMask() {
        //화면의 높이와 너비를 구한다.
        var maskHeight = $(document).height(); 
        var maskWidth = $(window).width();

        //문서영역의 크기 
        console.log( "document 사이즈:"+ $(document).width() + "*" + $(document).height()); 
        //브라우저에서 문서가 보여지는 영역의 크기
        console.log( "window 사이즈:"+ $(window).width() + "*" + $(window).height());        

        //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
        $('#mask').css({
            'width' : maskWidth,
            'height' : maskHeight
        });

        //애니메이션 효과
        //$('#mask').fadeIn(1000);      
        $('#mask').fadeTo("slow", 0.5);
    }

    function popupOpen() {
        $('.layerpop').css("position", "absolute");
        //영역 가운에데 레이어를 뛰우기 위해 위치 계산 
        $('.layerpop').css("top",(($(window).height() - $('.layerpop').outerHeight()) / 2) + $(window).scrollTop());
        $('.layerpop').css("left",(($(window).width() - $('.layerpop').outerWidth()) / 2) + $(window).scrollLeft());
        $('.layerpop').draggable();
        $('#layerbox').show();
    }

    function popupClose() {
        $('#layerbox').hide();
        $('#mask').hide();
    }

    function goDetail() {

        /*팝업 오픈전 별도의 작업이 있을경우 구현*/ 

        popupOpen(); //레이어 팝업창 오픈 
        wrapWindowByMask(); //화면 마스크 효과 
    }
	$(document).ready(function() { 
		$('#loginModal').modal('hidden');
	$(function () {
			$('[data-toggle="tooltip"]').tooltip()
		})
	});

</script>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>
<section class="col-xs-12 main" style="display: flow-root;" >
  <ul class="slider">
    <li>
      <div style=" background-position: center;" title="카라반 모습">
      	<img class="MainAcces" alt="카라반 주방" src="/gaia/images/CrvBasic1.png" >
        <dl class="right ">
          <dt class="mainSize">자연속의 캠핑</dt>
          <dd>자연과 함께 녹아드는 추억, 자연을 느끼는 캠핑.</dd>
        </dl>
      </div>
    </li>
    <li>
     <div style=" background-position: center;">
      	<img class="MainAcces" alt="대각선에서 바라본 맑은 날에 주차된 차와 목재테이블이 보이는 카라반" src="/gaia/images/MainCrv01.png" >
        <dl>
          <dt>지루한 일상을 벗어나</dt>
          <dd>캠핑카내에서 소중한 사람들과 즐거운 추억을</dd>
        </dl>
      </div>
    </li>
    <li>
      <div style=" background-position: center;">
      	<img class="MainAcces" alt="맑은 날에 분수대에서 카라반을 배경으로한 사진" src="/gaia/images/MainCrv02.png" >
        <dl class="right">
          <dt>차별화된 카라반</dt>
          <dd>새로운 경험으로 소중한 시간을 선사하고자 합니다.</dd>
        </dl>
      </div>
    </li>
    <li>
      <div style=" background-position: center;">
      	<img class="MainAcces" alt="늦은 밤 카라반테두리에 들어온 은은한 빛" src="/gaia/images/MainCrv03.png" >
        <dl>
          <dt>힐링을 느끼며</dt>
          <dd>요리하고 휴식하며 일탈을 즐기는</dd>
        </dl>
      </div>
    </li>
    <li>
      <div style=" background-position: center;">
      	<img class="MainAcces" alt="목제다리가 보이는 계단식으로 흐르는 계곡 풍경" src="/gaia/images/Main01.png" >
        <dl class="right">
          <dt>웅장한 산을 등지고</dt>
          <dd>방문하시는 모든 고객님들께 그 어디에서도 느낄 수 없는 최고의 공간을 제공합니다.</dd>
        </dl>
      </div>
    </li>
    <li>
      <div style=" background-position: center;">
      	<img class="MainAcces" alt="노을지는 하늘과 푸른 숲에 있는 계곡에서 노는 아이들"  src="/gaia/images/Main02.png" >
        <dl>
          <dt>캠핑카장만의</dt>
          <dd>특별하고 편리한 편의시설과 주변 자연경관을 즐겨보세요.</dd>
        </dl>
      </div>
    </li>
  </ul>
  <div class="btn">
  </div>


<div class="col-xs-12 pro_btn1"></div>
    <div style="height:800px;"> </div>
    <div style="text-align: center; position: relative; bottom: 180px;">
 		<button class="scale" title="상세보기" tabindex="0" id="detail" data-toggle="modal" data-target="#intro" style="display: inline;">상세보기</button>
    </div>
        <div class="modal modal-center fade" id="intro" role="dialog" aria-labelledby="introHeader" aria-hidden="true" tabindex="-1">
            <div class="modal-dialog modal-80size modal-lg  modal-center" style="width: 90%;margin: auto; padding-top: 30px; padding-bottom: 30px; padding-left: 10%;">
                <div class="modal-content  modal-80size" style="width: 90%;box-sizing: content-box;">
                    <div style="display: inline-block; text-align: center; padding-top: 2%; font-size: 20px;">	
                        <h3 class="modal-title">카라반(한옥형)</h3>
                    <hr style="width: 90%;"/>
                    </div>
                    	<div class="modal-body" style="width: 100%">
                    	<div>
                    	  	<c:set var="price" value="<%= proBean.getP_PRICE()%>"/>
                   		</div>
                   		 <div class="page-wrapper" style="position:relative;">
                   		   <!-- 상세 슬라이드 제발... -->
                   		   
	 	<div id="carouselExampleCaptions" class="carousel slide"
		data-ride="carousel">
		
		<div class="carousel-inner">
			<div class="carousel-item active" title="카라반">
				<img src="<%= proBean.getP_IMG()%>" class="d-block w-100" alt="카라반 외부모습">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="침실">
				<img src="/gaia/images/CrvFour-2.png" class="d-block w-100" alt="카라반 침실">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="주방">
				<img  src="/gaia/images/CrvBasic1.png" class="d-block w-100" alt="카라반 주방">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="샤워실">
				<img  src="/gaia/images/CrvBasic4.png" class="d-block w-100" alt="카라반 샤워실">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="외부모습">
				<img   src="/gaia/images/CaravanView2.png" class="d-block w-100" alt="카라반 모습">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
			<div class="carousel-item" title="캠핑장 배치도">
				<img  src="/gaia/images/Map.png" class="d-block w-100" alt="캠핑장 배치도">
				<div class="carousel-caption d-none d-md-block">
				</div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleCaptions" title="이전"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon scale1" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleCaptions" title="다음"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon scale1" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
    <br/>

    

	                    	 <p style="font-size: 15px;">가격 : 1박 <fmt:formatNumber type="number" maxFractionDigits="3" value="${price}" />원</p>
                        <p class="rd_small">◆최대 인원</p>
                        <p style="font-size: 15px;"><%= proBean.getP_SERVICE()%></p>
                        <p class="rd_small">◆특이사항 및 물품</p>
                        <p style="font-size: 15px;"><%= proBean.getP_NOTES()%></p><br/>
                        <h4>*주의사항</h4>
    					<p style="font-size: 13px; white-space: break-spaces;"><%=proBean.getP_MORE_INFO()%></p>
    					<div style="margin-left:  47%; margin-bottom: 2%" title="예약하러가기" tabindex="0">
    						<a class="button" type="button" id="post1"  style='cursor:pointer' onclick="location.href='rezList.camp'">
    							<span class="RezFont"> 
    								<i class="far fa-calendar-alt" style="width: 135px;">&nbsp;실시간 예약</i>
    							</span>
    						</a>
    					</div>
                    </div>
                    <div class="modal-footer" title="상세보기 닫기">
                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
       </div>
       <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript" src="js/ProSlider.js"></script>
</section>
<jsp:include page="footer.jsp" flush="true" />
</body>
</html>