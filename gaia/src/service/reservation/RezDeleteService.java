package service.reservation;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.reservation.RezDAO;

public class RezDeleteService {
public boolean rezDelete(int rez_num) throws Exception {
		
		Connection con = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(con);
		
		boolean rezDelete = false;
		
		int deleteCount = rezDAO.delete(rez_num);
		
		if (deleteCount > 0) {
			commit(con);
			rezDelete = true;
		} else {
			rollback(con);
		}
		close(con);
		return rezDelete;
	}
}
