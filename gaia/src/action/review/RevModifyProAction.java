package action.review;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.review.ReviewBean;
import service.review.RevModifyProService;
import util.Action;
import util.ActionForward;

public class RevModifyProAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = null;
		String nowPage = request.getParameter("page");
		System.out.println("page:" +nowPage);
		int rev_num = Integer.parseInt(request.getParameter("REV_NUM"));

		ReviewBean article = new ReviewBean();
		article.setREV_NUM(rev_num);
		article.setREV_NAME(request.getParameter("REV_NAME"));
		article.setREV_OPTION(request.getParameter("REV_OPTION"));
		article.setREV_SUBJECT(request.getParameter("REV_SUBJECT"));
		article.setREV_CONTENT(request.getParameter("REV_CONTENT"));
		
		RevModifyProService revModifyProService = new RevModifyProService();
		boolean isModifySuccess = false;
		isModifySuccess = revModifyProService.modifyArticle(article);

		if (!isModifySuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('리뷰 수정에 실패하였습니다.');");
			out.println("history.back()");
			out.println("</script>");
		} else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("reviewDetail.camp?rev_num="+article.getREV_NUM()+"&page="+nowPage);
		}
		return forward;
	}
}