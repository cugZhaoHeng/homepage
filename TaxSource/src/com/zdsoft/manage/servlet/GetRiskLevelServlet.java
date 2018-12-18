package com.zdsoft.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.sf.json.JSONArray;

/**
 * 
 * @author �Ժ�
 *
 * 2017��12��23��
 */
@WebServlet("/getRiskLevel.do")
public class GetRiskLevelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		List<Map<String, String>> riskList = new ArrayList<Map<String, String>>();
		Map<String, String> map1 = new HashMap<String, String>();
		map1.put("level", "0");
		map1.put("value", "��");
		Map<String, String> map2 = new HashMap<String, String>();
		map2.put("level", "1");
		map2.put("value", "��");
		Map<String, String> map3 = new HashMap<String, String>();
		map3.put("level", "2");
		map3.put("value", "��");
		Map<String, String> map4 = new HashMap<String, String>();
		map4.put("level", "3");
		map4.put("value", "��");
		riskList.add(map1);
		riskList.add(map2);
		riskList.add(map3);
		riskList.add(map4);
		
		// ���ü���ת��ΪJSON���鷵�ص�Ajax
		JSONArray jsonArray = JSONArray.fromObject(riskList);
		PrintWriter out = response.getWriter();
		out.println(jsonArray);
		out.flush();
		out.close();
	}

}
