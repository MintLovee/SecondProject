package dao.product;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.sql.DataSource;

import javaBean.product.ProductBean;


public class ProductDAO {
	DataSource ds;		Connection conn;
	
	private static ProductDAO productDAO;
	private ProductDAO() {}
	public static ProductDAO getInstance() {
		if (productDAO == null) {
			productDAO = new ProductDAO();
		}
		return productDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	
	
	public int insertProduct(ProductBean proBean) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "INSERT into PRODUCT (P_NUM, P_NAME, P_PRICE, P_SERVICE, P_NOTES, P_MORE_INFO, P_IMG) VALUES (?,?,?,?,?,?,?)";
		int insertCount = 0;
		System.out.println(proBean.getP_NUM());
		try {
			ps = conn.prepareStatement(sql);
				ps.setString(1, proBean.getP_NUM());
				ps.setString(2, proBean.getP_NAME());
				ps.setInt(3, proBean.getP_PRICE());
				ps.setString(4, proBean.getP_SERVICE());
				ps.setString(5, proBean.getP_NOTES());
				ps.setString(6, proBean.getP_MORE_INFO());
				ps.setString(7, proBean.getP_IMG());
				insertCount = ps.executeUpdate();
			} catch (Exception e) {System.out.println("ProductInsert : " + e);}
		finally {	close(ps);}
		return insertCount;
		
	}
	public int UpdateProduct(ProductBean proBean) {
		PreparedStatement ps = null;
		int updateCount = 0;
		String sql = "UPDATE PRODUCT set P_NAME=?, P_PRICE=?, "
				+ "P_SERVICE=?, P_NOTES=?, P_MORE_INFO=?, P_IMG=? "
				+ "WHERE P_NUM =? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, proBean.getP_NAME());
			ps.setInt(2, proBean.getP_PRICE());
			ps.setString(3, proBean.getP_SERVICE());
			ps.setString(4, proBean.getP_NOTES());
			ps.setString(5, proBean.getP_MORE_INFO());
			ps.setString(6, proBean.getP_IMG());
			ps.setString(7, proBean.getP_NUM());
			updateCount = ps.executeUpdate();
		} catch (Exception e) {System.out.println("ProductUpdate : " + e);}
		finally {	close(ps);}
		return updateCount;
	}
	
	public int DeleteProduct(String P_NUM) {
		PreparedStatement ps = null;
		String sql = "DELETE FROM PRODUCT WHERE P_NUM=?";
		int deleteCount = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, P_NUM);
			deleteCount = ps.executeUpdate();
		} catch (Exception e) {System.out.println("ProductDelete : " + e);}
		finally {	close(ps);}
		return deleteCount;
	}
	
	public ProductBean selectProduct(String p_num) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		ProductBean proBean = null;
		try {
			ps = conn.prepareStatement("SELECT * FROM product WHERE P_NAME=? LIMIT 1");
			ps.setString(1, p_num);
			rs = ps.executeQuery();
			if (rs.next()) {
				proBean = new ProductBean();
				proBean.setP_NUM(rs.getString("P_NUM"));
				proBean.setP_NAME(rs.getString("P_NAME"));
				proBean.setP_PRICE(rs.getInt("P_PRICE"));
				proBean.setP_SERVICE(rs.getString("P_SERVICE"));
				proBean.setP_NOTES(rs.getString("P_NOTES"));
				proBean.setP_MORE_INFO(rs.getString("P_MORE_INFO"));
				proBean.setP_IMG(rs.getString("P_IMG"));
			}
		} catch (Exception e) {System.out.println("getDetail : " + e);}
		finally {close(rs);		close(ps);}
		return proBean;
	}
		
		public ProductBean showForUpdate(String p_num) {
			PreparedStatement ps = null;
			ResultSet rs = null;
			ProductBean proBean = null;
			try {
				ps = conn.prepareStatement("SELECT * FROM product WHERE P_NUM=?");
				ps.setString(1, p_num);
				rs = ps.executeQuery();
				if (rs.next()) {
					proBean = new ProductBean();
					proBean.setP_NUM(rs.getString("P_NUM"));
					proBean.setP_NAME(rs.getString("P_NAME"));
					proBean.setP_PRICE(rs.getInt("P_PRICE"));
					proBean.setP_SERVICE(rs.getString("P_SERVICE"));
					proBean.setP_NOTES(rs.getString("P_NOTES"));
					proBean.setP_MORE_INFO(rs.getString("P_MORE_INFO"));
					proBean.setP_IMG(rs.getString("P_IMG"));
				}
			} catch (Exception e) {System.out.println("getDetail : " + e);}
			finally {close(rs);		close(ps);}
			return proBean;
	}
	public ArrayList<ProductBean> selectProductAll() {
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<ProductBean> productList = new ArrayList<ProductBean>();
		ProductBean proBean = null;
		String proList = "SELECT * FROM product";
		try {
			ps = conn.prepareStatement(proList);
			rs = ps.executeQuery();
			while (rs.next()) {
				proBean = new ProductBean();
				proBean.setP_NUM(rs.getString("P_NUM"));
				proBean.setP_NAME(rs.getString("P_NAME"));
				proBean.setP_PRICE(rs.getInt("P_PRICE"));
				proBean.setP_SERVICE(rs.getString("P_SERVICE"));
				proBean.setP_NOTES(rs.getString("P_NOTES"));
				proBean.setP_MORE_INFO(rs.getString("P_MORE_INFO"));
				proBean.setP_IMG(rs.getString("P_IMG"));
				productList.add(proBean);
			}
		} catch (Exception e) {System.out.println("getDetail : " + e);}
		finally {close(rs);		close(ps);}
		return productList;
	}
	
}
