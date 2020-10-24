package loginManagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.MemberDTO;
import dto.UserDTO;

@Repository("loginDAO")
public class LoginDAO {
   
   @Autowired
   BasicDataSource dataSource;
   
   public UserDTO login(UserDTO user) {
      UserDTO userDTO = new UserDTO(); 
      MemberDTO memberDTO = new MemberDTO(); // 상황에 따라 얘나 SellerDTO로 가야할 듯
      
      Connection conn = null;
      Statement st = null;
      try {
         conn = dataSource.getConnection();
         st = conn.createStatement();
         ResultSet rs = st.executeQuery("SELECT * FROM user where user.id = \""+ user.getId() +"\" and user.password = \""+ user.getPassword() +"\";");
         while(rs.next()) {
            memberDTO.setId(rs.getString(1));
            memberDTO.setName(rs.getString(3));
         }
         
         memberDTO.setAutority(0);
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
      return memberDTO;
   }
}