package com.zdsoft.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zdsoft.system.dao.UserDao;
import com.zdsoft.system.entity.UserBean;
import com.zdsoft.util.EncryptUtil;

import net.sf.json.JSONObject;

/**
 * 
 * @author �Ժ�
 *
 * 2017��12��16��
 */
@WebServlet("/updatePersonPassword.do")
public class UpdatePersonPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		//����JSON����
		JSONObject jsonObject = new JSONObject();
		UserDao userDao = new UserDao();
		//��session�л�ȡ��ǰ��¼���û���������ȡϵͳ���룬�����뾭��md5����
		String userName = (String) request.getSession().getAttribute("username");
		String password = userDao.queryPasswordByName(userName);
		//��ȡ����
		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");
		//ͨ��dao���������ݿ��ѯ�������Ƿ���ȷ�����޸�����
		UserBean userBean = userDao.queryUserByUserName(userName);
		//�����������md5����
		oldPassword = EncryptUtil.encryptMD5(oldPassword+userBean.getSalt());
		newPassword = EncryptUtil.encryptMD5(newPassword+userBean.getSalt());
		
		//���û������������session�б�����������ƥ��
		if(oldPassword.equals(password)) {
			//��������md5���ܣ����뵽���ݱ���
			
			int rows = userDao.updatePassword(newPassword, userName);
			if(rows > 0) {
				jsonObject.put("success", true);
				jsonObject.put("msg", "�����޸ĳɹ��������µ�¼��");
				//ǿ�������µ�¼
				request.getSession().removeAttribute("username");
			} else {
				jsonObject.put("success", false);
				jsonObject.put("msg", "�����޸�ʧ�ܣ�");
			}
		} else {
			jsonObject.put("success", false);
			jsonObject.put("msg", "����������������������룡");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
