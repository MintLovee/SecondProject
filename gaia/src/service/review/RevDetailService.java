package service.review;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import dao.review.ReviewDAO;
import javaBean.review.CommentBean;
import javaBean.review.ReviewBean;

public class RevDetailService {

	public ReviewBean getArticle(int rev_num) throws Exception{
		
		ReviewBean article = null;
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		int updateCount = reviewDAO.updateReadCount(rev_num);
		if(updateCount > 0){
			commit(con);
		}
		else{
			rollback(con);
		}
		article = reviewDAO.selectArticle(rev_num);
		close(con);
		return article;
	}

	public int getListCount(int REV_RE_NUM) throws Exception{
		int listCount = 0;
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		listCount = reviewDAO.comSelectListCount(REV_RE_NUM);
		close(con);
		return listCount;
	}
	

	public ArrayList<CommentBean> getArticleList(int page, int limit , int revReNum) throws Exception{
		ArrayList<CommentBean> articleList = null;
		Connection con = getConnection();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		reviewDAO.setConnection(con);
		articleList = reviewDAO.selectArticleList(page,limit,revReNum);
		close(con);
		return articleList;
	}
}

