package action.notice;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.notice.NoticeDeleteService;
import util.Action;
import util.ActionForward;

public class NoticeDeleteAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		String nowPage = request.getParameter("page");
		int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		
		NoticeDeleteService noticeDeleteService = new NoticeDeleteService();
		boolean isDeleteSuccess = false;
		isDeleteSuccess = noticeDeleteService.deleteNotice(notice_num);
		
		if (!isDeleteSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('공지사항 삭제에 실패하였습니다.');");
			out.println("history.back()");
			out.println("</script>");
		} else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("noticeList.camp?page="+nowPage); 
		}
		return forward;
	}
}