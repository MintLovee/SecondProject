<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.member.MemberBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   request.setCharacterEncoding("UTF-8");
   MemberBean memberInfo = (MemberBean)request.getAttribute("memberInfo");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 수정</title>
 <style type="text/css">
        table{
            margin-left:auto; 
            margin-right:auto;
            border:3px solid skyblue;
        }
        
        td{
            border:1px solid skyblue
        }
        
        #title{
            background-color:skyblue
        }
    </style>
    
<script type="text/javascript">
    
        function changeForm(val){
            if(val == "-1"){
                location.href="index.jsp";
            }else if(val == "0"){
                location.href="MainForm.jsp?contentPage=member/view/ModifyFrom.jsp";
            }else if(val == "1"){
                location.href="MainForm.jsp?contentPage=member/view/DeleteForm.jsp";
            }
        }
        
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
                }
            }
        }
        </script>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>

        <b><font size="6" color="gray">내 정보</font></b>
        <br><br><br>
          
          <form action="myMemberPage.camp"><input type="submit" value="수정완료">             
        <table>
            <tr>
                <td id="title"><label for="MEM_ID">아이디</label></td>
                <td><input type="text" name="MEM_ID" id="MEM_ID" readonly="readonly" value = "<%=memberInfo.getMEM_ID()%>"><br></td>
            </tr>
                        
            <tr>
                <td id="title"><label for="pw">비밀번호</label></td>
                <!-- <input type="password" name="PASSWORD" id="pw" onchange="check_pw()" -->
                <td><input type="password" name="MEM_PW" id="pw" onchange="check_pw()" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_-+=[]{}~?:;`|/]).{4,10}$" value = "<%=memberInfo.getMEM_PW()%>"><br></td>
            <c:if test="${errors.PASSWORD}">암호를 입력하세요.</c:if> 
            </tr>
            
            <tr>
                <td id="title"><label for="pwCheck">비밀번호 확인</label></td>
                <td><input type="password" name="MEM_PW" id="pwCheck" onchange="check_pw()" value = "<%=memberInfo.getMEM_PW()%>"><br></td>
                <!-- <input type="password" name="CONFIRMPWD" id="pwCheck" onchange="check_pw()">&nbsp;<span id="check"></span> -->
                <c:if test="${errors.notMatch}">암호와 확인이 일치하지 않습니다.</c:if>           
            </tr>
            
            <tr>
                <td id="title"><label for="MEM_NAME">이름</label></td>
                <td><input type="text" name="MEM_NAME" id="MEM_NAME" value = "<%=memberInfo.getMEM_NAME()%>"><br></td>
            </tr>
                    
            <tr>
                <td id="title"><label for="MEM_ADDR">주소</label></td>
                <td><input type="text" name="MEM_ADDR" id="MEM_ADDR" value = "<%=memberInfo.getMEM_ADDR()%>"><br></td>
            </tr>
                    
            <tr>
                <td id="title"><label for="MEM_TEL">전화번호</label></td>
                <td><input type="text" name="MEM_TEL" id="MEM_TEL" value = "<%=memberInfo.getMEM_TEL()%>"><br></td>
            </tr>
            <tr><td id="title"><label for="MEM_JUMIN">생년월일</label></td>
                <td><input type="text" name="MEM_JUMIN" id="MEM_JUMIN" readonly="readonly" value = "<%=memberInfo.getMEM_JUMIN()%>"><br></td>
            </tr>
            <tr>
                <td id="title"><label for="MEM_EMAIL">이메일</label></td>
                <td><input type="text" name="MEM_EMAIL" id="MEM_EMAIL" value = "<%=memberInfo.getMEM_EMAIL()%>"><br></td>
            </tr>
           
        </table>
        </form>
        
        <br>
        <form action="myMemberPage.camp"><input type="button" value="뒤로"></form>
         
        
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>

<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="javaBean.member.MemberBean"%>
    
    <%
   request.setCharacterEncoding("UTF-8");
   MemberBean memberInfo = (MemberBean)request.getAttribute("memberInfo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/script.js?ver=2"></script>

<script type="text/javascript">

window.onload = function(){
   
      }
   }

   document.getElementById("btnModify").onclick = memberModify;

   document.getElementById("btnModifyCancel").onclick = memberModifyCancel;

   document.getElementById("btnDelete").onclick = function(){

      memberDelete("<%=memberInfo.getMEM_ID()%>");
   }
}
</script>
</head>
<body>
<br>

<table class="table">

<tr>

   <td align="center" valign="middle" style="background-color: #FFFFCC">

      <form name="regForm" method="post" action="modify_member_action.jsp">

         <table border="1">

            <tr align="center" style="background-color: #8899aa">

               <td colspan="2"><b style="color: #FFFFFF">회원 정보 수정</b></td>

            </tr>

            <tr>

               <td width="16%">아이디</td>

               <td width="57%">

                  <input type="text" name="MEM_ID" size="15" style="background-color: lightgray" readonly="readonly" value = "<%=memberInfo.getMEM_ID()%>"> 

               </td>

            </tr>

            <tr>

               <td>패스워드</td>

               <td><input type="password" name="MEM_PW" size="15" value="<%=memberInfo.getMEM_PW() %>"></td>

            </tr>

            <tr>

               <td>패스워드 확인</td>

               <td><input type="password" name="repass" size="15"></td>

            </tr>

            <tr>

               <td>이름</td>

               <td><input type="text" name="name" size="15" value="<%=memberInfo.getMEM_NAME() %>"></td>

            </tr>
            
            <tr>

               <td>주소</td>

               <td><input type="text" name="MEM_ADDR" size="60" value="<%=memberInfo.getMEM_ADDR() %>"></td>

            </tr>
            
            <tr>

               <td>전화번호</td>

               <td><input type="text" name="MEM_TEL" size="20" value="<%=memberInfo.getMEM_TEL() %>"></td>

            </tr>
            
            <tr>

               <td>주민번호(앞)</td>

               <td><input type="text" name="MEM_JUMIN" size="15" value="<%=memberInfo.getMEM_JUMIN() %>"></td>

            </tr>

            <tr>

               <td>이메일</td>

               <td><input type="text" name="mail" size="27" value="<%=memberInfo.getMEM_EMAIL() %>"></td>

            </tr>

            


            

            
            <tr>

               <td colspan="2" align="center">

                  <input type="button" value="수정완료" id="btnModify" />

                  &nbsp;&nbsp;

                  <input type="button" value="수정취소" id="btnModifyCancel" />

                  <input type="button" value="회원탈되" id="btnDelete" />

               </td>

            </tr>

         </table>

      </form>

   </td>

</tr>

</table>



</body>
</html> --%>