<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javaBean.member.MemberBean"%>

<%
	String id = (String) session.getAttribute("MEM_ID");
	request.setCharacterEncoding("UTF-8");
	MemberBean memberInfo = (MemberBean) request.getAttribute("memberInfo");
	String[] emailArray = memberInfo.getMEM_EMAIL().split("@");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠핑카장</title>
<style>
h2 {
	text-align: center;
}

table {
	margin: auto;
}

tr {
	text-align: center;
}

#button {
	text-align: center;
}

td.td_right {
	text-align: left;
}
</style>

<script type="text/javascript">

    function check_pw(){
        
        var pw = document.getElementById('pw').value;
        var SC = ["!","@","#","$","%"];
        var check_SC = 0;

        if(pw.length < 6 || pw.length> 16){
            window.alert('비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.');
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
                window.alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요");
                document.getElementById('pw').value='';
                document.getElementById('pwCheck').value='';
                mod.MEM_PW.focus();
            }
        }
    }
    function check() {
        if(document.getElementById('pwCheck').value === ''){
           alert('비밀번호 확인을 입력하세요');
           return false;
        }else{
           alert('수정 완료되었습니다.');
           return true;
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


</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<!-- 가져온 회원정보를 출력한다. -->
	<form name="form1" action="memberUpdateSuccess.camp" method="post">
		<div class="container">
			<section class="top">
				<br />
				<h2>내 정보 수정</h2>
			</section>
			<br>
			<hr>
			<br>
			<section class="modifyForm">
				<table>
					<tr>
						<td class="td_left"><label for="MEM_ID"></label>아&nbsp;&nbsp;&nbsp;이&nbsp;&nbsp;&nbsp;디</td>
						<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input
							type="text" name="memId" id="MEM_ID"
							value="<%=memberInfo.getMEM_ID()%>"></td>
					</tr>
					<tr>
						<td class="td_left"><label for="MEM_PW"></label>비&nbsp;밀&nbsp;번&nbsp;호</td>
						<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input
							type="password" name="memPw" id="pw"
							value="<%=memberInfo.getMEM_PW()%>" onchange="check_pw()"></td>
					</tr>
					<tr>
						<td class="td_left"><label for="MEM_CPW"></label>확&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;인</td>
						<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input
							type="password" name="MEM_CPW"
							value="<%=memberInfo.getMEM_PW()%>" id="pwCheck"
							onchange="check_pw()">&nbsp;<span id="check"></span></td>
					</tr>
					<tr>
						<td class="td_left"><label for="MEM_NAME"></label>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</td>
						<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input
							type="text" name="memName" id="pwCheck"
							value="<%=memberInfo.getMEM_NAME()%>" onchange="check_pw()"></td>
					</tr>
					<tr>
						<td class="td_left"><label for="MEM_ADDR"></label>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>
						<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input
							type="text" name="memAddr" id="MEM_ADDR"
							value="<%=memberInfo.getMEM_ADDR()%>"></td>
					</tr>
					<tr>
						<td class="td_left"><label for="MEM_TEL"></label>연&nbsp;&nbsp;&nbsp;락&nbsp;&nbsp;&nbsp;처</td>
						<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input
							type="text" name="memTel" id="MEM_TEL"
							value="<%=memberInfo.getMEM_TEL()%>"></td>
					</tr>
					<tr>
						<td class="td_left"><label for="MEM_JUMIN"></label>주&nbsp;민&nbsp;번&nbsp;호</td>
						<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input
							type="text" name="memJumin" id="MEM_JUMIN"
							value="<%=memberInfo.getMEM_JUMIN()%>" disabled></td>
					</tr>
					<tr>
						<td class="td_left"><label for="MEM_EMAIL"></label>이&nbsp;&nbsp;&nbsp;메&nbsp;&nbsp;&nbsp;일</td>
						<td>&nbsp;&nbsp;&nbsp; <input type="text" name="EMAIL1"
							value="<%=emailArray[0]%>">@ <input type="text"
							id="email2" name="EMAIL2" value="<%=emailArray[1]%>" /> <select
							id="camp" name="camp" onClick="getEmail()">
								<option selected="selected" id="0">직접입력</option>
								<option id="1" value="naver.com">naver.com</option>
								<option id="2" value="hanmail.net">hanmail.net</option>
								<option id="3" value="gmail.com">gmail.com</option>
								<option id="4" value="daum.net">daum.net</option>
						</select></td>
					</tr>
				</table>

				<br>
				<div id="button">
					<input type="hidden" class="btn btn-dark" name="id"
						value="<%=memberInfo.getMEM_ID()%>" /> 
						<input type="submit"
						class="btn btn-dark" name="memUpdate" value="회원정보 변경"
						onclick="alert('수정 완료되었습니다.')" /> 
						<input type="button"
						class="btn btn-dark" value="뒤로가기"
						onclick="location.href='managePageMem.camp'" />

				</div>
			</section>
		</div>
	</form>
	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>