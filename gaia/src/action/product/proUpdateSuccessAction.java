package action.product;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javaBean.product.ProductBean;
import service.product.proUpdateService;
import util.Action;
import util.ActionForward;

public class proUpdateSuccessAction implements Action {
public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		ActionForward forward =null;
		boolean  updateSuccess = false;
		ProductBean probean = new ProductBean();
		proUpdateService updateServ = new proUpdateService();
		
		String realFolder="";
		String saveFolder="images";
		String encType = "utf-8";
		int fileSize=5*1024*1024;
		ServletContext context = request.getServletContext();
		realFolder=context.getRealPath(saveFolder);   
		MultipartRequest multi=new MultipartRequest(request, realFolder, fileSize, encType,new DefaultFileRenamePolicy());
		
		
		probean.setP_NUM(multi.getParameter("P_NUM"));
		probean.setP_NAME(multi.getParameter("P_NAME"));
		probean.setP_PRICE(Integer.parseInt(multi.getParameter("P_PRICE")));
		probean.setP_SERVICE("최대"+multi.getParameter("P_SERVICE")+"인까지 이용 가능합니다.");
		probean.setP_NOTES(multi.getParameter("P_NOTES"));
		probean.setP_MORE_INFO(multi.getParameter("P_MORE_INFO"));
		probean.setP_IMG("/gaia/images/"+multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
		
		updateSuccess = updateServ.UpdateSuccess(probean);
		if(!updateSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.println("<script>");
			out.println("alert('수정 실패');");
			out.println("document.location.href='managePagePro.camp';");
			out.println("</script>");
			out.close();
		}else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.println("<script>");
			out.println("alert('수정 성공!');");
			out.println("document.location.href='managePagePro.camp';");
			out.println("</script>");
		}
		return forward;
	}
}
