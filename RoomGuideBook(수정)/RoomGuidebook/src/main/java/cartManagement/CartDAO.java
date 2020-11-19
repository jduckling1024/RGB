package cartManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.CartDTO;
import dto.ImageDTO;
import dto.ProductDTO;

@Repository("cartDAO")
public class CartDAO {
	@Autowired
	BasicDataSource dataSource;
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet res;
	String sql;
	
	public List<Object[]> getList(String id) throws SQLException{
		conn = dataSource.getConnection();
		sql = "select *, (cart.count * product.price) as eachTotal\r\n"
				+ "from cart, product, image\r\n"
				+ "where memberId = ? and cart.productId = product.id and product.id = image.divisionId\r\n"
				+ "and image.use = 201;";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		res = psmt.executeQuery();
		
		List<Object[]> cartList = new ArrayList<Object[]>();
		while(res.next()) {
			CartDTO cartDTO = new CartDTO(); // 1
			ProductDTO productDTO = new ProductDTO(); // 2
			ImageDTO imageDTO = new ImageDTO(); // 3
			Object[] obj = new Object[3];
			cartDTO.setMemberId(res.getString(1));
			cartDTO.setCount(res.getInt(3));
			productDTO.setId(res.getInt(2));
			productDTO.setName(res.getString(5));
			productDTO.setBrand(res.getString(13));
			productDTO.setColor(res.getString(17));
			imageDTO.setPath("/resources/image_pmain/" + res.getString(21)); 
			productDTO.setPrice(res.getInt(22));
			obj[0] = cartDTO;
			obj[1] = productDTO;
			obj[2] = imageDTO;
			cartList.add(obj);
		}
		
		if(res != null) {
			res.close();
		}
		if(psmt != null) {
			psmt.close();
		}
		if(conn != null) {
			conn.close();
		}
		
		return cartList;
	}
	
	public void register(CartDTO cartDTO) throws SQLException {
		conn = dataSource.getConnection();
		sql = "INSERT INTO cart (`memberId`, `productId`, `count`) VALUES (?, ?, ?)\r\n"
				+ "ON DUPLICATE KEY UPDATE count = count + 1;";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, cartDTO.getMemberId());
		psmt.setInt(2, cartDTO.getProductId());
		psmt.setInt(3, cartDTO.getCount());
		
		psmt.executeUpdate();
		
		if(res != null) {
			res.close();
		}
		if(psmt != null) {
			psmt.close();
		}
		if(conn != null) {
			conn.close();
		}
	}
	
	public void delete(String[] list) throws SQLException {
		conn = dataSource.getConnection();
		sql = "DELETE FROM cart WHERE `memberId` = 'jduck1024' AND productId = ?";
		for(int i = 0; i < list.length - 1; i++) {
			sql += " OR productId = ?";
		}
		
		sql += ";";
		
		psmt = conn.prepareStatement(sql);
		for(int i = 0; i < list.length; i++) {
			psmt.setString(i + 1, list[i]);
		}
		
		System.out.println(sql);
		psmt.executeUpdate();
		
		if(res != null) {
			res.close();
		}
		if(psmt != null) {
			psmt.close();
		}
		if(conn != null) {
			conn.close();
		}
	}
}
