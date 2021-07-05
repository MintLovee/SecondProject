package action.qna;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.qna.QnaDeleteProService;
import util.Action;
import util.ActionForward;

public class QnaDeleteProAction implements Action {

	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) 
			throws Exception{	 

		ActionForward forward = null;
		int qna_num=Integer.parseInt(request.getParameter("qna_num"));
		int qna_re_num=Integer.parseInt(request.getParameter("qna_re_num"));
		int qna_re_depth=Integer.parseInt(request.getParameter("qna_re_depth"));
		String nowPage = request.getParameter("page");
		//글번호 - 비밀번호 확인3, 답글 유무 확인
		QnaDeleteProService qnaDeleteProService = new QnaDeleteProService();

		boolean articleDel =qnaDeleteProService.isReplyWritten(qna_re_num, qna_re_depth);
		
		if(articleDel){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('답변이 등록된 글은 삭제할 수 없습니다');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		

		else{
			
			boolean isDeleteSuccess = qnaDeleteProService.removeArticle(qna_num);

			if(!isDeleteSuccess){
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('삭제 실패');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			}
			else{
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('삭제되었습니다.');");
				out.println("location.href='qnaList.camp?page="+ nowPage + "';");
				out.println("</script>");

			}
			
		}


		return forward;
	}

}