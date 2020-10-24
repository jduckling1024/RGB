package furnitureManagement;

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
	
	public List<Object[]> getList() throws SQLException{
		conn = dataSource.getConnection();
		sql = "SELECT * \r\n"
				+ "FROM product, image\r\n"
				+ "where product.id = image.divisionId and image.use = 201;";
		psmt = conn.prepareStatement(sql);
		res = psmt.executeQuery();
		
		List<Object[]> list = new ArrayList<Object[]>();
		while(res.next()) {
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
		
		return list;
	}
	
	public Object[] get(int id) throws SQLException {
		conn = dataSource.getConnection();
		sql = "SELECT * \r\n"
				+ "FROM product, image\r\n"
				+ "where product.id = ? and image.use <> 203 and product.id = image.divisionId\r\n"
				+ "order by image.use";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, id);
		res = psmt.executeQuery();

		Object[] obj = new Object[2];
		List<ImageDTO> imageList = new ArrayList<ImageDTO>();
		
		ImageDTO imageDTO;
		while(res.next()) {
			ProductDTO productDTO = new ProductDTO();
			productDTO.setId(res.getInt(1));
			productDTO.setName(res.getString(2));
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
		
		while(res.next()){ 
			 imageDTO = new ImageDTO();
			 imageDTO.setPath(res.getString(18));
			 imageList.add(imageDTO);
		}
		obj[1] = imageList;
		
		return obj;
	}
	
	public ArrayList<Object[]> search(String word) throws SQLException{
		conn = dataSource.getConnection();
		sql = "SELECT * \r\n"
				+ "FROM product, image\r\n"
				+ "where product.id = image.divisionId and image.use = 201 and product.name LIKE '%?%';";
		psmt = conn.prepareStatement(sql);
		return null;
	}
}




