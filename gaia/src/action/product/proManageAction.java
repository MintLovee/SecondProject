package action.product;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.product.ProductBean;
import service.product.productAllViewService;
import util.Action;
import util.ActionForward;

public class proManageAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<ProductBean> productList = new ArrayList<ProductBean>();
		productAllViewService crvService = new productAllViewService();
		ActionForward forward = new ActionForward();
		productList = crvService.getProduct();
		request.setAttribute("productList", productList);
		forward.setPath("/view/proManage.jsp");
		return forward;
	
	}
}
