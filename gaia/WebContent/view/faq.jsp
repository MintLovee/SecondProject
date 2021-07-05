<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javaBean.qna.QnaBean"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	ArrayList<QnaBean> faqList = (ArrayList<QnaBean>) request.getAttribute("faqList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>faq</title>
<style>
.b {
	padding: 20px;
	background-color: #eeeeee;
}

.a {
	padding: 15px;
	border: 1px solid #dddddd;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$('div.a').click(function() {
			$(this).next().slideToggle();
		});
	});

	$(document).ready(function() {
		$('#click').click(function() {
			$('#faq').slideToggle('slow', function() {
			});
		});
	});
</script>
</head>
<body>

		<section class="top">
			<h2>문의하기</h2>
			<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
		</section>
		<br>
		<hr>
		
		<br>
		<table class="table table-striped"
			style="text-align: center; border: 0px solid #dddddd;">
			<thead>
				<tr id="click" style="text-align: center; width: 1110px;">
					<th scope="col" colspan="4"
						style="background-color: #f3f6f7; text-align: center;">자주하는
						질문 &#11167;</th>
				</tr>
			</thead>
		</table>


		<div id="faq" style="display: none;">
			<%
				if (faqList != null) {
			%>
			<%
				for (int i = 0; i < faqList.size(); i++) {
			%>
			<div class="a" style="font-weight: 500">
				Q.
				<%=faqList.get(i).getFAQ_Q()%></div>
			<div class="b" style="display: none;">
				A.
				<%=faqList.get(i).getFAQ_A()%></div>
			<%
				}
			%>
			<%
				}
			%>
			<br><br>
		</div>
	

</body>
</html>