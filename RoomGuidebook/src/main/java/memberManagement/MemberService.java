package memberManagement;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.MemberDTO;

@Service("memberService")
public class MemberService {
	@Autowired
	MemberDAO memberDAO;
	
	public void register(MemberDTO member) throws SQLException {
		memberDAO.register(member);
	}
	
	public void update(MemberDTO member) throws SQLException{
		memberDAO.update(member);
	}
	
	public void delete(String id) {
		memberDAO.delete(id);
	}
	
	public MemberDTO get(String id) throws SQLException {
		return memberDAO.get(id);
	}
}
