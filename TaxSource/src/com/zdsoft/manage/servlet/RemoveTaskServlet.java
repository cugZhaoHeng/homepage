package com.zdsoft.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zdsoft.manage.dao.TaskDao;

import net.sf.json.JSONObject;

/**
 * 
 * @author 赵恒
 *
 * 2017年12月26日
 */
@WebServlet("/removeTask.do")
public class RemoveTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/json;charset=utf-8");
		Integer id = Integer.valueOf(request.getParameter("id"));
		System.out.println("id="+id);
		JSONObject jsonObject = new JSONObject();
		TaskDao taskDao = new TaskDao();
		int rows = taskDao.removeById(id);
		System.out.println("rows="+rows);
		if(rows > 0) {
			jsonObject.put("success", true);
			jsonObject.put("msg", "删除成功");
		} else {
			jsonObject.put("success", false);
			jsonObject.put("msg", "删除失败");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
