package com.zdsoft.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zdsoft.manage.dao.TaxerDao;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * @author �Ժ�
 *
 * 2017��12��15��
 */
@WebServlet("/lookPersonInfo.do")
public class LookPersonInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		Integer id = Integer.valueOf(request.getParameter("id") == null ? "0" : request.getParameter("id"));
		System.out.println("id="+id);
		//ͨ��id��dao���ȡ˰����Ա�ĸ�����Ϣ
		TaxerDao taxerDao = new TaxerDao();
		List<Map<String, String>> list = taxerDao.queryTaxerById(id);
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		for(Map<String, String> map : list) {
			jsonArray.add(map);
		}
		jsonObject.put("rows", jsonArray);
		System.out.println(jsonObject.toString());
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
