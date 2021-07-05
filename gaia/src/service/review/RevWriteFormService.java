package service.review;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.review.ReviewDAO;
import javaBean.review.ReviewWriteBean;

public class RevWriteFormService {
	public ArrayList<ReviewWriteBean> getReservationList(String id) throws Exception {
		ArrayList<ReviewWriteBean> reviewWriteList = null;
		Connection conn = getConnection();
		ReviewDAO revDAO = ReviewDAO.getInstance();
		revDAO.setConnection(conn);
		reviewWriteList = revDAO.selectReservationList(id);
		close(conn);
		return reviewWriteList;
	}
}
