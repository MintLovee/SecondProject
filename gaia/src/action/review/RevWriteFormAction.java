package action.review;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.auth.AuthBean;
import javaBean.review.ReviewWriteBean;
import service.review.RevWriteFormService;
import util.Action;
import util.ActionForward;

public class RevWriteFormAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		AuthBean authBean = (AuthBean)request.getSession(false).getAttribute("authUser");
		String id = authBean.getMEM_ID();
		ArrayList<ReviewWriteBean> reviewWriteList = new ArrayList<ReviewWriteBean>();
		RevWriteFormService rezWriteFormService = new RevWriteFormService();
		reviewWriteList = rezWriteFormService.getReservationList(id);
		
		if (reviewWriteList.isEmpty()) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('리뷰작성은 캠핑을 이용한 후에 작성가능합니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		request.setAttribute("reviewWriteList", reviewWriteList);
		ActionForward forward = new ActionForward();
		forward.setPath("/view/reviewWrite.jsp");
		return forward;	
	}
}