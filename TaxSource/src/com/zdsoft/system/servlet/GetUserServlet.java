package com.zdsoft.system.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zdsoft.system.dao.UserDao;

import net.sf.json.JSONArray;

/**
 * 
 * @author �Ժ�
 *
 * 2017��12��13��
 */
@WebServlet("/getUser.do")
public class GetUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		//ͨ��dao���ȡUser����
		UserDao userDao = new UserDao();
		List<Map<String, String>> industryList = userDao.queryAllUser();
		//���ü���ת��ΪJSON���鷵�ص�Ajax
		JSONArray jsonArray = new JSONArray();
		for(Map<String, String> map : industryList) {
			jsonArray.add(map);
		}
		PrintWriter out = response.getWriter();
		out.println(jsonArray);
		out.flush();
		out.close();
	}

}
