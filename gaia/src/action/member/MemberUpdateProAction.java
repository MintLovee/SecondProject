package action.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.member.MemberDAO;
import javaBean.member.MemberBean;
import util.Action;
import util.ActionForward;

public class MemberUpdateProAction implements Action {

	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
	      request.setCharacterEncoding("utf-8");
	      MemberBean dto = new MemberBean();

	      dto.setMEM_ID(request.getParameter("MEM_ID"));
	      dto.setMEM_PW(request.getParameter("MEM_PW"));
	      dto.setMEM_NAME(request.getParameter("MEM_NAME"));
	      dto.setMEM_ADDR(request.getParameter("MEM_ADDR"));
	      String tel = (request.getParameter("TEL1")+"-"+request.getParameter("TEL2")+"-"+request.getParameter("TEL3"));
	      dto.setMEM_TEL(tel);
//	    dto.setMEM_TEL(request.getParameter("MEM_TEL"));
	      dto.setMEM_JUMIN(request.getParameter("MEM_JUMIN"));
	      dto.setMEM_EMAIL(request.getParameter("EMAIL1") + "@" + (request.getParameter("EMAIL2")));
	      //dto.setMEM_EMAIL(request.getParameter("NAME")+"("+ request.getParameter("TEL").substring(9, 13) + ")");

	      Connection con = getConnection();
	      MemberDAO memberDAO = MemberDAO.getInstance();
	      memberDAO.setConnection(con);

	      MemberBean memberBean = memberDAO.updateById(request.getParameter("MEM_ID"), request.getParameter("MEM_PW"),
	            request.getParameter("MEM_NAME"), request.getParameter("MEM_ADDR"), tel,
	            request.getParameter("EMAIL1") + "@" + (request.getParameter("EMAIL2")));
	      close(con);


	      ActionForward forward = new ActionForward();
	      forward.setPath("managePageMem.camp");
	      return forward;

	   }
}