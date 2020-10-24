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
import mainManagement.MainService;

@Controller
public class MainController {
	@Autowired
	MainService mainService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String getMain(Model model) {
		try {
			List<ImageDTO> imageList = mainService.getMainImageList();
			List<ImageDTO> boardImageList = new ArrayList<ImageDTO>();
			List<ImageDTO> productImageList = new ArrayList<ImageDTO>();
			
			for(int i = 0; i < imageList.size(); i++) {
				if(imageList.get(i).getUse() == 201) {
					productImageList.add(imageList.get(i));
				}else if(imageList.get(i).getUse() == 204){
					boardImageList.add(imageList.get(i));
				}
			}
			
			System.out.println("메인 경로 " + productImageList.get(0).getPath());
			
			model.addAttribute("productImageList", productImageList);
			model.addAttribute("boardImageList", boardImageList);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "/main/main";
	} // 여기 있을 친구는 아니지만...
	
}
