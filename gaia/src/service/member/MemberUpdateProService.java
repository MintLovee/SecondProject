package service.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.member.MemberDAO;
import javaBean.member.MemberBean;

public class MemberUpdateProService {
	
	public boolean modifyMemberInfo(String MEM_ID, String MEM_PW, String MEM_NAME, String MEM_ADDR, String MEM_TEL, String MEM_EMAIL) throws Exception {
		boolean isModifySuccess = false;
		
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		int updateCount = 0;
		updateCount = memberDAO.updateMemberInfo(MEM_ID, MEM_PW, MEM_NAME, MEM_ADDR, MEM_TEL, MEM_EMAIL);
		
		if(updateCount > 0) {
			commit(con);
			isModifySuccess=true;
		}
		else{
			rollback(con);
		}
		
		close(con);
		return isModifySuccess;
	}
}