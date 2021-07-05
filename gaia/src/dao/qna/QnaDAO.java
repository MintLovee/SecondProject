package dao.qna;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Timestamp;

import javax.sql.DataSource;

import javaBean.qna.QnaBean;

public class QnaDAO {
	DataSource ds;		Connection conn;
	private static QnaDAO qnaDAO;
	private QnaDAO() {}
	public static QnaDAO getInstance() {
		if (qnaDAO == null) {
			qnaDAO = new QnaDAO();
		}
		return qnaDAO;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public ArrayList<QnaBean> faqList() {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT FAQ_NUM, FAQ_Q, FAQ_A FROM FAQ";
		ArrayList<QnaBean> faqList = new ArrayList<QnaBean>();
		QnaBean qna = null;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				qna = new QnaBean();
				qna.setFAQ_NUM(rs.getInt("FAQ_NUM"));
				qna.setFAQ_Q(rs.getString("FAQ_Q"));
				qna.setFAQ_A(rs.getString("FAQ_A"));
				faqList.add(qna);
			}
		} catch (Exception e) {System.out.println("getFaqList : " + e);}
		finally {close(rs);		close(ps);}
		return faqList;
	}	
	
	public ArrayList<QnaBean> recentlyList() {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select * from qna where qna_secret=0 order by qna_re_num desc, qna_re_depth limit 4 offset 0 ;";
		ArrayList<QnaBean> recentlyList = new ArrayList<QnaBean>();
		QnaBean qna = null;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				qna = new QnaBean();
				qna.setQNA_NUM(rs.getInt("QNA_NUM"));
				qna.setQNA_NAME(rs.getString("QNA_NAME"));
				qna.setQNA_ID(rs.getString("QNA_ID"));
				qna.setQNA_SUBJECT(rs.getString("QNA_SUBJECT"));
				qna.setQNA_CONTENT(rs.getString("QNA_CONTENT"));
				qna.setQNA_RE_NUM(rs.getInt("QNA_RE_NUM"));
				qna.setQNA_RE_DEPTH(rs.getInt("QNA_RE_DEPTH"));
				DateFormat dateFormat = new SimpleDateFormat("yy-MM-dd");
				String dateToStr = dateFormat.format(rs.getTimestamp("QNA_DATE"));
				qna.setQNA_DATE(dateToStr);
				qna.setQNA_SECRET(rs.getInt("QNA_SECRET"));
				qna.setQNA_CATEGORY(rs.getString("QNA_CATEGORY"));
				recentlyList.add(qna);
			}
		} catch (Exception e) {System.out.println("getRecentlyList : " + e);}
		finally {close(rs);		close(ps);}
		return recentlyList;
	}	
	
	public ArrayList<QnaBean> managerList() {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select * from qna where qna_re_num in (select qna_re_num from qna group by qna_re_num having count(qna_re_num)=1) and not qna_name in ('관리자') order by qna_re_num desc, qna_re_depth";
		ArrayList<QnaBean> recentlyList = new ArrayList<QnaBean>();
		QnaBean qna = null;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				qna = new QnaBean();
				qna.setQNA_NUM(rs.getInt("QNA_NUM"));
				qna.setQNA_NAME(rs.getString("QNA_NAME"));
				qna.setQNA_ID(rs.getString("QNA_ID"));
				qna.setQNA_SUBJECT(rs.getString("QNA_SUBJECT"));
				qna.setQNA_CONTENT(rs.getString("QNA_CONTENT"));
				qna.setQNA_RE_NUM(rs.getInt("QNA_RE_NUM"));
				qna.setQNA_RE_DEPTH(rs.getInt("QNA_RE_DEPTH"));
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				String dateToStr = dateFormat.format(rs.getTimestamp("QNA_DATE"));
				qna.setQNA_DATE(dateToStr);
				qna.setQNA_SECRET(rs.getInt("QNA_SECRET"));
				qna.setQNA_CATEGORY(rs.getString("QNA_CATEGORY"));
				recentlyList.add(qna);
			}
		} catch (Exception e) {System.out.println("getQnaManagerList : " + e);}
		finally {close(rs);		close(ps);}
		return recentlyList;
	}	
	
	public int selectListCount(String fieldName, String searchWord) {
		int listCount = 0;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			System.out.println("getConnection");
			ps = conn.prepareStatement("SELECT COUNT(*) FROM QNA WHERE " + fieldName + " LIKE '%" + searchWord + "%'");
			rs = ps.executeQuery();
			if (rs.next()) listCount = rs.getInt(1);
		} catch (Exception e) {System.out.println("getListCount : " + e);}
		finally {close(rs);		close(ps);}
		return listCount;
	}

	public ArrayList<QnaBean> selectArticleList(int page, int limit, String fieldName, String searchWord) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String qna_list_sql = "SELECT * FROM QNA WHERE " + fieldName + " LIKE '%" + searchWord + "%' ORDER BY QNA_RE_NUM DESC, QNA_RE_DEPTH LIMIT ? OFFSET ?";
		ArrayList<QnaBean> articleList = new ArrayList<QnaBean>();
		QnaBean qna = null;
		int startrow = (page - 1) * limit;
		try {
			ps = conn.prepareStatement(qna_list_sql);
			ps.setInt(1, limit);
			ps.setInt(2, startrow);
			rs = ps.executeQuery();
			while (rs.next()) {
				qna = new QnaBean();
				qna.setQNA_NUM(rs.getInt("QNA_NUM"));
				qna.setQNA_NAME(rs.getString("QNA_NAME"));
				qna.setQNA_ID(rs.getString("QNA_ID"));
				qna.setQNA_SUBJECT(rs.getString("QNA_SUBJECT"));
				qna.setQNA_CONTENT(rs.getString("QNA_CONTENT"));
				qna.setQNA_RE_NUM(rs.getInt("QNA_RE_NUM"));
				qna.setQNA_RE_DEPTH(rs.getInt("QNA_RE_DEPTH"));
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				String dateToStr = dateFormat.format(rs.getTimestamp("QNA_DATE"));
				qna.setQNA_DATE(dateToStr);
				qna.setQNA_SECRET(rs.getInt("QNA_SECRET"));
				qna.setQNA_CATEGORY(rs.getString("QNA_CATEGORY"));
				articleList.add(qna);
			}
		} catch (Exception e) {System.out.println("getQnaList : " + e);}
		finally {close(rs);		close(ps);}
		return articleList;
	}
	
	public QnaBean selectArticle(int qna_num) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		QnaBean qnaBean = null;
		try {
			ps = conn.prepareStatement("SELECT * FROM QNA WHERE QNA_NUM=?");
			ps.setInt(1, qna_num);
			rs = ps.executeQuery();
			if (rs.next()) {
				qnaBean = new QnaBean();
				qnaBean.setQNA_NUM(rs.getInt("QNA_NUM"));
				qnaBean.setQNA_NAME(rs.getString("QNA_NAME"));
				qnaBean.setQNA_ID(rs.getString("QNA_ID"));
				qnaBean.setQNA_SUBJECT(rs.getString("QNA_SUBJECT"));
				qnaBean.setQNA_CONTENT(rs.getString("QNA_CONTENT"));
				qnaBean.setQNA_RE_NUM(rs.getInt("QNA_RE_NUM"));
				qnaBean.setQNA_RE_DEPTH(rs.getInt("QNA_RE_DEPTH"));
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd a hh:mm:ss");
				String dateToStr = dateFormat.format(rs.getTimestamp("QNA_DATE"));
				qnaBean.setQNA_DATE(dateToStr);
				qnaBean.setQNA_SECRET(rs.getInt("QNA_SECRET"));
				qnaBean.setQNA_CATEGORY(rs.getString("QNA_CATEGORY"));
			}
		} catch (Exception e) {System.out.println("getDetail : " + e);}
		finally {close(rs);		close(ps);}
		return qnaBean;
	}
	
	public int insertArticle(QnaBean article) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int num = 0;
		String sql = "";
		int insertCount = 0;
		try {
			ps = conn.prepareStatement("SELECT MAX(QNA_NUM) FROM QNA");
			rs = ps.executeQuery();
			if (rs.next()) num = rs.getInt(1) + 1;
			else num = 1;
			sql = "INSERT INTO QNA (QNA_NUM, QNA_NAME, QNA_ID, QNA_SUBJECT, "
					+ "QNA_CONTENT, QNA_RE_NUM, QNA_RE_DEPTH, "
					+ "QNA_SECRET, QNA_CATEGORY) VALUES (?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, num);
			ps.setString(2, article.getQNA_NAME());
			ps.setString(3, article.getQNA_ID());
			ps.setString(4, article.getQNA_SUBJECT());
			ps.setString(5, article.getQNA_CONTENT());
			ps.setInt(6, num);
			ps.setInt(7, 0);
			ps.setInt(8, article.getQNA_SECRET());
			ps.setString(9, article.getQNA_CATEGORY());
			insertCount = ps.executeUpdate();
		} catch (Exception e) {System.out.println("qnaInsert : " + e);}
		finally {close(rs);		close(ps);}
		return insertCount;
	}
	
	public int insertReplyArticle(QnaBean article) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String qna_max_sql = "SELECT MAX(QNA_NUM) FROM QNA";
		String sql = "";
		int num = 0;
		int insertCount = 0;
		int re_num = article.getQNA_RE_NUM();

		
		try {
			ps = conn.prepareStatement(qna_max_sql);
			rs = ps.executeQuery();
			if (rs.next()) num = rs.getInt(1) + 1;
			else num = 1;

			sql = "INSERT INTO QNA (QNA_NUM, QNA_NAME, QNA_ID, QNA_SUBJECT, "
					+ "QNA_CONTENT, QNA_RE_NUM, QNA_RE_DEPTH, "
					+ "QNA_SECRET, QNA_CATEGORY) VALUES (?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, num);
			ps.setString(2, article.getQNA_NAME());
			ps.setString(3, article.getQNA_ID());
			ps.setString(4, article.getQNA_SUBJECT());
			ps.setString(5, article.getQNA_CONTENT());
			ps.setInt(6, re_num);
			ps.setInt(7, 1);
			ps.setInt(8, article.getQNA_SECRET());
			ps.setString(9, "");
			
			insertCount = ps.executeUpdate();
		} catch (Exception e) {System.out.println("qnaReply : " + e);}
		finally {close(rs);		close(ps);}
		return insertCount;
	}
	
	public int updateArticle(QnaBean article) {
		int updateCount = 0;
		PreparedStatement ps = null;
		String sql = "UPDATE QNA SET QNA_SUBJECT=?, QNA_CONTENT=?, QNA_SECRET=?, QNA_CATEGORY=? WHERE QNA_NUM=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, article.getQNA_SUBJECT());
			ps.setString(2, article.getQNA_CONTENT());
			ps.setInt(3, article.getQNA_SECRET());
			ps.setString(4, article.getQNA_CATEGORY());
			ps.setInt(5, article.getQNA_NUM());
			updateCount = ps.executeUpdate();
		} catch (Exception e) {System.out.println("qnaModify : " + e);}
		finally {close(ps);}
		String sql2 = "UPDATE QNA SET QNA_SECRET=? WHERE QNA_RE_NUM=?";
		try {
			ps = conn.prepareStatement(sql2);
			ps.setInt(1, article.getQNA_SECRET());
			ps.setInt(2, article.getQNA_RE_NUM());
			updateCount = ps.executeUpdate();
		} catch (Exception e) {System.out.println("qnaModify : " + e);}
		finally {close(ps);}
		return updateCount;
	}
	
	public int deleteArticle(int qna_num) {
		PreparedStatement ps = null;
		String qna_delete_sql = "DELETE FROM QNA WHERE QNA_NUM=?";
		int deleteCount = 0;
		try {
			ps = conn.prepareStatement(qna_delete_sql);
			ps.setInt(1, qna_num);
			deleteCount = ps.executeUpdate();
		} catch (Exception e) {System.out.println("qnaDelete : " + e);}
		finally {close(ps);}
		return deleteCount;
	}
	

	//글번호 - 비밀번호 확인
	public boolean isArticleBoardWriter(int qna_num, String pass) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String qna_sql = "SELECT * FROM QNA WHERE QNA_NUM=?";
		boolean isWriter = false;
		try {
			ps = conn.prepareStatement(qna_sql);
			ps.setInt(1, qna_num);
			rs = ps.executeQuery();
			rs.next();
			if (pass.equals(rs.getString("QNA_PASS"))) {
				isWriter = true;
			}
		} catch (Exception e) {System.out.println("isQnaWriter : " + e);}
		finally {close(ps);}
		return isWriter;
	}
	
	public boolean isReplyWritten(int qna_re_num, int qna_re_depth) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int replyCount = 0;
		boolean articleDel = false;
		String sql = "SELECT COUNT(*) FROM QNA WHERE QNA_RE_NUM=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, qna_re_num);
			rs = ps.executeQuery();
			rs.next();
			replyCount = rs.getInt(1);
			if(replyCount >= 2 && qna_re_depth == 0)
				articleDel = true;
			
		} catch (Exception e) {System.out.println("isReplyWriter : " + e);}
		finally {close(ps);}
		return articleDel;
				
	}
}
