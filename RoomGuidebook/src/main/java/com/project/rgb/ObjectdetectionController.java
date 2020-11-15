package com.project.rgb;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Base64;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.Gson;
import java.net.*;

@Controller
public class ObjectdetectionController {
	
	@Resource(name = "defaultPath")
	   private String defaultPath;
	
	@RequestMapping(value = "/pathtest")
	String test(Model model) {
		
		return "/furniture/test";
	}
	
	@RequestMapping(value = "/objectdetect") // �� ���� �ޱ�
	String objectDetect(Model model) { // post, file�� �� filetype �ޱ�
		
		// �̹� ������ �޾ƿ� ���¶�� api ȣ�������ʰ� ��Ű ����
		
		String openApiURL = "http://aiopen.etri.re.kr:8000/ObjectDetect";
		String accessKey = "b2dcca90-be1f-4043-917c-04c4f661f55d";    // �߱޹��� API Key
		String type = "jpg";     // �̹��� ���� Ȯ����
		String filename = "lensro.PNG"; // ����ڰ� ���ε��� ���ϸ�
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
		/*
		try {
			url = new URL(openApiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
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
			
			for(int i =0; i < data.size(); i++) { // java���� ������ 2���� �迭�� js������ 2�����迭�� �����Ϸ�������
												  // ������ �ε����� ���ÿ� �����ϴ� ����� ã������
												  // �����͵��� ���� string ���ٿ� �־� tokenizer�̿��� 
												  // js�� 2���� �迭�� ����
				objects += data.get(i).getAsJsonObject().get("x").getAsInt()+"#";
				objects += data.get(i).getAsJsonObject().get("y").getAsInt() +"#";
				objects += data.get(i).getAsJsonObject().get("width").getAsInt() +"#";
				objects += data.get(i).getAsJsonObject().get("height").getAsInt() +"#";
			}
			
			System.out.print(objects);
			*/
			model.addAttribute("cookie", true);
			model.addAttribute("size", 2); // 
			model.addAttribute("objects", "39#470#55#53#2#337#425#358#"); //
			model.addAttribute("filepath", "\\resources\\image_room\\" + filename); // filename
/*
			
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} */
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
	void transferColor(String rFilepath, String fFilepath, String x, String y, Model model) { // ��Ʈ�ѷ� ȣ�� ��, x, y, ���̹���, �����̹��� ���� �޾ƿ�

		
		StringTokenizer st = new StringTokenizer(fFilepath, "\\");
		String fFilename = "";
		
		while(st.hasMoreTokens()) {
			fFilename = st.nextToken();
		}
		System.out.println(fFilename);
		
		String openApiURL = "http://localhost:9998";
		
		URL url;
		Integer responseCode = null;
		String responBody = null;
		
		System.out.print("("+x+", "+y+")");
		
		try {
			Socket socket = new Socket("localhost", 9998);
			OutputStream wr = socket.getOutputStream();
			InputStream is = socket.getInputStream();
			
			JSONObject posObject = new JSONObject();
			posObject.put("x", x); 
			posObject.put("y", y);
			
			
			JSONObject imageObject = new JSONObject();
			imageObject.put("r_filepath", defaultPath+rFilepath);
			imageObject.put("f_filepath",defaultPath+fFilepath);
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

			}catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		
	}
}
