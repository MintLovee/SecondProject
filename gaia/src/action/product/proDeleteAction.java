package action.product;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.product.proDeleteService;
import util.Action;
import util.ActionForward;
public class proDeleteAction  implements Action{

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		String p_num = request.getParameter("P_NUM");
		proDeleteService proDelete = new proDeleteService();
		boolean isDelete = proDelete.deleteProduct(p_num);
		
		if(!isDelete) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.println("<script>");
			out.println("alert('삭제실패했습니다.');");
			out.println("document.location.href='managePagePro.camp';");
			out.println("</script>");
			out.close();
		}
		else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.println("<script>");
			out.println("document.location.href='managePagePro.camp';");
			out.println("</script>");
		}
	
		return forward;
	}
}

