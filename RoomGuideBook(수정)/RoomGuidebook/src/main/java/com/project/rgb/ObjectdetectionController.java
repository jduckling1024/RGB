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
		String savedName = uid.toString() + "_" + originalName; // ��� �� ���� �����ٰ� ��Ʈ�ѷ��� �־߰��� ��¥ ��ϱ��� �Ϸ���???

		String folderPath = "/resources/image_room";
		File target = new File(defaultPath + folderPath, savedName);
		FileCopyUtils.copy(fileData, target); // �� �������� ���� ���������� �̷������ ��
		return folderPath + "/" + savedName;
	}

	@RequestMapping(value = "/objectdetect", method = RequestMethod.POST) // �� ���� �ޱ�
	String objectDetect(Model model, @RequestParam(value = "file", required = false) MultipartFile file,
			@ModelAttribute(value = "productId") int productId,
			@ModelAttribute(value = "productName") String productName,
			@ModelAttribute(value = "widthSize") int widthSize, @ModelAttribute(value = "heightSize") int heightSize) { // post,
																														// file��
																														// ��
																														// filetype
																														// �ޱ�
		try {
			Object[] obj = furnitureService.arrange(productId);
			ProductDTO productInfo = (ProductDTO) obj[0];
			List<ImageDTO> imageList = (List<ImageDTO>) obj[1];

			if(file == null) {
				System.out.println("��");
			}else {
				System.out.println("�� �ƴ�");
			}
			
			// �̹��� �� �� ����
			BufferedImage image = ImageIO.read(file.getInputStream());
			Integer roomImgWidth = image.getWidth();
			Integer roomImgHeight = image.getHeight();

			ArrayList<Integer[]> pSize = new ArrayList<Integer[]>();
			for (int i = 0; i < imageList.size(); i++) {
				Integer[] imgSizeInfo = new Integer[2]; // 0��°�� ���ΰ� 1��°�� ����
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
				// // �ƴ� �����غ��� �� ���̿� ���ߴ°� �ƴ϶� ���ο� �´� ���� ������ ���ϴ°� �°ڳ�???

				pSize.add(imgSizeInfo);
			}

			String myRoomPath = uploadFile(file.getOriginalFilename(), file.getBytes()); // �̹��� ���ε�

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

		// �̹� ������ �޾ƿ� ���¶�� api ȣ�������ʰ� ��Ű ����

		String openApiURL = "http://aiopen.etri.re.kr:8000/ObjectDetect";
		String accessKey = "b2dcca90-be1f-4043-917c-04c4f661f55d"; // �߱޹��� API Key
		
		String filename = file.getOriginalFilename(); // ����ڰ� ���ε��� ���ϸ�
		StringTokenizer st = new StringTokenizer(filename, ".");
		st.nextToken();
		String type = st.nextToken(); // �̹��� ���� Ȯ����
		String filepath = defaultPath + "//resources//image_room//" + filename;
		// ����ڰ� ���ε��� ���� ���
		String imageContents = ""; // byte�迭�� ��ȯ �� ���ڵ�
		Gson gson = new Gson(); // Dependency �߰�

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

			for (int i = 0; i < data.size(); i++) { // java���� ������ 2���� �迭�� js������ 2�����迭�� �����Ϸ�������
													// ������ �ε����� ���ÿ� �����ϴ� ����� ã������
													// �����͵��� ���� string ���ٿ� �־� tokenizer�̿���
													// js�� 2���� �迭�� ����
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
			// filename (�� �̹����ε� ������ ó���ϹǷ� �ϴ� �ּ�ó��)

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
	void transferColor(String rFilepath, String fFilepath, String x, String y, Model model) { // ��Ʈ�ѷ� ȣ�� ��, x, y, ���̹���,
																								// �����̹��� ���� �޾ƿ�
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
