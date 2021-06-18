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
		String savedName = uid.toString() + "_" + originalName; // 얘네 두 줄을 가져다가 컨트롤러로 둬야겠지 진짜 등록까지 하려면???

		String folderPath = "/resources/image_room";
		File target = new File(defaultPath + folderPath, savedName);
		FileCopyUtils.copy(fileData, target); // 이 과정으로 인해 파일저장이 이루어지는 듯
		return savedName;
	}

	@RequestMapping(value = "/objectdetect", method = RequestMethod.POST) // 방 정보 받기
	String objectDetect(Model model, @RequestParam(value = "file", required = false) MultipartFile file,
			@ModelAttribute(value = "productId") int productId,
			@ModelAttribute(value = "productName") String productName,
			@ModelAttribute(value = "widthSize") int widthSize, @ModelAttribute(value = "heightSize") int heightSize) { // post,
																														// file명
																														// 및
																														// filetype
		String myRoom = ""; // 방 이름(식별자도 붙었음)																												// 받기
		try {
			Object[] obj = furnitureService.arrange(productId);
			ProductDTO productInfo = (ProductDTO) obj[0];
			productInfo.setId(productId);
			List<ImageDTO> imageList = (List<ImageDTO>) obj[1];

			productInfo.setName(productName);
			
			// 이미지 상 방 정보
			BufferedImage image = ImageIO.read(file.getInputStream());
			Integer roomImgWidth = image.getWidth();
			Integer roomImgHeight = image.getHeight();

			ArrayList<Integer[]> pSize = new ArrayList<Integer[]>();
			for (int i = 0; i < imageList.size(); i++) {
				Integer[] imgSizeInfo = new Integer[2]; // 0번째가 가로고 1번째가 세로
				Integer furnitureImgWidth = null; // 실제 적용할 가로
				Integer furnitureImgHeight = null; // 실제 적용할 세로
	
				String tempImgPath = imageList.get(i).getPath();
				if(tempImgPath.contains("Front") || tempImgPath.contains("Hide")) {
					System.out.println("가로");
					furnitureImgWidth = (roomImgWidth * productInfo.getWidth()) / widthSize;
					furnitureImgHeight = (furnitureImgWidth * productInfo.getHeight()) / productInfo.getWidth();
				}else if(tempImgPath.contains("Left") || tempImgPath.contains("Right")) {
					System.out.println("세로");
					furnitureImgWidth = (roomImgWidth * productInfo.getLength()) / widthSize;
					furnitureImgHeight = (furnitureImgWidth * productInfo.getHeight()) / productInfo.getLength();
				}else {
					furnitureImgWidth = (roomImgWidth * ((productInfo.getLength() + productInfo.getWidth()) / 2)) / widthSize;
					furnitureImgHeight = (furnitureImgWidth * productInfo.getHeight()) / ((productInfo.getLength() + productInfo.getWidth()) / 2);
					System.out.println("비스듬");
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
				// // 아니 생각해보니 방 높이에 맞추는게 아니라 가로에 맞는 세로 비율을 구하는게 맞겠네???

				pSize.add(imgSizeInfo);
			}
			myRoom = uploadFile(file.getOriginalFilename(), file.getBytes()); // 이미지 업로드
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

		// 이미 정보를 받아온 상태라면 api 호출하지않고 쿠키 참조

		 // 방 이미지 경로 입력
		  String filename = myRoom; // 사용자가 업로드한 파일명
		  String filepath = defaultPath + "//resources//image_room//" + filename;
		  StringTokenizer st = new StringTokenizer(filename, ".");
		  st.nextToken();
		  String type = st.nextToken(); // 이미지 파일 확장자
		  
		  URL url;
		  Integer responseCode = null;
		  String responBody = null;
		  String objects = null;
		  
		  try {
			  	 System.out.println("파일 이름 : " + filename);
		         Socket socket = new Socket("localhost", 9997); // Yolo 서버
		         OutputStream wr = socket.getOutputStream();
		         InputStream is = socket.getInputStream();

		         JSONObject object = new JSONObject();
		         object.put("filename", filename);
		         
		         byte[] data = object.toJSONString().getBytes(); // String to Bytes
		         ByteBuffer b = ByteBuffer.allocate(4);
		         // bytebuffer의 포맷지정 및 값 입력
		         b.order(ByteOrder.LITTLE_ENDIAN);
		         b.putInt(data.length);
		         // 데이터 길이 전송
		         wr.write(b.array(), 0, 4);
		         // 데이터 전송
		         wr.write(data);

		         data = new byte[4];

		         is.read(data, 0, 4); // 4바이트를 읽어 data에
		         b = ByteBuffer.wrap(data);
		         b.order(ByteOrder.LITTLE_ENDIAN);
		         int length = b.getInt(); // byte little_endian의 정수 -> int
		         // 데이터를 받을 버퍼를 선언한다.
		         data = new byte[length];
		         // 데이터를 받는다.
		         is.read(data, 0, length);
		         // byte형식의 데이터를 string형식으로 변환한다.
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
	         String x, String y, String rWidth, String rHeight, String fWidth, String fHeight, Model model) { // 컨트롤러 호출 시, x, y, 방이미지,
	                                                                        // 가구이미지 정보 받아옴
	      
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
	         // bytebuffer의 포맷지정 및 값 입력
	         b.order(ByteOrder.LITTLE_ENDIAN);
	         b.putInt(data.length);
	         // 데이터 길이 전송
	         wr.write(b.array(), 0, 4);
	         // 데이터 전송
	         wr.write(data);

	         data = new byte[4];

	         is.read(data, 0, 4); // 4바이트를 읽어 data에
	         b = ByteBuffer.wrap(data);
	         b.order(ByteOrder.LITTLE_ENDIAN);
	         int length = b.getInt(); // byte little_endian의 정수 -> int
	         // 데이터를 받을 버퍼를 선언한다.
	         data = new byte[length];
	         // 데이터를 받는다.
	         is.read(data, 0, length);
	         // byte형식의 데이터를 string형식으로 변환한다.
	         System.out.println(new String(data, "UTF-8"));

	         socket.close();

	      } catch (MalformedURLException e) {
	         e.printStackTrace();
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	 }
}
