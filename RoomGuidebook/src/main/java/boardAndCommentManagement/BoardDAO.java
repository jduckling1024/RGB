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

@Repository("boardDAO")
public class BoardDAO {
	@Autowired
	BasicDataSource dataSource;

    Connection conn;
    PreparedStatement psmt;
    ResultSet res;
    String sql;
    
	public List<BoardDTO> getList(int page) throws SQLException {
        conn = dataSource.getConnection();
        sql = "select * \r\n"
        		+ "from board \r\n"
        		+ "where id > 0\r\n"
        		+ "order by board.id desc\r\n"
        		+ "limit ?, 2;";
        psmt = conn.prepareStatement(sql);
        psmt.setInt(1, 2 * (page - 1));
        
        res = psmt.executeQuery();
        
        List<BoardDTO> boardList = new ArrayList<BoardDTO>();
        
        while(res.next()) {
        	BoardDTO boardDTO = new BoardDTO();
        	boardDTO.setBoardId(res.getInt(1));
        	boardDTO.setMemberId(res.getString(2));
        	boardDTO.setTitle(res.getString(3));
        	boardDTO.setContent(res.getString(4));
        	boardDTO.setDate(res.getString(5));
        	boardDTO.setLikeCnt(res.getInt(6));
        	boardDTO.setCommentCnt(res.getInt(7));
        	boardList.add(boardDTO); // �ϴ� �� �޾ƿ���� �ߴµ� ������ �ȹ޾ƿ͵� �� ��
        }
       
        return boardList;
	}
	
	public Object[] get(int no) throws SQLException {
		conn = dataSource.getConnection();
        sql = "select *\r\n"
        		+ "from board\r\n"
        		+ "left join image\r\n"
        		+ "on board.id = image.divisionId\r\n"
        		+ "where board.id = ?;";
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
        
        return obj;
	} // �Խù��� �̹����� �����;� �ϱ� ������ ����Ÿ�� ���� + ��ȸ�� ���̴� ������ �ʿ���.
}