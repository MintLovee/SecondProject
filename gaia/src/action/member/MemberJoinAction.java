package action.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.member.MemberBean;
import service.member.MemberJoinService;
import util.Action;
import util.ActionForward;

public class MemberJoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		MemberBean dto = null;
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("ID");
		String pw = request.getParameter("PASSWORD");
		String cpw = request.getParameter("CONFIRMPWD");
		
		if(!pw.equals(cpw)) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('입력하신 비밀번호를 확인해주세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/view/joinForm.jsp");
			return null;
		}
		
		MemberJoinService svc = new MemberJoinService();
		int oldMember = svc.getMemberByLoginId(id);
		
		if(oldMember != 0) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('아이디가 중복되었습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		} else {
			dto = new MemberBean();
			dto.setMEM_ID(request.getParameter("ID"));
			dto.setMEM_PW(request.getParameter("PASSWORD"));
			dto.setMEM_NAME(request.getParameter("NAME"));
			dto.setMEM_ADDR(request.getParameter("ADDR"));
			String tel = (request.getParameter("TEL1")+"-"+request.getParameter("TEL2")+"-"+request.getParameter("TEL3"));
			dto.setMEM_TEL(tel);
			dto.setMEM_JUMIN(request.getParameter("JUMIN"));
			dto.setMEM_EMAIL(request.getParameter("EMAIL1") + "@" + (request.getParameter("EMAIL2")));
			dto.setMEM_NICKNAME(request.getParameter("NAME")+"("+ request.getParameter("TEL3") + ")");
		
			boolean isJoinSuccess = svc.join(dto);
			if (!isJoinSuccess) {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('회원가입에 실패하였습니다.')");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			} else {
				request.setAttribute("NAME", request.getParameter("NAME"));
				forward = new ActionForward();
				forward.setPath("/view/joinSuccess.jsp");
			}
		}
		return forward;
	}
}
