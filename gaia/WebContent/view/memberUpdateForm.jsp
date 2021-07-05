<%@page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="javaBean.member.MemberBean"%>
<%
	MemberBean dto = (MemberBean) request.getAttribute("memberInfo");
	Object updateId = request.getAttribute("MEM_ID");
	String[] emailArray = dto.getMEM_EMAIL().split("@");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<style>
  h2 {text-align: center;}
  table{margin: auto;}
  tr{text-align: center;}
  #button{text-align: center;}
</style>
<meta charset="UTF-8">

<title>캠핑카장</title>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>
<br><br>


<div class="wrap">
	<div class="container">
	<form action="memberUpdateSuccess.camp" name="form1" method="post">
		<section class="top">
		<h2>관리자 회원 수정</h2>
      	</section><br><hr><br>
      	
	
		<section class="middle">
	
	
	  			<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label" >아이디</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" name="MEM_ID" id="ID" value="<%=dto.getMEM_ID()%>" pattern="^([a-z0-9_]){4,20}$" readonly>
    				</div>
  				</div>
  				<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label">비밀번호</label>
    				<div class="col-sm-10">
    					<input
								type="password" name="MEM_PW" required name="PASSWORD" id="pw" class="form-control"
								placeholder="*특수문자 포함 4자 이상 20자 이하" onchange="check_pw()"
								pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_-+=[]{}~?:;`|/]).{4,10}$"
								value="<%=dto.getMEM_PW()%>">
    				</div>
  				</div>
  				<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label">이름</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" id="colFormLabel" placeholder="" name="MEM_NAME" value="<%=dto.getMEM_NAME()%>">
    				</div>
  				</div>
  				<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label">주소</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" id="colFormLabel" placeholder="" required name="MEM_ADDR" value="<%=dto.getMEM_ADDR()%>">
    				</div>
  				</div>
  				
  				
  				<!--  전화번호 -->
				<div class="form-group row">
					<label for="colFormLabel" class="col-sm-2 col-form-label">전화번호</label>
					<%
					String tel = dto.getMEM_TEL();
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
      					<input type="text" class="form-control" id="colFormLabel" placeholder="" readonly name="MEM_JUMIN" value="<%=dto.getMEM_JUMIN()%>">
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
		
		</section>
		</form>
		</div><br>
      	
      	
      	
<%--       	<section class="modifyForm">
		<table>
		<tr>
			<td class="td_left"><label for="MEM_ID"></label>아&nbsp;&nbsp;&nbsp;이&nbsp;&nbsp;&nbsp;디</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" value="<%=dto.getMEM_ID()%>" disabled>
			<input type="hidden" name="MEM_ID" id="MEM_ID" value="<%=dto.getMEM_ID()%>"></td>
		</tr><tr>
			<td class="td_left"><label for="MEM_PW"></label>비&nbsp;밀&nbsp;번&nbsp;호</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="MEM_PW" id="MEM_PW" value="<%=dto.getMEM_PW()%>"></td>
		</tr><tr>
			<td class="td_left"><label for="MEM_NAME"></label>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="MEM_NAME" id="MEM_NAME" value="<%=dto.getMEM_NAME()%>"></td>
		</tr><tr>
			<td class="td_left"><label for="MEM_ADDR"></label>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="MEM_ADDR" id="MEM_ADDR" value="<%=dto.getMEM_ADDR()%>"></td>
		</tr><tr>
			<td class="td_left"><label for="MEM_TEL"></label>전&nbsp;화&nbsp;번&nbsp;호</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="MEM_TEL" id="MEM_TEL" value="<%=dto.getMEM_TEL()%>"></td>
		</tr><tr>
			<td class="td_left"><label for="MEM_JUMIN"></label>주&nbsp;민&nbsp;번&nbsp;호</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="MEM_JUMIN" id="MEM_JUMIN" value="<%=dto.getMEM_JUMIN()%>" disabled></td>
		</tr><tr>
			<td class="td_left"><label for="MEM_EMAIL"></label>이&nbsp;&nbsp;&nbsp;메&nbsp;&nbsp;&nbsp;일</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="MEM_EMAIL" id="MEM_EMAIL" value="<%=dto.getMEM_EMAIL()%>"></td>
		</tr>
      	</table><br>
      	
		<div id="button">
		<input type="hidden" name="memberId" value="<%=dto.getMEM_ID()%>"/>
		<input type="submit" class="btn btn-dark" value="수정하기 " />
		<input type="button" class="btn btn-dark" value="뒤로가기" onclick="history.back(-1)" />
  		</div>
 		</section> --%>
	


<jsp:include page="footer.jsp" flush="true"/>
</div>
</body>
</html>