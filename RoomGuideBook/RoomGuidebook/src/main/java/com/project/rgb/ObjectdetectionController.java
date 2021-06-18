package com.project.rgb;

import java.awt.image.BufferedImage;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import dto.ImageDTO;
import dto.ProductDTO;
import furnitureManagement.FurnitureService;

import com.google.gson.Gson;
import java.net.*;

@Controller
public class ObjectdetectionController {
	@Autowired
	FurnitureService furnitureService;

	@Resource(name = "defaultPath")
	private String defaultPath;

	@RequestMapping(value = "/pathtest")
	String test(Model model) {

		return "/furniture/test";
	}

	public String uploadFile(String originalName, byte[] fileData) throws IOException {
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() + "_" + originalName; // ��� �� ���� �����ٰ� ��Ʈ�ѷ��� �־߰��� ��¥ ��ϱ��� �Ϸ���???

		String folderPath = "/resources/image_room";
		File target = new File(defaultPath + folderPath, savedName);
		FileCopyUtils.copy(fileData, target); // �� �������� ���� ���������� �̷������ ��
		return savedName;
	}

	@RequestMapping(value = "/objectdetect", method = RequestMethod.POST) // �� ���� �ޱ�
	String objectDetect(Model model, @RequestParam(value = "file", required = false) MultipartFile file,
			@ModelAttribute(value = "productId") int productId,
			@ModelAttribute(value = "productName") String productName,
			@ModelAttribute(value = "widthSize") int widthSize, @ModelAttribute(value = "heightSize") int heightSize) { // post,
																														// file��
																														// ��
																														// filetype
		String myRoom = ""; // �� �̸�(�ĺ��ڵ� �پ���)																												// �ޱ�
		try {
			Object[] obj = furnitureService.arrange(productId);
			ProductDTO productInfo = (ProductDTO) obj[0];
			productInfo.setId(productId);
			List<ImageDTO> imageList = (List<ImageDTO>) obj[1];

			productInfo.setName(productName);
			
			// �̹��� �� �� ����
			BufferedImage image = ImageIO.read(file.getInputStream());
			Integer roomImgWidth = image.getWidth();
			Integer roomImgHeight = image.getHeight();

			ArrayList<Integer[]> pSize = new ArrayList<Integer[]>();
			for (int i = 0; i < imageList.size(); i++) {
				Integer[] imgSizeInfo = new Integer[2]; // 0��°�� ���ΰ� 1��°�� ����
				Integer furnitureImgWidth = null; // ���� ������ ����
				Integer furnitureImgHeight = null; // ���� ������ ����
	
				String tempImgPath = imageList.get(i).getPath();
				if(tempImgPath.contains("Front") || tempImgPath.contains("Hide")) {
					System.out.println("����");
					furnitureImgWidth = (roomImgWidth * productInfo.getWidth()) / widthSize;
					furnitureImgHeight = (furnitureImgWidth * productInfo.getHeight()) / productInfo.getWidth();
				}else if(tempImgPath.contains("Left") || tempImgPath.contains("Right")) {
					System.out.println("����");
					furnitureImgWidth = (roomImgWidth * productInfo.getLength()) / widthSize;
					furnitureImgHeight = (furnitureImgWidth * productInfo.getHeight()) / productInfo.getLength();
				}else {
					furnitureImgWidth = (roomImgWidth * ((productInfo.getLength() + productInfo.getWidth()) / 2)) / widthSize;
					furnitureImgHeight = (furnitureImgWidth * productInfo.getHeight()) / ((productInfo.getLength() + productInfo.getWidth()) / 2);
					System.out.println("�񽺵�");
				}
				
				imgSizeInfo[0] = furnitureImgWidth;
				imgSizeInfo[1] = furnitureImgHeight;
				
				System.out.println(furnitureImgWidth + " " + furnitureImgHeight);
				
//					if (i % 2 == 0) {
//						furnitureImgWidth = (roomImgWidth * productInfo.getWidth()) / widthSize;
//						furnitureImgHeight = (furnitureImgWidth * productInfo.getHeight()) / productInfo.getWidth();
//					} else {
//						furnitureImgWidth = (roomImgWidth * productInfo.getLength()) / widthSize;
//						furnitureImgHeight = (furnitureImgWidth * productInfo.getHeight()) / productInfo.getLength();
//					}
					
				// furnitureImgHeight = (roomImgHeight * productInfo.getHeight()) / heightSize;
				// // �ƴ� �����غ��� �� ���̿� ���ߴ°� �ƴ϶� ���ο� �´� ���� ������ ���ϴ°� �°ڳ�???

				pSize.add(imgSizeInfo);
			}
			myRoom = uploadFile(file.getOriginalFilename(), file.getBytes()); // �̹��� ���ε�
			Date d = new Date();
			model.addAttribute("pSize", pSize);
			model.addAttribute("myRoomPath", "/resources/image_room/"); 
			model.addAttribute("myRoomPath2", "\\resources\\image_room\\" + myRoom);
			model.addAttribute("filename", myRoom);
			model.addAttribute("imageList", imageList);
			model.addAttribute("productInfo", productInfo);
			
			model.addAttribute("widthSize", widthSize);
			model.addAttribute("heightSize", heightSize);
			
		} catch (SQLException e) {
			e.printStackTrace(); 
		} catch (IOException e) {
			e.printStackTrace();
		}

		// �̹� ������ �޾ƿ� ���¶�� api ȣ�������ʰ� ��Ű ����

		 // �� �̹��� ��� �Է�
		  String filename = myRoom; // ����ڰ� ���ε��� ���ϸ�
		  String filepath = defaultPath + "//resources//image_room//" + filename;
		  StringTokenizer st = new StringTokenizer(filename, ".");
		  st.nextToken();
		  String type = st.nextToken(); // �̹��� ���� Ȯ����
		  
		  URL url;
		  Integer responseCode = null;
		  String responBody = null;
		  String objects = null;
		  
		  try {
			  	 System.out.println("���� �̸� : " + filename);
		         Socket socket = new Socket("localhost", 9997); // Yolo ����
		         OutputStream wr = socket.getOutputStream();
		         InputStream is = socket.getInputStream();

		         JSONObject object = new JSONObject();
		         object.put("filename", filename);
		         
		         byte[] data = object.toJSONString().getBytes(); // String to Bytes
		         ByteBuffer b = ByteBuffer.allocate(4);
		         // bytebuffer�� �������� �� �� �Է�
		         b.order(ByteOrder.LITTLE_ENDIAN);
		         b.putInt(data.length);
		         // ������ ���� ����
		         wr.write(b.array(), 0, 4);
		         // ������ ����
		         wr.write(data);

		         data = new byte[4];

		         is.read(data, 0, 4); // 4����Ʈ�� �о� data��
		         b = ByteBuffer.wrap(data);
		         b.order(ByteOrder.LITTLE_ENDIAN);
		         int length = b.getInt(); // byte little_endian�� ���� -> int
		         // �����͸� ���� ���۸� �����Ѵ�.
		         data = new byte[length];
		         // �����͸� �޴´�.
		         is.read(data, 0, length);
		         // byte������ �����͸� string�������� ��ȯ�Ѵ�.
		         objects = new String(data, "UTF-8");

		         socket.close();

		      } catch (MalformedURLException e) {
		         e.printStackTrace();
		      } catch (IOException e) {
		         e.printStackTrace();
		      }
		   
		   st = new StringTokenizer(objects, "#");
		   int size = Integer.parseInt(st.nextToken());
		   objects = objects.substring(2, objects.length()-1);
		   
		   System.out.println(objects);
		   
		   model.addAttribute("cookie", true);
	       model.addAttribute("size", size); // data.size()
	       model.addAttribute("objects", objects); // objects
	       model.addAttribute("filepath", "\\resources\\image_room\\"+filename);
  
     	return "furniture/arrange";
	}

