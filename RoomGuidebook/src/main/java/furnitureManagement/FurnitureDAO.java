package furnitureManagement;

import java.sql.Connection;

import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.ImageDTO;
import dto.ProductDTO;

@Repository("furnitureDAO")
public class FurnitureDAO {
	@Autowired
	BasicDataSource dataSource;

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet res;
	String sql;

	public void register() {

	}

	public List<Object[]> getList() throws SQLException {
		conn = dataSource.getConnection();
		sql = "SELECT * \r\n" + "FROM product, image\r\n" + "where product.id = image.divisionId and image.use = 201;";
		psmt = conn.prepareStatement(sql);
		res = psmt.executeQuery();

		List<Object[]> list = new ArrayList<Object[]>();
		while (res.next()) {
			Object[] obj = new Object[2];
			ProductDTO productDTO = new ProductDTO();
			ImageDTO imageDTO = new ImageDTO();

			productDTO.setId(res.getInt(1));
			productDTO.setName(res.getString(2));
			productDTO.setPrice(res.getInt(8));
			productDTO.setBrand(res.getString(9));
			imageDTO.setPath(res.getString(18)); // 추가할거 있으면 추가하고 아니면 빼면 되지

			obj[0] = productDTO;
			obj[1] = imageDTO;
			list.add(obj);
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

	public Object[] arrange(int id) throws SQLException {
		conn = dataSource.getConnection();
		sql = "select *   \r\n"
				+ "from product, image   \r\n"
				+ "where product.id = 8 and image.use = 202 and image.divisionId = ?;";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, id);
		res = psmt.executeQuery();
		res = psmt.executeQuery();

		List<Object[]> list = new ArrayList<Object[]>();
		List<ImageDTO> imageList = new ArrayList<ImageDTO>();
		Object[] obj = new Object[2];
		int cnt = 0;
		while (res.next()) {
			if(cnt == 0) {
				ProductDTO product = new ProductDTO();
				product.setWidth(res.getInt(11));
				product.setLength(res.getInt(12));
				product.setHeight(res.getInt(13));
				obj[0] = product;
			}
			cnt++;
			ImageDTO imageDTO = new ImageDTO();
			imageDTO.setId(res.getInt(15));
			imageDTO.setPath(res.getString(18));
			imageList.add(imageDTO);
		}
		
		obj[1] = imageList;

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
	}

	public Object[] get(int id) throws SQLException {
		conn = dataSource.getConnection();
		sql = "SELECT * \r\n" + "FROM product, image\r\n"
				+ "where product.id = ? and (image.use = 201 or image.use = 203) and product.id = image.divisionId\r\n"
				+ "order by image.use;";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, id);
		res = psmt.executeQuery();

		Object[] obj = new Object[2];
		List<ImageDTO> imageList = new ArrayList<ImageDTO>();

		ImageDTO imageDTO;
		while (res.next()) {
			ProductDTO productDTO = new ProductDTO();
			productDTO.setId(res.getInt(1));
			productDTO.setName(res.getString(2));
			productDTO.setStock(res.getInt(5));
			productDTO.setPrice(res.getInt(8));
			productDTO.setInfo(res.getString(9));
			productDTO.setBrand(res.getString(10));
			productDTO.setWidth(res.getInt(11));
			productDTO.setLength(res.getInt(12));
			productDTO.setHeight(res.getInt(13));
			productDTO.setColor(res.getString(14));
			obj[0] = productDTO;
			imageDTO = new ImageDTO();
			imageDTO.setPath(res.getString(18));
			imageList.add(imageDTO);
			break;
		}

		while (res.next()) {
			imageDTO = new ImageDTO();
			imageDTO.setPath(res.getString(18));
			imageList.add(imageDTO);
		}
		obj[1] = imageList;

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
	}

