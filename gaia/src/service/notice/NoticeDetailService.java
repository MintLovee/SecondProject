package service.notice;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.notice.NoticeDAO;
import javaBean.notice.NoticeBean;

public class NoticeDetailService {
	public NoticeBean getDetailNotice(int notice_num) throws Exception {
		
		Connection con = getConnection();
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		noticeDAO.setConnection(con);
		NoticeBean detailNotice = noticeDAO.selectNotice(notice_num);
		close(con);
		return detailNotice;
	}
}
