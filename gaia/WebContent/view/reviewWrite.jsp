<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.review.ReviewWriteBean" %>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% ArrayList<ReviewWriteBean> reviewWriteList = (ArrayList<ReviewWriteBean>)request.getAttribute("reviewWriteList");%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script>
function back(){
   window.history.back();
}
</script>
<style>
.top{text-align: center;}
.top p{font-size: 0.8em; color: gray;}

table {
  width: 100%;
  border-collapse: collapse;
  text-align: center;
  line-height: 1.5;
}
thead th {
  padding: 15px;
  font-weight: bold;
  vertical-align: top;
  color: #369;
  border-bottom: 3px solid #036;
  background: #f3f6f7;
}
tbody td {
  width: 200px;
  
  font-size: 0.9em;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}
tbody td.td_left {
  font-weight: bold;
  padding-top: 10px;
  padding-bottom: 10px;
  min-width: 71px;
}
#td_REV_SITE{text-align: left;}
#button{text-align: right;}
</style>

</head>
<body>
<jsp:include page="header.jsp" flush="true"/>
<br><br>
<div class="wrap">
<div class="container">

	<section class="top">
	<h2>고객후기</h2>
	<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
	</section><br>
	<hr><br><br>
   
   <section class="write">
      <form action="reviewWritepro.camp" method="post" enctype="multipart/form-data" name="boardform">
      <input type="hidden" name="REV_ID" value="${authUser.MEM_ID}" />
      <input type="hidden" name="REV_NAME" id="REV_NAME" value="${authUser.MEM_NICKNAME}" readonly>
         <table>
         <thead>
            <tr><th scope="row" colspan="4">글 작성</th></tr>
            </thead>
            <tbody>
         <tr><td class="td_left" colspan="1" style="width: 20%;">이름</td>
         <td class="td_right" colspan="3" align="left">${authUser.MEM_NICKNAME}</td></tr>
         
         <tr><td class="td_left" colspan="1" style="width: 20%;"><label for="REV_SUBJECT">제 목</label></td>
            <td class="td_right" colspan="3"><input type="text" class="form-control" name="REV_SUBJECT" id="REV_SUBJECT" placeholder="* 제목을 입력하세요." maxlength="50" required autofocus></td></tr>
         
         <tr>
            <td class="td_left" style="width: 20%;"><label for="REV_FILE"> 파일 첨부 </label></td>
            <td class="td_right" style="text-align: left;"><input name="REV_FILE" type="file"
                  accept="image/*" id="REV_FILE" /></td>
         </tr>
         
         <tr>
            <td class="td_left" style="width: 20%;"><label for="REV_SITE">캠핑사이트</label></td>
            <c:if test="${!empty reviewWriteList}" >
            <td id="td_REV_SITE" >
               <select name="REV_SITE" id="REV_SITE" style="width:300px;">
               <option value="">사이트를 선택해주세요.</option>
               <% for (int i = 0; i < reviewWriteList.size(); i++) { %>
               <option value="<%=reviewWriteList.get(i).getREZ_NUM()%>,<%=reviewWriteList.get(i).getREZ_PNUM()%>"><%=reviewWriteList.get(i).getSITE()%></option>
                  <% } %>
               </select></td>
            </c:if>
         </tr>
         
         <tr><td class="td_left" colspan="1"><label for="REV_CONTENT">내 용</label></td>
            <td colspan="3"><textarea class="form-control" name="REV_CONTENT" id="REV_CONTENT" rows="10" placeholder="* 내용을 입력하세요." required> </textarea></td></tr>
         
         </tbody>
         </table> 
         <br>
         <div class="col text-center">
            <button class="btn btn-outline-dark" onclick="back()">뒤로가기</button>
            <input type="submit" class="btn btn-dark" value="글쓰기">&nbsp;&nbsp;
         </div>
      </form>
   </section>
   </div>
   <br>
<jsp:include page="footer.jsp" flush="true"/>
</div>
</body>
</html>