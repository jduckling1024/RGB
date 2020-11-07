package mainManagement;

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

import dto.ImageDTO;

@Repository("mainDAO")
public class MainDAO {

	@Autowired
	BasicDataSource dataSource;
	
	Connection conn = null;
    PreparedStatement psmt = null;
    ResultSet res;
    String sql;
	
	public List<ImageDTO> getMainImageList() throws SQLException {
		conn = dataSource.getConnection();
		sql = "(select *\r\n"
				+ "from (select product.id as boardId, image.id as imageId, image.use, image.divisionId, image.path, RANK() OVER(ORDER BY product.registrationDate desc) as ranking\r\n"
				+ "from image, product\r\n"
				+ "where image.use = 204 and image.divisionId = product.id) as temp1\r\n"
				+ "limit 4)\r\n"
				+ "union\r\n"
				+ "(select *\r\n"
				+ "from (select board.id as boardId, image.id as imageId, image.use, image.divisionId, image.path, RANK() OVER(ORDER BY board.likeCnt DESC) as ranking\r\n"
				+ "from image, board\r\n"
				+ "where image.use = 201 and image.divisionId = board.id) as temp2\r\n"
				+ "limit 4);";
        psmt = conn.prepareStatement(sql);
		
		res = psmt.executeQuery();
		List<ImageDTO> imageList = new ArrayList<ImageDTO>();
		
		while(res.next()) {
			ImageDTO image = new ImageDTO();
			image.setId(1);
			image.setUse(res.getInt(3));
			image.setDivisionId(res.getInt(4));
			image.setPath(res.getString(5));
			imageList.add(image);
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
		
		return imageList;
	}
}
