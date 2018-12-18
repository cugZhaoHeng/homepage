package com.zdsoft.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
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
 * 2017��12��18��
 */
@WebServlet("/removeTaxer.do")
public class RemoveTaxerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/json;charset=utf-8");
		Integer id = Integer.valueOf(request.getParameter("id"));
		JSONObject jsonObject = new JSONObject();
		TaxerDao taxerDao = new TaxerDao();
		int rows = taxerDao.removeById(id);
		if(rows > 0) {
			jsonObject.put("success", true);
			jsonObject.put("msg", "ɾ���ɹ�");
		} else {
			jsonObject.put("success", false);
			jsonObject.put("msg", "ɾ��ʧ��");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
