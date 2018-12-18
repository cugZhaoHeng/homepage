package com.zdsoft.system.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zdsoft.system.dao.UserDao;
import com.zdsoft.system.entity.UserBean;
import com.zdsoft.util.EncryptUtil;


import net.sf.json.JSONObject;

/**
 * ��֤��¼ҳ����û���������
 * @author �Ժ�
 *
 * 2017��12��13��
 */
@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		//�������ص�Ajax��json����
		JSONObject jsonObj = new JSONObject();
		//��ȡ�û���д���û���������
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		//ͨ��dao���ȡ�û�����Ϣ��������Ӧ��˰����Ա����Ϣ
		UserDao userDao = new UserDao();
		UserBean userBean = userDao.queryUserByUserName(userName);
		//����session�������Cookie
		HttpSession session = request.getSession();
		Cookie cookie = new Cookie("username", userName);
		cookie.setMaxAge(3600*24*7);
		cookie.setPath("/");
		response.addCookie(cookie);
		//���û���������������ֵ����md5����
		password = EncryptUtil.encryptMD5(password+userBean.getSalt());
		//�ж������Ƿ�������ȷ
		String password2 = userDao.queryPasswordByName(userName);
		if(password.equals(password2)) {
			//���û���Ϣ��˰����Ա����Ϣ���浽session��
			session.setAttribute("username", userName);
			session.setAttribute("taxerId", userBean.getTaxerId());
			
			jsonObj.put("success", true);
			jsonObj.put("msg", "��¼�ɹ�");
		} else {
			jsonObj.put("success", false);
			jsonObj.put("msg", "�������");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObj);
		out.flush();
		out.close();
	}

}
