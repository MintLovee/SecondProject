package action.review;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.review.CommentBean;
import javaBean.review.ReviewBean;
import service.review.RevDetailService;
import util.Action;
import util.ActionForward;
import util.PageInfo;

 public class RevDetailAction implements Action {
	 
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{ 
	
		ArrayList<CommentBean> articleList=new ArrayList<CommentBean>();
		int page=1;
		int limit=5;
		int listPage = 1;
		if (request.getParameter("listPage")!=null) {
			listPage = Integer.parseInt(request.getParameter("listPage"));
		}
		
		int re_num=Integer.parseInt(request.getParameter("rev_num"));
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		RevDetailService revDetailService = new RevDetailService();
		ReviewBean article = revDetailService.getArticle(re_num);
		int listCount=revDetailService.getListCount(re_num); 
		articleList = revDetailService.getArticleList(page,limit,re_num);
			
		int maxPage=(int)((double)listCount/limit+0.95); 
   		int startPage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
   	    int endPage = startPage+10-1;

   		if (endPage> maxPage) endPage= maxPage;

   		PageInfo pageInfo = new PageInfo();
   		pageInfo.setEndPage(endPage);
   		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);	
		
		ActionForward forward = new ActionForward();
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("listPage", listPage);
	   	request.setAttribute("article", article);
	   	request.setAttribute("comment", articleList);
   		forward.setPath("/view/reviewDetail.jsp");
   		return forward;
	 }
}