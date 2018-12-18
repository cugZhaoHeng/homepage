package com.zdsoft.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zdsoft.manage.dao.PayerDao;
import com.zdsoft.manage.dao.TaskDao;
import com.zdsoft.system.dao.UserDao;

import net.sf.json.JSONObject;

/**
 * 
 * @author 赵恒
 *
 * 2017年12月23日
 */
@WebServlet("/editTask.do")
public class EditTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		JSONObject jsonObject = new JSONObject();
		Integer id = Integer.valueOf(request.getParameter("id") == null ? "0" : request.getParameter("id"));
		//创建dao层
		TaskDao taskDao = new TaskDao();
		UserDao userDao = new UserDao();
		PayerDao payerDao = new PayerDao();
		//接收form表单的参数
		String payerCode = request.getParameter("payerCode");
		String payerId = payerDao.getIdByCode(payerCode);
		
		String taskName = request.getParameter("taskName");
		String subOrganId = request.getParameter("subOrganId");
		String approverId = request.getParameter("approverId");
		String executeId = request.getParameter("executeId");
		String executeTime = request.getParameter("executeTime");
		String riskLevel = request.getParameter("riskLevel");
		String taskState = request.getParameter("taskState");
		String idea = request.getParameter("idea");
		
		String userName = request.getSession().getAttribute("username").toString();
		Integer recordUserId = userDao.getIdByName(userName);
		Object[] obj = {payerId, taskName, subOrganId, approverId, executeId, executeTime, taskState, idea, riskLevel, recordUserId, id};
		int rows = taskDao.editTask(obj);
		if(rows > 0) {
			jsonObject.put("success", true);
			jsonObject.put("msg", "修改成功");
		} else {
			jsonObject.put("success", false);
			jsonObject.put("msg", "修改失败");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
