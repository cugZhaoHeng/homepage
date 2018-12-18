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

import com.zdsoft.manage.dao.PayerDao;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * @author 赵恒
 *
 * 2017年12月23日
 */
@WebServlet("/statistical.do")
public class StatisticalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		//接收传递的参数
		String payerCode = request.getParameter("payerCode") == null ? "" : request.getParameter("payerCode");
		String payerName = request.getParameter("payerName") == null ? "" : request.getParameter("payerName");
		
		Integer page = Integer.valueOf(request.getParameter("page") );
		Integer rows = Integer.valueOf(request.getParameter("rows") );
		
		//创建返回到Ajax的json对象和json数组
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		
		//通过dao层从数据库中查询数据
		PayerDao payerDao = new PayerDao();
		List<Map<String, String>> payerList = payerDao.queryStatisticalPayer(payerCode, payerName, page, rows);
		
		//将payerList中的键值对保存到jsonArray之中
		for(Map<String, String> map : payerList) {
			jsonArray.add(map);
		}
		jsonObj.put("rows", jsonArray);
		int total = payerDao.getTotal(payerCode, payerName);
		jsonObj.put("total", total);
		
		PrintWriter out = response.getWriter();
		out.println(jsonObj);
		out.flush();
		out.close();
	}

}
