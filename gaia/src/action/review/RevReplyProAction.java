package action.review;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.auth.AuthBean;
import javaBean.review.CommentBean;
import service.review.RevReplyProService;
import util.Action;
import util.ActionForward;

public class RevReplyProAction implements Action {
	
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) 
	 throws Exception{
		 
		 	ActionForward forward = null;
		    String nowPage = request.getParameter("page");
		 	CommentBean article = new CommentBean();  		
		 	AuthBean authBean = (AuthBean)request.getSession(false).getAttribute("authUser");
		 	article.setRE_ID(authBean.getMEM_ID());
		 	article.setRE_NICKNAME(authBean.getMEM_NICKNAME());
		 	article.setRE_CONTENT(request.getParameter("RE_CONTENT"));
		 	article.setRE_PT_NUM(Integer.parseInt(request.getParameter("RE_PT_NUM")));
		 	RevReplyProService revReplyProService = new RevReplyProService();
		 	boolean isReplySuccess = revReplyProService.replyArticle(article);
		 	
	   		if(isReplySuccess){
	   			forward = new ActionForward();
	   			forward.setPath("reviewDetail.camp?rev_num="+article.getRE_PT_NUM()+"&page="+nowPage);
	   		}
	   		else{
	   			response.setContentType("text/html;charset=UTF-8");
	   			PrintWriter out = response.getWriter();
	   			out.println("<script>");
	   			out.println("alert('답글실패')");
	   			out.println("history.back()");
	   			out.println("</script>");
	   		}
	   		return forward;
	}  	
}