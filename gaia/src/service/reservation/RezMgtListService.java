package service.reservation;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.reservation.RezDAO;
import javaBean.reservation.ReservationListBean;

public class RezMgtListService {
	public int getListCount(String fieldName, String searchWord) throws Exception{
		int listCount = 0;
		Connection con = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(con);
		listCount = rezDAO.selectListCount(fieldName, searchWord);
		close(con);
		return listCount;
	}
	
	public ArrayList<ReservationListBean> getRezList(int page, int limit, String fieldName, String searchWord) throws Exception{
		
		ArrayList<ReservationListBean> rezList = null;
		Connection con = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(con);
		rezList = rezDAO.selectRezMgtList(page, limit, fieldName, searchWord);
		close(con);
		return rezList;
	}
	
	public static int rezMgtCheck(String alp, int fDate) throws Exception {
		int rmc = 0;
		Connection conn = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(conn);
		rmc = rezDAO.rezMgtCheck(alp, fDate);
		close(conn);
		return rmc;
	}
}
