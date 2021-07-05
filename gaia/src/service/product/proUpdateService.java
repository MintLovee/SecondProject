package service.product;

import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.rollback;
import static db.JdbcUtil.close;

import java.sql.Connection;

import dao.product.ProductDAO;
import javaBean.product.ProductBean;

public class proUpdateService {
	
	public boolean UpdateSuccess(ProductBean proBean) throws Exception{
		
		boolean updateDone = false;
		Connection con = getConnection();
		ProductDAO productDAO = ProductDAO.getInstance();
		productDAO.setConnection(con);
		int updateCount = productDAO.UpdateProduct(proBean);
		
		if(updateCount > 0) {
			commit(con);
			updateDone= true;
		}else {
			rollback(con);
		}
		close(con);
		return updateDone;
	}
}
