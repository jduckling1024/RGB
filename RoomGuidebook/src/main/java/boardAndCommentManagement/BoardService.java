package boardAndCommentManagement;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import dto.BoardDTO;

public class BoardService {

	@Autowired
	BoardDAO boardDAO;
	
	public List<Object[]> getList(String name, int page) throws SQLException{
		return boardDAO.getList(name, page);
	}
	
	public Object[] get(int no) throws SQLException {
		return boardDAO.get(no);
	}
}
