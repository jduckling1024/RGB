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

import dto.BoardDTO;
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
      sql = "(select * from (select product.id as boardId, image.id as imageId, image.use, image.divisionId, image.path, product.name, product.brand, RANK() OVER(ORDER BY product.registrationDate desc) as ranking\r\n"
            + "from image, product  where image.use = 201 and image.divisionId = product.id limit 4) as temp1)\r\n"
            + "union\r\n"
            + "(select * from (select board.id as boardId, image.id as imageId, image.use, image.divisionId, image.path, board.title , board.likeCnt ,RANK() OVER(ORDER BY board.likeCnt DESC) as ranking\r\n"
            + "from image, board  where image.use = 204 and image.divisionId = board.id limit 6) as temp2)";
      psmt = conn.prepareStatement(sql);

      res = psmt.executeQuery();
      List<Object[]> list = new ArrayList<Object[]>();

      while (res.next()) {
         Object[] obj = new Object[3];
         ImageDTO image = new ImageDTO();
         ProductDTO product = new ProductDTO();
         BoardDTO board = new BoardDTO();

         image.setUse(res.getInt(3));
         
         if(image.getUse() == 201) {
            product.setId(res.getInt(1));
            image.setPath("/resources/image_pmain/" + res.getString(5));
            product.setName(res.getString(6));
            product.setBrand(res.getString(7));
         }else if(image.getUse() == 204) {
            board.setBoardId(res.getInt(1));
            image.setPath("/resources/image_board/" + res.getString(5));   
            board.setTitle(res.getString(6));
            board.setLikeCnt(res.getInt(7));
         }
         
         obj[0] = image;
         obj[1] = product;
         obj[2] = board;
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