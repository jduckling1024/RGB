package CartManagement;

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
		sql = "SELECT * \r\n"
				+ "FROM cart, product, image\r\n"
				+ "where memberId = ? and image.use = 201 and cart.productId = image.divisionId and cart.productId = product.id;";
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
			productDTO.setName(res.getString(5));
			productDTO.setPrice(res.getInt(11));
			productDTO.setBrand(res.getString(13));
			productDTO.setColor(res.getString(17));
			imageDTO.setPath(res.getString(21));
			obj[0] = cartDTO;
			obj[1] = productDTO;
			obj[2] = imageDTO;
			cartList.add(obj);
		}
		
		return cartList;
	}
	
	public void register(CartDTO cartDTO) {
		
	}
	
	public void delete(int id) {
		
	}
}
