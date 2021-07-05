package action.qna;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.qna.QnaBean;
import service.qna.QnaDetailService;
import util.Action;
import util.ActionForward;

public class QnaModifyFormAction implements Action {
	
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		 
		 	ActionForward forward = new ActionForward();
		 	String nowPage = request.getParameter("page");
			int qna_num=Integer.parseInt(request.getParameter("qna_num"));
			QnaDetailService qnaDetailService = new QnaDetailService();	
		   	QnaBean article = qnaDetailService.getArticle(qna_num);
		   	request.setAttribute("article", article);
		   	request.setAttribute("page", nowPage);
	   		forward.setPath("/view/qnaModify.jsp");
	   		return forward;
	   		
	 }
	 
}