package loginManagement;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import dto.UserDTO;

@Service("loginService")
public class LoginService {
	
	@Autowired
	LoginDAO loginDAO;
	public UserDTO login(UserDTO user) throws SQLException {
		return loginDAO.login(user);
	}
}
