package action.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.member.MemberDAO;
import javaBean.auth.AuthBean;
import javaBean.member.MemberBean;
import javaBean.reservation.ReservationListBean;
import service.member.MemberInfoService;
import util.Action;
import util.ActionForward;

public class MemberMyPageAction implements Action {

   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      request.setCharacterEncoding("utf-8");
      MemberBean dto = new MemberBean();

      dto.setMEM_ID(request.getParameter("MEM_ID"));
      dto.setMEM_PW(request.getParameter("MEM_PW"));
      dto.setMEM_NAME(request.getParameter("MEM_NAME"));
      dto.setMEM_ADDR(request.getParameter("MEM_ADDR"));
      String tel = (request.getParameter("TEL1")+"-"+request.getParameter("TEL2")+"-"+request.getParameter("TEL3"));
      dto.setMEM_TEL(tel);
//    dto.setMEM_TEL(request.getParameter("MEM_TEL"));
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

      AuthBean authBean = (AuthBean) request.getSession(false).getAttribute("authUser");
      
      
      MemberInfoService memberInfoService = new MemberInfoService();
      ArrayList<ReservationListBean> rezList = new ArrayList<ReservationListBean>();
      
      
      int limit = 0;
      if (request.getParameter("limit") == null) {
    	  limit = 3;
      } else {
      limit = Integer.parseInt(request.getParameter("limit"));
      }
      
      rezList = memberInfoService.getRezList(authBean.getMEM_ID(), limit);
      
      String mem_id = authBean.getMEM_ID();
      MemberBean memberInfo = memberInfoService.getMemberInfo(authBean.getMEM_ID());

      request.setAttribute("limit", limit);
      request.setAttribute("rezList", rezList);
      request.setAttribute("memberInfo", memberInfo);
      int rezListCount = memberInfoService.getRezListCount(mem_id);
      request.setAttribute("rezListCount", rezListCount);
      ActionForward forward = new ActionForward();
      forward.setPath("/view/myPage.jsp");
      return forward;

   }

}