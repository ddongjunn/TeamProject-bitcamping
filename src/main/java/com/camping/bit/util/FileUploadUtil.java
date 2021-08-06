package com.camping.bit.util;

import java.util.Date;

public class FileUploadUtil {

	public static String getNewFileName(String originalFileName) {
		
		String newFileName = "";
		String fileExtension = "";
		
		if(originalFileName.indexOf('.') >= 0) {			
			fileExtension = originalFileName.substring(originalFileName.indexOf('.'));
			newFileName = new Date().getTime() + fileExtension;
		}else {
			newFileName = new Date().getTime() + ".back";
		}
		
		return newFileName;
	}
	
}




