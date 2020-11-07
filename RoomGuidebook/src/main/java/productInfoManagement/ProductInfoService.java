package productInfoManagement;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ImageDTO;
import dto.ProductDTO;

@Service("productInfoService")
public class ProductInfoService {

	@Autowired
	ProductDAO productDAO;
	
	public void register(List<ImageDTO> show, List<ImageDTO> arrange, ProductDTO product) {
		
	}
	
	public List<Object[]> search(ProductDTO product, String dateStart, String dateEnd) throws SQLException {
		return productDAO.search(product, dateStart, dateEnd);
	}
	
	public void delete(String[] list) throws SQLException {
		productDAO.delete(list);
	}
	
	public List<Object[]> getList(String id) throws SQLException{
		return productDAO.getList(id);
	}
}