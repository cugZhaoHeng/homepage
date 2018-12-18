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
 * @author 赵恒
 *
 * 2017年12月18日
 */
@WebServlet("/listTaxer.do")
public class ListTaxerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		
		//接收传递的参数
		String taxerCode = request.getParameter("taxerCode") == null ? "" : request.getParameter("taxerCode");
		String taxerName = request.getParameter("taxerName") == null ? "" : request.getParameter("taxerName");
		
		Integer page = Integer.valueOf(request.getParameter("page") );
		Integer rows = Integer.valueOf(request.getParameter("rows") );
		
		//创建返回到Ajax的json对象和json数组
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		
		TaxerDao taxerDao = new TaxerDao();
		List<Map<String, String>> list = taxerDao.queryTaxer(taxerCode, taxerName, page, rows);
		for(Map<String, String> map : list) {
			jsonArray.add(map);
		}
		jsonObject.put("rows", jsonArray);
		jsonObject.put("total", taxerDao.getTotal(taxerCode, taxerName));
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}
}
