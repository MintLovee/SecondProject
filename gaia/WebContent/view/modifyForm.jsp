<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javaBean.member.MemberBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	MemberBean memberInfo = (MemberBean) request.getAttribute("memberInfo");
	String[] emailArray = memberInfo.getMEM_EMAIL().split("@");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.10.0/themes/ui-lightness/jquery-ui.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.0.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/i18n/jquery-ui-i18n.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
function check_pw(){
    var pw = document.getElementById('pw').value;
    var SC = ["!","@","#","$","%"];
    var check_SC = 0;

    if(pw.length < 4 || pw.length> 20){
        window.alert('비밀번호는 4글자 이상, 20글자 이하만 이용 가능합니다.');
        document.getElementById('pw').value='';
    }
    for(var i=0;i<SC.length;i++){
        if(pw.indexOf(SC[i]) != -1){
            check_SC = 1;
        }
    }
    if(check_SC == 0){
        window.alert('!,@,#,$,% 의 특수문자가 들어가 있지 않습니다.')
        document.getElementById('pw').value='';
    }
    if(document.getElementById('pw').value !='' && document.getElementById('pwCheck').value!=''){
        if(document.getElementById('pw').value==document.getElementById('pwCheck').value){
            document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
            document.getElementById('check').style.color='blue';
        }
        else{
            document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.';
            document.getElementById('check').style.color='red';
            document.getElementById('pw').value='';
            document.getElementById('pwCheck').value='';
            join.PASSWORD.focus();
        }
    }
}

function getEmail() {
  var s = document.getElementById("camp");
  var email = s.options[s.selectedIndex].value;
  
  if(email == "직접입력"){
	  document.getElementById('email2').readOnly = false;
	  document.getElementById("email2").value = "";
  }else{
	  document.getElementById('email2').readOnly = true;
	  document.getElementById("email2").value = email;
  }	  	  
}
</script>

<style>
.top{text-align: center;}
.top p{font-size: 0.8em; color: gray;}
table{margin: auto;}
tr{text-align: center;}
td.td_right {text-align: left;}
.td_right input{width:392px;}
#button {text-align: center;}
</style>

<title>캠핑카장</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true" />
<br><br>
<div class="wrap">
	<div class="container">
	
	<section class="top">
	<h2>내 정보 수정</h2>
	<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
	</section><br>
	<hr><br><br>
	
	<section class="middle">
	<form action="myPage.camp" method="post" onsubmit="return check();">
	
	  			<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label" >아이디</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" name="MEM_ID" id="ID" value="<%=memberInfo.getMEM_ID()%>" pattern="^([a-z0-9_]){4,20}$" readonly>
    				</div>
  				</div>
  				<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label">비밀번호</label>
    				<div class="col-sm-10">
    					<input
								type="password" name="MEM_PW" required name="PASSWORD" id="pw" class="form-control"
								placeholder="*특수문자 포함 4자 이상 20자 이하" onchange="check_pw()"
								pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_-+=[]{}~?:;`|/]).{4,10}$"
								value="<%=memberInfo.getMEM_PW()%>">
    				</div>
  				</div>
  				<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label">비밀번호확인</label>
    				<div class="col-sm-10">
      					<input
								type="password" required name="CONFIRMPWD" id="pwCheck" class="form-control"
								onchange="check_pw()" value="">
    				</div>
    				<label class="col-sm-2"></label>
    				<div id="check" class="cols" style="padding-left:15px;"></div>
  				</div>
  				<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label">이름</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" id="colFormLabel" placeholder="" name="MEM_NAME" value="<%=memberInfo.getMEM_NAME()%>" readonly>
    				</div>
  				</div>
  				<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label">주소</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" id="colFormLabel" placeholder="" required name="MEM_ADDR" value="<%=memberInfo.getMEM_ADDR()%>">
    				</div>
  				</div>
  				
  				<!--  전화번호 -->
				<div class="form-group row">
					<label for="colFormLabel" class="col-sm-2 col-form-label">전화번호</label>
					<%
					String tel = memberInfo.getMEM_TEL();
					String tel1 = tel.substring(0,tel.indexOf("-"));
					String tel2 = tel.substring((tel.indexOf("-"))+1, tel.lastIndexOf("-"));
					String tel3 = tel.substring((tel.lastIndexOf("-"))+1);
					%>
					<div class="col">
      					<input type="text" class="form-control" placeholder="" required name="TEL1" value="<%=tel1%>">
    				</div>
    				<div class="col">
      					<input type="text" class="form-control" placeholder="" required name="TEL2" value="<%=tel2%>">
    				</div>
    				<div class="col">
      					<input type="text" class="form-control" placeholder="" required name="TEL3" value="<%=tel3%>">
    				</div>
	
  				</div>
  				<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label">생년월일</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" id="colFormLabel" placeholder="" readonly name="MEM_JUMIN" value="<%=memberInfo.getMEM_JUMIN()%>">
    				</div>
  				</div>
				<div class="form-group row">
					<label for="colFormLabel" class="col-sm-2 col-form-label">이메일</label>
					<div class="col">
      					<input type="text" class="form-control" placeholder="" id="email1" name="EMAIL1"
								onKeyup="this.value=this.value.replace(/[^a-zA-Z0-9]/gi,'');"
								value="<%=emailArray[0]%>" required />
    				</div>
    				<label class="col-form-label">&#64;</label>
    				<div class="col">
      					<input type="text" class="form-control" placeholder="" id="email2" name="EMAIL2"
								value="<%=emailArray[1]%>"
								onKeyup="this.value=this.value.replace(/[^a-zA-Z0-9.]/gi,'');"
								required />
    				</div>
    				<div class="col">
      					<select id="camp" name="camp" class="custom-select mr-sm-2" onclick="getEmail()">
									<option selected="selected" id="0">직접입력</option>
									<option id="1" value="naver.com">naver.com</option>
									<option id="2" value="hanmail.net">hanmail.net</option>
									<option id="3" value="gmail.com">gmail.com</option>
						</select>
    				</div>
  				</div>
	
		<br><br>

		<div id="button">
			<input type="button" class="btn btn-outline-dark" value="취소" onclick="history.go(-1);">&nbsp;&nbsp;
			<input type="submit" class="btn btn-dark" value="수정" >
		</div>
		</form>
		</section>
		</div><br>

<br>
<jsp:include page="footer.jsp" flush="true" />
</div>
</body>
</html>