package action.member;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.member.MemberBean;
import service.member.MemberUpdateService;
import util.Action;
import util.ActionForward;


public class MemberUpdateFormAction implements Action {
	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		ActionForward forward = new ActionForward();
		MemberBean memberInfo = null;
		String id = request.getParameter("rezNumA");
		MemberUpdateService memberUpdateService = new MemberUpdateService();
		memberInfo = memberUpdateService.getmemberInfo(id);
		

		request.setAttribute("memberInfo", memberInfo);
		forward = new ActionForward();
		forward.setPath("/view/memberUpdateForm.jsp");
		return forward;
	}
}
