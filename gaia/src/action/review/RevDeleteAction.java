package action.review;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.review.RevDeleteService;
import util.Action;
import util.ActionForward;

public class RevDeleteAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		String page = request.getParameter("page");
		int revNum = Integer.parseInt(request.getParameter("rev_num"));
		
		RevDeleteService revDeleteService = new RevDeleteService();
		revDeleteService.updateDelRevCheck(revNum);
		boolean isRemoveSuccess1 = revDeleteService.comDeleteArticle(revNum);
		
		if(isRemoveSuccess1){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('댓글이 등록된 글은 삭제할 수 없습니다');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		else{
			boolean isDeleteSuccess = revDeleteService.revDelete(revNum);
			if(!isDeleteSuccess){
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('삭제 실패');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			}
			else{
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('삭제되었습니다');");
				out.println("location.href='reviewList.camp?page="+ page + "';"); 
				out.println("</script>");
			}
		}
		return forward;
	}
}