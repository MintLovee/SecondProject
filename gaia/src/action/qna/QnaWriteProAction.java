package action.qna;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.qna.QnaBean;
import service.qna.QnaWriteProService;
import util.Action;
import util.ActionForward;

public class QnaWriteProAction implements Action {
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ActionForward forward = null;
		QnaBean qnaBean = null;
		qnaBean = new QnaBean();
		qnaBean.setQNA_NAME(req.getParameter("QNA_NAME"));
		qnaBean.setQNA_ID(req.getParameter("QNA_ID"));
		qnaBean.setQNA_SUBJECT(req.getParameter("QNA_SUBJECT"));
		qnaBean.setQNA_CONTENT(req.getParameter("QNA_CONTENT"));
		qnaBean.setQNA_CATEGORY(req.getParameter("QNA_CATEGORY"));
		qnaBean.setQNA_SECRET(Integer.parseInt(req.getParameter("QNA_SECRET")));
		
		QnaWriteProService qnaWriteProService = new QnaWriteProService();
		boolean isWriteSuccess = qnaWriteProService.registArticle(qnaBean);
		
		if (!isWriteSuccess) {
			res.setContentType("text/html;charset=UTF-8");
			PrintWriter out = res.getWriter();
			out.println("<script>");
			out.println("alert('등록 실패');");
			out.println("history.back();");
			out.println("</script>");
		} else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("qnaList.camp");
		}
		return forward;
	}
}
