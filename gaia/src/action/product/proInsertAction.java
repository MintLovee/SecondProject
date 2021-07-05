package action.product;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javaBean.product.ProductBean;
import service.product.proInsertService;
import util.Action;
import util.ActionForward;

public class proInsertAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	
		ProductBean proBean =null;
		ActionForward forward = null;	
		String realFolder="";
		String saveFolder="images";
		String encType = "utf-8";
		int fileSize=5*1024*1024;
		ServletContext context = request.getServletContext();
		realFolder=context.getRealPath(saveFolder);   
		MultipartRequest multi=new MultipartRequest(request, realFolder, fileSize, encType,new DefaultFileRenamePolicy());
		
		
		proBean = new ProductBean();
		proBean.setP_NUM(multi.getParameter("P_NUM"));
		proBean.setP_NAME(multi.getParameter("P_NAME"));
		proBean.setP_PRICE(Integer.parseInt(multi.getParameter("P_PRICE")));
		proBean.setP_SERVICE("최대 "+multi.getParameter("P_SERVICE")+"인까지 이용 가능합니다.");
		proBean.setP_NOTES(multi.getParameter("P_NOTES"));
		proBean.setP_MORE_INFO(multi.getParameter("P_MORE_INFO"));
		proBean.setP_IMG("/gaia/images/"+multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
		proInsertService proInsertService = new proInsertService();
	//	ProductBean productBean = proInsertService.insertProduct(num, name, price, service, notes, moreInfo, img);
		
		boolean InsertSuccess = proInsertService.insertProduct(proBean);
		if(!InsertSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.println("<script>");
			out.println("alert('등록 실패!');");
			out.println("document.location.href='managePagePro.camp';");
			out.println("</script>");
		}else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.println("<script>");
			out.println("alert('등록 성공!');");
			out.println("document.location.href='managePagePro.camp';");
			out.println("</script>");
		}
		return forward;
	}
}
