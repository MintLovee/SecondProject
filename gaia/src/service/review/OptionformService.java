package service.review;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.review.ReviewDAO;
import javaBean.auth.AuthBean;
import javaBean.reservation.ReservationBean;


public class OptionformService {
	public ReservationBean optionArticle(AuthBean authbean) throws Exception{
		
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		ReservationBean option = reviewDAO.selectoption(authbean);
		
		close(con);
		return option;
	}
}
