package com.project.rgb;

import java.io.File;
import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hc.client5.http.entity.mime.MultipartEntityBuilder;
import org.apache.hc.client5.http.fluent.Request;
import org.apache.hc.client5.http.fluent.Response;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class imageProcessController {
	@RequestMapping("/removeBg")
	
	// ����� �̹����� Api�� ����
	public String removeBackground() {
		
		// ����ڷκ��� ���� �̹��� ���
		String file_path = "C:\\Users\\DeepLearning_7\\Desktop\\��ǰ�̹���\\����13.jpg";

		String image_name = "";
		
		StringTokenizer st = new StringTokenizer(file_path, "\\");
		
		while(st.hasMoreTokens()) {
			image_name = st.nextToken();
		}
		
		Response response;
		
		try {
			response = Request.post("https://api.remove.bg/v1.0/removebg")
				    .addHeader("X-Api-Key", "inser API key")
				    .body(
				        MultipartEntityBuilder.create()
				        .addBinaryBody("image_file", new File(file_path))
				        .addTextBody("size", "auto")
				        .build()
				    ).execute();
			

			response.saveContent(new File("C:\\Users\\DeepLearning_7\\Desktop\\ForArrange\\"+"rm"+image_name));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "furniture/imageProcessedView";
	}
}
