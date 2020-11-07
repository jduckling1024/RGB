package OrderManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
