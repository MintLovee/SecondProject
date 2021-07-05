<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.product.ProductBean" %>
<%@ page import="java.util.*"%>
  <%   ArrayList<ProductBean> productList = (ArrayList<ProductBean>)request.getAttribute("productList"); %> 
   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.10.0/themes/ui-lightness/jquery-ui.css" />

<title>캠핑카장</title>
<style >
	hr{
	width: 88%;
	}
	h2{
		text-align: center;
	}
	#fortap{
		text-align: center;
	}
	#forLabel{
	text-align:right;
	letter-spacing: 4px;
	margin-right: 10px;
	}
	#tabTitle{
		text-align: right;
	}
	#proNum{
		width: 77%;
	}
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
</style>
<script>
function getMany() {
	  var s = document.getElementById("camp");
	  var email = s.options[s.selectedIndex].value;
	  
	  if(email == "인원선택"){
		  document.getElementById('proNum1').readOnly = false;
		  document.getElementById("proNum1").value = "";
	  }else{
		  document.getElementById('proNum1').readOnly = true;
		  document.getElementById("proNum1").value = email;
	  }	  	  
	}
</script>
</head>
<body >
	<jsp:include page="header.jsp" flush="true"/>
	<br/><br/>
<section class="top">
<h2> 상품 등록</h2>
</section><br><hr><br>
<form action="productInsert.camp" name="form1" method="post" enctype="multipart/form-data">
<section>
 <table style="margin: auto;" >
	<tr>
		<td id="tabTitle"><label id="forLabel" for="P_NUM">상품번호</label></td>
		<td><input type="text" name="P_NUM" id="proNum"></td>
	</tr>
	
	<tr>
		<td id="tabTitle"><label id="forLabel" for="P_NAME">상품이름</label></td>
		<td><input type="text" name="P_NAME" id="proNum"></td>
	</tr>
	
	<tr>
		<td id="tabTitle"><label id="forLabel" for="P_PRICE">가&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;격</label></td>
		<td ><input type="number" name="P_PRICE" id="proNum"></td>
	</tr>
	
	<tr>
		<td id="tabTitle"><label id="forLabel" for="P_SERVICE">인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;원</label></td>
		<td><input style="display: none;" type="text" name="P_SERVICE" id="proNum1" value="">
				<select id="camp" name="camp" onclick="getMany()" >
					<option selected="selected" id="0">인원선택</option>
					<option id="1" value="4">최대 4인</option>
					<option id="2" value="5">최대 5인</option>
					<option id="3" value="6">최대 6인</option>
					<option id="4" value="7">최대 7인</option>
					<option id="5" value="8">최대 8인</option>
					<option id="6" value="9">최대 9인</option>
					<option id="7" value="10">최대 10인</option>
				</select>
		</td>
	</tr>
	
	<tr>
	<td id="tabTitle"><label id="forLabel" for="P_NOTES">특이사항 및 물품</label></td>
	<td><textarea name="P_NOTES"  cols="28" rows="5" style="resize: none;"></textarea></td>
	</tr>
	
	<tr>
	<td id="tabTitle"><label id="forLabel" for="P_MORE_INFO">공&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;지</label></td>
	<td><textarea name="P_MORE_INFO" cols="28" rows="10" style="resize: none;">CHECK_IN(오전 11시~) CHECK_OUT(~오후 1시)<br>
- 21시 이후 도착할 경우에는 현장관리 사정으로 입실이 어려우니 사전 연락 부탁드립니다.<br>
- CHECK_OUT 후에는 모든 부대시설물 이용이 불가합니다.<br></textarea></td>
	</tr>
	
	<tr>
	<td id="tabTitle"><label id="forLabel" for="P_IMG">메인사진</label></td>
	<td class="td_right" style="cursor:pointer; text-align: left;"><input name="P_IMG" type="file"
                  accept="image/*" id="load" /></td>
	</tr>
</table>
<br/><br/>
		<div style="text-align: center;">
			<input style="margin-right: 1.9%;" type="submit" class="btn btn-dark" value="상품 등록"/>
			<input type="button" class="btn btn-dark" value="등록 취소" onclick="location.href='managePagePro.camp'"/>
		</div>
	</section>
</form>
<br/>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>