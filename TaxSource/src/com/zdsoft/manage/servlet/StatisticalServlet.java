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
 * @author �Ժ�
 *
 * 2017��12��23��
 */
@WebServlet("/statistical.do")
public class StatisticalServlet extends HttpServlet {
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
		
		Integer page = Integer.valueOf(request.getParameter("page") );
		Integer rows = Integer.valueOf(request.getParameter("rows") );
		
		//�������ص�Ajax��json�����json����
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		
		//ͨ��dao������ݿ��в�ѯ����
		PayerDao payerDao = new PayerDao();
		List<Map<String, String>> payerList = payerDao.queryStatisticalPayer(payerCode, payerName, page, rows);
		
		//��payerList�еļ�ֵ�Ա��浽jsonArray֮��
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
