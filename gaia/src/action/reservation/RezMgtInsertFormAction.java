package action.reservation;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.member.MemberBean;
import javaBean.product.ProductBean;
import service.reservation.RezMgtInsertFormService;
import util.Action;
import util.ActionForward;

public class RezMgtInsertFormAction implements Action {
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		 ArrayList<ProductBean> productList = new ArrayList<ProductBean>();
		 MemberBean memNameTel = new MemberBean();
		 memNameTel = null;
		 String reloadID = "";
		 String reloadPnum = "";
		 String reloadPrice = "";
		 String reloadInDate = "";
		 String reloadOutDate = "";
		 String memName = "";
		 String memTel = "";
		 RezMgtInsertFormService rezMgtInsertFormService = new RezMgtInsertFormService();
		 if (request.getParameter("REZ_ID") != null && request.getParameter("REZ_ID") != "") {
			 reloadID = request.getParameter("REZ_ID");
			 reloadPnum = request.getParameter("pSite");
			 reloadPrice = request.getParameter("REZ_PRICE");
			 reloadInDate = request.getParameter("REZ_INDATE");
			 reloadOutDate = request.getParameter("REZ_OUTDATE");
			 memNameTel = rezMgtInsertFormService.searchID(request.getParameter("REZ_ID"));
			 if (memNameTel != null) {
				 memName = memNameTel.getMEM_NAME();
				 memTel = memNameTel.getMEM_TEL();
			 }
		 }
		 productList = rezMgtInsertFormService.getProductList();
		 
		 request.setAttribute("reloadID", reloadID);
		 request.setAttribute("reloadPnum", reloadPnum);
		 request.setAttribute("reloadPrice", reloadPrice);
		 request.setAttribute("reloadInDate", reloadInDate);
		 request.setAttribute("reloadOutDate", reloadOutDate);
		 request.setAttribute("memName", memName);
		 request.setAttribute("memTel", memTel);
		 request.setAttribute("productList", productList);
		 ActionForward forward = new ActionForward();
		 forward.setPath("/view/rezMgtInsertForm.jsp");
		 return forward;
	 }
}
