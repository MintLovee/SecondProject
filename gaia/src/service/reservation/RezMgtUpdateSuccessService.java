package service.reservation;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.reservation.RezDAO;
import javaBean.reservation.ReservationBean;

public class RezMgtUpdateSuccessService {
	
	public boolean rezMgtUpdate(ReservationBean reservationBean) throws Exception {
		Connection con = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(con);
		
		boolean rezMgtUpdate = false;
		int updateCount = rezDAO.updateMgt(reservationBean);
		
		System.out.println("updateCount: " + updateCount);
		
		if (updateCount > 0) {
			commit(con);
			rezMgtUpdate = true;
		} else { 
			rollback(con);
		}
		close(con);
		return rezMgtUpdate;
	}
}
