package action.qna;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.qna.QnaBean;
import service.qna.QnaReplyProService;
import util.Action;
import util.ActionForward;

public class QnaReplyProAction implements Action {
	
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) 
	 throws Exception{
		 
		 	ActionForward forward = null;
		    String nowPage = request.getParameter("page");
		 	QnaBean article = new QnaBean();  		
		 	article.setQNA_NUM(Integer.parseInt(request.getParameter("QNA_NUM")));
		 	article.setQNA_NAME(request.getParameter("QNA_NAME"));
		 	article.setQNA_ID(request.getParameter("QNA_ID"));
		 	article.setQNA_SUBJECT(request.getParameter("QNA_SUBJECT"));
		 	article.setQNA_CONTENT(request.getParameter("QNA_CONTENT"));
		 	article.setQNA_RE_NUM(Integer.parseInt(request.getParameter("QNA_RE_NUM")));
		 	article.setQNA_RE_DEPTH(Integer.parseInt(request.getParameter("QNA_RE_DEPTH")));
		 	article.setQNA_SECRET(Integer.parseInt(request.getParameter("QNA_SECRET")));
	   		
		 	QnaReplyProService qnaReplyProService = new QnaReplyProService();
		 	boolean isReplySuccess = qnaReplyProService.replyArticle(article);
		 	
	   		if(isReplySuccess){
	   			forward = new ActionForward();
	   			forward.setRedirect(true);
	   			forward.setPath("qnaList.camp?page=" + nowPage);
	   		}
	   		else{
	   			response.setContentType("text/html;charset=UTF-8");
	   			PrintWriter out = response.getWriter();
	   			out.println("<script>");
	   			out.println("alert('답장 실패')");
	   			out.println("history.back()");
	   			out.println("</script>");
	   		}
	   		
	   		return forward;
	   		
	}  	
	 
}