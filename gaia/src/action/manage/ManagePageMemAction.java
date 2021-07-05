package action.manage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.member.MemberBean;
import service.member.MemberListService;
import util.Action;
import util.ActionForward;
import util.PageInfo;


public class ManagePageMemAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
		int page = 1;
		int limit = 10;
		String fieldName = "mem_id";
		String searchWord = "";
		String show = "";
		if (request.getParameter("show") != null) {
			show = request.getParameter("show");
		}
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		if(request.getParameter("fieldName")!=null) {
			fieldName=request.getParameter("fieldName");
		}
		if(request.getParameter("searchWord")!=null) {
			searchWord=request.getParameter("searchWord");
		}
		
		MemberListService memberListService = new MemberListService();
		int listCount = memberListService.getListCount(fieldName, searchWord);
		if (show.equals("newShow")) {
			memberList = memberListService.getNewMemberList(page, limit);
		} else {
			memberList = memberListService.getMemberList(page, limit, fieldName, searchWord);
		}
		
		
		
		int maxPage = listCount / limit;
   		if (listCount % limit > 0) {
   		    maxPage++;
   		}
   		if (maxPage < page) {
   		    page = maxPage;
   		}
		
   		int startPage = ((int) ((double)page / 10 + 0.9) - 1) * 10 + 1;
   	    int endPage = startPage + 10 - 1;
   		if (endPage > maxPage) endPage = maxPage;

		PageInfo pageInfo = new PageInfo();
		pageInfo.setPage(page);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);

		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("memberList", memberList);
		ActionForward forward = new ActionForward();
		forward.setPath("/view/managePageMem.jsp");
		return forward;

	}

}