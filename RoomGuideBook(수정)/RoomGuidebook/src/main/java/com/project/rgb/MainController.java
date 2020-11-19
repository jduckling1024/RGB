package com.project.rgb;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dto.ImageDTO;
import dto.ProductDTO;
import mainManagement.MainService;

@Controller
public class MainController {
	@Autowired
	MainService mainService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String getMain(Model model) {
		try {
			List<Object[]> list = mainService.getMainImageList();
			
			List<ImageDTO> boardImageList = new ArrayList<ImageDTO>();
			List<ImageDTO> productImageList = new ArrayList<ImageDTO>();
			List<ProductDTO> productList = new ArrayList<ProductDTO>(); 
			
			for(int i = 0; i < list.size(); i++) {
				if(((ImageDTO) list.get(i)[0]).getUse() == 201) {
					productImageList.add((ImageDTO) list.get(i)[0]);
					productList.add((ProductDTO)list.get(i)[1]);
				}else if(((ImageDTO) list.get(i)[0]).getUse() == 204){
					boardImageList.add((ImageDTO) list.get(i)[0]);
				}
			}
			
			System.out.println(boardImageList.size());
			// 톰캣 서버 내에 저장하는 방향으로
			
			//System.out.println("메인 경로 " + productImageList.get(0).getPath());
			
			model.addAttribute("productImageList", productImageList);
			model.addAttribute("boardImageList", boardImageList);
			model.addAttribute("productList", productList);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "/main/main";
	} // 여기 있을 친구는 아니지만...
	
}
