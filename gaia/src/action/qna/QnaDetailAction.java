package action.qna;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.qna.QnaBean;
import service.qna.QnaDeleteProService;
import service.qna.QnaDetailService;
import util.Action;
import util.ActionForward;

 public class QnaDetailAction implements Action {
	 
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{ 
	   	
		int qna_num=Integer.parseInt(request.getParameter("qna_num"));
		String page = request.getParameter("page");
		QnaDetailService qnaDetailService = new QnaDetailService();
		QnaBean article = qnaDetailService.getArticle(qna_num);
		ActionForward forward = new ActionForward();
		request.setAttribute("page", page);
		request.setAttribute("article", article);
		int qna_re_num=article.getQNA_RE_NUM();
		int qna_re_depth=article.getQNA_RE_DEPTH();
		QnaDeleteProService qnaDeleteProService = new QnaDeleteProService();
		boolean articleDel =qnaDeleteProService.isReplyWritten(qna_re_num, qna_re_depth);
		request.setAttribute("isreply", articleDel);
	   	forward.setPath("/view/qnaDetail.jsp");
	   	return forward;

	 }
	 
}