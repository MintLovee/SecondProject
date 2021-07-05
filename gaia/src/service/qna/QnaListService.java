package service.qna;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.qna.QnaDAO;
import javaBean.qna.QnaBean;

public class QnaListService {

	public int getListCount(String fieldName, String searchWord) throws Exception{
				
		int listCount = 0;
		Connection con = getConnection();
		QnaDAO qnaDAO = QnaDAO.getInstance();
		qnaDAO.setConnection(con);
		listCount = qnaDAO.selectListCount(fieldName, searchWord);
		close(con);
		return listCount;
		
	}

	public ArrayList<QnaBean> getArticleList(int page, int limit, String fieldName, String searchWord) throws Exception{
		
		ArrayList<QnaBean> articleList = null;
		Connection con = getConnection();
		QnaDAO qnaDAO = QnaDAO.getInstance();
		qnaDAO.setConnection(con);
		articleList = qnaDAO.selectArticleList(page, limit, fieldName, searchWord);
		close(con);
		return articleList;
		
	}

}
