package action.notice;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.notice.NoticeBean;
import service.notice.NoticeUpdateService;
import util.Action;
import util.ActionForward;

public class NoticeUpdateAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		String nowPage = request.getParameter("page");
		int notice_num = Integer.parseInt(request.getParameter("NOTICE_NUM"));
		
		NoticeBean detailNotice = new NoticeBean();
		detailNotice.setNOTICE_NUM(notice_num);
		detailNotice.setNOTICE_TITLE(request.getParameter("NOTICE_TITLE"));
		detailNotice.setNOTICE_CONTENT(request.getParameter("NOTICE_CONTENT"));
		
		NoticeUpdateService noticeUpdateService = new NoticeUpdateService();
		boolean isUpdateSuccess = false;
		isUpdateSuccess = noticeUpdateService.updateNotice(detailNotice);
		
		if (!isUpdateSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('공지사항 수정에 실패하였습니다.');");
			out.println("history.back()");
			out.println("</script>");
		} else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("noticeDetail.camp?notice_num="+detailNotice.getNOTICE_NUM()+"&page="+nowPage); 
		}
		return forward;
	}
}