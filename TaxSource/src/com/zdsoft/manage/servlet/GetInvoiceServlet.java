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
 * 2017��12��26��
 */
@WebServlet("/getInvoice.do")
public class GetInvoiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		
		List<Map<String, String>> invoiceList = new ArrayList<Map<String, String>>();
		Map<String, String> map1 = new HashMap<String, String>();
		map1.put("invoiceType", "��ֵ˰ר�÷�Ʊ");
		Map<String, String> map2 = new HashMap<String, String>();
		map2.put("invoiceType", "��ֵ˰��ͨ��Ʊ");
		Map<String, String> map3 = new HashMap<String, String>();
		map3.put("invoiceType", "����������ͬͳһ��Ʊ");
		Map<String, String> map4 = new HashMap<String, String>();
		map4.put("invoiceType", "��ֵ˰������ͨ��Ʊ");
		Map<String, String> map5 = new HashMap<String, String>();
		map5.put("invoiceType", "��·�����ţ��ѷ�Ʊ");
		Map<String, String> map6 = new HashMap<String, String>();
		map6.put("invoiceType", "���ֳ�����ͳһ��Ʊ");
		Map<String, String> map7 = new HashMap<String, String>();
		map7.put("invoiceType", "���Ʊ");
		Map<String, String> map8 = new HashMap<String, String>();
		map8.put("invoiceType", "���˷�Ʊ");
		invoiceList.add(map1);
		invoiceList.add(map2);
		invoiceList.add(map3);
		invoiceList.add(map4);
		invoiceList.add(map5);
		invoiceList.add(map6);
		invoiceList.add(map7);
		invoiceList.add(map8);
		JSONArray jsonArray = JSONArray.fromObject(invoiceList);

		PrintWriter out = response.getWriter();
		out.println(jsonArray);
		out.flush();
		out.close();
	}

}
