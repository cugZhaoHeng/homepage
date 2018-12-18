package com.zdsoft.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zdsoft.manage.dao.TaxerDao;

import net.sf.json.JSONObject;

/**
 * 
 * @author �Ժ�
 *
 * 2017��12��20��
 */
@WebServlet("/editTaxer.do")
@MultipartConfig(location="G://Java//TaxSource")
public class EditTaxerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		JSONObject jsonObject = new JSONObject();
		Integer id = Integer.valueOf(request.getParameter("id") == null ? "0" : request.getParameter("id"));
		//����dao��
		TaxerDao taxerDao = new TaxerDao();
		//��ȡ����
		String taxerCode = request.getParameter("taxerCode");
		String taxerName = request.getParameter("taxerName");
		String mobile = request.getParameter("mobile");
		String address = request.getParameter("address");
		String sex = request.getParameter("sex");
		String birthday = request.getParameter("birthday");
		String email = request.getParameter("email");
		String organId = request.getParameter("organId");
		String admin = request.getParameter("admin");
		
		//���������뵽���ݿ��У����޸�
		Object[] obj = {taxerCode, taxerName, mobile, address, sex, birthday, email, organId, admin, id};
		int rows = taxerDao.editTaxer(obj);
		if(rows > 0) {
			jsonObject.put("success", true);
			jsonObject.put("msg", "�޸ĳɹ�");
		} else {
			jsonObject.put("success", false);
			jsonObject.put("msg", "�޸�ʧ��");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
