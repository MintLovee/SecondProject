package service.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.member.MemberDAO;

public class MemberUserDeleteService {
	public String getPW(String mem_id) throws Exception {
		
		Connection conn = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(conn);
		
		String mem_pw = memberDAO.getPW(mem_id);
		close(conn);
		return mem_pw;
	}
}
