<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">

<script>
function clearInput(){
	var el = document.getElementsByClassName("input-text");
	for (var i=0; i<el.length; i++){
		el[i].value = '';
	}
	window.history.back();
}
</script>

<style>
.top {
	text-align: center;
}

.top p {
	font-size: 0.8em;
	color: gray;
}

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
	padding: 10px;
	font-size: 0.9em;
	vertical-align: center;
	border-bottom: 1px solid #ccc;
}

tbody td.td_left {
	font-weight: bold;
	padding-left: 0px;
	padding-right: 0px;
}

#NOTICE_CONTENT {
	height: 350px;
	resize: none;
}

#button {
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />

	<br>
	<br>
	<div class="wrap">
		<div class="container">
			<form action="qnaWritePro.camp" method="post" name="boardform" id="writeform">


				<section class="top">
					<h2>문의사항</h2>
					<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
				</section>
				<br>
				<hr>
				<br> <br>
				<div class="row">
<%-- 					<c:if test="${authUser.MEM_ID == null}">
						<script>
							alert("로그인이 필요합니다.");
							location.href = 'qnaList.camp';
						</script>
					</c:if> --%>
					<input type="hidden" name="QNA_ID" value="${authUser.MEM_ID}" /> <input
						type="hidden" name="QNA_NAME" id="QNA_NAME"
						value="${authUser.MEM_NICKNAME}" readonly>
					<table>
						<thead>
							<tr>
								<th scope="row" colspan="4">문의하기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="td_left" colspan="1" style="width: 18%"><label
									for="QNA_NAME">작성자</label></td>
								<td class="td_right" colspan="3" align="left">${authUser.MEM_NICKNAME}</td>
							</tr>
							<tr>
								<td class="td_left" colspan="1"><label for="QNA_CATEGORY">카테고리</label></td>
								<td class="td_right" colspan="1" style="max-width: 18%"><select
									name="QNA_CATEGORY" id="QNA_CATEGORY" class="form-control">
										<option value="">분류선택</option>
										<option value="예약관련">예약관련</option>
										<option value="결제관련">결제관련</option>
										<option value="기타">기타</option>
										<script>
										$("#writeform").submit(function (event) {
											if ($("#QNA_CATEGORY").val() == "") {
											  alert("문의유형을 선택해주세요.");
											  return false;
											}
										});
										</script>
											
								</select></td>
								<td class="td_left" colspan="1" style="width: 18%"><label for="QNA_SECRET">공개여부</label></td>
								<td class="td_right" colspan="1" align="left" style="padding-right: 0"><input
									type="radio" id="QNA_SECRET" name="QNA_SECRET" value="0"
									checked><label>&nbsp;공개</label>&nbsp;&nbsp; <input
									type="radio" id="QNA_SECRET" name="QNA_SECRET" value="1"><label>&nbsp;비공개</label>
								</td>
							</tr>
							<tr>
								<td class="td_left" colspan="1"><label for="QNA_SUBJECT">제
										목</label></td>
								<td class="td_right" colspan="3"><input type="text"
									class="form-control" name="QNA_SUBJECT" id="QNA_SUBJECT"
									maxlength="50" required></td>
							</tr>
							<tr>
								<td class="td_left" colspan="1"><label for="QNA_CONTENT">내
										용</label></td>
								<td colspan="3"><textarea name="QNA_CONTENT"
										class="form-control" id="QNA_CONTENT"
										style="height: 350px; resize: none;"
										placeholder="* 답변이 완료된 게시물은 삭제되지 않습니다." required></textarea></td>
							</tr>
						</tbody>

					</table>

					<div class="col text-center">
						<br>
						<button class="btn btn-outline-dark" type="button" onclick="history.go(-1);">뒤로가기</button>&nbsp;&nbsp;
						<input type="submit" class="btn btn-dark pull-right" value="글쓰기">
					</div>

				</div>

			</form>
		</div>
		<br>
		<jsp:include page="footer.jsp" flush="true" />
	</div>

</body>
</html>