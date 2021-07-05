package service.review;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.review.ReviewDAO;


public class RevDeleteService {
	
	public boolean revDelete(int revNum) throws Exception {
		boolean isRemoveSuccess = false;
		Connection con = getConnection();
		ReviewDAO revDAO = ReviewDAO.getInstance();
		revDAO.setConnection(con);
		int deleteCount = revDAO.deleteRev(revNum);
		
		if (deleteCount > 0) {
			commit(con);
			isRemoveSuccess = true;
		} else {
			rollback(con);
		}
		close(con);
		return isRemoveSuccess;
	}
	
	public boolean comDeleteArticle(int revnum) throws Exception{
		
		boolean articleDel = false;
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		articleDel = reviewDAO.chDeleteArticle(revnum);
		
		close(con);
		return articleDel;

	}
	
	public void updateDelRevCheck(int revNum) throws Exception {
		int updateCount = 0;
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		updateCount = reviewDAO.updateDelRevCheck(revNum);	
		if(updateCount > 0)	commit(con);
		else				rollback(con);
		close(con);
	}
}