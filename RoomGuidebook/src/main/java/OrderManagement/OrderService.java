package OrderManagement;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("orderService")
public class OrderService {
	
	@Autowired
	OrderDAO orderDAO;

	public List<Object[]> listForSeller(String sellerId) throws SQLException{
		return orderDAO.listForSeller(sellerId);
	}
}
