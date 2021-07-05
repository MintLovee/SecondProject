package service.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import dao.member.MemberDAO;
import javaBean.review.CommentBean;

public class memberUserDeleteProService {
	public boolean memberUserDelete(String mem_id) throws Exception {
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		boolean memDelete = false;
		
		int deleteCount = memberDAO.memberUserDelete(mem_id);
		
		if (deleteCount > 0) {
			commit(con);
			memDelete = true;
		} else {
			rollback(con);
		}
		close(con);
		return memDelete;
	}
	
	public boolean rezCheck(String mem_id) throws Exception {
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		boolean rezCheck = false;
		
		int rc = memberDAO.rezCheck(mem_id);
		
		if (rc > 0) {
			rezCheck = true;
		}
		close(con);
		return rezCheck;
	}
	
	public void memberUserComDelete(String mem_id) throws Exception {
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		int deleteComCount = memberDAO.memberUserComDelete(mem_id);
		
		if (deleteComCount > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		close(con);
	}
	
	public ArrayList<CommentBean> allCom(String mem_id) throws Exception {
		ArrayList<CommentBean> cl = new ArrayList<CommentBean>();
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		cl = memberDAO.allCom(mem_id);
		close(con);
		return cl;
	}
	
	public void updateCom(int rev_num) throws Exception{
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		int updateCount = memberDAO.updateCom(rev_num);
		
		if(updateCount > 0)
			commit(con);
		else
			rollback(con);
		close(con);
	}
}
