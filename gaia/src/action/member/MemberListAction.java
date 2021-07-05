package action.member;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.member.MemberBean;
import service.member.MemberListService;
import util.Action;
import util.ActionForward;
import util.PageInfo;


public class MemberListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
		int page = 1;
		int limit = 10;

		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		MemberListService memberListService = new MemberListService();
		int listCount = memberListService.getListCount();
		memberList = memberListService.getMemberList(page, limit);
		int maxPage = (int) ((double) listCount / limit + 0.95);
		int startPage = ((int) ((double) page / 10 + 0.9) - 1) * 10 + 1;
		int endPage = startPage + 10 - 1;

		if (endPage > maxPage)
			endPage = maxPage;

		PageInfo pageInfo = new PageInfo();
		pageInfo.setPage(page);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);

		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("memberList", memberList);
		ActionForward forward = new ActionForward();
		forward.setPath("/view/memberList.jsp");
		return forward;

	}

}