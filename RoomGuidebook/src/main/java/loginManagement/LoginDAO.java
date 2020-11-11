package loginManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
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

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet res = null;
	String sql;

	final static int MEMBER = 1;
	final static int SELLER = 2;

	public UserDTO login(UserDTO user) throws SQLException {
		MemberDTO memberDTO = null;
		SellerDTO sellerDTO = null;

		System.out.println(user.getId() + " " + user.getPassword());

		conn = dataSource.getConnection();
		sql = "SELECT * FROM user where user.id = ? and user.password = ?;";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, user.getId());
		psmt.setString(2, user.getPassword());

		res = psmt.executeQuery();
		
		while (res.next()) {
			int autority = res.getInt(4);

			if (autority == MEMBER) {
				memberDTO = new MemberDTO();
				memberDTO.setId(res.getString(1));
				memberDTO.setPassword(res.getString(2));
				memberDTO.setName(res.getString(3));
				memberDTO.setAutority(autority);
			} else if (autority == SELLER) {
				sellerDTO = new SellerDTO();
				sellerDTO.setId(res.getString(1));
				sellerDTO.setPassword(res.getString(2));
				sellerDTO.setName(res.getString(3));
				sellerDTO.setAutority(autority);
			}
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

		if (memberDTO != null) {
			return memberDTO;
		} else if (sellerDTO != null) {
			return sellerDTO;
		}

		return null;
	}
}