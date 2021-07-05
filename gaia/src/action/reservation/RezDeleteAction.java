package action.reservation;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.reservation.RezDeleteService;
import util.Action;
import util.ActionForward;

public class RezDeleteAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		String rezNum = request.getParameter("rez_num");
		int rez_num = Integer.parseInt(rezNum);
		
		RezDeleteService rezDeleteService = new RezDeleteService();
		boolean rezDeleteSuccess = rezDeleteService.rezDelete(rez_num);
		
		if (!rezDeleteSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('예약취소를 실패하였습니다.');");
			out.println("history.back();");
			out.println("<script>");
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('예약이 취소되었습니다.');");
			out.println("location.href='myPage.camp';");
			out.println("</script>");
		}
		return forward;
	}
}
