package furnitureManagement;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("furnitureService")
public class FurnitureService {

	@Autowired
	FurnitureDAO furnitureDAO;
	
	public List<Object[]> getList() throws SQLException{
		List<Object[]> list = furnitureDAO.getList();
		return list;
	}
	
	public Object[] get(int id) throws SQLException {
		return furnitureDAO.get(id);
	}
	
	public List<Object[]> search(String word) throws SQLException {
		return furnitureDAO.search(word);
	}
}