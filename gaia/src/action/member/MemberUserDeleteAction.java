package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.auth.AuthBean;
import javaBean.member.MemberBean;
import service.member.MemberUserDeleteService;
import util.Action;
import util.ActionForward;

public class MemberUserDeleteAction implements Action {
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

		AuthBean authBean = (AuthBean)req.getSession(false).getAttribute("authUser");
		
		MemberUserDeleteService memberUserDeleteService = new MemberUserDeleteService();
		String mem_id = authBean.getMEM_ID();
		String mem_pw = memberUserDeleteService.getPW(mem_id);
		
		MemberBean memberBean = new MemberBean();
		memberBean.setMEM_ID(mem_id);
		memberBean.setMEM_PW(mem_pw);
		
		ActionForward forward = new ActionForward();
		req.setAttribute("memberBean", memberBean);
		forward.setPath("/view/memberUserDelete.jsp");
		return forward;
	}

}
