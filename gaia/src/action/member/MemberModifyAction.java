package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.auth.AuthBean;
import javaBean.member.MemberBean;
import service.member.MemberUserUpdateService;
import util.Action;
import util.ActionForward;

public class MemberModifyAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		AuthBean authBean = (AuthBean) request.getSession(false).getAttribute("authUser");

		MemberUserUpdateService memberUserUpdateService = new MemberUserUpdateService();
		MemberBean memberInfo = memberUserUpdateService.getMemberInfo(authBean.getMEM_ID());

		request.setAttribute("memberInfo", memberInfo);
		ActionForward forward = new ActionForward();
		forward.setPath("/view/modifyForm.jsp");
		return forward;
	}
}