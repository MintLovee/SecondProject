package service.review;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.review.ReviewDAO;

public class ComDeleteProService {
	public boolean removeArticle(int re_num) throws Exception{
		
		boolean isRemoveSuccess = false;
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		int deleteCount = reviewDAO.condeleteArticle(re_num);
		
		if(deleteCount > 0){
			commit(con);
			isRemoveSuccess=true;
		}
		else{
			rollback(con);
		}
		
		close(con);
		return isRemoveSuccess;
	}
	
	public void updateCom(int rev_num) throws Exception{
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		int updateCount = reviewDAO.updateCom(rev_num);
		
		if(updateCount > 0)
			commit(con);
		else
			rollback(con);
		close(con);
	}
}
