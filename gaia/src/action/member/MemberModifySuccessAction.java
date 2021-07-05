package action.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.member.MemberBean;
import util.Action;
import util.ActionForward;

public class MemberModifySuccessAction implements Action {
   
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      ActionForward forward = null;
      MemberBean memberBean = null;
      memberBean = new MemberBean();
      String MEM_ID = request.getParameter("MEM_ID"); 
      
      memberBean.setMEM_ID(MEM_ID);
      memberBean.setMEM_PW(request.getParameter("MEM_PW"));
      memberBean.setMEM_NAME(request.getParameter("MEM_NAME"));
      memberBean.setMEM_ADDR(request.getParameter("MEM_ADDR"));
      memberBean.setMEM_TEL(request.getParameter("MEM_TEL"));
      memberBean.setMEM_JUMIN(request.getParameter("MEM_JUMIN"));
      memberBean.setMEM_EMAIL(request.getParameter("EMAIL1") + "@" + (request.getParameter("EMAIL2")));
      memberBean.setMEM_NICKNAME(request.getParameter("NAME")+"("+ request.getParameter("TEL").substring(9, 13) + ")");
      boolean updateSuccess = true;
      if(!updateSuccess) {
         response.setContentType("text/html;charset=UTF-8");
         PrintWriter out = response.getWriter();
         out.println("<script>");
         out.println("alert('변경에 실패하였습니다.');");
         out.println("history.back();");
         out.println("</script>");
      }else {
         forward = new ActionForward();
         forward.setRedirect(true);
         forward.setPath("myPage.camp");
      }
      return forward;
      }
}

