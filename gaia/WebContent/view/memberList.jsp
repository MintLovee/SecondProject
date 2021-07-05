<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="javaBean.member.MemberBean"%>
<%@ page import="dao.member.MemberDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="action.member.MemberListAction"%>
<%@ page import="util.PageInfo"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");
	ArrayList<MemberBean> memberList = (ArrayList<MemberBean>)request.getAttribute("memberList");
	PageInfo rezPageInfo = (PageInfo)request.getAttribute("pageInfo");
	int nowPage = rezPageInfo.getPage();
	int maxPage = rezPageInfo.getMaxPage();
	int startPage = rezPageInfo.getStartPage();
	int endPage = rezPageInfo.getEndPage();
	int listCount = rezPageInfo.getListCount();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script>
$(function() {
	if (window.location.pathname != "/gaia/managePageMem.camp") {
		location.href="managePageMem.camp";
	}
   	$('.memInfo').click(function() {
		$('.memInfo').css("background-color", "transparent");
      	selectTr = $(this);
      	selectTd = selectTr.children();
      	rezNum = selectTd.eq(0).text();
      	if (rezNum == "admin") {
			alert("관리자계정은 선택할 수 없습니다.");
			return;
	}
	$('#rezNumA').val(rezNum);
	$('#rezNumB').val(rezNum);
	$('#'+rezNum).css("background-color", "#FFFFDE");
	});
});

   
   function check() {
      if ($('#rezNumB').val() == "") {
         alert("삭제할 항목을 선택해주세요.");
         return false;
      } else if($('#rezNumB').val() != "") {
         if (confirm("정말 삭제하시겠습니까?")) {
        	 location.href="memberDelete.camp";
         } else {
            return false;
          }
      }
   }
   function modi(modiId){
      var pw = prompt("관리자 암호 재 확인","");
      if(pw!="admin"){
         location.href = "managePageMem.camp";
         alert("암호가 일치하지 않습니다.")
      }
      else{
      location.href = "myMemberPage.camp?MEM_ID=" + modiId;
   }
   }

   function searchCheck(frm) {
      //검색

      if (frm.keyWord.value == "") {
         alert("검색 단어를 입력하세요.");
         frm.keyWord.focus();
         return;
      }
      frm.submit();
   }
   function lcSubmit() {
		if ($('#rezNumB').val() == "") {
			alert("수정할 항목을 선택해주세요.");
			return false;
		}
	  }
   
	function slectAll() {
	
	}
	function selectNew() {
		
	}
</script>
<style>
h2{text-align: center;}
#memberListButton form{display: inline;}
#memberListButton{text-align: right;}
   
.memberListTable {
  width: 100%;
  border-collapse: collapse;
  text-align: center;
  line-height: 1.5;
}
.memberListTable th {
  padding: 9px;
  font-weight: bold;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
  background: #f3f6f7;
}
.memberListTable td {
  padding: 9px;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}

