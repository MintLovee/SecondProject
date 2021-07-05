package service.qna;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.qna.QnaDAO;
import javaBean.qna.QnaBean;

public class QnaDetailService {

	public QnaBean getArticle(int qna_num) throws Exception{
				
		QnaBean article = null;
		Connection con = getConnection();
		QnaDAO qnaDAO = QnaDAO.getInstance();
		qnaDAO.setConnection(con);
		
		
		article = qnaDAO.selectArticle(qna_num);
		close(con);
		return article;
		
	}

}
