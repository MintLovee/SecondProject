<%@page import="javaBean.product.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	ProductBean proBean = (ProductBean)request.getAttribute("probean");
    %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.10.0/themes/ui-lightness/jquery-ui.css" />
<title>캠핑카장</title>
<style type="text/css">
h2{padding-top: 4%;}
</style>
<script type="text/javascript">
	function modifyboard(){
		form1.submit();
	}
</script>
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

<style type="text/css">
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
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<br/><br/>
<section class="top">
<h2> 상품 수정</h2>
</section><br/><hr/><br/>
<form action="productUpdateSuccess.camp" name="form1" method="post" enctype="multipart/form-data" >
<section>
<table   style="margin: auto;">
	<tr>
		<td id="tabTitle"><label id="forLabel" for="P_NUM">상품번호</label></td>
		<td><input type="text" name="P_NUM"  id="proNum" readonly value="<%= proBean.getP_NUM()%>"></td>
	</tr>
	
	<tr>
		<td id="tabTitle"><label id="forLabel" for="P_NAME">상품명</label></td>
		<td><input type="text" name="P_NAME" id="proNum"value="<%= proBean.getP_NAME()%>"></td>
	</tr>
	
	<tr>
		<td id="tabTitle"><label id="forLabel" for="P_PRICE">가&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;격</label></td>
		<td ><input type="number" name="P_PRICE" id="proNum" value="<%= proBean.getP_PRICE()%>"></td>
	</tr>
	
	<tr>
		<td id="tabTitle"><label id="forLabel" for="P_SERVICE">현재인원</label>
		<td><input type="text" name="P_SERVICE" id="proNum" value="<%= proBean.getP_SERVICE()%>" disabled="disabled"></td>
		
	</tr>
	<tr>
		<td id="tabTitle"><label id="forLabel" for="P_SERVICE">변경인원</label>
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
	<tr>
	
	<td id="tabTitle"><label id="forLabel" for="P_NOTES">특이사항 및 물품</label></td>
	<td><textarea name="P_NOTES" cols="28" rows="5" style="resize: none;" ><%= proBean.getP_NOTES()%></textarea></td>
	</tr>
	
	<tr>
	<td id="tabTitle"><label id="forLabel" for="P_MORE_INFO">공&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;지</label></td>
	<td><textarea name="P_MORE_INFO" cols="28" rows="10" style="resize: none;" ><%= proBean.getP_MORE_INFO()%></textarea></td>
	</tr>
	
	<tr>
	<td id="tabTitle"><label id="forLabel" for="P_IMG">변경할 메인사진</label></td>
	<td class="td_right" style="cursor:pointer; text-align: left;"><input name="P_IMG" type="file"
                  accept="image/*" id="load" /></td>
	</tr>
	<tr>
	  <td id="tabTitle"><label id="forLabel" for="P_IMG">현재 메인사진</label></td>
     <td><input type="text" name="P_IMG" id="proNum"value="<%= proBean.getP_IMG()%>"  disabled/></td>
	</tr>
</table>
<section style="text-align: center; padding-top: 3%">
	<input type="submit" class="btn btn-dark" value="수정 확인" onclick="location.href='productModifySuccess.camp'" style="margin-right: 3%;"/>
	<input type="button" class="btn btn-dark" value="수정 취소" onclick="location.href='managePagePro.camp'"/>
</section>
</section>
</form>
<br/>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>