	@RequestMapping(value = "/com_objectdetect", method = RequestMethod.POST)
	String com_objectDetect(String rFilepath, Model model) {

		model.addAttribute("cookie", false);
		model.addAttribute("filepath", rFilepath);

		return "furniture/arrange";
	}

	 @RequestMapping(value = "/transferColor", method = RequestMethod.POST)
	   @ResponseBody
	   void transferColor(String rFilepath, String fFilepath, 
	         String x, String y, String rWidth, String rHeight, String fWidth, String fHeight, Model model) { // ��Ʈ�ѷ� ȣ�� ��, x, y, ���̹���,
	                                                                        // �����̹��� ���� �޾ƿ�
	      
	      StringTokenizer st = new StringTokenizer(fFilepath, "\\");
	      String fFilename = "";

	      while (st.hasMoreTokens()) {
	         fFilename = st.nextToken();
	      }
	      System.out.println(fFilename);

	      String openApiURL = "http://localhost:9998";

	      URL url;
	      Integer responseCode = null;
	      String responBody = null;

	      System.out.print("(" + x + ", " + y + ")");

	      try {
	         Socket socket = new Socket("localhost", 9998);
	         OutputStream wr = socket.getOutputStream();
	         InputStream is = socket.getInputStream();

	         JSONObject posObject = new JSONObject();
	         posObject.put("x", x);
	         posObject.put("y", y);

	         JSONObject imageObject = new JSONObject();
	         imageObject.put("r_filepath", defaultPath + rFilepath);
	         imageObject.put("f_filepath", defaultPath + fFilepath);
	         imageObject.put("f_filename", fFilename);
	         
	         JSONObject shapeObject = new JSONObject();
	         shapeObject.put("r_width", rWidth);
	         shapeObject.put("r_height", rHeight);
	         shapeObject.put("f_width", fWidth);
	         shapeObject.put("f_height", fHeight);

	         JSONObject objects = new JSONObject();
	         objects.put("pos", posObject);
	         objects.put("image", imageObject);
	         objects.put("shape", shapeObject);
	         

	         byte[] data = objects.toJSONString().getBytes(); // String to Bytes
	         ByteBuffer b = ByteBuffer.allocate(4);
	         // bytebuffer�� �������� �� �� �Է�
	         b.order(ByteOrder.LITTLE_ENDIAN);
	         b.putInt(data.length);
	         // ������ ���� ����
	         wr.write(b.array(), 0, 4);
	         // ������ ����
	         wr.write(data);

	         data = new byte[4];

	         is.read(data, 0, 4); // 4����Ʈ�� �о� data��
	         b = ByteBuffer.wrap(data);
	         b.order(ByteOrder.LITTLE_ENDIAN);
	         int length = b.getInt(); // byte little_endian�� ���� -> int
	         // �����͸� ���� ���۸� �����Ѵ�.
	         data = new byte[length];
	         // �����͸� �޴´�.
	         is.read(data, 0, length);
	         // byte������ �����͸� string�������� ��ȯ�Ѵ�.
	         System.out.println(new String(data, "UTF-8"));

	         socket.close();

	      } catch (MalformedURLException e) {
	         e.printStackTrace();
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	 }
}
