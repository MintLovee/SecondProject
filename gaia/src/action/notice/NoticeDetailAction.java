package action.notice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.notice.NoticeBean;
import service.notice.NoticeDetailService;
import util.Action;
import util.ActionForward;

public class NoticeDetailAction implements Action {
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{ 
		 
		 int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		 String page = request.getParameter("page");
		 
		 NoticeDetailService noticeDetailService = new NoticeDetailService();
		 NoticeBean detailNotice = noticeDetailService.getDetailNotice(notice_num);
		 
		 ActionForward forward = new ActionForward();
		 request.setAttribute("page", page);
		 request.setAttribute("detailNotice", detailNotice);
		 forward.setPath("/view/noticeDetail.jsp");
		 return forward;
	 }
}
