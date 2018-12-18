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

import com.zdsoft.manage.dao.TaskDao;

import net.sf.json.JSONArray;

/**
 * 
 * @author 赵恒
 *
 * 2017年12月22日
 */
@WebServlet("/getTask.do")
public class GetTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		//通过dao层获取task集合
		TaskDao taskDao = new TaskDao();
		List<Map<String, String>> allTaxer =taskDao.queryAllTask();
		//将该集合转化为JSON数组返回到Ajax
		JSONArray jsonArray = JSONArray.fromObject(allTaxer);
		
		PrintWriter out = response.getWriter();
		out.println(jsonArray);
		out.flush();
		out.close();
	}

}
