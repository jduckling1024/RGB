package boardAndCommentManagement;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dto.CommentDTO;

@Service("commentService")
public class CommentService {

	@Autowired
	CommentDAO commentDAO;
	
	public void register(String memberId, CommentDTO commentDTO) throws SQLException {
		commentDAO.register(memberId, commentDTO);
	}
	
	public List<CommentDTO> getList(int boardId) throws SQLException{
		return commentDAO.getList(boardId);
	}

	public void delete(int no, String memberId) throws SQLException {
		commentDAO.delete(no, memberId);
	}

	public void update(Integer no, CommentDTO commentDTO) throws SQLException {
		commentDAO.update(no, commentDTO);	
	}
}