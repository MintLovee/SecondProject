package action.manage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.reservation.ReservationListBean;
import service.reservation.RezMgtListService;
import util.Action;
import util.ActionForward;
import util.PageInfo;

public class ManagePageRezAction implements Action {
	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		ArrayList<ReservationListBean> rezList = new ArrayList<ReservationListBean>();
		int page = 1;
		int limit = 10;
		String fieldName = "rez_num";
		String searchWord = "";
		 
		if(request.getParameter("page")!=null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		if(request.getParameter("fieldName")!=null) {
			fieldName=request.getParameter("fieldName");
		}
		if(request.getParameter("searchWord")!=null) {
			searchWord=request.getParameter("searchWord");
		}
		
		RezMgtListService rezMgtListService = new RezMgtListService();
		
		int listCount = rezMgtListService.getListCount(fieldName, searchWord);
		rezList = rezMgtListService.getRezList(page, limit, fieldName, searchWord);
		
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
		request.setAttribute("rezList", rezList);
		ActionForward forward= new ActionForward();
   		forward.setPath("/view/managePageRez.jsp");
   		return forward;
	}
}
