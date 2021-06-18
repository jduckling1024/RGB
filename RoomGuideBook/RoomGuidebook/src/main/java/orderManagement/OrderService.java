package orderManagement;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.OrderDTO;
import dto.PaymentDTO;

@Service("orderService")
public class OrderService {
	
	@Autowired
	OrderDAO orderDAO;

	public List<Object[]> getFurnitureForOrder(String memberId, int productId) throws SQLException{
		return orderDAO.getFurnitureForOrder(memberId, productId);
	}
	
	
	public List<Object[]> listForMember(String memberId) throws SQLException{
		return orderDAO.listForMember(memberId);
	}
	
	public List<Object[]> listForSeller(String sellerId) throws SQLException{
		return orderDAO.listForSeller(sellerId);
	}


	public void purchase(String userId, List<OrderDTO> orderList, PaymentDTO paymentDTO, int priceSum) throws SQLException {
		orderDAO.purchase(userId, orderList, paymentDTO, priceSum);
	} 
	
	public List<Object[]> getPaymentList(String memberName) throws SQLException{
		return orderDAO.getPaymentList(memberName);
	}
	
	public void cancel(String[] checked) throws SQLException {
		orderDAO.cancel(checked);
	}
}
