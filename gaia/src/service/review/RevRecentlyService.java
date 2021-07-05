package service.review;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.review.ReviewDAO;
import javaBean.review.ReviewBean;

public class RevRecentlyService {

	public ArrayList<ReviewBean> getRecentlyList() throws Exception{
		
		ArrayList<ReviewBean> recentlyList = null;
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		recentlyList = reviewDAO.recentlyList();
		close(con);
		return recentlyList;
		
	}

}
