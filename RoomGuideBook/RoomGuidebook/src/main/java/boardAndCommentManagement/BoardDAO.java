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

import dto.BoardDTO;
import dto.ImageDTO;
import dto.LikeDTO;

@Repository("boardDAO")
public class BoardDAO {
	@Autowired
	BasicDataSource dataSource;

	Connection conn;
	PreparedStatement psmt;
	ResultSet res;
	String sql;

	public void register(String memberId, BoardDTO boardDTO, ImageDTO imageDTO) throws SQLException {
		try {
			System.out.println(imageDTO.getPath());
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			sql = "INSERT INTO rgb.board (`memberId`, `title`, `content`, `date`, `likeCnt`, `commentCnt`) VALUES (?, ?, ?, current_timestamp(), ?, ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, memberId);
			psmt.setString(2, boardDTO.getTitle());
			psmt.setString(3, boardDTO.getContent());
			psmt.setInt(4, boardDTO.getLikeCnt());
			psmt.setInt(5, boardDTO.getCommentCnt());

			psmt.executeUpdate();

			sql = "select board.id from board order by board.id desc limit 1;";
			psmt = conn.prepareStatement(sql);
			res = psmt.executeQuery();

			int no = 0;
			while (res.next()) {
				no = res.getInt(1);
			}

			sql = "INSERT INTO rgb.image (`use`, `divisionId`, `path`) VALUES (204, ?, ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, no);
			psmt.setString(2, imageDTO.getPath());

			System.out.println(imageDTO.getPath() + " " + sql);

			psmt.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			throw new SQLException();
		} finally {
			conn.setAutoCommit(true);

			if (res != null) {
				res.close();
			}
			if (psmt != null) {
				psmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	public List<Object[]> getList(String name, int page) throws SQLException {
		conn = dataSource.getConnection();
		sql = "SELECT *\r\n"
				+ "FROM (SELECT board.id, board.memberId, image.path, board.likeCnt, board.date, board.title FROM board left join image on board.id = image.divisionId where image.use = 204) as tempImage\r\n"
				+ "LEFT JOIN (SELECT * FROM rgb.like as likeIt WHERE likeIt.memberId = ?) as likeIt \r\n"
				+ "ON tempImage.id = likeIt.boardId\r\n" + "ORDER BY tempImage.id DESC\r\n" + "LIMIT ?, 6;"; // 한 페이지에 몇 개 띄우고 싶은지는 마지막 부분 수정.
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, name);
		psmt.setInt(2, 3 * (page - 1));

		res = psmt.executeQuery();

		List<Object[]> list = new ArrayList<Object[]>();

		while (res.next()) {
			BoardDTO boardDTO = new BoardDTO();
			ImageDTO imageDTO = new ImageDTO();
			LikeDTO likeDTO = new LikeDTO();

			Object[] obj = new Object[3];

			boardDTO.setBoardId(res.getInt(1));
			boardDTO.setMemberId(res.getString(2));
			imageDTO.setPath("/resources/image_board/" + res.getString(3));
			boardDTO.setLikeCnt(res.getInt(4));
			boardDTO.setDate(res.getString(5));
			boardDTO.setTitle(res.getString(6));
			likeDTO.setMemberId(res.getString(7));

			obj[0] = boardDTO;
			obj[1] = imageDTO;
			obj[2] = likeDTO;

			list.add(obj);

//        	boardDTO.setBoardId(res.getInt(1));
//        	boardDTO.setMemberId(res.getString(2));
//        	boardDTO.setTitle(res.getString(3));
//        	boardDTO.setContent(res.getString(4));
//        	boardDTO.setDate(res.getString(5));
//        	boardDTO.setLikeCnt(res.getInt(6));
//        	boardDTO.setCommentCnt(res.getInt(7));
//        	boardList.add(boardDTO); // 일단 다 받아오기는 했는데 내용은 안받아와도 될 듯
		}

		if (res != null) {
			res.close();
		}
		if (psmt != null) {
			psmt.close();
		}
		if (conn != null) {
			conn.close();
		}

		return list;
	}

	public Object[] get(int no) throws SQLException {
		conn = dataSource.getConnection();
		sql = "select *\r\n"
				+ "from (select board.id as bid, memberId, title, content, date, likeCnt, commentCnt, image.id, image.use, image.divisionId, image.path from board left join image on board.id = image.divisionId where image.use = 204 and board.id = ?) as myBoard\r\n"
				+ "left join rgb.like as l\r\n" + "on myBoard.id = l.boardId;";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, no);

		res = psmt.executeQuery();

		Object[] obj = new Object[3];
		BoardDTO boardDTO = new BoardDTO();
		ImageDTO imageDTO = new ImageDTO();
		LikeDTO likeDTO = new LikeDTO();

		while (res.next()) {
			boardDTO.setBoardId(res.getInt(1));
			boardDTO.setMemberId(res.getString(2));
			boardDTO.setTitle(res.getString(3));
			boardDTO.setContent(res.getString(4));
			boardDTO.setDate(res.getString(5));
			boardDTO.setLikeCnt(res.getInt(6));
			boardDTO.setCommentCnt(res.getInt(7));
			imageDTO.setPath("/resources/image_board/" + res.getString(11));
			likeDTO.setBoardId(res.getInt(13));
			likeDTO.setMemberId(res.getString(12));
		}

		obj[0] = boardDTO;
		obj[1] = imageDTO;
		obj[2] = likeDTO;

		if (res != null) {
			res.close();
		}
		if (psmt != null) {
			psmt.close();
		}
		if (conn != null) {
			conn.close();
		}

		return obj;
	} // 게시물의 이미지도 가져와야 하기 때문에 리턴타입 변경 + 조회수 높이는 구문도 필요함.

	public Object[] getInfoForUpdate(int boardId) throws SQLException {
		conn = dataSource.getConnection();

		sql = "select * from board, image where board.id = ? and board.id = image.divisionId and image.use = '204';";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, boardId);

		res = psmt.executeQuery();

		Object[] obj = new Object[2];
		BoardDTO boardDTO = new BoardDTO();
		ImageDTO imageDTO = new ImageDTO();

		while (res.next()) {
			boardDTO.setBoardId(res.getInt(1));
			boardDTO.setMemberId(res.getString(2));
			boardDTO.setTitle(res.getString(3));
			boardDTO.setContent(res.getString(4));
			imageDTO.setId(res.getInt(8));
			imageDTO.setPath("/resources/image_board/" + res.getString(11));
		}

		obj[0] = boardDTO;
		obj[1] = imageDTO;

		if (res != null) {
			res.close();
		}
		if (psmt != null) {
			psmt.close();
		}
		if (conn != null) {
			conn.close();
		}

		return obj;
	}

