package service.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.member.MemberDAO;
import javaBean.member.MemberBean;

public class MemberJoinService {

	public int getMemberByLoginId(String id) throws Exception {

		Connection conn = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(conn);
		
		int oldMember = 0;
		oldMember = dao.isCheck(id);
		close(conn);
		return oldMember;
	}

	public boolean join(MemberBean dto) throws Exception {

		Connection conn = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(conn);

		boolean isJoinSuccess = false;
		int insertCount = dao.joinMember(dto);
		
		if (insertCount > 0) {
			commit(conn);		isJoinSuccess = true;
		} else {
			rollback(conn);
		}
		close(conn);		return isJoinSuccess;
	}

}
