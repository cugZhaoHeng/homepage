package com.zdsoft.manage.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;


import net.sf.json.JSONObject;

/**
 * 
 * @author 赵恒
 *
 * 2017年12月25日
 */
@WebServlet("/uploadImg.do")
@MultipartConfig(location="G://Java//TaxSource")
public class UploadImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/json;charset=utf-8");
		JSONObject jsonObject = new JSONObject();
		Part part1 = request.getPart("file");
		String legalIdCardImageURL = "";
		if(part1!= null) {
			String header = part1.getHeader("content-disposition");
			//如果没有上传，则设置为空
			if(header.indexOf("filename") == -1) {
				legalIdCardImageURL = "";
			} else {
				legalIdCardImageURL = header.substring(header.indexOf("filename=")+10);
				legalIdCardImageURL = legalIdCardImageURL.replace("\"", "");
				legalIdCardImageURL = UUID.randomUUID().toString() + legalIdCardImageURL;
				part1.write(legalIdCardImageURL);
			}
			
		}
		jsonObject.put("url", legalIdCardImageURL);
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
