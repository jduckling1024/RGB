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
		sql = "with recursive cte as (\r\n"
				+ "  select     id, upperId, memberId, boardId, content, date, 1 as lev\r\n"
				+ "  from       rgb.comment\r\n"
				+ "  where      upperId is null\r\n"
				+ "  union all\r\n"
				+ "  select     B.id, B.upperId, B.memberId, B.boardId, B.content, B.date, lev + 1 as lev\r\n"
				+ "  from       rgb.comment as B\r\n"
				+ "  inner join cte\r\n"
				+ "          on cte.id = B.upperId\r\n"
				+ ")\r\n"
				+ "select * from cte where boardId = ? order by id, memberId;";
		psmt = conn.prepareStatement(sql);
		System.out.println(boardId);
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
			commentDTO.setLevel(res.getInt(7));
			commentList.add(commentDTO);
		}
		
		if(res != null) {
			res.close();
		}
		if(psmt != null) {
			psmt.close();
		}
		if(conn != null) {
			conn.close();
		}
		return commentList; // �翬�� null �ƴ�;
	}
}
