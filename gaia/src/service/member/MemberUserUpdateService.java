package service.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.member.MemberDAO;
import javaBean.member.MemberBean;

public class MemberUserUpdateService {
	
	public MemberBean getMemberInfo(String id) {
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		MemberBean memberBean = memberDAO.selectById(id);
		
		close(con);
		return memberBean;
	}
	
	
	

}
