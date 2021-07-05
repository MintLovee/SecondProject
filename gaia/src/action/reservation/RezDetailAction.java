package action.reservation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.product.ProductBean;
import javaBean.reservation.InfoUseBean;
import service.reservation.RezDetailService;
import util.Action;
import util.ActionForward;

public class RezDetailAction implements Action {
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception { 
		
		String p_num = request.getParameter("p_num");
		String diffDays = request.getParameter("diffDays");
		int diff = Integer.parseInt((diffDays).trim());
		
		RezDetailService rezDetailService = new RezDetailService();
		int price = rezDetailService.getPrice(p_num);
		
		ProductBean productInfo = rezDetailService.getProductInfo(p_num);
		InfoUseBean infoUse = rezDetailService.getInfoUse(p_num, diff, price);
		ActionForward forward = new ActionForward();
		request.setAttribute("productInfo", productInfo);
	   	request.setAttribute("infoUse", infoUse);
  		forward.setPath("/view/rezDetail.jsp");
  		return forward;
	 }
}