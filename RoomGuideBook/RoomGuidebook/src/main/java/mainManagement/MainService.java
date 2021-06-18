package mainManagement;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ImageDTO;

@Service("mainService")
public class MainService {
   @Autowired
   MainDAO mainDAO;
   
   public List<Object[]> getMainImageList() throws SQLException {
      return mainDAO.getMainImageList();
   }
}