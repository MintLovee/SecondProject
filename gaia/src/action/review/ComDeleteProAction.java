package action.review;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.review.ComDeleteProService;
import util.Action;
import util.ActionForward;

	public class ComDeleteProAction implements Action {
		public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			ActionForward forward = null;
			int re_num = Integer.parseInt(request.getParameter("re_num"));
			int rev_num = Integer.parseInt(request.getParameter("rev_num"));
			String nowPage = request.getParameter("page");
			ComDeleteProService comDeleteProService = new ComDeleteProService();
			boolean isDeleteSuccess = comDeleteProService.removeArticle(re_num);
			
			
			if(!isDeleteSuccess) {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert(삭제 실패);");
				out.println("history.back();");
				out.println("</script>");
			}else {
				comDeleteProService.updateCom(rev_num);
				forward = new ActionForward();
				forward.setRedirect(true);
				forward.setPath("reviewDetail.camp?rev_num=" + rev_num + "&page=" + nowPage);
			}
			return forward;
		}
	}		
