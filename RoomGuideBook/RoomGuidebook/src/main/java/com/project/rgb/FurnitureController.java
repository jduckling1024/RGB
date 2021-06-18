package com.project.rgb;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import dto.ImageDTO;
import dto.ProductDTO;
import furnitureManagement.FurnitureService;

@Controller
public class FurnitureController {
	@Autowired
	FurnitureService furnitureService;

	@Resource(name = "defaultPath")
	private String defaultPath;

	@RequestMapping(value = "/getFurnitureList", method = RequestMethod.GET)
	public String list(Model model) {
		try {
			List<Object[]> list = furnitureService.getList();
			model.addAttribute("list", list);
			model.addAttribute("proLen", list.size());
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
			
			System.out.println("컨트롤러" + productDTO.getParentCategory() + " " + productDTO.getChildCategory());
			
			model.addAttribute("product", productDTO);
			model.addAttribute("imageList", imageList);
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
			if (st.hasMoreTokens()) {
				String name = st.nextToken();
				if (code.equals("category")) {
					id = 1;
				} else if (code.equals("brand")) {
					id = 2;
				} else if (code.equals("price")) {
					id = 3;
				} else if (code.equals("color")) {
					id = 4;
				} else if (code.equals("sort")) {
					id = 5;
				} else {
					id = -1;
				}
				list = furnitureService.search(id, name);
			} else {
				id = -1;
				list = furnitureService.search(id, word);
			}
			model.addAttribute("proLen", list.size());
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

//	@RequestMapping(value = "/arrange", method = RequestMethod.POST)
//	public String arrange(MultipartFile file, @ModelAttribute(value = "productId") int productId,
//			@ModelAttribute(value = "productName") String productName,
//			@ModelAttribute(value = "widthSize") int widthSize, 
//			@ModelAttribute(value = "heightSize") int heightSize, Model model) {
//		try {
//			//BufferedImage image = ImageIO.read(file.getInputStream());
//			//System.out.print(image.getWidth() + " " + image.getHeight());
//			
//			Object[] obj = furnitureService.arrange(productId);
//			ProductDTO productInfo = (ProductDTO) obj[0];
//			List<ImageDTO> imageList = (List<ImageDTO>) obj[1];
//
//			//String myRoomPath = uploadFile(file.getOriginalFilename(), file.getBytes());
//			
//			String myRoomPath = "/resources/image_room/room2.PNG";
//			model.addAttribute("myRoomPath", myRoomPath);
//			model.addAttribute("imageList", imageList);
//			model.addAttribute("productInfo", productInfo);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} 
//
//
//		return "/furniture/arrange";
//	}
//
//	public String uploadFile(String originalName, byte[] fileData) throws IOException {
//		UUID uid = UUID.randomUUID();
//		String savedName = uid.toString() + "_" + originalName; // 얘네 두 줄을 가져다가 컨트롤러로 둬야겠지 진짜 등록까지 하려면???
//
//		String folderPath = "/resources/image_room";
//		File target = new File(defaultPath + folderPath, savedName);
//		FileCopyUtils.copy(fileData, target); // 이 과정으로 인해 파일저장이 이루어지는 듯
//		return folderPath + "/" + savedName;
//	}
}
