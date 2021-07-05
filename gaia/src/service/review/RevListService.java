package service.review;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.review.ReviewDAO;
import javaBean.review.ReviewBean;

public class RevListService {

	public int getListCount() throws Exception{
		int listCount = 0;
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		listCount = reviewDAO.selectListCount();
		close(con);
		return listCount;
	}

	public ArrayList<ReviewBean> getArticleList(int page, int limit) throws Exception{
		ArrayList<ReviewBean> articleList = null;
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		articleList = reviewDAO.selectArticleList(page,limit);
		close(con);
		return articleList;
	}
}
