package action.auth;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.Action;
import util.ActionForward;


public class LogoutAction implements Action {
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception {
		 
			HttpSession session = request.getSession(false);
			if(session != null) {
				session.invalidate();
			}
			response.sendRedirect(request.getContextPath());
			return null;
	
	 }

}
