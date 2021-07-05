package service.notice;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.notice.NoticeDAO;
import javaBean.notice.NoticeBean;

public class NoticeUpdateService {
	public boolean updateNotice (NoticeBean detailNotice) throws Exception {
		
		Connection con = getConnection();
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		noticeDAO.setConnection(con);
		
		int updateCount = noticeDAO.updateNotice(detailNotice);
		boolean isUpdateSuccess = false;
		
		if (updateCount > 0) {
			commit(con);
			isUpdateSuccess = true;
		} else {
			rollback(con);
		}
		close(con);
		return isUpdateSuccess;
	}
}
