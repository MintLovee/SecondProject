package action.review;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.review.ReviewBean;
import service.review.RevDetailService;
import util.Action;
import util.ActionForward;

public class RevModifyFormAction implements Action {
	
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		 
		 	ActionForward forward = new ActionForward();
		 	String nowPage = request.getParameter("page");
			int rev_num=Integer.parseInt(request.getParameter("rev_num"));
			RevDetailService revDetailService = new RevDetailService();	
		   	ReviewBean article = revDetailService.getArticle(rev_num);
		   	request.setAttribute("article", article);
		   	request.setAttribute("page", nowPage);
	   		forward.setPath("/view/reviewModify.jsp");
	   		return forward;
	 }
}