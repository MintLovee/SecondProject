package action.auth;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.auth.AuthBean;
import service.auth.LoginService;
import util.Action;
import util.ActionForward;

public class LoginAction implements Action {
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception {

		 String id = trim(request.getParameter("id"));
		 String password = trim(request.getParameter("password"));
		 String referer = request.getParameter("referer");

		 
		 if(referer != null && referer.contains("/")) {
			 referer = referer.replace("/", "");
		 }
		 
		 if(referer.isEmpty()) {
			 referer = request.getContextPath();
		 }
		 
		 System.out.println(request.getParameter("referer"));
		 System.out.println(referer);

		 Map<String, Boolean> errors = new HashMap<>();
		 request.setAttribute("errors", errors);
		 
		 try {
 			 LoginService loginService = new LoginService();
			 AuthBean authBean = loginService.login(id, password);
			 
			 
			 ActionForward forward = new ActionForward();
			 if (authBean.getMEM_ID().equals("admin")) {
				 request.getSession().setAttribute("authUser", authBean);
				 forward.setPath("managePageRez.camp");
				 forward.setRedirect(true);
			 } else {
				 request.getSession().setAttribute("authUser", authBean);
				 forward.setPath(referer);
				 forward.setRedirect(true);
			 }
			 return forward;
			 
		} catch (Exception e) {
			errors.put("idOrPwNotMatch", Boolean.TRUE);
			ActionForward forward = new ActionForward();
			forward.setPath("login.camp");
			return forward;
		}
	}
	 
	 private String trim(String str) {
		return str == null ? null : str.trim();
	}
}
