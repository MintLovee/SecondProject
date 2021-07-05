package dao.reservation;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.sql.DataSource;

import javaBean.auth.AuthBean;
import javaBean.member.MemberBean;
import javaBean.product.ProductBean;
import javaBean.reservation.InfoUseBean;
import javaBean.reservation.ReservationBean;
import javaBean.reservation.ReservationListBean;
import util.MyCalendar;

public class RezDAO {
	DataSource ds;
	Connection conn;
	private static RezDAO rezDAO;

	private RezDAO() {
	}

	public static RezDAO getInstance() {
		if (rezDAO == null) {
			rezDAO = new RezDAO();
		}
		return rezDAO;
	}

	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public ArrayList<ProductBean> selectProductList() {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String proListSql = "SELECT * FROM PRODUCT";
		ArrayList<ProductBean> productList = new ArrayList<ProductBean>();
		ProductBean product = null;
		try {
			ps = conn.prepareStatement(proListSql);
			rs = ps.executeQuery();
			while (rs.next()) {
				product = new ProductBean();
				product.setP_NUM(rs.getString("P_NUM"));
				product.setP_NAME(rs.getString("P_NAME"));
				product.setP_PRICE(rs.getInt("P_PRICE"));
				product.setP_SERVICE(rs.getString("P_SERVICE"));
				product.setP_NOTES(rs.getString("P_NOTES"));
				product.setP_MORE_INFO(rs.getString("P_MORE_INFO"));
				product.setP_IMG(rs.getString("P_IMG"));
				productList.add(product);
			}
		} catch (Exception e) {
			System.out.println("getProList : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return productList;
	}

	public ArrayList<ReservationBean> selectRezList() {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String today = String.valueOf(MyCalendar.today());
		String afterWeeks = String.valueOf(MyCalendar.afterWeeks());
		String sql = "SELECT * FROM RESERVATION WHERE REZ_INDATE>=? AND REZ_OUTDATE<?";
		ArrayList<ReservationBean> rezList = new ArrayList<ReservationBean>();
		ReservationBean rezBean = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, today);
			ps.setString(2, afterWeeks);
			rs = ps.executeQuery();
			while (rs.next()) {
				rezBean = new ReservationBean();
				rezBean.setREZ_NUM(rs.getInt("REZ_NUM"));
				rezBean.setREZ_NICKNAME(rs.getString("REZ_NICKNAME"));
				rezBean.setREZ_TEL(rs.getString("REZ_TEL"));
				rezBean.setREZ_PNUM(rs.getString("REZ_PNUM"));
				rezBean.setREZ_INDATE(sdf.format(rs.getDate("REZ_INDATE")));
				rezBean.setREZ_OUTDATE(sdf.format(rs.getDate("REZ_OUTDATE")));
				rezBean.setREZ_TOTAL(rs.getInt("REZ_TOTAL"));
				rezList.add(rezBean);
			}
		} catch (Exception e) {
			System.out.println("getRezList : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return rezList;
	}

	public ProductBean selectProductInfo(String p_num) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM PRODUCT WHERE P_NUM=?";
		ProductBean productBean = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, p_num);
			rs = ps.executeQuery();
			if (rs.next()) {
				productBean = new ProductBean();
				productBean.setP_NUM(rs.getString("P_NUM"));
				productBean.setP_NAME(rs.getString("P_NAME"));
				productBean.setP_PRICE(rs.getInt("P_PRICE"));
				productBean.setP_SERVICE(rs.getString("P_SERVICE"));
				productBean.setP_NOTES(rs.getString("P_NOTES"));
				productBean.setP_MORE_INFO(rs.getString("P_MORE_INFO"));
				productBean.setP_IMG(rs.getString("P_IMG"));
			}
		} catch (Exception e) {
			System.out.println("getDetail : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return productBean;
	}

	public MemberBean selectMember(String id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		MemberBean mb = null;
		String sql = "SELECT * FROM MEMBER WHERE MEM_ID=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				mb = new MemberBean();
				mb.setMEM_NAME(rs.getString("MEM_NAME"));
				mb.setMEM_TEL(rs.getString("MEM_TEL"));
			}
		} catch (Exception e) {
			System.out.println("selectMember : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return mb;
	}

	public InfoUseBean selectInfoUse(String p_num, int diff, int price) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		InfoUseBean infoUseBean = null;
		String sql = "SELECT * FROM INFOUSE WHERE SITE_NUM=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, p_num);
			rs = ps.executeQuery();
			if (rs.next()) {
				infoUseBean = new InfoUseBean();
				infoUseBean.setSITE_NUM(rs.getString("SITE_NUM"));
				infoUseBean.setSITE_NAME(rs.getString("SITE_NAME"));
				infoUseBean.setSITE_SIZE(rs.getString("SITE_SIZE"));
				infoUseBean.setSITE_INFO(rs.getString("SITE_INFO"));
			}
			infoUseBean.setDIFF((String) (diff + "박" + (diff + 1) + "일"));
			infoUseBean.setTOTAL(price * diff);
		} catch (Exception e) {
			System.out.println("getInfoUse : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return infoUseBean;
	}

	public ProductBean selectPrice(String p_num) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT P_PRICE FROM PRODUCT WHERE P_NUM=?";
		ProductBean productBean = new ProductBean();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, p_num);
			rs = ps.executeQuery();
			if (rs.next()) {
				productBean.setP_PRICE(rs.getInt("P_PRICE"));
			}
		} catch (Exception e) {
			System.out.println("getDetail : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return productBean;
	}

	public int insert(AuthBean authBean, ReservationBean reservationBean, int total) {
		PreparedStatement ps = null;
		int insertCount = 0;
		String sql = "INSERT INTO RESERVATION (REZ_ID, REZ_NICKNAME, REZ_TEL, REZ_PNUM, REZ_INDATE, REZ_OUTDATE, REZ_TOTAL) VALUES (?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, authBean.getMEM_ID());
			ps.setString(2, authBean.getMEM_NICKNAME());
			ps.setString(3, authBean.getMEM_TEL());
			ps.setString(4, reservationBean.getREZ_PNUM());
			ps.setString(5, reservationBean.getREZ_INDATE());
			ps.setString(6, reservationBean.getREZ_OUTDATE());
			ps.setInt(7, total);
			insertCount = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("insertReservationInfo : " + e);
		} finally {
			close(ps);
		}
		return insertCount;
	}

	public int delete(int rez_num) {
	   PreparedStatement ps = null;
	   int deleteCount = 0;
	   String sql = "DELETE FROM RESERVATION WHERE REZ_NUM=?";
	   try {
		   ps = conn.prepareStatement(sql);
		   ps.setInt(1, rez_num);
		   deleteCount = ps.executeUpdate();
	   } catch (Exception e) {
		   System.out.println("deleteReservation : " + e);
	   } finally {
		   close(ps);
	   }
	   return deleteCount;
   }

	public ReservationBean selectRezInfo(String nickName) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM RESERVATION WHERE REZ_NICKNAME=? ORDER BY REZ_NUM DESC LIMIT 1";

		ReservationBean reservationInfo = new ReservationBean();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, nickName);
			rs = ps.executeQuery();
			if (rs.next()) {
				reservationInfo.setREZ_NUM(rs.getInt("REZ_NUM"));
				reservationInfo.setREZ_NICKNAME(rs.getString("REZ_NICKNAME"));
				reservationInfo.setREZ_TEL(rs.getString("REZ_TEL"));
				reservationInfo.setREZ_PNUM(rs.getString("REZ_PNUM"));
				reservationInfo.setREZ_INDATE(rs.getString("REZ_INDATE"));
				reservationInfo.setREZ_OUTDATE(rs.getString("REZ_OUTDATE"));
				reservationInfo.setREZ_TOTAL(rs.getInt("REZ_TOTAL"));
			}
		} catch (Exception e) {
			System.out.println("getRezInfo : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return reservationInfo;
	}

	public int selectListCount(String fieldName, String searchWord) {
		int listCount = 0;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(
					"SELECT COUNT(*) FROM RESERVATION WHERE " + fieldName + " LIKE '%" + searchWord + "%'");
			rs = ps.executeQuery();
			if (rs.next())
				listCount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("getListCount : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return listCount;
	}

	public ArrayList<ReservationListBean> selectRezList(int page, int limit) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT R.REZ_NUM,R.REZ_ID,M.MEM_NAME,R.REZ_TEL,R.REZ_PNUM,R.REZ_INDATE,R.REZ_OUTDATE,"
				+ "DATEDIFF(R.REZ_OUTDATE,R.REZ_INDATE) AS DIIFDAYS,P.P_PRICE,DATEDIFF(R.REZ_OUTDATE,R.REZ_INDATE)*P.P_PRICE AS REZ_TOTAL "
				+ "FROM RESERVATION R, MEMBER M, PRODUCT P " + "WHERE R.REZ_ID = M.MEM_ID AND R.REZ_PNUM = P.P_NUM "
				+ "ORDER BY REZ_NUM DESC LIMIT ? OFFSET ?;";
		ArrayList<ReservationListBean> rezList = new ArrayList<ReservationListBean>();
		ReservationListBean rezBean = null;
		int startrow = (page - 1) * limit;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, limit);
			ps.setInt(2, startrow);
			rs = ps.executeQuery();
			while (rs.next()) {
				rezBean = new ReservationListBean();
				rezBean.setREZ_NUM(rs.getInt("REZ_NUM"));
				rezBean.setREZ_ID(rs.getString("REZ_ID"));
				rezBean.setREZ_NAME(rs.getString("MEM_NAME"));
				rezBean.setREZ_TEL(rs.getString("REZ_TEL"));
				rezBean.setREZ_PNUM(rs.getString("REZ_PNUM"));
				rezBean.setREZ_INDATE(rs.getDate("REZ_INDATE"));
				rezBean.setREZ_OUTDATE(rs.getDate("REZ_OUTDATE"));
				rezBean.setREZ_DIFFDAYS(rs.getInt("DIIFDAYS") + "박 " + (rs.getInt("DIIFDAYS") + 1) + "일");
				rezBean.setREZ_PRICE(rs.getInt("P_PRICE"));
				rezBean.setREZ_TOTAL(rs.getInt("REZ_TOTAL"));
				rezList.add(rezBean);
			}
		} catch (Exception e) {
			System.out.println("getRezList : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return rezList;
	}

	public ArrayList<ReservationListBean> selectRezMgtList(int page, int limit, String fieldName, String searchWord) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT R.REZ_NUM,R.REZ_ID,M.MEM_NAME,R.REZ_TEL,R.REZ_PNUM,R.REZ_INDATE,R.REZ_OUTDATE,"
				+ "DATEDIFF(R.REZ_OUTDATE,R.REZ_INDATE) AS DIIFDAYS,P.P_PRICE,DATEDIFF(R.REZ_OUTDATE,R.REZ_INDATE)*P.P_PRICE AS REZ_TOTAL "
				+ "FROM RESERVATION R, MEMBER M, PRODUCT P " + "WHERE R.REZ_ID = M.MEM_ID AND R.REZ_PNUM = P.P_NUM AND "
				+ fieldName + " LIKE '%" + searchWord + "%' ORDER BY REZ_NUM DESC LIMIT ? OFFSET ?;";
		ArrayList<ReservationListBean> rezList = new ArrayList<ReservationListBean>();
		ReservationListBean rezBean = null;
		int startrow = (page - 1) * limit;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, limit);
			ps.setInt(2, startrow);
			rs = ps.executeQuery();
			while (rs.next()) {
				rezBean = new ReservationListBean();
				rezBean.setREZ_NUM(rs.getInt("REZ_NUM"));
				rezBean.setREZ_ID(rs.getString("REZ_ID"));
				rezBean.setREZ_NAME(rs.getString("MEM_NAME"));
				rezBean.setREZ_TEL(rs.getString("REZ_TEL"));
				rezBean.setREZ_PNUM(rs.getString("REZ_PNUM"));
				rezBean.setREZ_INDATE(rs.getDate("REZ_INDATE"));
				rezBean.setREZ_OUTDATE(rs.getDate("REZ_OUTDATE"));
				rezBean.setREZ_DIFFDAYS(rs.getInt("DIIFDAYS") + "박 " + (rs.getInt("DIIFDAYS") + 1) + "일");
				rezBean.setREZ_PRICE(rs.getInt("P_PRICE"));
				rezBean.setREZ_TOTAL(rs.getInt("REZ_TOTAL"));
				rezList.add(rezBean);
			}
		} catch (Exception e) {
			System.out.println("getRezList : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return rezList;
	}

	public ReservationListBean selectRezListOne(int rez_num) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		ReservationListBean rezListOne = null;

		String sql = "SELECT R.REZ_NUM,R.REZ_ID,M.MEM_NAME,R.REZ_TEL,R.REZ_PNUM,R.REZ_INDATE,R.REZ_OUTDATE,"
				+ "DATEDIFF(R.REZ_OUTDATE,R.REZ_INDATE) AS DIIFDAYS,P.P_PRICE,DATEDIFF(R.REZ_OUTDATE,R.REZ_INDATE)*P.P_PRICE AS REZ_TOTAL "
				+ "FROM RESERVATION R, MEMBER M, PRODUCT P "
				+ "WHERE R.REZ_ID = M.MEM_ID AND R.REZ_PNUM = P.P_NUM AND R.REZ_NUM=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, rez_num);
			rs = ps.executeQuery();
			if (rs.next()) {
				rezListOne = new ReservationListBean();
				rezListOne.setREZ_NUM(rs.getInt("REZ_NUM"));
				rezListOne.setREZ_ID(rs.getString("REZ_ID"));
				rezListOne.setREZ_NAME(rs.getString("MEM_NAME"));
				rezListOne.setREZ_TEL(rs.getString("REZ_TEL"));
				rezListOne.setREZ_PNUM(rs.getString("REZ_PNUM"));
				rezListOne.setREZ_INDATE(rs.getDate("REZ_INDATE"));
				rezListOne.setREZ_OUTDATE(rs.getDate("REZ_OUTDATE"));
				rezListOne.setREZ_DIFFDAYS(rs.getInt("DIIFDAYS") + "박 " + (rs.getInt("DIIFDAYS") + 1) + "일");
				rezListOne.setREZ_PRICE(rs.getInt("P_PRICE"));
				rezListOne.setREZ_TOTAL(rs.getInt("REZ_TOTAL"));
			}
		} catch (Exception e) {
			System.out.println("getRezList : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return rezListOne;
	}

	public int insertMgt(ReservationBean rezBean) {
		PreparedStatement ps = null;
		int insertCount = 0;
		String sql = "INSERT INTO RESERVATION (REZ_ID, REZ_NICKNAME, REZ_TEL, REZ_PNUM, REZ_INDATE, REZ_OUTDATE, REZ_TOTAL) VALUES (?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, rezBean.getREZ_ID());
			ps.setString(2, rezBean.getREZ_NICKNAME());
			ps.setString(3, rezBean.getREZ_TEL());
			ps.setString(4, rezBean.getREZ_PNUM());
			ps.setString(5, rezBean.getREZ_INDATE());
			ps.setString(6, rezBean.getREZ_OUTDATE());
			ps.setInt(7, rezBean.getREZ_TOTAL());
			insertCount = ps.executeUpdate();

		} catch (Exception e) {
			System.out.println("insertReservationInfo : " + e);
		} finally {
			close(ps);
		}
		return insertCount;
	}

	public int updateMgt(ReservationBean reservationBean) {
		PreparedStatement ps = null;
		int updateCount = 0;
		String sql = "UPDATE RESERVATION SET REZ_TEL=?, REZ_PNUM=?, REZ_INDATE=?, REZ_OUTDATE=? WHERE REZ_NUM=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, reservationBean.getREZ_TEL());
			ps.setString(2, reservationBean.getREZ_PNUM());
			ps.setString(3, reservationBean.getREZ_INDATE());
			ps.setString(4, reservationBean.getREZ_OUTDATE());
			ps.setInt(5, reservationBean.getREZ_NUM());
			System.out.println(sql);
			updateCount = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateReservationInfo : " + e);
		} finally {
			close(ps);
		}
		return updateCount;
	}

	public int deleteMgt(int rez_num) {
		PreparedStatement ps = null;
		int deleteCount = 0;
		String sql = "DELETE FROM RESERVATION WHERE REZ_NUM=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, rez_num);
			deleteCount = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("deleteReservationInfo : " + e);
		} finally {
			close(ps);
		}
		return deleteCount;
	}

	public boolean rezCheck(String pNum, String inDate, String outDate) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean rc = false;
		String sql = "SELECT COUNT(*) cnt FROM RESERVATION WHERE REZ_PNUM=? AND REZ_INDATE < date_format(?,'%Y-%m-%d') AND REZ_OUTDATE > date_format(?,'%Y-%m-%d')";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, pNum);
			ps.setString(2, outDate);
			ps.setString(3, inDate);
			rs = ps.executeQuery();
			if (rs.next()) {
				if (rs.getInt(1) == 0) {
					rc = true;
					if (rc == true) {
						return true;
					}
				} else {
					rc = false;
				}
			}
		} catch (Exception e) {
			System.out.println("rezCheck : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return rc;
	}

	public int rezMgtCheck(String alp, int fDate) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int rmc = 0;
		String tDay = "";
		String nextDate = String.valueOf(fDate);
		int year = Integer.parseInt(nextDate.substring(0, 2));
		int month = Integer.parseInt(nextDate.substring(2, 4));
		int day = Integer.parseInt(nextDate.substring(4, 6)) + 1;
		if (day >= MyCalendar.lastDay(year, month)) {
			month++;
			day = 1;
		}
		if (month >= 13) {
			year++;
			month = 1;
		}
		if (day < 10) {
			tDay = "0" + String.valueOf(day);
		} else {
			tDay = String.valueOf(day);
		}
		if (month < 10) {
			nextDate = "";
			nextDate = String.valueOf(year) + "0" + String.valueOf(month);
		} else {
			nextDate = "";
			nextDate = String.valueOf(year) + String.valueOf(month);
		}
		nextDate += tDay;
		String sql = "SELECT COUNT(*) cnt FROM RESERVATION WHERE REZ_PNUM LIKE ? AND REZ_INDATE < date_format(?,'%Y-%m-%d') AND REZ_OUTDATE > date_format(?,'%Y-%m-%d')";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, alp + "%");
			ps.setString(2, String.valueOf(nextDate));
			ps.setString(3, String.valueOf(fDate));
			rs = ps.executeQuery();
			if (rs.next()) {
				rmc = rs.getInt("cnt");
			}
			switch (rmc) {
			case 0:
				rmc = 4;
				break;
			case 1:
				rmc = 3;
				break;
			case 2:
				rmc = 2;
				break;
			case 3:
				rmc = 1;
				break;
			case 4:
				rmc = 0;
				break;
			}
		} catch (Exception e) {
			System.out.println("rezCheck : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return rmc;
	}
}