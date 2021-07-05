package service.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.member.MemberDAO;
import javaBean.member.MemberBean;
import javaBean.qna.QnaBean;

public class MemberUpdateService {

	public MemberBean getmemberInfo(String mem_id) throws Exception {

		MemberBean memberInfo = null;
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);

		memberInfo = memberDAO.selectArticle(mem_id);
		close(con);
		return memberInfo;

	}



	public boolean updateMember(MemberBean dto) throws Exception {
		boolean isUpdateSuccess = false;

		Connection conn = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(conn);
		int insertCount = memberDAO.updateMember(dto);

		if (insertCount > 0) {
			commit(conn);
			isUpdateSuccess = true;
		} else {
			rollback(conn);
		}
		close(conn);
		return isUpdateSuccess;
	}
}