	public void update(BoardDTO boardDTO, ImageDTO imageDTO) throws SQLException {
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			sql = "delete from image \r\n"
					+ "where image.id in (select * from (select image.id from board, image where board.id = ? and board.id = image.divisionId and image.use = '204') as temp);";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, boardDTO.getBoardId());
			psmt.executeUpdate();

			sql = "UPDATE rgb.board SET `title` = ?, `content` = ?, `date` = current_date() WHERE (`id` = ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, boardDTO.getTitle());
			psmt.setString(2, boardDTO.getContent());
			psmt.setInt(3, boardDTO.getBoardId());
			psmt.executeUpdate();

			sql = "INSERT INTO rgb.image (`use`, `divisionId`, `path`) VALUES (204, ?, ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, boardDTO.getBoardId());
			psmt.setString(2, imageDTO.getPath());
			psmt.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			throw new SQLException();
		} finally {
			conn.setAutoCommit(true);

			if (res != null) {
				res.close();
			}
			if (psmt != null) {
				psmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	public void delete(BoardDTO boardDTO) throws SQLException {
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			sql = "delete from image \r\n"
					+ "where image.id in (select * from (select image.id from board, image where board.id = ? and board.id = image.divisionId and image.use = '204') as temp);";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, boardDTO.getBoardId());
			psmt.executeUpdate();

			sql = "DELETE FROM `rgb`.`board` WHERE (`id` = ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, boardDTO.getBoardId());
			psmt.executeUpdate();

			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			throw new SQLException();
		} finally {
			conn.setAutoCommit(true);

			if (res != null) {
				res.close();
			}
			if (psmt != null) {
				psmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}

	}

	public Object[] likeIt(LikeDTO likeDTO) throws SQLException {
		Object[] obj = new Object[2];
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			sql = "select * from rgb.like as l where l.memberId = ? and l.boardId = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, likeDTO.getMemberId());
			psmt.setInt(2, likeDTO.getBoardId());
			res = psmt.executeQuery();

			int rowCnt = 0; // 좋아요 여부
			int likeCnt = 0; // 좋아요 개수

			while (res.next()) {
				rowCnt++;
			}

			
			
			if (rowCnt == 0) {
				sql = "INSERT INTO `rgb`.`like` (`memberId`, `boardId`) VALUES (?, ?);";
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, likeDTO.getMemberId());
				psmt.setInt(2, likeDTO.getBoardId());
				psmt.executeUpdate();

				sql = "UPDATE rgb.board SET board.likeCnt = board.likeCnt + 1 WHERE (board.id = ?);";
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, likeDTO.getBoardId());
				psmt.executeUpdate();

				sql = "select * from board where board.id = ?;";
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, likeDTO.getBoardId());
				res = psmt.executeQuery();

				while (res.next()) {
					likeCnt = res.getInt(6);
					break;
				}

				obj[0] = likeCnt;
				obj[1] = true; // 좋아요
			} else if (rowCnt == 1) {
				sql = "DELETE FROM rgb.like WHERE (`memberId` = ?) and (`boardId` = ?);";
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, likeDTO.getMemberId());
				psmt.setInt(2, likeDTO.getBoardId());
				psmt.executeUpdate();

				sql = "UPDATE `rgb`.`board` SET `likeCnt` = `likeCnt` - 1 WHERE (`id` = ?);";
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, likeDTO.getBoardId());
				psmt.executeUpdate();

				sql = "select * from board where board.id = ?;";
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, likeDTO.getBoardId());
				res = psmt.executeQuery();

				while (res.next()) {
					likeCnt = res.getInt(6);
					break;
				}

				obj[0] = likeCnt;
				obj[1] = false; // 좋아요 취소
			} else {
				System.out.println("???");
			}

			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			throw new SQLException();
		} finally {
			conn.setAutoCommit(true);

			if (res != null) {
				res.close();
			}
			if (psmt != null) {
				psmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}

		return obj;
	}
}