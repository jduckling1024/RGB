package memberManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



import dto.MemberDTO;
import dto.UserDTO;

@Repository("memberDAO")
public class MemberDAO {

	@Autowired
	BasicDataSource dataSource;

	UserDTO userDTO = new UserDTO();
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet res;
	String sql;

	public void register(MemberDTO member) throws SQLException {
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			sql = "insert into rgb.user values (?, ?, ?, 1);";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, member.getId());
			psmt.setString(2, member.getPassword());
			psmt.setString(3, member.getName());
			psmt.executeUpdate();
			
			sql = "insert into rgb.member values(?, ?, ?, ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, member.getId());
			psmt.setString(2,  member.getPhoneNum());
			psmt.setString(3, member.getAddress());
			psmt.setString(4, member.getEmail());
			psmt.executeUpdate();
			conn.commit();
		} 
		catch (SQLException e) {
			conn.rollback();
			throw new SQLException();
		} finally {
			conn.setAutoCommit(true);
			
			if(res != null) {
				res.close();
			}
			if(psmt != null) {
				psmt.close();
			}
			if(conn != null) {
				conn.close();
			}
		}
	}
	
	public void update(MemberDTO member) throws SQLException{
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			sql = "UPDATE rgb.user SET password = ?, name = ?  WHERE (id = ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, member.getPassword());
			psmt.setString(2, member.getName());
			psmt.setString(3, member.getId());
			psmt.executeUpdate();
			
			sql = "UPDATE rgb.member SET phoneNum = ?, address = ?, email = ? WHERE (id = ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,  member.getPhoneNum());
			psmt.setString(2, member.getAddress());
			psmt.setString(3, member.getEmail());
			psmt.setString(4, member.getId());
			psmt.executeUpdate();
			conn.commit();
		} 
		catch (SQLException e) {
			conn.rollback();
			throw new SQLException();
		} finally {
			conn.setAutoCommit(true);
			
			if(res != null) {
				res.close();
			}
			if(psmt != null) {
				psmt.close();
			}
			if(conn != null) {
				conn.close();
			}
		}
	}
	
	public void delete(String id) throws SQLException{
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			sql = "DELETE FROM rgb.member WHERE (id = ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.executeUpdate();
			
			sql = "DELETE FROM rgb.user WHERE (id = ?);";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.executeUpdate();
			conn.commit();
		} 
		catch (SQLException e) {
			conn.rollback();
			throw new SQLException();
		} finally {
			conn.setAutoCommit(true);
			
			if(res != null) {
				res.close();
			}
			if(psmt != null) {
				psmt.close();
			}
			if(conn != null) {
				conn.close();
			}
		}
	}
	
	public MemberDTO get(String id) throws SQLException {
		conn = dataSource.getConnection();
		sql = "SELECT * \r\n"
				+ "FROM user, member \r\n"
				+ "WHERE user.id = ? and user.id = member.id;";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		res = psmt.executeQuery();
		
		MemberDTO memberDTO = new MemberDTO();
		while(res.next()) {
			memberDTO.setId(res.getString(1));
			memberDTO.setPassword(res.getString(2));
			memberDTO.setName(res.getString(3));
			memberDTO.setPhoneNum(res.getString(6));
			memberDTO.setAddress(res.getString(7));
			memberDTO.setEmail(res.getString(8));
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
		
		return memberDTO;
	}
}
