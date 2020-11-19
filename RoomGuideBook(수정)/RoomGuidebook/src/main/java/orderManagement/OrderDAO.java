package orderManagement;

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
import dto.MemberDTO;
import dto.OrderDTO;
import dto.PaymentDTO;
import dto.ProductDTO;
import dto.UserDTO;

@Repository("orderDAO")
public class OrderDAO {
	
	@Autowired
	BasicDataSource dataSource;

	UserDTO userDTO = new UserDTO();
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet res;
	String sql;

	
	public List<Object[]> getFurnitureForOrder(String memberId, int productId) throws SQLException{
		List<Object[]> list;
		Object[] obj;
		try {
			list = new ArrayList<Object[]>();
			obj = new Object[4];
			MemberDTO memberDTO = new MemberDTO(); // 1
//			CartDTO cartDTO = new CartDTO(); // 2
			ProductDTO productDTO = new ProductDTO(); // 3
			ImageDTO imageDTO = new ImageDTO(); // 4
			
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			sql = "SELECT u.id, u.name, m.phoneNum, m.address, m.email FROM rgb.user as u, rgb.member as m where u.id = m.id and u.id = ?;"; // 회원 정보
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, memberId);
			res = psmt.executeQuery();
			
			while(res.next()) {
				memberDTO.setId(res.getString(1));
				memberDTO.setName(res.getString(2));
				memberDTO.setPhoneNum(res.getString(3));
				memberDTO.setAddress(res.getString(4));
				memberDTO.setEmail(res.getString(5));
			}
			
			obj[0] = memberDTO;
			
			sql = "select * from product, image where product.id = ? and product.id = image.divisionId and image.use = 201;"; // 상품 정보
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, productId);
			res = psmt.executeQuery();
			
			while(res.next()) {
				productDTO.setName(res.getString(2));
				productDTO.setPrice(res.getInt(8));
				imageDTO.setPath(res.getString(18));
			}
			
			obj[2] = productDTO;
			obj[3] = imageDTO;

			conn.commit();
		} 
		catch (SQLException e) {
			conn.rollback();
			throw new SQLException();
		} finally {
			conn.setAutoCommit(true);
			
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
		
		list.add(obj);
		return list;
	}
	
	public List<Object[]> listForMember(String memberId) throws SQLException{
		conn = dataSource.getConnection();
		sql = "select *, (cart.count * product.price) as eachTotal\r\n"
				+ "from (SELECT u.id, u.name, m.phoneNum, m.address, m.email FROM rgb.user as u, rgb.member as m where u.id = m.id) as memberInfo, cart, product, image\r\n"
				+ "where memberId = ? and memberInfo.id = memberId and cart.productId = product.id and product.id = image.divisionId\r\n"
				+ "and image.use = 201;";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, memberId);
		res = psmt.executeQuery();
		
		List<Object[]> cartList = new ArrayList<Object[]>();
		int cnt = 0;
		while(res.next()) {
			Object[] obj = new Object[4];
			MemberDTO memberDTO = new MemberDTO(); // 1
			CartDTO cartDTO = new CartDTO(); // 2
			ProductDTO productDTO = new ProductDTO(); // 3
			ImageDTO imageDTO = new ImageDTO(); // 4
			
			if(cnt == 0) {
				memberDTO.setId(memberId);
				memberDTO.setName(res.getString(2));
				memberDTO.setPhoneNum(res.getString(3));
				memberDTO.setAddress(res.getString(4));
				memberDTO.setEmail(res.getString(5));
				
				cartDTO.setCount(res.getInt(3+5));
				productDTO.setId(res.getInt(2+5));
				productDTO.setName(res.getString(5+5));
				productDTO.setBrand(res.getString(13+5));
				productDTO.setColor(res.getString(17+5));
				imageDTO.setPath(res.getString(21+5)); 
				productDTO.setPrice(res.getInt(22+5));
				obj[0] = memberDTO;
				obj[1] = cartDTO;
				obj[2] = productDTO;
				obj[3] = imageDTO;
				cartList.add(obj);
			}else {
				cartDTO.setCount(res.getInt(3+5));
				productDTO.setId(res.getInt(2+5));
				productDTO.setName(res.getString(5+5));
				productDTO.setBrand(res.getString(13+5));
				productDTO.setColor(res.getString(17+5));
				imageDTO.setPath(res.getString(21+5)); 
				productDTO.setPrice(res.getInt(22+5));
				obj[1] = cartDTO;
				obj[2] = productDTO;
				obj[3] = imageDTO;
				
			}
			
			cnt++;
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
	
	public List<Object[]> listForSeller(String sellerId) throws SQLException{
		conn = dataSource.getConnection();
		sql = "SELECT ord.id, ord.userId, product.name, ord.amount, payment.amountSum, payment.paidAmount, pg.state, ord.purchaseDate\r\n"
				+ "FROM product, rgb.order as ord, payment, code as pg\r\n"
				+ "where product.sellerId = ? and product.id = ord.productId and ord.id = payment.id and payment.progress = pg.code;";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, sellerId);
		res = psmt.executeQuery();
		
		List<Object[]> list = new ArrayList<Object[]>();
		while(res.next()) {
			Object[] obj = new Object[3];
			ProductDTO productDTO = new ProductDTO();
			OrderDTO orderDTO = new OrderDTO();
			PaymentDTO paymentDTO = new PaymentDTO();
			
			orderDTO.setOrderId(res.getInt(1));
			orderDTO.setUserId(res.getString(2));
			productDTO.setName(res.getString(3));
			orderDTO.setAmount(res.getInt(4));
			paymentDTO.setAmountSum(res.getInt(5));
			paymentDTO.setPaidAmount(res.getInt(6));
			paymentDTO.setProgress(res.getString(7));
			orderDTO.setPurchaseDate(res.getString(8));
			
			obj[0] = productDTO;
			obj[1] = orderDTO;
			obj[2] = paymentDTO;
			
			list.add(obj);
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
		
		return list;
	}
}
