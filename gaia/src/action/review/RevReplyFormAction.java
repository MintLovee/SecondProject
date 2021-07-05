package action.review;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.review.ReviewBean;
import service.review.RevDetailService;
import util.Action;
import util.ActionForward;

public class RevReplyFormAction implements Action {
	
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		 
		 	ActionForward forward = new ActionForward();
	   		String page = request.getParameter("page");
	   		String listPage = request.getParameter("listPage");
	   		int rev_num=Integer.parseInt(request.getParameter("rev_num"));
	   		RevDetailService boardDetailService = new RevDetailService();
	   		ReviewBean article=boardDetailService.getArticle(rev_num);
	   		
	   		request.setAttribute("article", article);
	   		request.setAttribute("page", listPage);
	   		forward.setPath("/view/reviewReply.jsp?rev_num="+rev_num+"&page="+page+"&listPage="+listPage);
	   		return forward;
	}
}