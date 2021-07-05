<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="util.PageInfo"%>
<%@ page import="javaBean.review.ReviewBean"%>
<%@ page import="java.util.*"%>
<%@ page import="service.review.RevRecentlyService"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	ArrayList<ReviewBean> recentlyList=new ArrayList<ReviewBean>();
	RevRecentlyService recentlyListService = new RevRecentlyService();
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
		for(int i=0;i<recentlyList.size();i++){
			
	%>
		<tbody>
			<tr>

				<td style="text-align: left;"><a title="상세보기" 
					href="reviewDetail.camp?rev_num=<%=recentlyList.get(i).getREV_NUM()%>">

						<%=recentlyList.get(i).getREV_SUBJECT()%>

				</a></td>

				<td style="width: 90px">
					<%=recentlyList.get(i).getREV_DATE()%>
					
				</td>

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