package service.reservation;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.reservation.RezDAO;
import javaBean.reservation.ReservationBean;

public class RezMgtInsertService {
	public boolean insertMgt(ReservationBean rezBean) throws Exception {
		boolean isWriteSuccess = false;
		Connection conn = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(conn);
		int insertCount = rezDAO.insertMgt(rezBean);
		
		if (insertCount > 0) {
			commit(conn);		isWriteSuccess = true;
		} else {
			rollback(conn);
		}
		close(conn);		return isWriteSuccess;
	}
}
