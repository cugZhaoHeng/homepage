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
 * @author 赵恒
 *
 * 2017年12月26日
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
		// 设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		
		List<Map<String, String>> invoiceList = new ArrayList<Map<String, String>>();
		Map<String, String> map1 = new HashMap<String, String>();
		map1.put("invoiceType", "增值税专用发票");
		Map<String, String> map2 = new HashMap<String, String>();
		map2.put("invoiceType", "增值税普通发票");
		Map<String, String> map3 = new HashMap<String, String>();
		map3.put("invoiceType", "机动车销售同统一发票");
		Map<String, String> map4 = new HashMap<String, String>();
		map4.put("invoiceType", "增值税电子普通发票");
		Map<String, String> map5 = new HashMap<String, String>();
		map5.put("invoiceType", "过路（过桥）费发票");
		Map<String, String> map6 = new HashMap<String, String>();
		map6.put("invoiceType", "二手车销售统一发票");
		Map<String, String> map7 = new HashMap<String, String>();
		map7.put("invoiceType", "定额发票");
		Map<String, String> map8 = new HashMap<String, String>();
		map8.put("invoiceType", "客运发票");
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
