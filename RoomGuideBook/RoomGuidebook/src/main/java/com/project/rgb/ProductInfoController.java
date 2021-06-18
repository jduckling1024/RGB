package com.project.rgb;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.Socket;
import java.net.URL;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.annotation.Resource;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.hc.client5.http.entity.mime.MultipartEntityBuilder;
import org.apache.hc.client5.http.fluent.Request;
import org.apache.hc.client5.http.fluent.Response;
import org.json.simple.JSONObject;
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

import com.google.gson.JsonArray;

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
	public String register(MultipartHttpServletRequest mpreq, @ModelAttribute("product") ProductDTO product, HttpSession session, RedirectAttributes ra)
			throws IOException {
		String id = ((SellerDTO) session.getAttribute("seller")).getId();
		product.setSellerId(id);
		
		MultipartFile tmpMainImg = mpreq.getFile("myFile3"); // ���� �̹���
		List<MultipartFile> imgForShow = mpreq.getFiles("myFile1"); // �� �̹���
		List<MultipartFile> imgForArrange = mpreq.getFiles("myFile2"); // ��ġ�� �̹���

		ImageDTO imgForMain = setPathAndUploadFile(tmpMainImg);
		List<ImageDTO> imgForShowList = setPathAndUploadFile(FOR_SHOW, imgForShow);
		List<ImageDTO> imgForArrangeList = setPathAndUploadFile(FOR_ARRANGE, imgForArrange);

		try {
			productInfoService.register(imgForMain, imgForShowList, imgForArrangeList, product);
			ra.addFlashAttribute("ProductInsertResult", "success");
		} catch (SQLException e) {
			ra.addFlashAttribute("ProductInsertResult", "fail");
			e.printStackTrace();
		}

		return "redirect:/getProductList";
	}
	
	@RequestMapping(value = "/updateProductFrom", method = RequestMethod.POST)
	public String updateForm(HttpServletRequest request, Model model, RedirectAttributes ra) {
		try {
			String[] target = request.getParameterValues("values");
			int id = Integer.parseInt(target[0]);
			System.out.println("��ǰ ���̵� : " + id);
			Object[] obj = productInfoService.getInfoToUpdate(id);
			ProductDTO product = (ProductDTO) obj[0];
			List<ImageDTO> imageList = (List<ImageDTO>) obj[1];
			
			ImageDTO mainImage = null;
			List<ImageDTO> infoImage = new ArrayList<ImageDTO>();
			List<ImageDTO> arrangeImage = new ArrayList<ImageDTO>();
			
			for(int i = 0; i < imageList.size(); i++) {
				int use = imageList.get(i).getUse();
				if(use == 201) {
					mainImage = imageList.get(i);
					// ���� �̹���
				}else if(use == 202) {
					arrangeImage.add(imageList.get(i));
					// ��ġ �̹���
				}else if(use == 203) {
					infoImage.add(imageList.get(i));
					// �� �̹���
				}
			}
			
			System.out.println(arrangeImage.size() + " " + infoImage.size());
			
			model.addAttribute("product", product);
			model.addAttribute("mainImage", mainImage);
			model.addAttribute("infoImage", infoImage);
			model.addAttribute("arrangeImage", arrangeImage);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			ra.addFlashAttribute("result", "fail"); 
			return "redirect:/getProductList";
		}
		
		return "/product/ProductUpdateView";
	}
	
	@RequestMapping(value = "/updateProduct", method = RequestMethod.POST)
	public String update(MultipartHttpServletRequest mpreq, @ModelAttribute("product") ProductDTO product, HttpSession session, RedirectAttributes ra)
			throws IOException {
		String id = ((SellerDTO) session.getAttribute("seller")).getId();
		product.setSellerId(id);
		
		MultipartFile tmpMainImg = mpreq.getFile("myFile3"); // ���� �̹���
		List<MultipartFile> imgForShow = mpreq.getFiles("myFile1"); // �� �̹���
		List<MultipartFile> imgForArrange = mpreq.getFiles("myFile2"); // ��ġ�� �̹���

		ImageDTO imgForMain = setPathAndUploadFile(tmpMainImg);
		List<ImageDTO> imgForShowList = setPathAndUploadFile(FOR_SHOW, imgForShow);
		List<ImageDTO> imgForArrangeList = setPathAndUploadFile(FOR_ARRANGE, imgForArrange);

//		for (int i = 0; i < imgForShowList.size(); i++) {
//			System.out.println(i + " " + imgForShowList.get(i).getPath());
//		}

		try {
			productInfoService.update(imgForMain, imgForShowList, imgForArrangeList, product);
			ra.addFlashAttribute("ProductUpdateResult", "success");
		} catch (SQLException e) {
			ra.addFlashAttribute("ProductUpdateResult", "fail");
			e.printStackTrace();
		}

		return "redirect:/getProductList";
	}

	
	public ImageDTO setPathAndUploadFile(MultipartFile file) throws IOException {
		UUID uid = UUID.randomUUID();
		String additoryPath;
		ImageDTO imageDTO = new ImageDTO();

		String originFileName = file.getOriginalFilename();
		imageDTO.setUse(201);
		additoryPath = "\\resources\\image_pmain\\";

		String savedName = additoryPath + uid.toString() + "_" + originFileName;

		imageDTO.setPath(uid.toString() + "_" + originFileName);
		
		File target = new File(defaultPath, savedName);
		FileCopyUtils.copy(file.getBytes(), target); // �� �������� ���� ���� ������ �̷������ ��

		return imageDTO;
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

				imageDTO.setUse(203);
				additoryPath = "\\resources\\image_pinfo\\";

				String savedName = additoryPath + uid.toString() + "_" + originFileName;

				imageDTO.setPath(uid.toString() + "_" + originFileName);
				imageList.add(imageDTO);

				File target = new File(defaultPath, savedName);
				FileCopyUtils.copy(mf.getBytes(), target); // �� �������� ���� ���� ������ �̷������ ��
			}
		} else {
			ArrayList<String> filenamesForArrange = new ArrayList<String>();
			// �޹�� ���� + ����

			for (MultipartFile mf : fileList) {
				String originFileName = mf.getOriginalFilename();
				ImageDTO imageDTO = new ImageDTO();

				imageDTO.setUse(202);
				additoryPath = "\\resources\\image_arrange_bp\\";

				String savedName = additoryPath + uid.toString() + "_" + originFileName;

				System.out.println("���� �̸� " + savedName);
				imageDTO.setPath(uid.toString() + "_" + originFileName);
				imageList.add(imageDTO); // ���� ���̳� �ĳ� �̹����� ������

				File target = new File(defaultPath, savedName);
				FileCopyUtils.copy(mf.getBytes(), target); // �� �������� ���� ���� ������ �̷������ ��

				filenamesForArrange.add(uid.toString() + "_" + originFileName);
			}

			imageProcess(filenamesForArrange);
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

	@RequestMapping(value = "/searchProduct", method = RequestMethod.GET)
	public String search(HttpSession session, @ModelAttribute("product") ProductDTO product, String dateStart,
			String dateEnd, Model model) {
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

	public void imageProcess(ArrayList<String> filenames) {

		try {
			Socket socket = new Socket("localhost", 9999);
			OutputStream os = socket.getOutputStream();

			JsonArray array = new JsonArray();

			for (int i = 0; i < filenames.size(); i++) {
				array.add(filenames.get(i));
			}

			JSONObject object = new JSONObject();
			object.put("file_names", array);

			System.out.println("���̽� ������ �����մϴ� ... ");

			byte[] data = object.toJSONString().getBytes(); // String to Bytes
			ByteBuffer b = ByteBuffer.allocate(4);
			// bytebuffer�� �������� �� �� �Է�
			b.order(ByteOrder.LITTLE_ENDIAN);
			b.putInt(data.length);
			// ������ ���� ����
			os.write(b.array(), 0, 4);
			// ������ ����
			os.write(data);
			socket.close();

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			for (int i = 0; i < filenames.size(); i++) {
				 //removeBackground(filenames.get(i));
			}
		}

	}

	public void removeBackground(String filename) {

		try {
			// String file_path =
			// "C:\\Users\\DeepLearning_7\\Desktop\\ForArrange\\"+filename;
			String file_path = defaultPath + "\\resources\\image_arrange_ap\\" + filename; // ��ġ�� �̹����� �ִ�
																										// ���
			System.out.println("���� ���� : " + file_path);

			Response response;

			response = Request.post("https://api.remove.bg/v1.0/removebg").addHeader("X-Api-Key", "11Lu8WRkTCeZjrkakKKWHRTi")
					.body(MultipartEntityBuilder.create().addBinaryBody("image_file", new File(file_path))
							.addTextBody("size", "auto").build())
					.execute();

			System.out.println(defaultPath + "\\resources\\image_arrange_ap\\" + filename);
			response.saveContent(new File(defaultPath + "\\resources\\image_arrange_ap\\" + filename));

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
