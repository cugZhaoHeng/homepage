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
 * @author �Ժ�
 *
 * 2017��12��17��
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
		//����Ĭ��ͼƬ
		if(idCardImage.length()<32) {
			idCardImage = "defaultIdCardImage.jpg";
		}
		// ��Ӳ���ж�ȡ�ļ�
		File file = new File("G://Java//TaxSource//" + idCardImage);
		//��������ͼƬ�ļ�
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
