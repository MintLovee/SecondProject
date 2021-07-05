package action.product;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.product.ProductBean;
import service.product.proDetailViewService;
import util.Action;
import util.ActionForward;

public class proUpdateFormAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		String p_num = request.getParameter("P_NUM");
		
		proDetailViewService proDetail = new proDetailViewService();
		ProductBean probean = proDetail.showProduct(p_num);
		request.setAttribute("probean", probean);
		forward.setPath("/view/productUpdateForm.jsp");
		return forward;
	}
}
