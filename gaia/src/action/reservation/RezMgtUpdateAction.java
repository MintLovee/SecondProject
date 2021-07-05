package action.reservation;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.product.ProductBean;
import javaBean.reservation.ReservationListBean;
import service.reservation.RezMgtUpdateService;
import util.Action;
import util.ActionForward;

public class RezMgtUpdateAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String rezNum = request.getParameter("rezNumA");
		String pNum = request.getParameter("pNum");
		String pNumPrice = "";
		switch (pNum.substring(0, 1)) {
		case "A":  pNumPrice = pNum + ",120000";
			break;
		case "B":  pNumPrice = pNum + ",50000";
			break;
		case "C":  pNumPrice = pNum + ",50000";
        	break;
		}
		System.out.println(pNumPrice);
		int rez_num = Integer.parseInt(rezNum);
		 ArrayList<ProductBean> productList = new ArrayList<ProductBean>();
		RezMgtUpdateService rezMgtUpdateService = new RezMgtUpdateService();
		ReservationListBean rezListOne = rezMgtUpdateService.getRezListOne(rez_num);
		productList = rezMgtUpdateService.getProductList();
		
		request.setAttribute("pNumPrice", pNumPrice);
		request.setAttribute("rezListOne", rezListOne);
		request.setAttribute("productList", productList);
		ActionForward forward = new ActionForward();
		forward.setPath("/view/rezMgtUpdateForm.jsp");
		return forward;
	}
}
