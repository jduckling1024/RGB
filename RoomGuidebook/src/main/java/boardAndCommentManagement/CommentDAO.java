package boardAndCommentManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.CommentDTO;

@Repository("commentDAO")
public class CommentDAO {

	@Autowired
	BasicDataSource dataSource;
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet res = null;
	String sql;

	public List<CommentDTO> getList(int boardId) throws SQLException {
		conn = dataSource.getConnection();
		sql = "select *\r\n" + "from comment\r\n" + "where boardId = ?;";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, boardId);
		res = psmt.executeQuery();

		List<CommentDTO> commentList = new ArrayList<CommentDTO>();
		while (res.next()) {
			CommentDTO commentDTO = new CommentDTO();
			commentDTO.setCommentId(res.getInt(1));
			commentDTO.setUpperId(res.getInt(2));
			commentDTO.setMemberId(res.getString(3));
			commentDTO.setBoardId(res.getInt(4));
			commentDTO.setContent(res.getString(5));
			commentDTO.setDate(res.getString(6));
			commentList.add(commentDTO);
		}
		return commentList; // ´ç¿¬È÷ null ¾Æ´Ô;
	}
}
