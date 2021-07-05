package service.qna;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.qna.QnaDAO;
import javaBean.qna.QnaBean;

public class QnaManagerService {

	public ArrayList<QnaBean> getManagerList() throws Exception{
		
		ArrayList<QnaBean> managerList = null;
		Connection con = getConnection();
		QnaDAO qnaDAO = QnaDAO.getInstance();
		qnaDAO.setConnection(con);
		managerList = qnaDAO.managerList();
		close(con);
		return managerList;
		
	}

}
