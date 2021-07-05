package service.notice;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.notice.NoticeDAO;
import javaBean.notice.NoticeBean;

public class NoticeRecentlyService {

	public ArrayList<NoticeBean> getRecentlyList() throws Exception{
		
		ArrayList<NoticeBean> recentlyList = null;
		Connection con = getConnection();
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		noticeDAO.setConnection(con);
		recentlyList = noticeDAO.recentlyList();
		close(con);
		return recentlyList;
		
	}

}
