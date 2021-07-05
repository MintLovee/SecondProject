package dao.notice;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.sql.DataSource;

import javaBean.notice.NoticeBean;
import javaBean.qna.QnaBean;

public class NoticeDAO {
	DataSource ds;		Connection conn;
	private static NoticeDAO noticeDAO;
	private NoticeDAO() {}
	public static NoticeDAO getInstance() {
		if (noticeDAO == null) {
			noticeDAO = new NoticeDAO();
		}
		return noticeDAO;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<NoticeBean> recentlyList() {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select * from notice order by notice_num desc limit 4 offset 0 ;";
		ArrayList<NoticeBean> recentlyList = new ArrayList<NoticeBean>();
		NoticeBean notice = null;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				notice = new NoticeBean();
				notice.setNOTICE_NUM(rs.getInt("NOTICE_NUM"));
				notice.setNOTICE_NAME(rs.getString("NOTICE_NAME"));
				notice.setNOTICE_TITLE(rs.getString("NOTICE_TITLE"));
				notice.setNOTICE_CONTENT(rs.getString("NOTICE_CONTENT"));
				DateFormat dateFormat = new SimpleDateFormat("yy-MM-dd");
				String dateToStr = dateFormat.format(rs.getTimestamp("NOTICE_DATE"));
				notice.setNOTICE_DATE(dateToStr);
				recentlyList.add(notice);
			}
		} catch (Exception e) {System.out.println("getRecentlyList : " + e);}
		finally {close(rs);		close(ps);}
		return recentlyList;
	}	
	
	public int selectListCount(String fieldName, String searchWord) {
		int listCount = 0;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("SELECT COUNT(*) FROM NOTICE WHERE " + fieldName + " LIKE '%" + searchWord + "%'");
			rs = ps.executeQuery();
			if (rs.next()) listCount = rs.getInt(1);
		} catch (Exception e) {System.out.println("getListCount : " + e);}
		finally {close(rs);		close(ps);}
		return listCount;
	}
	
	public ArrayList<NoticeBean> selectNoticeList(int page, int limit, String fieldName, String searchWord) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM NOTICE WHERE " + fieldName + " LIKE '%" + searchWord + "%' ORDER BY NOTICE_NUM DESC LIMIT ? OFFSET ?";
		ArrayList<NoticeBean> noticeList = new ArrayList<NoticeBean>();
		NoticeBean noticeBean = null;
		int startrow = (page - 1) * limit;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, limit);
			ps.setInt(2, startrow);
			rs = ps.executeQuery();
			while (rs.next()) {
				noticeBean = new NoticeBean();
				noticeBean.setNOTICE_NUM(rs.getInt("NOTICE_NUM"));
				noticeBean.setNOTICE_NAME(rs.getString("NOTICE_NAME"));
				noticeBean.setNOTICE_TITLE(rs.getString("NOTICE_TITLE"));
				noticeBean.setNOTICE_CONTENT(rs.getString("NOTICE_CONTENT"));
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				String dateToStr = dateFormat.format(rs.getTimestamp("NOTICE_DATE"));
				noticeBean.setNOTICE_DATE(dateToStr);
				noticeList.add(noticeBean);
			}
		} catch (Exception e) {System.out.println("getNoticeList : " + e);}
		finally {close(rs);		close(ps);}
		return noticeList;
	}
	
	public int insertNotice(NoticeBean noticeBean) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int num = 0;
		int insertCount = 0;
		String sql = "INSERT INTO NOTICE (NOTICE_NUM, NOTICE_NAME, NOTICE_TITLE, NOTICE_CONTENT) VALUES (?, ?, ?, ?)";
		try {
			ps = conn.prepareStatement("SELECT MAX(NOTICE_NUM) FROM NOTICE");
			rs = ps.executeQuery();
			if (rs.next()) num = rs.getInt(1) + 1;
			else num = 1;
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, num);
			ps.setString(2, noticeBean.getNOTICE_NAME());
			ps.setString(3, noticeBean.getNOTICE_TITLE());
			ps.setString(4, noticeBean.getNOTICE_CONTENT());
			insertCount = ps.executeUpdate();
		} catch (Exception e) {System.out.println("insertNotice: " + e);}
		finally {close(rs); 	close(ps);}
		return insertCount;
	}
	
	public NoticeBean selectNotice(int notice_num) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		NoticeBean detailNotice = null;
		String sql = "SELECT * FROM NOTICE WHERE NOTICE_NUM=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, notice_num);
			rs = ps.executeQuery();
			if (rs.next()) {
				detailNotice = new NoticeBean();
				detailNotice.setNOTICE_NUM(rs.getInt("NOTICE_NUM"));
				detailNotice.setNOTICE_NAME(rs.getString("NOTICE_NAME"));
				detailNotice.setNOTICE_TITLE(rs.getString("NOTICE_TITLE"));
				detailNotice.setNOTICE_CONTENT(rs.getString("NOTICE_CONTENT"));
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd a hh:mm:ss");
				String dateToStr = dateFormat.format(rs.getTimestamp("NOTICE_DATE"));
				detailNotice.setNOTICE_DATE(dateToStr);
			}
		} catch (Exception e) {System.out.println("getDetailNotice : " + e);}
		finally {close(rs);		close(ps);}
		return detailNotice;
	}
	
	public int updateNotice(NoticeBean noticeBean) {
		PreparedStatement ps = null;
		int updateCount = 0;
		String sql = "UPDATE NOTICE SET NOTICE_TITLE=?, NOTICE_CONTENT=? WHERE NOTICE_NUM=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, noticeBean.getNOTICE_TITLE());
			ps.setString(2, noticeBean.getNOTICE_CONTENT());
			ps.setInt(3, noticeBean.getNOTICE_NUM());
			updateCount = ps.executeUpdate();
		} catch (Exception e) {System.out.println("updateNotice: " + e);}
		finally {close(ps);}
		return updateCount;
	}
	
	public int deleteNotice(int notice_num) {
		PreparedStatement ps = null;
		int deleteCount = 0;
		String sql = "DELETE FROM NOTICE WHERE NOTICE_NUM=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, notice_num);
			deleteCount = ps.executeUpdate();
		} catch (Exception e) {System.out.println("deleteNotice: " + e);}
		finally {close(ps);}
		return deleteCount;
	}
}
