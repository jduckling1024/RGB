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
    
	public List<Object[]> getList(String name, int page) throws SQLException {
        conn = dataSource.getConnection();
        sql = "SELECT *\r\n"
        		+ "FROM (SELECT board.id, board.memberId, image.path, board.likeCnt, board.date FROM board left join image on board.id = image.divisionId where image.use = 204) as tempImage\r\n"
        		+ "LEFT JOIN (SELECT * FROM rgb.like as likeIt WHERE likeIt.memberId = ?) as likeIt \r\n"
        		+ "ON tempImage.id = likeIt.boardId\r\n"
        		+ "ORDER BY tempImage.id DESC\r\n"
        		+ "LIMIT ?, 3;";
        psmt = conn.prepareStatement(sql);
        psmt.setString(1, name);
        psmt.setInt(2, 3 * (page - 1));
        
        res = psmt.executeQuery();

        List<Object[]> list = new ArrayList<Object[]>();
        
        while(res.next()) {
        	BoardDTO boardDTO = new BoardDTO();
        	ImageDTO imageDTO = new ImageDTO();
        	LikeDTO likeDTO = new LikeDTO();
        	
        	Object[] obj = new Object[3];
        	
        	boardDTO.setBoardId(res.getInt(1));
        	boardDTO.setMemberId(res.getString(2));
        	imageDTO.setPath(res.getString(3));
        	boardDTO.setLikeCnt(res.getInt(4));
        	boardDTO.setDate(res.getString(5));
        	likeDTO.setMemberId(res.getString(6));
        	
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
        
		if(res != null) {
			res.close();
		}
		if(psmt != null) {
			psmt.close();
		}
		if(conn != null) {
			conn.close();
		}
       
        return list;
	}
	
	public Object[] get(int no) throws SQLException {
		conn = dataSource.getConnection();
        sql = "select *\r\n"
        		+ "from board\r\n"
        		+ "left join image\r\n"
        		+ "on board.id = image.divisionId\r\n"
        		+ "where image.use = 204 and board.id = ?;";
        psmt = conn.prepareStatement(sql);
        psmt.setInt(1, no);
        
        res = psmt.executeQuery();
        
        Object[] obj = new Object[2];
        BoardDTO boardDTO = new BoardDTO();
        ImageDTO imageDTO = new ImageDTO();
      
        while(res.next()) {
        	boardDTO.setBoardId(res.getInt(1));
        	boardDTO.setMemberId(res.getString(2));
        	boardDTO.setTitle(res.getString(3));
        	boardDTO.setContent(res.getString(4));
        	boardDTO.setDate(res.getString(5));
        	boardDTO.setLikeCnt(res.getInt(6));
        	boardDTO.setCommentCnt(res.getInt(7));
        	imageDTO.setPath(res.getString(11));
        }
        
        obj[0] = boardDTO;
        obj[1] = imageDTO;
        
		if(res != null) {
			res.close();
		}
		if(psmt != null) {
			psmt.close();
		}
		if(conn != null) {
			conn.close();
		}
        
        return obj;
	} // 게시물의 이미지도 가져와야 하기 때문에 리턴타입 변경 + 조회수 높이는 구문도 필요함.
}