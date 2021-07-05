package action.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.member.MemberBean;
import service.member.MemberInsertService;
import util.Action;
import util.ActionForward;

public class MemberInsertAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	
		MemberBean dto =null;
		ActionForward forward = null;
			
		dto = new MemberBean();
		dto.setMEM_ID(request.getParameter("ID"));
		dto.setMEM_PW(request.getParameter("PASSWORD"));
		dto.setMEM_NAME(request.getParameter("NAME"));
		dto.setMEM_ADDR(request.getParameter("ADDR"));
		dto.setMEM_TEL(request.getParameter("TEL"));
		dto.setMEM_JUMIN(request.getParameter("JUMIN"));
		dto.setMEM_EMAIL(request.getParameter("EMAIL1") + "@" + (request.getParameter("EMAIL2")));
		dto.setMEM_NICKNAME(request.getParameter("NAME")+"("+ request.getParameter("TEL").substring(9, 13) + ")");
		
		MemberInsertService memberInsertService = new MemberInsertService();

		boolean InsertSuccess = memberInsertService.insertMember(dto);
		if(!InsertSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.println("<script>");
			out.println("alert('등록실패');");
			out.println("document.location.href='memberList.camp';");
			out.println("</script>");
		}else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("memberList.camp");
		}
		return forward;
	}
}