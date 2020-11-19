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
import dto.ProductDTO;

@Repository("mainDAO")
public class MainDAO {

	@Autowired
	BasicDataSource dataSource;

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet res;
	String sql;

	public List<Object[]> getMainImageList() throws SQLException {
		conn = dataSource.getConnection();
		sql = "(select *\r\n"
				+ "from (select product.id as boardId, image.id as imageId, image.use, image.divisionId, image.path, product.name, product.brand, RANK() OVER(ORDER BY product.registrationDate desc) as ranking\r\n"
				+ "from image, product  where image.use = 201 and image.divisionId = product.id) as temp1\r\n"
				+ "limit 4)  union  (select *\r\n"
				+ "from (select board.id as boardId, image.id as imageId, image.use, image.divisionId, image.path, \"tmp1\" , \"tmp2\" ,RANK() OVER(ORDER BY board.likeCnt DESC) as ranking\r\n"
				+ "from image, board  where image.use = 204 and image.divisionId = board.id) as temp2\r\n"
				+ "limit 6);";
		psmt = conn.prepareStatement(sql);

		res = psmt.executeQuery();
		List<Object[]> list = new ArrayList<Object[]>();

		while (res.next()) {
			Object[] obj = new Object[2];
			ImageDTO image = new ImageDTO();
			ProductDTO product = new ProductDTO();

			image.setId(1);
			image.setUse(res.getInt(3));
			image.setDivisionId(res.getInt(4));
			if (image.getUse() == 201) {
				image.setPath("/resources/image_pmain/" + res.getString(5));
				product.setName(res.getString(6));
				product.setBrand(res.getString(7));
			} else if (image.getUse() == 204) {
				image.setPath("/resources/image_board/" + res.getString(5));	
			}

			obj[0] = image;
			obj[1] = product;
			list.add(obj);
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
}
