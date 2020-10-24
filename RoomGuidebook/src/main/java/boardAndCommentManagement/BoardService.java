package boardAndCommentManagement;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import dto.BoardDTO;

public class BoardService {

	@Autowired
	BoardDAO boardDAO;
	
	public List<BoardDTO> getList(int page) throws SQLException{
		return boardDAO.getList(page);
	}
	
	public Object[] get(int no) throws SQLException {
		return boardDAO.get(no);
	}
}
