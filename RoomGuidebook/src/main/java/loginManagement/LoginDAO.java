package loginManagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.MemberDTO;
import dto.SellerDTO;
import dto.UserDTO;

@Repository("loginDAO")
public class LoginDAO {
   
   @Autowired
   BasicDataSource dataSource;
   
   final static int MEMBER = 1;
   final static int SELLER = 2;
   
   public UserDTO login(UserDTO user) {
      MemberDTO memberDTO = new MemberDTO();
      SellerDTO sellerDTO = new SellerDTO();
      
      Connection conn = null;
      Statement st = null;
      try {
         conn = dataSource.getConnection();
         st = conn.createStatement();
         ResultSet rs = st.executeQuery("SELECT * FROM user where user.id = \""+ user.getId() +"\" and user.password = \""+ user.getPassword() +"\";");
         
         while(rs.next()) {
        	int autority = rs.getInt(4);
        	
        	if(autority == MEMBER) {
        		 memberDTO.setId(rs.getString(1));
                 memberDTO.setName(rs.getString(3));
                 memberDTO.setAutority(autority);
        	}else if(autority == SELLER) {
        		sellerDTO.setId(rs.getString(1));
        		sellerDTO.setName(rs.getString(3));
        		sellerDTO.setAutority(autority);
        	}
         }
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
		
      if(memberDTO != null) {
    	  return memberDTO;
      }else if(sellerDTO != null) {
    	  return sellerDTO;
      }
      
      return null;
   }
}