package service.product;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.product.ProductDAO;
import javaBean.product.ProductBean;

public class proInsertService {
	public boolean insertProduct(ProductBean proBean) throws Exception{
		
		boolean InsertSuccess = false;
		
		Connection con = getConnection();
		ProductDAO productDAO = ProductDAO.getInstance();
		productDAO.setConnection(con);
		int InsertDone = productDAO.insertProduct(proBean);
		
		if(InsertDone > 0) {
			commit(con); InsertSuccess = true;
		}else {
			rollback(con);
		}
		close(con);
		return InsertSuccess;
	}
}
