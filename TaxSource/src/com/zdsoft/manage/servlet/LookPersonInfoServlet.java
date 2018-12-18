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
 * 2017年12月15日
 */
@WebServlet("/lookPersonInfo.do")
public class LookPersonInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		Integer id = Integer.valueOf(request.getParameter("id") == null ? "0" : request.getParameter("id"));
		System.out.println("id="+id);
		//通过id从dao层获取税务人员的个人信息
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
