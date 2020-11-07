package com.project.rgb;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dto.ImageDTO;
import dto.MemberDTO;
import dto.ProductDTO;
import dto.SellerDTO;
import productInfoManagement.ProductInfoService;

@Controller
public class ProductInfoController {

	@Autowired
	ProductInfoService productInfoService;

	@Resource(name = "defaultPath")
	private String defaultPath;

	final static int FOR_SHOW = 1;
	final static int FOR_ARRANGE = 2;

	/*
	 * -----------------------------------------------------------------------------
	 * ----------
	 */
	@RequestMapping(value = "/getRegisterProductForm", method = RequestMethod.GET)
	public String registerForm() {
		return "/product/ProductInsertView";
	}

	@RequestMapping(value = "/registerProduct", method = RequestMethod.POST)
	public String register(MultipartHttpServletRequest mpreq, @ModelAttribute("product") ProductDTO product)
			throws IOException {
		List<MultipartFile> imgForShow = mpreq.getFiles("myFile1"); // �� �̹���
		List<MultipartFile> imgForArrange = mpreq.getFiles("myFile2"); // ��ġ�� �̹���
		// �̹��� ��� ������ �ڸ��°� �ڵ� ������ �� ������ ������ ���� �ϰ� ��ȯ���ִ°� ���� �� ���� ����...?

		List<ImageDTO> imgForShowList = setPathAndUploadFile(FOR_SHOW, imgForShow);
		List<ImageDTO> imgForArrangeList = setPathAndUploadFile(FOR_ARRANGE, imgForArrange);

		for (int i = 0; i < imgForShowList.size(); i++) {
			System.out.println(i + " " + imgForShowList.get(i).getPath());
		}

		productInfoService.register(imgForShowList, imgForArrangeList, product);

		return null; // ���� �̷��� ������ �����̷�Ʈ�� �ض�...
	}

	public List<ImageDTO> setPathAndUploadFile(int use, List<MultipartFile> fileList) throws IOException {
		UUID uid = UUID.randomUUID();
		int i = 0;
		String additoryPath;
		List<ImageDTO> imageList = new ArrayList<ImageDTO>();

		if (use == FOR_SHOW) {
			for (MultipartFile mf : fileList) {
				String originFileName = mf.getOriginalFilename();
				ImageDTO imageDTO = new ImageDTO();
				if (i == 0) {
					imageDTO.setUse(201);
					additoryPath = "\\resources\\image_main\\";
				} else {
					additoryPath = "\\resources\\image_info\\";
				}

				String savedName = additoryPath + uid.toString() + "_" + originFileName;

				imageDTO.setPath(savedName);
				imageList.add(imageDTO);

				// File target = new File(defaultPath, savedName);
				// FileCopyUtils.copy(mf.getBytes(), target); // �� �������� ���� ���� ������ �̷������ ��
			}
		} else {
			// �̹��� ��� ���ִ°� ó�����ּ���
		}
		return imageList;
	}

	/*
	 * -----------------------------------------------------------------------------
	 * ----------
	 */

	@RequestMapping(value = "/deleteProduct", method = RequestMethod.POST)
	public String delete(HttpServletRequest request, RedirectAttributes ra) {
		try {
			String[] targets = request.getParameterValues("values");
			for (int i = 0; i < targets.length; i++) {
				System.out.print(targets[i] + " ");
			}
			productInfoService.delete(targets);
			ra.addFlashAttribute("ProductDeleteResult", "success");
			return "redirect:/getProductList";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			ra.addFlashAttribute("ProductDeleteResult", "fail");
			return "redirect:/getProductList";
		}
	}

	@RequestMapping(value = "/searchProduct", method = RequestMethod.POST)
	public String search(HttpSession session, @ModelAttribute("product") ProductDTO product, String dateStart, String dateEnd, Model model) {
		try {
			String id = ((SellerDTO) session.getAttribute("seller")).getId();
			System.out.println(product.getChildCategory());
			product.setSellerId(id);
			List<Object[]> list = productInfoService.search(product, dateStart, dateEnd);
			System.out.println("��" + list);
			model.addAttribute("list", list);
			return "product/ProductView";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

	@RequestMapping(value = "/getProductList", method = RequestMethod.GET)
	public String list(HttpSession session, Model model) {
		try {
			String id = ((SellerDTO) session.getAttribute("seller")).getId();
			List<Object[]> list = productInfoService.getList(id);
			model.addAttribute("list", list);
			return "product/ProductView";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
