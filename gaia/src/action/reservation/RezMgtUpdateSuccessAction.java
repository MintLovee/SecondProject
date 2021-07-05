package action.reservation;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.reservation.ReservationBean;
import service.reservation.RezListService;
import service.reservation.RezMgtUpdateSuccessService;
import util.Action;
import util.ActionForward;
import util.MyCalendar;

public class RezMgtUpdateSuccessAction implements Action {
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ActionForward forward = null;
		ReservationBean reservationBean = new ReservationBean();
		
		String rez_num = req.getParameter("rezNum");
		String rezTel = req.getParameter("rez_tel");
		String rezPNum = req.getParameter("pNum");
		String inD = req.getParameter("rez_inDate");
		String outD = req.getParameter("rez_outDate");
		int iy = Integer.parseInt(inD.substring(0, 4));
		int im = Integer.parseInt(inD.substring(5, 7));
		int id = Integer.parseInt(inD.substring(8, 10));
		int oy = Integer.parseInt(outD.substring(0, 4));
		int om = Integer.parseInt(outD.substring(5, 7));
		int od = Integer.parseInt(outD.substring(8, 10));
		String rezInDate = MyCalendar.printDay2(iy, im, id);
		String rezOutDate = MyCalendar.printDay2(oy, om, od);
		int rezNum = Integer.parseInt(rez_num);
		reservationBean.setREZ_NUM(rezNum);
		reservationBean.setREZ_TEL(rezTel);
		reservationBean.setREZ_PNUM(rezPNum);
		reservationBean.setREZ_INDATE(rezInDate);
		reservationBean.setREZ_OUTDATE(rezOutDate);
		RezMgtUpdateSuccessService rezMgtUpdateSuccessService = new RezMgtUpdateSuccessService();
		boolean dateCheck = RezListService.rezCheck(rezPNum, rezInDate, rezOutDate);
		
		if (!dateCheck) {
			res.setContentType("text/html;charset=UTF-8");
			PrintWriter out = res.getWriter();
			out.println("<script>");
			out.println("alert('예약일정이 비어있지 않습니다. 일정을 확인하고 다시 수정해주세요.');");
			out.println("history.back();");
			out.println("</script>");
		} else {
			boolean rezMgtUpdateSuccess = rezMgtUpdateSuccessService.rezMgtUpdate(reservationBean);
			if (!rezMgtUpdateSuccess) {
				res.setContentType("text/html;charset=UTF-8");
				PrintWriter out = res.getWriter();
				out.println("<script>");
				out.println("alert('예약내용 수정에 실패하였습니다.');");
				out.println("history.back();");
				out.println("</script>");
			} else {
				forward = new ActionForward();
				forward.setPath("managePageRez.camp");
			}
		}
		return forward;
	 }
}
