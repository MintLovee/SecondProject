package service.review;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.review.ReviewDAO;
import javaBean.review.ReviewBean;
public class RevWriteProService {
	public boolean revistArticle(ReviewBean reviewBean) throws Exception {
		boolean isWriteSuccess = false;
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		int insertCount = reviewDAO.insertArticle(reviewBean);
		
		if(insertCount > 0){
			commit(con);
			isWriteSuccess = true;
		}
		else{
			rollback(con);
		}
		close(con);
		return isWriteSuccess;
	}
	
	public int selectNewReviewNum(ReviewBean reviewBean) throws Exception {
		int newReviewNum = 0;
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		newReviewNum = reviewDAO.selectNewReview(reviewBean);
		return newReviewNum;
	}
	
	public void revCheck(String rezNum, int newReviewNum) throws Exception {
		int updateCount = 0;
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		updateCount = reviewDAO.updateRevCheck(rezNum, newReviewNum);
		
		if(updateCount > 0)	commit(con);
		else				rollback(con);
		close(con);
	}
}
