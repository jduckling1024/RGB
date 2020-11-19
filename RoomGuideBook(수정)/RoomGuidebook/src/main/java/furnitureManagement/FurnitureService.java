package furnitureManagement;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ImageDTO;

@Service("furnitureService")
public class FurnitureService {

	@Autowired
	FurnitureDAO furnitureDAO;

	public List<Object[]> getList() throws SQLException {
		List<Object[]> list = furnitureDAO.getList();
		return list;
	}

	public Object[] get(int id) throws SQLException {
		return furnitureDAO.get(id);
	}

	public List<Object[]> search(int id, String word) throws SQLException {
		return furnitureDAO.search(id, word);
	}

	public Object[] arrange(int id) throws SQLException {
		return furnitureDAO.arrange(id);
	}
}