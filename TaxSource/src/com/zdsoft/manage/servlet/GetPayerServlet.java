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

/**
 * 
 * @author 赵恒
 *
 * 2017年12月19日
 */
@WebServlet("/getPayer.do")
public class GetPayerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		//通过dao层获取taxer集合
		PayerDao payerDao = new PayerDao();
		List<Map<String, String>> allPayer = payerDao.queryAllPayer();
		
		//将该集合转化为JSON数组返回到Ajax
		JSONArray jsonArray = JSONArray.fromObject(allPayer);
		PrintWriter out = response.getWriter();
		out.println(jsonArray);
		out.flush();
		out.close();
	}

}
