package service.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.member.MemberDAO;
import javaBean.member.MemberBean;

public class MemberInsertService {
	public boolean insertMember(MemberBean dto) throws Exception {

		boolean InsertSuccess = false;

		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		int InsertDone = memberDAO.insertMember(dto);

		if (InsertDone > 0) {
			commit(con);
			InsertSuccess = true;
		} else {
			rollback(con);
		}
		close(con);

		return InsertSuccess;
	}
}
