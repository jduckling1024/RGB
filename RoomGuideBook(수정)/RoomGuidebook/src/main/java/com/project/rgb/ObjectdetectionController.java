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
		return folderPath + "/" + savedName;
	}

	@RequestMapping(value = "/objectdetect", method = RequestMethod.POST) // 방 정보 받기
	String objectDetect(Model model, @RequestParam(value = "file", required = false) MultipartFile file,
			@ModelAttribute(value = "productId") int productId,
			@ModelAttribute(value = "productName") String productName,
			@ModelAttribute(value = "widthSize") int widthSize, @ModelAttribute(value = "heightSize") int heightSize) { // post,
																														// file명
																														// 및
																														// filetype
																														// 받기
		try {
			Object[] obj = furnitureService.arrange(productId);
			ProductDTO productInfo = (ProductDTO) obj[0];
			List<ImageDTO> imageList = (List<ImageDTO>) obj[1];

			if(file == null) {
				System.out.println("널");
			}else {
				System.out.println("널 아님");
			}
			
			// 이미지 상 방 정보
			BufferedImage image = ImageIO.read(file.getInputStream());
			Integer roomImgWidth = image.getWidth();
			Integer roomImgHeight = image.getHeight();

			ArrayList<Integer[]> pSize = new ArrayList<Integer[]>();
			for (int i = 0; i < imageList.size(); i++) {
				Integer[] imgSizeInfo = new Integer[2]; // 0번째가 가로고 1번째가 세로
				Integer furnitureImgWidth;
				Integer furnitureImgHeight;
	
					if (i % 2 == 0) {
						furnitureImgWidth = (roomImgWidth * productInfo.getWidth()) / widthSize;
						furnitureImgHeight = (furnitureImgWidth * productInfo.getHeight()) / productInfo.getWidth();
					} else {
						furnitureImgWidth = (roomImgWidth * productInfo.getLength()) / widthSize;
						furnitureImgHeight = (furnitureImgWidth * productInfo.getHeight()) / productInfo.getLength();
					}
					imgSizeInfo[0] = furnitureImgWidth;
					imgSizeInfo[1] = furnitureImgHeight;
					System.out.println(furnitureImgWidth + " " + furnitureImgHeight);
				
				// furnitureImgHeight = (roomImgHeight * productInfo.getHeight()) / heightSize;
				// // 아니 생각해보니 방 높이에 맞추는게 아니라 가로에 맞는 세로 비율을 구하는게 맞겠네???

				pSize.add(imgSizeInfo);
			}

			String myRoomPath = uploadFile(file.getOriginalFilename(), file.getBytes()); // 이미지 업로드

			model.addAttribute("pSize", pSize);
			model.addAttribute("myRoomPath", myRoomPath);
			model.addAttribute("myRoomPath2", "\\resources\\image_room\\" + file.getOriginalFilename());
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

		String openApiURL = "http://aiopen.etri.re.kr:8000/ObjectDetect";
		String accessKey = "b2dcca90-be1f-4043-917c-04c4f661f55d"; // 발급받은 API Key
		
		String filename = file.getOriginalFilename(); // 사용자가 업로드한 파일명
		StringTokenizer st = new StringTokenizer(filename, ".");
		st.nextToken();
		String type = st.nextToken(); // 이미지 파일 확장자
		String filepath = defaultPath + "//resources//image_room//" + filename;
		// 사용자가 업로드한 파일 경로
		String imageContents = ""; // byte배열로 변환 후 인코딩
		Gson gson = new Gson(); // Dependency 추가

		Map<String, Object> request = new HashMap();
		Map<String, String> argument = new HashMap();
		try {
			Path path = Paths.get(filepath);
			byte[] imageBytes = Files.readAllBytes(path);
			imageContents = Base64.getEncoder().encodeToString(imageBytes);

		} catch (IOException e) {
			e.printStackTrace();
		}

		argument.put("type", type);
		argument.put("file", imageContents);

		request.put("access_key", accessKey);
		request.put("argument", argument);

		URL url;
		Integer responseCode = null;
		String responBody = null;

		try {
			url = new URL(openApiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);

			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.write(gson.toJson(request).getBytes("UTF-8"));
			wr.flush();
			wr.close();

			responseCode = con.getResponseCode();
			InputStream is = con.getInputStream();
			byte[] buffer = new byte[is.available()];
			int byteRead = is.read(buffer);
			responBody = new String(buffer);

			JsonParser pa = new JsonParser();
			JsonObject object = pa.parse(responBody).getAsJsonObject().getAsJsonObject("return_object");
			JsonArray data = object.getAsJsonArray("data");

			String objects = "";

			for (int i = 0; i < data.size(); i++) { // java에서 저장한 2차원 배열을 js에서의 2차원배열로 변경하려했으나
													// 서로의 인덱스를 동시에 접근하는 방법을 찾지못해
													// 데이터들을 몽땅 string 한줄에 넣어 tokenizer이용해
													// js의 2차원 배열에 저장
				objects += data.get(i).getAsJsonObject().get("x").getAsInt() + "#";
				objects += data.get(i).getAsJsonObject().get("y").getAsInt() + "#";
				objects += data.get(i).getAsJsonObject().get("width").getAsInt() + "#";
				objects += data.get(i).getAsJsonObject().get("height").getAsInt() + "#";
			}

			System.out.print(objects);

			model.addAttribute("cookie", true);
			model.addAttribute("size", data.size()); // data.size()
			model.addAttribute("objects", objects); // "5#232#544#320#425#455#123#36#420#10#89#103#"
			// model.addAttribute("filepath", "\\resources\\image_room\\" + filename); //
			// filename (방 이미지인데 위에서 처리하므로 일단 주석처리)

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
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
	void transferColor(String rFilepath, String fFilepath, String x, String y, Model model) { // 컨트롤러 호출 시, x, y, 방이미지,
																								// 가구이미지 정보 받아옴
		System.out.println("???" + fFilepath);
		
		StringTokenizer st = new StringTokenizer(fFilepath, "/");
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

			JSONObject objects = new JSONObject();
			objects.put("pos", posObject);
			objects.put("image", imageObject);

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
