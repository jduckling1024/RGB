package testPackage;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class TestMain {
	public static void main(String[] args) {

		try {
			String filePath = "C:/Users/samsung/eclipse-workspace/RoomGuidebook/src/main/webapp/resources/image_room/room2.JPG";
			File imageFile = new File(filePath);

			if (imageFile.exists()) {
				BufferedImage bi = ImageIO.read(new File(filePath));
				System.out.println(bi.getWidth() + " " + bi.getHeight());

			} else {
				
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}