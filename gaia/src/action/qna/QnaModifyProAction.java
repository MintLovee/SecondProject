package action.qna;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.qna.QnaBean;
import service.qna.QnaModifyProService;
import util.Action;
import util.ActionForward;

public class QnaModifyProAction implements Action {

	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) 
			throws Exception{

		ActionForward forward = null;
		String nowPage = request.getParameter("page");
		boolean isModifySuccess = false;
		int qna_num=Integer.parseInt(request.getParameter("QNA_NUM"));
		QnaBean article=new QnaBean();
		QnaModifyProService qnaModifyProService = new QnaModifyProService();

			
			
		article.setQNA_NUM(qna_num);
		article.setQNA_SUBJECT(request.getParameter("QNA_SUBJECT"));
		article.setQNA_CONTENT(request.getParameter("QNA_CONTENT"));
		article.setQNA_CATEGORY(request.getParameter("QNA_CATEGORY"));
		article.setQNA_SECRET(Integer.parseInt(request.getParameter("QNA_SECRET")));
		article.setQNA_RE_NUM(Integer.parseInt(request.getParameter("QNA_RE_NUM"))); 
		isModifySuccess = qnaModifyProService.modifyArticle(article);

		if(!isModifySuccess){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('수정 실패');");
			out.println("history.back()");
			out.println("</script>");
		}
		else{
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("qnaDetail.camp?qna_num="+article.getQNA_NUM()+"&page="+nowPage); 
		}


		return forward;
	}

}