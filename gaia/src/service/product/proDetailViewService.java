package service.product;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.product.ProductDAO;
import javaBean.product.ProductBean;

public class proDetailViewService {
	
	
	public ProductBean showProduct(String p_num)throws Exception{
		ProductBean proBean = null;

		Connection con = getConnection();
		ProductDAO productDAO = ProductDAO.getInstance();
		productDAO.setConnection(con);
		
		proBean = productDAO.showForUpdate(p_num);
		close(con);
		return proBean;
	}
}
