package service.reservation;

import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.close;

import java.sql.Connection;
import java.util.ArrayList;

import dao.reservation.RezDAO;
import javaBean.product.ProductBean;
import javaBean.reservation.ReservationListBean;

public class RezMgtUpdateService {
	public ReservationListBean getRezListOne(int rez_num) throws Exception{
		
		Connection con = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(con);
		
		ReservationListBean rezListOne = rezDAO.selectRezListOne(rez_num);
		close(con);
		return rezListOne;
	}
	
	public ArrayList<ProductBean> getProductList() throws Exception {
		ArrayList<ProductBean> productList = null;
		Connection conn = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(conn);
		productList = rezDAO.selectProductList();
		close(conn);
		return productList;
	}
}
