package service.notice;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.notice.NoticeDAO;
import javaBean.notice.NoticeBean;


public class NoticeListService {
	
	public int getListCount(String fieldName, String searchWord) throws Exception{
		int listCount = 0;
		Connection con = getConnection();
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		noticeDAO.setConnection(con);
		listCount = noticeDAO.selectListCount(fieldName, searchWord);
		close(con);
		return listCount;
	}
	
	public ArrayList<NoticeBean> getNoticeList(int page, int limit, String fieldName, String searchWord) throws Exception{
		ArrayList<NoticeBean> noticeList = null;
		Connection con = getConnection();
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		noticeDAO.setConnection(con);
		noticeList = noticeDAO.selectNoticeList(page, limit, fieldName, searchWord);
		close(con);
		return noticeList;
	}
}
