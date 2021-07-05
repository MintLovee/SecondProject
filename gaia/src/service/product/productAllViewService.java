package service.product;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.product.ProductDAO;
import javaBean.product.ProductBean;

public class productAllViewService {
	public ArrayList<ProductBean> getProduct() throws Exception{
		ArrayList<ProductBean> productList = null;
		Connection con = getConnection();
		ProductDAO productDAO = ProductDAO.getInstance();
		productDAO.setConnection(con);
		productList = productDAO.selectProductAll();
		
		close(con);
		return productList;
	}

}
