package action.reservation;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.auth.AuthBean;
import javaBean.product.ProductBean;
import javaBean.reservation.ReservationBean;
import service.reservation.RezOkService;
import util.Action;
import util.ActionForward;

public class RezOkAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ActionForward forward = null;
		ReservationBean reservationBean = new ReservationBean();
		
		AuthBean authBean = (AuthBean)request.getSession(false).getAttribute("authUser");
		String p_num = request.getParameter("p_num");
		String diff = request.getParameter("diffDays");
		int diffDays = Integer.parseInt((diff).trim());
		
		reservationBean.setREZ_PNUM(p_num);
		reservationBean.setREZ_INDATE(request.getParameter("inDate"));
		reservationBean.setREZ_OUTDATE(request.getParameter("outDate"));
		
		RezOkService rezOkService = new RezOkService();
		ProductBean productBean = rezOkService.getPrice(p_num);
		boolean reservation = rezOkService.setReservation(authBean, reservationBean, productBean.getP_PRICE(), diffDays);
		
		if (!reservation) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('예약은 로그인 후 가능합니다.');");
			out.println("history.back();");
			out.println("</script>");
		} else {
			reservationBean = rezOkService.getReservationInfo(authBean.getMEM_NICKNAME());
			request.setAttribute("reservationInfo", reservationBean);
			forward = new ActionForward();
			forward.setPath("/view/rezOk.jsp");
		}
		return forward;
	 }
}