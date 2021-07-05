package service.qna;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.qna.QnaDAO;
import javaBean.qna.QnaBean;

public class FaqListService {

	public ArrayList<QnaBean> getFaqList() throws Exception{
		
		ArrayList<QnaBean> faqList = null;
		Connection con = getConnection();
		QnaDAO qnaDAO = QnaDAO.getInstance();
		qnaDAO.setConnection(con);
		faqList = qnaDAO.faqList();
		close(con);
		return faqList;
		
	}

}
