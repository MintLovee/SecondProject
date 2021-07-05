package action.member;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javaBean.review.CommentBean;
import service.member.memberUserDeleteProService;
import util.Action;
import util.ActionForward;

public class MemberUserDeleteProAction implements Action {
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ActionForward forward = null;
		boolean rezCheck = false;
		ArrayList<CommentBean> comList = new ArrayList<CommentBean>();
		String mem_id = req.getParameter("MEM_ID");
		memberUserDeleteProService memberUserDeleteProService = new memberUserDeleteProService();
		rezCheck = memberUserDeleteProService.rezCheck(mem_id);
		if (rezCheck) {
			res.setContentType("text/html;charset=UTF-8");
			PrintWriter out = res.getWriter();
			out.println("<script>");
			out.println("alert('예약내역이 남아있어서 탈퇴가 불가능합니다. 예약취소를 하시거나 관리자에게 문의해주세요.');");
			out.println("history.back();");
			out.println("</script>");
		} else {
		boolean deleteSuccess = memberUserDeleteProService.memberUserDelete(mem_id);
			if (!deleteSuccess) {
				res.setContentType("text/html;charset=UTF-8");
				PrintWriter out = res.getWriter();
				out.println("<script>");
				out.println("alert('회원탈퇴에 실패하였습니다.');");
				out.println("history.back();");
				out.println("<script>");
			} else {
				comList = memberUserDeleteProService.allCom(mem_id);
				int[] revNumList = new int[comList.size()];
				for (int i = 0; i < comList.size(); i++) {
					revNumList[i] = comList.get(i).getRE_PT_NUM();
				}
				for (int i=0; i<revNumList.length; i++) {
					memberUserDeleteProService.updateCom(revNumList[i]);
				}
				memberUserDeleteProService.memberUserComDelete(mem_id);
				HttpSession session = req.getSession(false);
				if(session != null) {
					session.invalidate();
				}
				res.setContentType("text/html;charset=UTF-8");
				PrintWriter out=res.getWriter();
				out.println("<script>");
				out.println("location.href='memberUserDeletePro.camp';");
				out.println("</script>");
			}
		}
		return forward;
	}
}
