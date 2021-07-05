package action.qna;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.qna.QnaBean;
import service.qna.QnaDetailService;
import util.Action;
import util.ActionForward;

public class QnaDeleteFormAction implements Action {
	
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{

			String nowPage = request.getParameter("page");
			request.setAttribute("page", nowPage);
			int qna_num = Integer.parseInt(request.getParameter("qna_num"));
			request.setAttribute("qna_num", qna_num);
			ActionForward forward = new ActionForward();
			forward.setPath("/view/qnaDelete.jsp");
		 
		 	
		 	
			
			QnaDetailService qnaDetailService = new QnaDetailService();	
		   	QnaBean article = qnaDetailService.getArticle(qna_num);
		   	request.setAttribute("article", article);
		   	int qna_re_num = article.getQNA_RE_NUM();
		   	request.setAttribute("qna_re_num", qna_re_num);
	   		return forward;
	   		
	 }
	 
}