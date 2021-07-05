package action.notice;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.notice.NoticeBean;
import service.notice.NoticeWriteService;
import util.Action;
import util.ActionForward;

public class NoticeWriteAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		NoticeBean noticeBean = new NoticeBean();
		
		noticeBean.setNOTICE_NAME(request.getParameter("NOTICE_NAME"));
		noticeBean.setNOTICE_TITLE(request.getParameter("NOTICE_TITLE"));
		noticeBean.setNOTICE_CONTENT(request.getParameter("NOTICE_CONTENT"));
		
		NoticeWriteService noticeWriteService = new NoticeWriteService();
		boolean isWriteSuccess = noticeWriteService.insertNotice(noticeBean);
		
		if (!isWriteSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('공지사항 등록에 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
		} else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("noticeList.camp");
		}
		return forward;
	}
}
