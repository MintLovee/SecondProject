package action.notice;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.notice.NoticeBean;
import service.notice.NoticeListService;
import util.Action;
import util.ActionForward;
import util.PageInfo;

public class NoticeListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<NoticeBean> noticeList = new ArrayList<NoticeBean>();
		int page = 1;
		int limit = 10;
		String fieldName = "notice_title";
		String searchWord = "";

		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		if (request.getParameter("fieldName") != null) {
			fieldName = request.getParameter("fieldName");
		}
		if (request.getParameter("searchWord") != null) {
			searchWord = request.getParameter("searchWord");
		}

		NoticeListService noticeListService = new NoticeListService();

		int listCount = noticeListService.getListCount(fieldName, searchWord);
		noticeList = noticeListService.getNoticeList(page, limit, fieldName, searchWord);

		int maxPage = listCount / limit;
		if (listCount % limit > 0) {
			maxPage++;
		}
		if (maxPage < page) {
			page = maxPage;
		}

		int startPage = ((int) ((double) page / 10 + 0.9) - 1) * 10 + 1;
		int endPage = startPage + 10 - 1;
		if (endPage > maxPage) endPage = maxPage;

		PageInfo pageInfo = new PageInfo();
		pageInfo.setPage(page);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("noticeList", noticeList);
		ActionForward forward= new ActionForward();
   		forward.setPath("/view/noticeList.jsp");
   		return forward;
	 }
 }