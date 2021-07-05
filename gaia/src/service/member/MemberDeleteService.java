package service.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.member.MemberDAO;

public class MemberDeleteService {

	public boolean deleteMember(String id) throws Exception{
		boolean isDelete = false;
		Connection conn = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(conn);
		int delete =memberDAO.DeleteMember(conn, id);
		
		if(delete>0 && !id.equals("admin")) {
			commit(conn);
			isDelete = true;
		}else {
			rollback(conn);
		}
		close(conn);
		return isDelete;
	}

}
