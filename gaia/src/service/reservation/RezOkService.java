package service.reservation;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.reservation.RezDAO;
import javaBean.auth.AuthBean;
import javaBean.product.ProductBean;
import javaBean.reservation.ReservationBean;

public class RezOkService {
	
	public ProductBean getPrice(String p_num) throws Exception {
		Connection con = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(con);
		
		ProductBean productBean = rezDAO.selectPrice(p_num);
		close(con);
		return productBean;
	}
	
	public boolean setReservation(AuthBean authBean, ReservationBean reservationBean, int p_price, int diffDays) throws Exception {
		Connection con = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(con);
		
		boolean reservation = false;

		int total = p_price * diffDays;
		int insertCount = rezDAO.insert(authBean, reservationBean, total);
		
		if (insertCount > 0) {
			commit(con);
			reservation = true;
		} else {
			rollback(con);
		}
		close(con);
		return reservation;
	}
	
	public ReservationBean getReservationInfo(String nickName) {
		Connection con = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(con);
		
		ReservationBean reservationInfo = rezDAO.selectRezInfo(nickName);
		close(con);
		return reservationInfo;
	}
}