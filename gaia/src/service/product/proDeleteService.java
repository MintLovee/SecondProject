package service.product;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.product.ProductDAO;

public class proDeleteService {
	
	
	
	public boolean deleteProduct(String p_num) throws Exception{
		boolean isDelete = false;
		Connection con = getConnection();
		ProductDAO productDAO = ProductDAO.getInstance();
		productDAO.setConnection(con);
		int delete =productDAO.DeleteProduct(p_num);
		if(delete>0) {
			commit(con);
			isDelete = true;
		}else {
			rollback(con);
		}
		close(con);
		return isDelete;
	}

}
