<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.PageInfo"%>
<%@ page import="javaBean.qna.QnaBean"%>
<%@ page import="java.util.*"%>
<%@ page import="service.qna.QnaRecentlyService"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	ArrayList<QnaBean> recentlyList=new ArrayList<QnaBean>();
	QnaRecentlyService recentlyListService = new QnaRecentlyService();
	recentlyList = recentlyListService.getRecentlyList();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">


</head>
<body>


	<table class="table" style="text-align: center;">
		<%
		if(recentlyList != null){
			%>
		<%
		for(int i=0;i<recentlyList.size();i++){ %>
		<tbody>
			<tr>
				<td style="text-align: left;">
					<%if(recentlyList.get(i).getQNA_RE_DEPTH()!=0){ %> <%for(int a=0;a<=recentlyList.get(i).getQNA_RE_DEPTH();a++){ %>
					&nbsp; <%} %>&#10551; &nbsp;<%}else{ %> <%} %>
					<a title="상세보기" href="qnaDetail.camp?qna_num=<%=recentlyList.get(i).getQNA_NUM()%>">
						<%=recentlyList.get(i).getQNA_SUBJECT()%></a>
				</td>
				<td style="width: 90px"><%=recentlyList.get(i).getQNA_DATE() %></td>

			</tr>
		</tbody>
		<%} %>

	</table>

	<%
    }
	else
	{
	%>
	<section id="emptyArea">등록된 글이 없습니다.</section>
	<%
	}
%>

</body>
</html>