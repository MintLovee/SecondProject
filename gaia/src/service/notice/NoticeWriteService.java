package service.notice;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.notice.NoticeDAO;
import javaBean.notice.NoticeBean;

public class NoticeWriteService {
	public boolean insertNotice(NoticeBean noticeBean) throws Exception {
		
		Connection conn = getConnection();
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		noticeDAO.setConnection(conn);
		int insertCount = noticeDAO.insertNotice(noticeBean);
		
		boolean isWriteSuccess = false;
		if (insertCount > 0) {
			commit(conn);		isWriteSuccess = true;
		} else {
			rollback(conn);
		}
		close(conn);
		return isWriteSuccess;
	}
}
