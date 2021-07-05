package service.qna;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.qna.QnaDAO;
import javaBean.qna.QnaBean;

public class QnaRecentlyService {

	public ArrayList<QnaBean> getRecentlyList() throws Exception{
		
		ArrayList<QnaBean> recentlyList = null;
		Connection con = getConnection();
		QnaDAO qnaDAO = QnaDAO.getInstance();
		qnaDAO.setConnection(con);
		recentlyList = qnaDAO.recentlyList();
		close(con);
		return recentlyList;
		
	}

}
