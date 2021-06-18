/*
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
				productDTO.setId(res.getInt(1));
				productDTO.setName(res.getString(2));
				productDTO.setPrice(res.getInt(8));
				imageDTO.setPath("/resources/image_pmain/" + res.getString(18));
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
		sql = "select *, (cart.amount * product.price) as eachTotal\r\n"
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
				
				cartDTO.setAmount(res.getInt(3+5));
				productDTO.setId(res.getInt(2+5));
				productDTO.setName(res.getString(5+5));
				productDTO.setBrand(res.getString(13+5));
				productDTO.setColor(res.getString(17+5));
				imageDTO.setPath("/resources/image_pmain/" + res.getString(21+5)); 
				productDTO.setPrice(res.getInt(22+5));
				obj[0] = memberDTO;
				obj[1] = cartDTO;
				obj[2] = productDTO;
				obj[3] = imageDTO;
			}else {
				cartDTO.setAmount(res.getInt(3+5));
				productDTO.setId(res.getInt(2+5));
				productDTO.setName(res.getString(5+5));
				productDTO.setBrand(res.getString(13+5));
				productDTO.setColor(res.getString(17+5));
				imageDTO.setPath("/resources/image_pmain/" + res.getString(21+5)); 
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
		
		System.out.println("배열 크기" + cartList.size());
		
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

	public void purchase(String userId, List<OrderDTO> orderList, PaymentDTO paymentDTO, int priceSum) throws SQLException {
		
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			
			sql = "select o.id \r\n"
					+ "from rgb.order as o \r\n"
					+ "order by o.id desc limit 1;";
			psmt = conn.prepareStatement(sql);
			res = psmt.executeQuery();
			
			int startId = 0;
			while(res.next()) {
				startId = res.getInt(1);
				break;
			}
			startId++;
			
			for(int i = 0; i < orderList.size(); i++) {
				sql = "INSERT INTO `rgb`.`order` (`id`, `productId`, `userId`, `amount`, `purchaseDate`) VALUES (?, ?, ?, ?, current_timestamp());";
				psmt = conn.prepareStatement(sql);
				System.out.println("상품아이디" + orderList.get(i).getProductId());
				psmt.setInt(1, startId);
;				psmt.setInt(2, orderList.get(i).getProductId());
				psmt.setString(3, orderList.get(i).getUserId());
				psmt.setInt(4, orderList.get(i).getAmount());
			
				psmt.executeUpdate();
			}
			
			sql = "INSERT INTO `rgb`.`payment` (`id`, `amountSum`, `paidAmount`, `cancellationStatus`, `progress`, `name`, `phoneNum`, `address`, `email`, `paymentMethod`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,  startId);
			psmt.setInt(2, priceSum);
			psmt.setInt(3, 0);
			psmt.setInt(4, 0);
			psmt.setInt(5, 101);
			psmt.setString(6, paymentDTO.getName());
			psmt.setString(7,  paymentDTO.getPhoneNum());
			psmt.setString(8,  paymentDTO.getAddress());
			psmt.setString(9,  paymentDTO.getEmail());
			psmt.setString(10, paymentDTO.getPaymentMethod());
			
			psmt.executeUpdate();
			
			sql = "delete from cart where cart.memberId = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, userId);
			psmt.executeUpdate();
			
			conn.commit();
		} 
		catch (SQLException e) {
			e.printStackTrace();
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
	}
	
	public List<Object[]> getPaymentList(String memberName) throws SQLException{
		List<Object[]> list = new ArrayList<Object[]>();
		
		try {
			conn = dataSource.getConnection();
			
			sql = "select product.id, product.name, product.brand, o.amount, product.color, product.price * o.amount as price, c.state as progress, o.purchaseDate, i.path\r\n"
					+ "from product, rgb.order as o, rgb.code as c, payment as p, image as i\r\n"
					+ "where product.id = i.divisionId and i.use = 201 and o.id = p.id and p.progress = c.code and product.id = o.productId and o.userId = ?;";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, memberName);
			
			res = psmt.executeQuery();
			
			Integer[] progress = new Integer[5];
			
			for(int i = 0; i < progress.length; i++) {
				progress[0] = 0;
			}
			
			while(res.next()) {
				Object[] obj = new Object[4];
				ProductDTO productDTO = new ProductDTO();
				OrderDTO orderDTO = new OrderDTO();
				PaymentDTO paymentDTO = new PaymentDTO();
				ImageDTO imageDTO = new ImageDTO();
				productDTO.setId(res.getInt(1));
				productDTO.setName(res.getString(2));
				productDTO.setBrand(res.getString(3));
				orderDTO.setAmount(res.getInt(4));
				productDTO.setColor(res.getString(5));
				paymentDTO.setAmountSum(res.getInt(6)); // 여기서 얘는 각 물건을 몇 개 샀는지를 담는 용도
				paymentDTO.setProgress(res.getString(7));
				orderDTO.setPurchaseDate(res.getString(8));
				imageDTO.setPath("/resources/image_pmain/" + res.getString(9));
				
				String tempProgress = paymentDTO.getProgress();
				
				if(tempProgress.equals("입금전")) {
					progress[0]++;
				}else if(tempProgress.equals("입금완료")) {
					progress[1]++;
				}else if(tempProgress.equals("상품준비중")) {
					progress[2]++;
				}else if(tempProgress.equals("배송중")) {
					progress[3]++;
				}else {
					progress[4]++;
				}
				
				obj[0] = productDTO;
				obj[1] = orderDTO;
				obj[2] = paymentDTO;
				obj[3] = imageDTO;
				
				list.add(obj);
			}
			
			list.add(progress);
			for(int i = 0; i < progress.length; i++) {
				System.out.print(progress[i] + " ");
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
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

*/

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

	public List<Object[]> getFurnitureForOrder(String memberId, int productId) throws SQLException {
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
			sql = "SELECT u.id, u.name, m.phoneNum, m.address, m.email FROM rgb.user as u, rgb.member as m where u.id = m.id and u.id = ?;"; // 회원
																																				// 정보
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, memberId);
			res = psmt.executeQuery();

			while (res.next()) {
				memberDTO.setId(res.getString(1));
				memberDTO.setName(res.getString(2));
				memberDTO.setPhoneNum(res.getString(3));
				memberDTO.setAddress(res.getString(4));
				memberDTO.setEmail(res.getString(5));
			}

			obj[0] = memberDTO;

			sql = "select * from product, image where product.id = ? and product.id = image.divisionId and image.use = 201;"; // 상품
																																// 정보
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, productId);
			res = psmt.executeQuery();

			while (res.next()) {
				productDTO.setId(res.getInt(1));
				productDTO.setName(res.getString(2));
				productDTO.setPrice(res.getInt(8));
				imageDTO.setPath("/resources/image_pmain/" + res.getString(18));
			}

			obj[2] = productDTO;
			obj[3] = imageDTO;

			conn.commit();
		} catch (SQLException e) {
			conn.rollback();
			throw new SQLException();
		} finally {
			conn.setAutoCommit(true);

			if (res != null) {
				res.close();
			}
			if (psmt != null) {
				psmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}

		list.add(obj);
		return list;
	}

	public List<Object[]> listForMember(String memberId) throws SQLException {
		conn = dataSource.getConnection();
		sql = "select *, (cart.amount * product.price) as eachTotal\r\n"
				+ "from (SELECT u.id, u.name, m.phoneNum, m.address, m.email FROM rgb.user as u, rgb.member as m where u.id = m.id) as memberInfo, cart, product, image\r\n"
				+ "where memberId = ? and memberInfo.id = memberId and cart.productId = product.id and product.id = image.divisionId\r\n"
				+ "and image.use = 201;";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, memberId);
		res = psmt.executeQuery();

		List<Object[]> cartList = new ArrayList<Object[]>();
		int cnt = 0;
		while (res.next()) {
			Object[] obj = new Object[4];
			MemberDTO memberDTO = new MemberDTO(); // 1
			CartDTO cartDTO = new CartDTO(); // 2
			ProductDTO productDTO = new ProductDTO(); // 3
			ImageDTO imageDTO = new ImageDTO(); // 4

			if (cnt == 0) {
				memberDTO.setId(memberId);
				memberDTO.setName(res.getString(2));
				memberDTO.setPhoneNum(res.getString(3));
				memberDTO.setAddress(res.getString(4));
				memberDTO.setEmail(res.getString(5));

				cartDTO.setAmount(res.getInt(3 + 5));
				productDTO.setId(res.getInt(2 + 5));
				productDTO.setName(res.getString(5 + 5));
				productDTO.setBrand(res.getString(13 + 5));
				productDTO.setColor(res.getString(17 + 5));
				imageDTO.setPath("/resources/image_pmain/" + res.getString(21 + 5));
				productDTO.setPrice(res.getInt(22 + 5));
				obj[0] = memberDTO;
				obj[1] = cartDTO;
				obj[2] = productDTO;
				obj[3] = imageDTO;
			} else {
				cartDTO.setAmount(res.getInt(3 + 5));
				productDTO.setId(res.getInt(2 + 5));
				productDTO.setName(res.getString(5 + 5));
				productDTO.setBrand(res.getString(13 + 5));
				productDTO.setColor(res.getString(17 + 5));
				imageDTO.setPath("/resources/image_pmain/" + res.getString(21 + 5));
				productDTO.setPrice(res.getInt(22 + 5));
				obj[1] = cartDTO;
				obj[2] = productDTO;
				obj[3] = imageDTO;
			}

			cnt++;
			cartList.add(obj);

		}

		if (res != null) {
			res.close();
		}
		if (psmt != null) {
			psmt.close();
		}
		if (conn != null) {
			conn.close();
		}

		System.out.println("배열 크기" + cartList.size());

		return cartList;
	}

	public List<Object[]> listForSeller(String sellerId) throws SQLException {
		conn = dataSource.getConnection();
		sql = "SELECT ord.id, ord.userId, product.name, ord.amount, payment.amountSum, payment.paidAmount, pg.state, ord.purchaseDate\r\n"
				+ "FROM product, rgb.order as ord, payment, code as pg\r\n"
				+ "where product.sellerId = ? and product.id = ord.productId and ord.id = payment.id and payment.progress = pg.code;";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, sellerId);
		res = psmt.executeQuery();

		List<Object[]> list = new ArrayList<Object[]>();
		while (res.next()) {
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

		if (res != null) {
			res.close();
		}
		if (psmt != null) {
			psmt.close();
		}
		if (conn != null) {
			conn.close();
		}

		return list;
	}

	public void purchase(String userId, List<OrderDTO> orderList, PaymentDTO paymentDTO, int priceSum)
			throws SQLException {

		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);

			sql = "select o.id \r\n" + "from rgb.order as o \r\n" + "order by o.id desc limit 1;";
			psmt = conn.prepareStatement(sql);
			res = psmt.executeQuery();

			int startId = 0;
			while (res.next()) {
				startId = res.getInt(1);
				break;
			}
			startId++;

			for (int i = 0; i < orderList.size(); i++) {
				sql = "INSERT INTO `rgb`.`order` (`id`, `productId`, `userId`, `amount`, `purchaseDate`) VALUES (?, ?, ?, ?, current_timestamp());";
				psmt = conn.prepareStatement(sql);
				System.out.println("상품아이디" + orderList.get(i).getProductId());
				psmt.setInt(1, startId);
				;
				psmt.setInt(2, orderList.get(i).getProductId());
				psmt.setString(3, orderList.get(i).getUserId());
				psmt.setInt(4, orderList.get(i).getAmount());

				psmt.executeUpdate();
			}

			sql = "INSERT INTO `rgb`.`payment` (`id`, `amountSum`, `paidAmount`, `cancellationStatus`, `progress`, `name`, `phoneNum`, `address`, `email`, `paymentMethod`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, startId);
			psmt.setInt(2, priceSum);
			psmt.setInt(3, 0);
			psmt.setInt(4, 0);
			psmt.setInt(5, 101);
			psmt.setString(6, paymentDTO.getName());
			psmt.setString(7, paymentDTO.getPhoneNum());
			psmt.setString(8, paymentDTO.getAddress());
			psmt.setString(9, paymentDTO.getEmail());
			psmt.setString(10, paymentDTO.getPaymentMethod());

			psmt.executeUpdate();

			sql = "delete from cart where cart.memberId = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, userId);
			psmt.executeUpdate();

			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			throw new SQLException();
		} finally {
			conn.setAutoCommit(true);

			if (res != null) {
				res.close();
			}
			if (psmt != null) {
				psmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	public List<Object[]> getPaymentList(String memberName) throws SQLException {
		List<Object[]> list = new ArrayList<Object[]>();

		try {
			conn = dataSource.getConnection();

			sql = "select product.id, product.name, product.brand, o.amount , product.color, product.price * o.amount as price, p.cancellationStatus , c.state as progress, o.purchaseDate, i.path\r\n"
					+ "	from product, image, rgb.order as o, rgb.code as c, payment as p, image as i\r\n"
					+ "	where image.use = 201 and product.id = image.divisionId and o.productId = product.id and o.id = p.id\r\n"
					+ "	and p.progress = c.code and i.use = 201 and i.divisionId = p.id and o.userId = ? order by o.purchaseDate desc;";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, memberName);

			res = psmt.executeQuery();

			Integer[] progress = new Integer[5];

			for (int i = 0; i < progress.length; i++) {
				progress[0] = 0;
			}

			while (res.next()) {
				Object[] obj = new Object[4];
				ProductDTO productDTO = new ProductDTO();
				OrderDTO orderDTO = new OrderDTO();
				PaymentDTO paymentDTO = new PaymentDTO();
				ImageDTO imageDTO = new ImageDTO();
				productDTO.setId(res.getInt(1));
				productDTO.setName(res.getString(2));
				productDTO.setBrand(res.getString(3));
				orderDTO.setAmount(res.getInt(4));
				productDTO.setColor(res.getString(5));
				paymentDTO.setAmountSum(res.getInt(6)); // 여기서 얘는 각 물건을 몇 개 샀는지를 담는 용도
				int isCanceled = res.getInt(7);

				if (isCanceled == 1) {
					paymentDTO.setProgress("취소신청");
				} else {
					paymentDTO.setProgress(res.getString(8));
				}

				orderDTO.setPurchaseDate(res.getString(9));
				imageDTO.setPath("/resources/image_pmain/" + res.getString(10));

				String tempProgress = paymentDTO.getProgress();

				if (tempProgress.equals("입금전")) {
					progress[0]++;
				} else if (tempProgress.equals("입금완료")) {
					progress[1]++;
				} else if (tempProgress.equals("상품준비중")) {
					progress[2]++;
				} else if (tempProgress.equals("배송중")) {
					progress[3]++;
				} else if (tempProgress.equals("배송 완료")) {
					progress[4]++;
				}

				obj[0] = productDTO;
				obj[1] = orderDTO;
				obj[2] = paymentDTO;
				obj[3] = imageDTO;

				list.add(obj);
			}

			list.add(progress);
			for (int i = 0; i < progress.length; i++) {
				System.out.print(progress[i] + " ");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (res != null) {
			res.close();
		}
		if (psmt != null) {
			psmt.close();
		}
		if (conn != null) {
			conn.close();
		}

		return list;
	}

	public void cancel(String[] checked) throws SQLException {
		conn = dataSource.getConnection();

		for (int i = 0; i < checked.length; i++) {
			sql = "UPDATE `rgb`.`payment` SET `cancellationStatus` = '1' WHERE (`id` = (select o.id from rgb.order as o where purchaseDate = ? group by purchaseDate));";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, checked[i]);
			psmt.executeUpdate();
		}

		if (res != null) {
			res.close();
		}
		if (psmt != null) {
			psmt.close();
		}
		if (conn != null) {
			conn.close();
		}
	}
}
