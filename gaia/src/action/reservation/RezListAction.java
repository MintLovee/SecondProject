package action.reservation;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.product.ProductBean;
import javaBean.reservation.ReservationBean;
import service.reservation.RezListService;
import util.Action;
import util.ActionForward;

public class RezListAction implements Action {
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		 ArrayList<ProductBean> productList = new ArrayList<ProductBean>();
		 ArrayList<ReservationBean> rezList = new ArrayList<ReservationBean>();
		 RezListService rezListService = new RezListService();
		 productList = rezListService.getProductList();
		 rezList = rezListService.getRezList();
		 
		 request.setAttribute("productList", productList);
		 request.setAttribute("rezList", rezList);
		 ActionForward forward = new ActionForward();
		 forward.setPath("/view/rezList.jsp");
		 return forward;
	 }
}