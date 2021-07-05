package service.product;

import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.close;
import java.sql.Connection;

import dao.product.ProductDAO;
import javaBean.product.ProductBean;

public class graDetailViewService {
	
	public ProductBean getProduct(String name) throws Exception{
		ProductBean proBean = null;
		Connection con = getConnection();
		ProductDAO productDAO = ProductDAO.getInstance();
		productDAO.setConnection(con);
		
		
		proBean = productDAO.selectProduct(name);
		close(con);
		
		return proBean;
	}

}
