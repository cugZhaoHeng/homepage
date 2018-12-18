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
import net.sf.json.JSONObject;

/**
 * 
 * @author �Ժ�
 *
 * 2017��12��21��
 */
@WebServlet("/listTask.do")
public class ListTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		//���մ��ݵĲ���
		String payerCode = request.getParameter("payerCode") == null ? "" : request.getParameter("payerCode");
		String payerName = request.getParameter("payerName") == null ? "" : request.getParameter("payerName");
		String organId = "";
		//�ж�organId�Ƿ�Ϊ�ջ�ѡ��ֵΪ-1
		if(request.getParameter("organId") == null) {
			organId = "";
		} else if(request.getParameter("organId").equals("-1")) {
			organId = "";
		} else {
			organId = request.getParameter("organId");
		}
		String industryId = "";
		//�ж�industryId�Ƿ�Ϊ�ջ�ѡ��ֵΪ-1
		if(request.getParameter("industryId") == null) {
			industryId = "";
		} else if(request.getParameter("industryId").equals("-1")) {
			industryId = "";
		} else {
			industryId = request.getParameter("industryId");
		}
		String startDate = request.getParameter("startDate") == null ? "" : request.getParameter("startDate");
		String endDate = request.getParameter("endDate") == null ? "" : request.getParameter("endDate");
		
		Integer page = Integer.valueOf(request.getParameter("page") );
		Integer rows = Integer.valueOf(request.getParameter("rows") );
		
		//ͨ��dao���ȡ����
		TaskDao taskDao = new TaskDao();
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		List<Map<String, String>> taskList = taskDao.queryTask(payerCode, payerName, organId, industryId, startDate, endDate, page, rows);
		for(Map<String, String> map : taskList) {
			jsonArray.add(map);
		}
		jsonObject.put("rows", jsonArray);
		int total = taskDao.getTotal(payerCode, payerName, organId, industryId, startDate, endDate);
		jsonObject.put("total", total);
		
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
