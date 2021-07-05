package service.reservation;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.reservation.RezDAO;
import javaBean.product.ProductBean;
import javaBean.reservation.ReservationBean;

public class RezListService {
	public ArrayList<ProductBean> getProductList() throws Exception {
		ArrayList<ProductBean> productList = null;
		Connection conn = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(conn);
		productList = rezDAO.selectProductList();
		close(conn);
		return productList;
	}
	
	public ArrayList<ReservationBean> getRezList() throws Exception {
		ArrayList<ReservationBean> rezList = null;
		Connection conn = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(conn);
		rezList = rezDAO.selectRezList();
		close(conn);
		return rezList;
	}
	
	public static boolean rezCheck(String pNum, String inDate, String outDate) throws Exception {
		boolean rc = false;
		Connection conn = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(conn);
		rc = rezDAO.rezCheck(pNum, inDate, outDate);
		close(conn);
		return rc;
	}
}
