package productInfoManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.ImageDTO;
import dto.ProductDTO;

@Repository("productDAO")
public class ProductDAO {
	@Autowired
	BasicDataSource dataSource;

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet res;
	String sql;

	public void register(List<ImageDTO> show, List<ImageDTO> arrange, ProductDTO product) {
		// conn = dataSource.getConnection();
	}

	public void update(ProductDTO product, ImageDTO image) {

	}

	public void delete(String[] list) throws SQLException {
		conn = dataSource.getConnection();
		sql = "delete p, i\r\n" + "from product as p, image as i\r\n"
				+ "where p.sellerId = \"tomotomoo\" and i.use = 201 and p.id = i.divisionId and (p.id = ?";
		for (int i = 0; i < list.length - 1; i++) {
			sql += " or p.id = ?";
		}

		sql += ");";

		psmt = conn.prepareStatement(sql);
		for (int i = 0; i < list.length; i++) {
			psmt.setString(i + 1, list[i]);
		}

		psmt.executeUpdate();

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

	public List<Object[]> getList(String id) throws SQLException {
		conn = dataSource.getConnection();
		sql = "select image.path, code1.state, code2.state, product.id, product.name, product.stock, product.registrationDate\r\n"
				+ "from product, image, rgb.code as code1, rgb.code as code2\r\n"
				+ "where product.sellerId = ? and image.use = 201 and product.id = image.divisionId and code1.code = product.parentCategory and code2.code = product.childCategory;";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		res = psmt.executeQuery();

		List<Object[]> list = new ArrayList<Object[]>();
		while (res.next()) {
			Object[] obj = new Object[2];
			ImageDTO image = new ImageDTO();
			ProductDTO product = new ProductDTO();

			image.setPath(res.getString(1));
			product.setParentCategory(res.getString(2));
			product.setChildCategory(res.getString(3));
			product.setId(res.getInt(4));
			product.setName(res.getString(5));
			product.setStock(res.getInt(6));
			product.setRegistrationDate(res.getString(7));

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

	public List<Object[]> search(ProductDTO productDTO, String dateStart, String dateEnd) throws SQLException {
		conn = dataSource.getConnection();
		sql = "SELECT image.path, code1.state, code2.state, product.id, product.name, product.stock, product.registrationDate FROM product, image, rgb.code as code1, rgb.code as code2 "
				+ "WHERE sellerId = ? AND image.use = 201 AND product.id = image.divisionId AND code1.code = product.parentCategory AND code2.code = product.childCategory ";
		if ((productDTO.getParentCategory()).equals("300")) {
			// 카테고리 선택 X
			if ((productDTO.getName().equals("")) && productDTO.getId() != -1) {
				if (dateStart.equals("")) {
					System.out.println("1번");
					sql += "AND product.id = ?";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setInt(2, productDTO.getId());
				} else {
					System.out.println("2번");
					sql += "AND product.id = ? AND (registrationDate between ? AND ?);";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2, productDTO.getSellerId());
					psmt.setString(3, dateStart);
					psmt.setString(4, dateEnd);
				}
			} else if(!(productDTO.getName().equals("")) && productDTO.getId() == -1){
				if (dateStart.equals("")) {
					System.out.println("3번");
					sql += "AND name = ?;";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2,  "%" + productDTO.getName() + "%");
				} else {
					System.out.println("4번");
					sql += "AND name = ? AND registrationDate between ? AND ?;";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2,  "%" + productDTO.getName() + "%");
					psmt.setString(3, dateStart);
					psmt.setString(4, dateEnd);
				}
			}else {
				System.out.println("5번");
				sql += "AND (registrationDate between ? AND ?);";
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, productDTO.getSellerId());
				psmt.setString(2,  dateStart);
				psmt.setString(3,  dateEnd);
			}
		} else {
			// 카테고리 선택 O
			if ((productDTO.getName().equals("")) && productDTO.getId() != -1) {
				if (dateStart.equals("")) {
					System.out.println("6번");
					sql += "AND product.id = ? AND parentCategory = ? AND childCategory = ?";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setInt(2, productDTO.getId());
					psmt.setString(3, productDTO.getParentCategory());
					psmt.setString(4, productDTO.getChildCategory());
				} else {
					System.out.println("7번");
					sql += "AND product.id = ? AND parentCategory = ? AND childCategory = ? AND (registrationDate between ? AND ?);";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setInt(2, productDTO.getId());
					psmt.setString(3, productDTO.getParentCategory());
					psmt.setString(4, productDTO.getChildCategory());
					psmt.setString(5,  dateStart);
					psmt.setString(6,  dateEnd);
				}
			} else if(!(productDTO.getName().equals("")) && productDTO.getId() == -1) {
				if (dateStart.equals("")) {
					System.out.println("8번");
					sql += "AND name = ? AND parentCategory = ? AND childCategory = ?;";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2, "%" + productDTO.getName() + "%");
					psmt.setString(3, productDTO.getParentCategory());
					psmt.setString(4, productDTO.getChildCategory());
				} else {
					System.out.println("9번");
					sql += "AND name = ? AND parentCategory = ? AND childCategory = ? AND registrationDate between ? AND ?;";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2, "%" + productDTO.getName() + "%");
					psmt.setString(3, productDTO.getParentCategory());
					psmt.setString(4, productDTO.getChildCategory());
					psmt.setString(5,  dateStart);
					psmt.setString(6,  dateEnd);
				}
			}else {
				if(dateStart.equals("")) {
					System.out.println("9.5번");
					sql += "AND parentCategory = ? AND childCategory = ?;";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2,  productDTO.getParentCategory());
					psmt.setString(3,  productDTO.getChildCategory());
				}else {
					System.out.println("10번");
					sql += "AND parentCategory = ? AND childCategory = ? AND (registrationDate between ? AND ?);";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2,  productDTO.getParentCategory());
					psmt.setString(3,  productDTO.getChildCategory());
					psmt.setString(4,  dateStart);
					psmt.setString(5,  dateEnd);
				}
				
			}
			
		}

		res = psmt.executeQuery();
		
		List<Object[]> list = new ArrayList<Object[]>();
		while (res.next()) {
			Object[] obj = new Object[2];
			ImageDTO image = new ImageDTO();
			ProductDTO product = new ProductDTO();

			image.setPath(res.getString(1));
			product.setParentCategory(res.getString(2));
			product.setChildCategory(res.getString(3));
			product.setId(res.getInt(4));
			product.setName(res.getString(5));
			product.setStock(res.getInt(6));
			product.setRegistrationDate(res.getString(7));

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
		
		System.out.println(list);
		
		return list;
	}
}
