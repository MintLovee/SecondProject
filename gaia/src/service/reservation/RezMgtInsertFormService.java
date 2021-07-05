package service.reservation;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.reservation.RezDAO;
import javaBean.member.MemberBean;
import javaBean.product.ProductBean;

public class RezMgtInsertFormService {
	public ArrayList<ProductBean> getProductList() throws Exception {
		ArrayList<ProductBean> productList = null;
		Connection conn = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(conn);
		productList = rezDAO.selectProductList();
		close(conn);
		return productList;
	}
	
	public MemberBean searchID(String id) throws Exception {
		MemberBean mb = null;
		Connection conn = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(conn);
		mb = rezDAO.selectMember(id);
		close(conn);
		return mb;
	}
	
	public boolean rezMgtInsertCheck(String pNum, String inDate, String outDate) throws Exception {
		System.out.println("제발...");
		boolean rmic = false;
		Connection conn = getConnection();
		RezDAO rezDAO = RezDAO.getInstance();
		rezDAO.setConnection(conn);
		rmic = rezDAO.rezCheck(pNum, inDate, outDate);
		close(conn);
		return rmic;
	}
}
