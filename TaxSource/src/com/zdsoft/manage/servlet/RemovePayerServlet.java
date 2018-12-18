package com.zdsoft.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zdsoft.manage.dao.PayerDao;

import net.sf.json.JSONObject;

/**
 * 
 * @author 赵恒
 *
 * 2017年12月26日
 */
@WebServlet("/removePayer.do")
public class RemovePayerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		//获取参数
		Integer id = Integer.valueOf(request.getParameter("id") == null ? "0" : request.getParameter("id"));
		//创建返回到Ajax的json对象
		JSONObject jsonObj = new JSONObject();
		PayerDao payerDao = new PayerDao();
		int rows = payerDao.deletePayerById(id);
		if(rows > 0) {
			jsonObj.put("success", true);
			jsonObj.put("msg", "删除成功");
		} else {
			jsonObj.put("success", false);
			jsonObj.put("msg", "删除失败");
		}
		System.out.println(jsonObj);
		PrintWriter out = response.getWriter();
		out.println(jsonObj);
		out.flush();
		out.close();
	}

}
