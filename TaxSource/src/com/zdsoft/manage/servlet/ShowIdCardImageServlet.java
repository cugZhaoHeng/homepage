package com.zdsoft.manage.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * @author 赵恒
 *
 * 2017年12月17日
 */
@WebServlet("/showIdCardImage.do")
public class ShowIdCardImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("JPG");
		String idCardImage = request.getParameter("idCardImage");
		//设置默认图片
		if(idCardImage.length()<32) {
			idCardImage = "defaultIdCardImage.jpg";
		}
		// 从硬盘中读取文件
		File file = new File("G://Java//TaxSource//" + idCardImage);
		//输出流输出图片文件
		ServletOutputStream outputStream = response.getOutputStream();
		FileInputStream fis = new FileInputStream(file);
		byte[] b = new byte[1024];
		int len = 0;
		while ((len = fis.read(b)) != -1) {
			outputStream.write(b, 0, len);
		}
		fis.close();
		outputStream.close();
	}

}
