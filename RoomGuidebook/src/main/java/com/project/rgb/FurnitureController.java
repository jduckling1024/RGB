package com.project.rgb;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import dto.ImageDTO;
import dto.ProductDTO;
import furnitureManagement.FurnitureService;

@Controller
public class FurnitureController {
	@Autowired
	FurnitureService furnitureService;
	
	@RequestMapping(value="/getFurnitureList", method = RequestMethod.GET)
	public String list(Model model) {
		try {
			List<Object[]> list = furnitureService.getList();		
			model.addAttribute("list", list);
			return "/furniture/FurnitureListView";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping(value="/getFurniture", method = RequestMethod.GET)
	public String get(@RequestParam(value="id") int id, Model model) {
		try {
			Object[] obj = furnitureService.get(id);
			ProductDTO productDTO = (ProductDTO)obj[0];
			ArrayList<ImageDTO> imageList = (ArrayList<ImageDTO>)obj[1];
			// System.out.println(((ProductDTO) obj[0]).getName());
			model.addAttribute("product", productDTO);
			model.addAttribute("image", imageList);
			for(int i = 0; i < imageList.size(); i++) {
				System.out.println("경로 " + imageList.get(i).getPath());
			}
			return "/furniture/FurnitureView";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public String search(String word, Model model) {
		
		return null;
	} // 아니 근데 색상이나 필터는 다른 컬럼에 적용되는데 어떡하지???
}
