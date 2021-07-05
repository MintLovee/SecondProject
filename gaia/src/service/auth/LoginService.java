package service.auth;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.member.MemberDAO;
import javaBean.auth.AuthBean;
import javaBean.member.MemberBean;

public class LoginService {

public AuthBean login(String id, String password) throws Exception {
		
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		AuthBean authBean = null;

		MemberBean memberBean = memberDAO.selectById(id);
		if (memberBean.getMEM_PW().equals(password)) {
			authBean = new AuthBean(memberBean.getMEM_ID(), memberBean.getMEM_NICKNAME(), memberBean.getMEM_TEL());
			close(con);
			return authBean;
		} else {
			throw new Exception();
		}
	}	
}