	public List<Object[]> search(int id, String word) throws SQLException {

		conn = dataSource.getConnection();
		List<Object[]> list = new ArrayList<Object[]>();

		switch (id) {
		case 1:
			sql = "select *\r\n"
					+ "from (select product.id, product.name, product.price, product.brand, product.color, temp1.state as temp1, temp1.state as temp2, image.path\r\n"
					+ "from product, image, rgb.code temp1, rgb.code temp2\r\n"
					+ "where image.use = 201 and product.id = image.divisionId and product.childCategory = temp2.code and product.parentCategory = temp1.code) as info\r\n"
					+ "where info.temp1 = ? or info.temp2 = ?;";
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, word);
			psmt.setString(2, word);
			res = psmt.executeQuery();

			while (res.next()) {
				Object[] obj = new Object[2];
				ProductDTO productDTO = new ProductDTO();
				ImageDTO imageDTO = new ImageDTO();

				productDTO.setId(res.getInt(1));
				productDTO.setName(res.getString(2));
				productDTO.setPrice(res.getInt(3));
				productDTO.setBrand(res.getString(4));
				imageDTO.setPath(res.getString(8)); // 추가할거 있으면 추가하고 아니면 빼면 되지

				obj[0] = productDTO;
				obj[1] = imageDTO;
				list.add(obj);
			}
			break; // 카테고리
		case 2:
			sql = "SELECT * \r\n" + "FROM product, image\r\n"
					+ "where product.id = image.divisionId and image.use = 201 and product.brand = ?;";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, word);
			res = psmt.executeQuery();

			while (res.next()) {
				Object[] obj = new Object[2];
				ProductDTO productDTO = new ProductDTO();
				ImageDTO imageDTO = new ImageDTO();

				productDTO.setId(res.getInt(1));
				productDTO.setName(res.getString(2));
				productDTO.setPrice(res.getInt(8));
				productDTO.setBrand(res.getString(9));
				imageDTO.setPath(res.getString(18));

				obj[0] = productDTO;
				obj[1] = imageDTO;
				list.add(obj);
			}
			break; // 브랜드
		case 3:
			StringTokenizer st = new StringTokenizer(word, "~");
			int min = Integer.parseInt(st.nextToken());
			int max = Integer.parseInt(st.nextToken());
			sql = "select * \r\n" + "from product, image\r\n"
					+ "where product.id = image.divisionId and image.use = 201 and (? <= price and price <= ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, min);
			psmt.setInt(2, max);
			res = psmt.executeQuery();

			while (res.next()) {
				Object[] obj = new Object[2];
				ProductDTO productDTO = new ProductDTO();
				ImageDTO imageDTO = new ImageDTO();

				productDTO.setId(res.getInt(1));
				productDTO.setName(res.getString(2));
				productDTO.setPrice(res.getInt(8));
				productDTO.setBrand(res.getString(9));
				imageDTO.setPath(res.getString(18));

				obj[0] = productDTO;
				obj[1] = imageDTO;
				list.add(obj);
			}
			break; // 가격

		case 4:
			sql = "SELECT *\r\n" + "FROM product, image\r\n"
					+ "WHERE product.id = image.divisionId AND image.use = 201 AND product.color = ?;";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, word);
			res = psmt.executeQuery();

			while (res.next()) {
				Object[] obj = new Object[2];
				ProductDTO productDTO = new ProductDTO();
				ImageDTO imageDTO = new ImageDTO();

				productDTO.setId(res.getInt(1));
				productDTO.setName(res.getString(2));
				productDTO.setPrice(res.getInt(8));
				productDTO.setBrand(res.getString(9));
				imageDTO.setPath(res.getString(18));

				obj[0] = productDTO;
				obj[1] = imageDTO;
				list.add(obj);
			}
			break;
		default :
			sql = "SELECT * \r\n" + "FROM product, image\r\n"
					+ "where product.id = image.divisionId and image.use = 201 and product.name LIKE ?;";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, "%" + word + "%");
			res = psmt.executeQuery();

			while (res.next()) {
				Object[] obj = new Object[2];
				ProductDTO productDTO = new ProductDTO();
				ImageDTO imageDTO = new ImageDTO();

				productDTO.setId(res.getInt(1));
				productDTO.setName(res.getString(2));
				productDTO.setPrice(res.getInt(8));
				productDTO.setBrand(res.getString(9));
				imageDTO.setPath(res.getString(18));

				obj[0] = productDTO;
				obj[1] = imageDTO;
				list.add(obj);
			}
			break;
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
}
