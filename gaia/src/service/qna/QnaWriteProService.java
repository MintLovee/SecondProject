package service.qna;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.qna.QnaDAO;
import javaBean.qna.QnaBean;

public class QnaWriteProService {
	public boolean registArticle(QnaBean qnaBean) throws Exception {
		boolean isWriteSuccess = false;
		
		Connection conn = getConnection();
		QnaDAO qnaDAO = QnaDAO.getInstance();
		qnaDAO.setConnection(conn);
		int insertCount = qnaDAO.insertArticle(qnaBean);
		
		if (insertCount > 0) {
			commit(conn);		isWriteSuccess = true;
		} else {
			rollback(conn);
		}
		close(conn);		return isWriteSuccess;
	}
}
