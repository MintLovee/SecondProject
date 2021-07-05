package action.product;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.product.ProductBean;
import service.product.crvDetailViewService;
import util.Action;
import util.ActionForward;

public class graDetailAction implements Action{
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			String name = request.getParameter("name");
			crvDetailViewService crvService = new crvDetailViewService();
			ProductBean proBean = crvService.getProduct(name);
			ActionForward forward = new ActionForward();
			request.setAttribute("proBean", proBean);
			forward.setPath("/view/proGRA.jsp");
			return forward;
		
		
	}
}
