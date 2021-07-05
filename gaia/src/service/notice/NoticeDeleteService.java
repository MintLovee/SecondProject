package service.notice;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.notice.NoticeDAO;

public class NoticeDeleteService {
	public boolean deleteNotice(int notice_num) throws Exception {
		
		Connection con = getConnection();
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		noticeDAO.setConnection(con);
		
		int deleteCount = noticeDAO.deleteNotice(notice_num);
		boolean isDeleteSuccess = false;
		
		if (deleteCount > 0) {
			commit(con);
			isDeleteSuccess = true;
		} else {
			rollback(con);
		}
		close(con);
		return isDeleteSuccess;
	}
}
