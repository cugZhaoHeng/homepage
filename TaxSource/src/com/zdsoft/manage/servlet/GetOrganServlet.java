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

import com.zdsoft.manage.dao.OrganDao;

import net.sf.json.JSONArray;

/**
 * ��ȡ���е�Organ���󣬲���json����ķ�ʽ����
 * 
 * @author �Ժ�
 *
 * 2017��12��15��
 */
@WebServlet("/getOrgan.do")
public class GetOrganServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		// ͨ��dao���ȡOrgan����
		OrganDao organDao = new OrganDao();
		List<Map<String, String>> industryList = organDao.queryAllOrgan();
		
		// ���ü���ת��ΪJSON���鷵�ص�Ajax
		JSONArray jsonArray = JSONArray.fromObject(industryList);

		PrintWriter out = response.getWriter();
		out.println(jsonArray);
		out.flush();
		out.close();
	}

}
