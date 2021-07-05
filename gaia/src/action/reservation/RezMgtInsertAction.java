package action.reservation;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.reservation.ReservationBean;
import service.reservation.RezListService;
import service.reservation.RezMgtInsertService;
import util.Action;
import util.ActionForward;
import util.MyCalendar;

public class RezMgtInsertAction implements Action {
	public ActionForward execute(HttpServletRequest req,HttpServletResponse res) throws Exception{
		ActionForward forward = null;
		ReservationBean rezBean = null;
		String tel = req.getParameter("REZ_TEL2");
		String nickName = req.getParameter("REZ_NAME2") + "(" + tel.substring(tel.length()-4, tel.length()) + ")";
		String inD = req.getParameter("REZ_INDATE");
		String outD = req.getParameter("REZ_OUTDATE");
		int iy = Integer.parseInt(inD.substring(0, 4));
		int im = Integer.parseInt(inD.substring(5, 7));
		int id = Integer.parseInt(inD.substring(8, 10));
		int oy = Integer.parseInt(outD.substring(0, 4));
		int om = Integer.parseInt(outD.substring(5, 7));
		int od = Integer.parseInt(outD.substring(8, 10));
		String pNum = req.getParameter("pNum");
		String inDate = MyCalendar.printDay2(iy, im, id);
		String outDate = MyCalendar.printDay2(oy, om, od);
		int diifDays = outDate.compareTo(inDate);
		int total = Integer.parseInt(req.getParameter("REZ_PRICE")) * diifDays;
		rezBean = new ReservationBean();
		rezBean.setREZ_ID(req.getParameter("REZ_ID"));
		rezBean.setREZ_NICKNAME(nickName);
		rezBean.setREZ_TEL(req.getParameter("REZ_TEL2"));
		rezBean.setREZ_PNUM(req.getParameter("pNum"));
		rezBean.setREZ_INDATE(req.getParameter("REZ_INDATE"));
		rezBean.setREZ_OUTDATE(req.getParameter("REZ_OUTDATE"));
		rezBean.setREZ_TOTAL(total);
		RezMgtInsertService rezInsertService = new RezMgtInsertService();
		boolean dateCheck = RezListService.rezCheck(pNum, inDate, outDate);
		
		if (!dateCheck) {
			res.setContentType("text/html;charset=UTF-8");
			PrintWriter out = res.getWriter();
			out.println("<script>");
			out.println("alert('예약일정이 비어있지 않습니다. 일정을 확인하고 다시 추가해주세요.');");
			out.println("history.back();");
			out.println("</script>");
		} else {
			boolean isInsertSuccess = rezInsertService.insertMgt(rezBean);
			if (!isInsertSuccess) {
				res.setContentType("text/html;charset=UTF-8");
				PrintWriter out = res.getWriter();
				out.println("<script>");
				out.println("alert('예약에 실패하였습니다.');");
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
