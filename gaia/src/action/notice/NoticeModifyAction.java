package action.notice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.notice.NoticeBean;
import service.notice.NoticeDetailService;
import util.Action;
import util.ActionForward;

public class NoticeModifyAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String nowPage = request.getParameter("page");
		int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		
		NoticeDetailService noticeDetailService = new NoticeDetailService();
		NoticeBean detailNotice = noticeDetailService.getDetailNotice(notice_num);
		
		ActionForward forward = new ActionForward();
		request.setAttribute("detailNotice", detailNotice);
		request.setAttribute("page", nowPage);
		forward.setPath("/view/noticeModifyForm.jsp");
		return forward;
	}
}
