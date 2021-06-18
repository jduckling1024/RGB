package boardAndCommentManagement;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import dto.BoardDTO;
import dto.ImageDTO;
import dto.LikeDTO;

public class BoardService {

	@Autowired
	BoardDAO boardDAO;
	
	public void register(String memberId, BoardDTO boardDTO, ImageDTO imageDTO) throws SQLException {
		boardDAO.register(memberId, boardDTO, imageDTO);
	}
	
	public List<Object[]> getList(String name, int page) throws SQLException{
		return boardDAO.getList(name, page);
	}
	
	public Object[] get(int no) throws SQLException {
		return boardDAO.get(no);
	}

	public Object[] getInfoForUpdate(int boardId) throws SQLException {
		return boardDAO.getInfoForUpdate(boardId);
		
	}

	public void update(BoardDTO boardDTO, ImageDTO imageDTO) throws SQLException {
		boardDAO.update(boardDTO, imageDTO);
		
	}

	public void delete(BoardDTO boardDTO) throws SQLException {
		boardDAO.delete(boardDTO);
	}

	public Object[] likeIt(LikeDTO likeDTO) throws SQLException {
		return boardDAO.likeIt(likeDTO);
	}
}
