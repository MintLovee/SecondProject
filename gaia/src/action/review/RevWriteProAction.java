package action.review;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javaBean.review.ReviewBean;
import service.review.RevWriteProService;
import util.Action;
import util.ActionForward;

public class RevWriteProAction implements Action {

	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{

		ActionForward forward=null;
		ReviewBean reviewBean = null;
		String realFolder="";
		String saveFolder="upload";
		String encType = "utf-8";
		int fileSize=5*1024*1024;
		ServletContext context = request.getServletContext();
		realFolder=context.getRealPath(saveFolder);   		
		MultipartRequest multi=new MultipartRequest(request, realFolder, fileSize, encType,new DefaultFileRenamePolicy());
		String[] aVal = multi.getParameter("REV_SITE").split(",");
		reviewBean = new ReviewBean();
		reviewBean.setREV_NAME(multi.getParameter("REV_NAME"));
		reviewBean.setREV_ID(multi.getParameter("REV_ID"));
		reviewBean.setREV_OPTION(aVal[1]);
		reviewBean.setREV_SUBJECT(multi.getParameter("REV_SUBJECT"));
		reviewBean.setREV_CONTENT(multi.getParameter("REV_CONTENT"));
		if (multi.getOriginalFileName((String)multi.getFileNames().nextElement())==null)
			reviewBean.setREV_FILE(multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
		else reviewBean.setREV_FILE("/gaia/upload/"+multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
		
		String rezNum = aVal[0];
		RevWriteProService revWriteProService = new RevWriteProService();
		boolean isWriteSuccess = revWriteProService.revistArticle(reviewBean);
		int newReviewNum = revWriteProService.selectNewReviewNum(reviewBean);
		revWriteProService.revCheck(rezNum, newReviewNum);

		if(!isWriteSuccess){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('등록실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		else{
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("reviewList.camp");
		}
		return forward;
	}  	
}