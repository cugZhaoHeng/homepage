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
 * @author �Ժ�
 *
 * 2017��12��23��
 */
@WebServlet("/editTask.do")
public class EditTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		JSONObject jsonObject = new JSONObject();
		Integer id = Integer.valueOf(request.getParameter("id") == null ? "0" : request.getParameter("id"));
		//����dao��
		TaskDao taskDao = new TaskDao();
		UserDao userDao = new UserDao();
		PayerDao payerDao = new PayerDao();
		//����form���Ĳ���
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
			jsonObject.put("msg", "�޸ĳɹ�");
		} else {
			jsonObject.put("success", false);
			jsonObject.put("msg", "�޸�ʧ��");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
