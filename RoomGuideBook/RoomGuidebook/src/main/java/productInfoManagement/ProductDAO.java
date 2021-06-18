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

	public void register(ImageDTO imgForMain, List<ImageDTO> show, List<ImageDTO> arrange, ProductDTO product)
			throws SQLException {

		System.out.println(product.getParentCategory() + " " + product.getChildCategory());

		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			sql = "INSERT INTO `rgb`.`PRODUCT` (`name`, `sellerId`, `parentCategory`, `childCategory`, `stock`, `registrationDate`, `price`, `info`, `brand`, `width`, `length`, `height`, `color`)"
					+ " VALUES (?, ?, ?, ?, ?, current_date(), ?, ?, ?, ?, ?, ?, ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, product.getName());
			psmt.setString(2, product.getSellerId());
			psmt.setString(3, product.getParentCategory());
			psmt.setString(4, product.getChildCategory());
			psmt.setInt(5, product.getStock());
			psmt.setInt(6, product.getPrice());
			psmt.setString(7, product.getInfo());
			psmt.setString(8, product.getBrand());
			psmt.setInt(9, product.getWidth());
			psmt.setInt(10, product.getLength());
			psmt.setInt(11, product.getHeight());
			psmt.setString(12, product.getColor()); // 뷰쪽에서 해결 못해서 박아논거
			psmt.executeUpdate();

			sql = "select product.id from product order by product.id desc limit 1;";
			psmt = conn.prepareStatement(sql);
			res = psmt.executeQuery();

			int productId = 0;
			while (res.next()) {
				productId = res.getInt(1);
			}

			sql = "INSERT INTO `rgb`.`image` (`use`, `divisionId`, `path`) VALUES (?, ?, ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, imgForMain.getUse());
			psmt.setInt(2, productId);
			psmt.setString(3, imgForMain.getPath());

			psmt.executeUpdate();

			for (int i = 0; i < show.size(); i++) {
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, show.get(i).getUse());
				psmt.setInt(2, productId);
				psmt.setString(3, show.get(i).getPath());
				psmt.executeUpdate();
			}

			for (int i = 0; i < arrange.size(); i++) {
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, arrange.get(i).getUse());
				psmt.setInt(2, productId);
				psmt.setString(3, arrange.get(i).getPath());
				psmt.executeUpdate();
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
	}

	public Object[] getInfoToUpdate(int productId) throws SQLException {
		conn = dataSource.getConnection();
		sql = "select * \r\n" + "from product, image\r\n"
				+ "where product.id = ? and product.id = image.divisionId and image.use != 204;";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, productId);

		res = psmt.executeQuery();

		int cnt = 0;

		List<ImageDTO> imageList = new ArrayList<ImageDTO>();
		Object[] obj = new Object[2];
		while (res.next()) {
			ImageDTO image = new ImageDTO();
			if (cnt == 0) {
				ProductDTO product = new ProductDTO();

				product.setId(res.getInt(1));
				product.setName(res.getString(2));
				product.setParentCategory(res.getString(4));
				product.setChildCategory(res.getString(5));
				product.setStock(res.getInt(6));
				product.setPrice(res.getInt(8));
				product.setInfo(res.getString(9));
				product.setBrand(res.getString(10));
				product.setWidth(res.getInt(11));
				product.setLength(res.getInt(12));
				product.setHeight(res.getInt(13));
				product.setColor(res.getString(14));

				obj[0] = product;
				cnt++;
			}

			image.setId(res.getInt(15));
			image.setUse(res.getInt(16));
			
			int use = image.getUse();
			
			if(use == 201) {
				image.setPath("/resources/image_pmain/" + res.getString(18));
			}else if(use == 202) {
				image.setPath("/resources/image_arrange_bp/" + res.getString(18));
			}else if(use == 203) {
				image.setPath("/resources/image_pinfo/" + res.getString(18));
			}
			
			imageList.add(image);
		}
		
		obj[1] = imageList;
		
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

	public void update(ImageDTO imgForMain, List<ImageDTO> show, List<ImageDTO> arrange, ProductDTO product) throws SQLException {
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			sql = "UPDATE rgb.product SET `name` = ?, `parentCategory` = ?, `childCategory` = ?, `stock` = ?, `registrationDate` = current_date(), `price` = ?, `info` = ?, `brand` = ?, `width` = ?, `length` = ?, `height` = ?, `color` = ? WHERE (`id` = ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, product.getName());
			psmt.setString(2, product.getParentCategory());
			psmt.setString(3, product.getChildCategory());
			psmt.setInt(4, product.getStock());
			psmt.setInt(5, product.getPrice());
			psmt.setString(6, product.getInfo());
			psmt.setString(7, product.getBrand());
			psmt.setInt(8, product.getWidth());
			psmt.setInt(9, product.getLength());
			psmt.setInt(10, product.getHeight());
			psmt.setString(11, "red"); // 뷰쪽에서 해결 못해서 박아논거
			psmt.setInt(12, product.getId());
			psmt.executeUpdate();

			sql = "select product.id from product order by product.id desc limit 1;";
			psmt = conn.prepareStatement(sql);
			res = psmt.executeQuery();

			int productId = 0;
			while (res.next()) {
				productId = res.getInt(1);
			}

			sql = "delete from image where image.id in\r\n"
					+ "(select image.id from product, image where product.id = ? and product.id = image.divisionId and image.use != 204);";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, productId);
			psmt.executeUpdate();
			
			sql = "INSERT INTO `rgb`.`image` (`use`, `divisionId`, `path`) VALUES (?, ?, ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, imgForMain.getUse());
			psmt.setInt(2, productId);
			psmt.setString(3, imgForMain.getPath());

			psmt.executeUpdate();

			for (int i = 0; i < show.size(); i++) {
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, show.get(i).getUse());
				psmt.setInt(2, productId);
				psmt.setString(3, show.get(i).getPath());
				psmt.executeUpdate();
			}

			for (int i = 0; i < arrange.size(); i++) {
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, arrange.get(i).getUse());
				psmt.setInt(2, productId);
				psmt.setString(3, arrange.get(i).getPath());
				psmt.executeUpdate();
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

			image.setPath("/resources/image_pmain/" + res.getString(1));
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
			} else if (!(productDTO.getName().equals("")) && productDTO.getId() == -1) {
				if (dateStart.equals("")) {
					System.out.println("3번");
					sql += "AND name like ?;";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2, "%" + productDTO.getName() + "%");
				} else {
					System.out.println("4번");
					sql += "AND name like ? AND registrationDate between ? AND ?;";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2, "%" + productDTO.getName() + "%");
					psmt.setString(3, dateStart);
					psmt.setString(4, dateEnd);
				}
			} else {
				System.out.println("5번");
				sql += "AND (registrationDate between ? AND ?);";
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, productDTO.getSellerId());
				psmt.setString(2, dateStart);
				psmt.setString(3, dateEnd);
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
					psmt.setString(5, dateStart);
					psmt.setString(6, dateEnd);
				}
			} else if (!(productDTO.getName().equals("")) && productDTO.getId() == -1) {
				if (dateStart.equals("")) {
					System.out.println("8번");
					sql += "AND name like ? AND parentCategory = ? AND childCategory = ?;";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2, "%" + productDTO.getName() + "%");
					psmt.setString(3, productDTO.getParentCategory());
					psmt.setString(4, productDTO.getChildCategory());
				} else {
					System.out.println("9번");
					sql += "AND name like ? AND parentCategory = ? AND childCategory = ? AND registrationDate between ? AND ?;";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2, "%" + productDTO.getName() + "%");
					psmt.setString(3, productDTO.getParentCategory());
					psmt.setString(4, productDTO.getChildCategory());
					psmt.setString(5, dateStart);
					psmt.setString(6, dateEnd);
				}
			} else {
				if (dateStart.equals("")) {
					System.out.println("9.5번");
					sql += "AND parentCategory = ? AND childCategory = ?;";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2, productDTO.getParentCategory());
					psmt.setString(3, productDTO.getChildCategory());
				} else {
					System.out.println("10번");
					sql += "AND parentCategory = ? AND childCategory = ? AND (registrationDate between ? AND ?);";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, productDTO.getSellerId());
					psmt.setString(2, productDTO.getParentCategory());
					psmt.setString(3, productDTO.getChildCategory());
					psmt.setString(4, dateStart);
					psmt.setString(5, dateEnd);
				}
			}
		}

		res = psmt.executeQuery();

		List<Object[]> list = new ArrayList<Object[]>();
		while (res.next()) {
			Object[] obj = new Object[2];
			ImageDTO image = new ImageDTO();
			ProductDTO product = new ProductDTO();

			image.setPath("/resources/image_pmain/" + res.getString(1));
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
