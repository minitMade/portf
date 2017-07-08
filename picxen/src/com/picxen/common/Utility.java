package com.picxen.common;

import java.io.File;

public class Utility {
	public static final String UPLOAD_PATH
	="G:\\JSP\\javaHyundai\\eclips\\PN2\\picxen\\WebContent\\pt_upload";
	//String upPath="pt_upload";
	
	/*="/usr/share/tomcat8/webapps/picxen/pt_upload";*/ //EC2
	
	public static final String PT_IMG_PATH
	/*="G:\\JSP\\javaHyundai\\eclips\\PN\\picxen\\WebContent\\pt_images";*/
	="G:\\JSP\\javaHyundai\\eclips\\PN2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\picxen\\pt_images";
	
	/*="/usr/share/tomcat8/webapps/picxen/pt_images";*/ //EC2
	
	public static final String MY_ICON
	/*="G:\\JSP\\javaHyundai\\eclips\\PN\\picxen\\WebContent\\my_icon";*/
	="G:\\JSP\\javaHyundai\\eclips\\PN2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\picxen\\my_icon";
	
	/*="/usr/share/tomcat8/webapps/picxen/my_icon";*/ //EC2
	
	public static final String MY_BG
	="G:\\JSP\\javaHyundai\\eclips\\PN2\\picxen\\WebContent\\my_bg";
	
	/*="/usr/share/tomcat8/webapps/picxen/my_bg";*/ //EC2
	
	public static String getUniqueFileName(String uploadPath, String fileName){
		//동일 이름의 경우 일련번호를 붙여서 이름을 변경해주는 메서드
		//test.txt => test_1.txt => test_2.txt =>test_3.txt
		//확장자를 제외한 이름만 추출 test
		int idx = fileName.lastIndexOf(".");
		String fName = fileName.substring(0, idx);//0=test, 1=est
		System.out.println("lastIndexOf. fName="+fName);
				
		//.확장자 추출=>.txt
		String ext = fileName.substring(idx);//.txt
		System.out.println("fName="+fName+",ext="+ext);
		
		//업로드 폴더에 해당 파일이 존재하는지 체크 , 사이즈도 비교?
		boolean bExist=true;
		int count=0;
		while(bExist){
			File myfile=new File(uploadPath, fileName);
			if(myfile.exists()){
				count++;
				fileName=fName+"_"+count+ext;//test_1.txt
				System.out.println("변경된 파일명:"+fileName);
				
				//파일 지우기
				/*if(myfile.delete()){
					count--;
					fileName=fName+"_"+count+ext;
					System.out.println("지운 파일명:"+fileName);
				}else{
					System.out.println("지우기 실패");
				}*/

			}else{
				bExist=false;
			}
	}//while
		return fileName;
		
		
		
	}//getUniqueFileName
}/////