.memInfo{cursor: pointer;}
.clearfix{clear: both;}
#rezPage{margin: auto; width: 70%; text-align: center;}
#emptyArea{margin: auto; width: 70%; text-align: center;}
</style>
<title>회원관리</title>
</head>
<body>
<div class="container">
	
	<section class="rezList" class="col-xs-12">
   <h2>회원 리스트</h2><br>
   
   <div id="memberListButton">
      <button type="button" class="btn btn-dark" onClick="location.href='joinAdmin.camp'">회원추가</button>
      
      <form action="myMemberPage.camp" method="POST" onsubmit="return lcSubmit();">
      <input type="hidden" id="rezNumA" name="rezNumA" />
      <input type="submit" class="btn btn-dark" id="mgtUpdateBt" value="회원정보수정"/>
      </form> 
      
      <form action="memberDelete.camp" method="POST" onsubmit="return check();">
      <input type="hidden" id="rezNumB" name="MEM_ID"/>
      <input type="submit" class="btn btn-dark" id="mgtDeleteBt" value="회원삭제"/>
      </form>
      
      <form action="managePageMem.camp" method="POST">
	  <input type="submit" class="btn btn-info" value="가입순보기" onClick="location.href='managePageMem.camp'"/>
	  <input type="hidden" id="showN" name="show" value="newShow"/>
	  </form>
	  
	  <form action="managePageMem.camp" method="POST">
      <input type="submit" class="btn btn-info" value="전체보기" onClick="location.href='managePageMem.camp'"/>
	  <input type="hidden" id="showA" name="show" value="allShow"/>
	  </form>
      </div>

      
   <div class="clearfix"></div><br>
   
   <div id="memberListTable">
		<table class="memberListTable">
		<% if (memberList != null && listCount > 0) {%>
		<tr id="tr_top">
		<th scope="col" width=16%>아이디</th>
        <th scope="col" width=6%>이름</th>
        <th>주소</th>
        <th scope="col" width=12%>전화번호</th>
        <th scope="col" width=8%>생년월일</th>
        <th scope="col" width=20%>이메일</th>
		</tr>
		
		<% for (int i = 0; i < memberList.size() ; i++) {%>
		<tr id=<%=memberList.get(i).getMEM_ID() %> class="memInfo">
		<td><%=memberList.get(i).getMEM_ID() %></td>
		<td><%= memberList.get(i).getMEM_NAME() %></td>
		<td><%= memberList.get(i).getMEM_ADDR() %></td>
		<td><%= memberList.get(i).getMEM_TEL() %></td>
		<td><%= memberList.get(i).getMEM_JUMIN() %></td>
		<td><%= memberList.get(i).getMEM_EMAIL() %></td>
		</tr>
		<% }%>
		</table>
	</div><br><br>

	<div id="pageList">
	<ul class="pagination justify-content-center">
	<% if(nowPage<=1 || nowPage<11){ %>
	<li class="page-item"><a title="이전" class="page-link" href="#"
		style="pointer-events: none; cursor: default; color: #000;">&#11164;</a></li>
	<% } else if(nowPage>=11) { %>
		<c:if test = "${param.searchWord != null}">
			<li class="page-item"><a title="이전" class="page-link"
				href="managePageMem.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%= nowPage-1%>">&#11164;</a>
		</c:if>
		<c:if test = "${param.searchWord == null}">
			<li class="page-item"><a title="이전" class="page-link"
				href="managePageMem.camp?page=<%= nowPage-1%>">&#11164;</a>
		</c:if>
	<%} %>				

	<% for(int a=startPage; a<=endPage;a++) {
		if(a==nowPage){ %>
	<li class="page-item"><a class="page-link" href="#"
		style="pointer-events: none; cursor: default; color: #000;"><%=a %></a></li>
	<% } else { %>
		<c:if test = "${param.searchWord != null}">
			<li class="page-item"><a class="page-link"
				href="managePageMem.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%= a%>"><%= a%></a>
		</c:if>
		<c:if test = "${param.searchWord == null}">
			<li class="page-item"><a class="page-link"
				href="managePageMem.camp?page=<%= a%>"><%= a%></a>
		</c:if>
	<%} %>	
	<%} %>
	
	<% if (nowPage>=maxPage) { %>
	<li class="page-item"><a class="page-link" href="#"
		style="pointer-events: none; cursor: default; color: #000;">&#11166;</a></li>
	<% } else if ((nowPage+10)>=maxPage) { %>
		<c:if test = "${param.searchWord != null}">
			<li class="page-item"><a title="다음" class="page-link"
				href="managePageMem.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=maxPage %>">&#11166;</a>
		</c:if>
		<c:if test = "${param.searchWord == null}">
			<li class="page-item"><a title="다음" class="page-link"
				href="managePageMem.camp?page=<%=maxPage %>">&#11166;</a>
		</c:if>
	<% } else { %>
		<c:if test = "${param.searchWord != null}">
			<li class="page-item"><a title="다음" class="page-link"
				href="managePageMem.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=nowPage+10 %>">&#11166;</a>
		</c:if>
		<c:if test = "${param.searchWord == null}">
			<li class="page-item"><a title="다음" class="page-link"
				href="managePageMem.camp?page=<%=nowPage+10 %>">&#11166;</a>
		</c:if>
	<%} %></ul><br><br>
	
	<form>
		<div class="form-row">
		<div class="form-group col-md-1"></div>
		<div class="form-group col-md-3">
			<select name="fieldName" id="fieldName" class="form-control">
	    		<option ${(param.fieldName == "MEM_ID")? "selected" : ""} value = "MEM_ID">아이디</option>
    			<option ${(param.fieldName == "MEM_NAME")? "selected" : ""} value = "MEM_NAME">이&nbsp;&nbsp;&nbsp;름</option>
    			<option ${(param.fieldName == "MEM_ADDR")? "selected" : ""} value = "MEM_ADDR">주&nbsp;&nbsp;&nbsp;소</option>
			</select>
		</div>
		<div class="form-group col-md-6">
			<input type="text" class="form-control" placeholder="Search" name="searchWord" value = "${param.searchWord}"/>
		</div>
		<div class="form-group col-md-1">
			<button class="btn btn-dark" type="submit">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
				 fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  				<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
			</svg>
			
			</button>
		</div>
		<div class="form-group col-md-1"></div>
		</div>
	</form>
	</div>
	
<% } else { %>
<section id="emptyArea">회원 목록이 없습니다.</section>
<% } %>
</section><br>
   
</div>
</body>
</html>