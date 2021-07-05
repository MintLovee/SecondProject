<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="util.PageInfo"%>
<%@ page import="javaBean.notice.NoticeBean"%>
<%@ page import="java.util.*"%>
<%@ page import="service.notice.NoticeRecentlyService"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	ArrayList<NoticeBean> recentlyList=new ArrayList<NoticeBean>();
	NoticeRecentlyService recentlyListService = new NoticeRecentlyService();
	recentlyList = recentlyListService.getRecentlyList();
	int a = 4 - recentlyList.size();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">

</head>
<body>
	<table class="table" style="text-align: center;">
		<% if(recentlyList != null){ %>
		<% for(int i=0;i<recentlyList.size();i++){ %>
		<tbody>
		<tr><td style="text-align: left;">
			<a title="상세보기" href="noticeDetail.camp?notice_num=<%=recentlyList.get(i).getNOTICE_NUM()%>">
				<%=recentlyList.get(i).getNOTICE_TITLE()%></a></td>
			<td style="width: 90px"><%=recentlyList.get(i).getNOTICE_DATE() %></td></tr>
			
		<%} if ( a > 0 ) {
			for (int i=0;i<a;i++) { %>
			<tr>
				<td><br></td>
				<td></td>
			</tr>
			<%	}
			} %>
		</tbody>
	</table>

	<% } else { %>
	<section id="emptyArea">등록된 글이 없습니다.</section>
	<% } %>


</body>
</html>