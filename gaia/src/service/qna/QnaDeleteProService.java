package service.qna;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.qna.QnaDAO;

public class QnaDeleteProService {
	

	public boolean isReplyWritten(int qna_re_num, int qna_re_depth) throws Exception {
		
		boolean articleDel = false;
		Connection con = getConnection();
		QnaDAO qnaDAO = QnaDAO.getInstance();
		qnaDAO.setConnection(con);
		articleDel = qnaDAO.isReplyWritten(qna_re_num, qna_re_depth);
		close(con);
		return articleDel;
	}
	

	public boolean removeArticle(int qna_num) throws Exception{
				
		boolean isRemoveSuccess = false;
		Connection con = getConnection();
		QnaDAO qnaDAO = QnaDAO.getInstance();
		qnaDAO.setConnection(con);
		int deleteCount = qnaDAO.deleteArticle(qna_num);
		
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

}
