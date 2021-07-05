package service.reservation;

import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.reservation.RezDAO;

public class RezMgtDeleteService {
	public boolean rezMgtDelete(int rez_num) throws Exception {
		
		Connection con = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(con);
		
		boolean rezMgtDelete = false;
		
		int deleteCount = rezDAO.deleteMgt(rez_num);
		
		if (deleteCount > 0) {
			commit(con);
			rezMgtDelete = true;
		} else {
			rollback(con);
		}
		close(con);
		return rezMgtDelete;
	}
}
