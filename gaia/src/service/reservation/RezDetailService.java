package service.reservation;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.reservation.RezDAO;
import javaBean.product.ProductBean;
import javaBean.reservation.InfoUseBean;


public class RezDetailService {

	public int getPrice(String p_num) throws Exception {
		Connection con = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(con);
		
		ProductBean productBean = rezDAO.selectPrice(p_num);
		close(con);
		return productBean.getP_PRICE();
	}
	
	
	
	public ProductBean getProductInfo(String p_num) throws Exception {

		ProductBean productInfo = null;
		Connection con = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(con);
		
		productInfo = rezDAO.selectProductInfo(p_num);
		close(con);
		return productInfo;
	}

	public InfoUseBean getInfoUse(String p_num, int diff, int price) throws Exception {

		InfoUseBean infoUse = null;
		Connection con = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(con);
		
		infoUse = rezDAO.selectInfoUse(p_num, diff, price);
		close(con);
		return infoUse;
	}
}
