package com.project.rgb;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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

	@RequestMapping(value = "/getFurnitureList", method = RequestMethod.GET)
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

	@RequestMapping(value = "/getFurniture", method = RequestMethod.GET)
	public String get(@RequestParam(value = "id") int id, Model model) {
		try {
			Object[] obj = furnitureService.get(id);
			ProductDTO productDTO = (ProductDTO) obj[0];
			ArrayList<ImageDTO> imageList = (ArrayList<ImageDTO>) obj[1];
			// System.out.println(((ProductDTO) obj[0]).getName());
			model.addAttribute("product", productDTO);
			model.addAttribute("image", imageList);
			for (int i = 0; i < imageList.size(); i++) {
				System.out.println("경로 " + imageList.get(i).getPath());
			}
			return "/furniture/FurnitureView";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String search(@RequestParam("product") String word, Model model) {
		System.out.println("word" + word);
		List<Object[]> list;
		try {
			StringTokenizer st = new StringTokenizer(word, "_");
			int id;
			String code = st.nextToken();
			if(st.hasMoreTokens()) {
				String name = st.nextToken();

				if (code.equals("category")) {
					id = 1;

				} else if (code.equals("brand")) {
					id = 2;

				} else if (code.equals("price")){
					id = 3;
				} else if (code.equals("color")){
					id = 4;
				}else {
					id = -1;
				}
				list = furnitureService.search(id, name);
				
			}else {
				id = -1;
				list = furnitureService.search(id, word);
			}
			
			model.addAttribute("list", list);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "/furniture/FurnitureListView";
	} // 아니 근데 색상이나 필터는 다른 컬럼에 적용되는데 어떡하지???

	@RequestMapping(value = "/insertArrangeInfo", method = RequestMethod.POST)
	public String getArrangeInfoPage(@ModelAttribute("productId") int productId,
			@ModelAttribute("productName") String productName, Model model) {
		model.addAttribute("productId", productId);
		model.addAttribute("productName", productName);

		System.out.println("상품 아이디" + productId);

		return "/furniture/insertInfo";
	}

	@RequestMapping(value = "/arrange", method = RequestMethod.POST)
	public String arrange(@ModelAttribute(value = "productId") int productId,
			@ModelAttribute(value = "productName") String productName,
			@ModelAttribute(value = "widthSize") int widthSize, @ModelAttribute(value = "heightSize") int heightSize,
			@ModelAttribute(value = "path") String path, Model model) {
		try {
			System.out.println("잘 넘어왔다.");
			Object[] obj = furnitureService.arrange(productId);
			ProductDTO productInfo = (ProductDTO) obj[0];
			List<ImageDTO> imageList = (List<ImageDTO>) obj[1];
			// 이미지 올리면 임시로 저장하는 구문 필요할 듯 지금은 살짝 사기(?)치고
			String myRoomPath = "/resources/temp_room/small.PNG";
			model.addAttribute("myRoomPath", myRoomPath);
			model.addAttribute("imageList", imageList);
			model.addAttribute("productInfo", productInfo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "/furniture/arrange";
	} // 중간에 뷰 하나 필요한데 일단은 테스트 상 바로 넘어가게 했다.
}
