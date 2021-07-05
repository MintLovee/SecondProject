package action.member;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.review.CommentBean;
import service.member.MemberDeleteService;
import service.member.memberUserDeleteProService;
import util.Action;
import util.ActionForward;

public class MemberAdminDeleteAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		String id = request.getParameter("MEM_ID");
		ArrayList<CommentBean> comList = new ArrayList<CommentBean>();
		MemberDeleteService memberDeleteService = new MemberDeleteService();
		memberUserDeleteProService memberUserDeleteProService = new memberUserDeleteProService();
		boolean isDelete = memberDeleteService.deleteMember(id);

		if (id.equals("admin")) { // 어드민 계정이 아닌경우
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('관리자계정은 삭제가 불가합니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		} else if (!isDelete) { // 삭제실패 시,
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		} else if (isDelete || !id.equals("admin")) {
			comList = memberUserDeleteProService.allCom(id);
			int[] revNumList = new int[comList.size()];
			for (int i = 0; i < comList.size(); i++) {
				revNumList[i] = comList.get(i).getRE_PT_NUM();
			}
			for (int i=0; i<revNumList.length; i++) {
				memberUserDeleteProService.updateCom(revNumList[i]);
			}
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제하였습니다.');");
			out.println("location.href='managePageMem.camp';");
			out.println("</script>");
		}

		return forward;
	}
}
