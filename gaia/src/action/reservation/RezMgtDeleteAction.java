package action.reservation;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.reservation.RezMgtDeleteService;
import util.Action;
import util.ActionForward;

public class RezMgtDeleteAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		ActionForward forward = null;
		String rezNum = request.getParameter("rezNumB");
		int rez_num = Integer.parseInt(rezNum);
		
		RezMgtDeleteService rezMgtDeleteService = new RezMgtDeleteService();
		boolean rezMgtDeleteSuccess = rezMgtDeleteService.rezMgtDelete(rez_num);
		
		if (!rezMgtDeleteSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('예약내용 삭제를 실패하였습니다.');");
			out.println("history.back();");
			out.println("<script>");
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('삭제하였습니다.');");
			out.println("location.href='managePageRez.camp'");
			out.println("</script>");
		}
		return forward;
	}
}
