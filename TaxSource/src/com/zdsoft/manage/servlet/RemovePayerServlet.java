package com.zdsoft.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zdsoft.manage.dao.PayerDao;

import net.sf.json.JSONObject;

/**
 * 
 * @author �Ժ�
 *
 * 2017��12��26��
 */
@WebServlet("/removePayer.do")
public class RemovePayerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		//��ȡ����
		Integer id = Integer.valueOf(request.getParameter("id") == null ? "0" : request.getParameter("id"));
		//�������ص�Ajax��json����
		JSONObject jsonObj = new JSONObject();
		PayerDao payerDao = new PayerDao();
		int rows = payerDao.deletePayerById(id);
		if(rows > 0) {
			jsonObj.put("success", true);
			jsonObj.put("msg", "ɾ���ɹ�");
		} else {
			jsonObj.put("success", false);
			jsonObj.put("msg", "ɾ��ʧ��");
		}
		System.out.println(jsonObj);
		PrintWriter out = response.getWriter();
		out.println(jsonObj);
		out.flush();
		out.close();
	}

}
