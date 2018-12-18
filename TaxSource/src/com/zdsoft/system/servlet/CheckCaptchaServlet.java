package com.zdsoft.system.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

/**
 * �Ե�¼ҳ���������֤�����У��
 * @author �Ժ�
 *
 * 2017��12��13��
 */
@WebServlet("/checkcaptcha.do")
public class CheckCaptchaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		//�������ص�Ajax��json����
		JSONObject jsonObj = new JSONObject();
		//��ȡ��¼ҳ�����д����֤��
		String captcha = request.getParameter("captcha");
		
		//��session�л�ȡϵͳ�Զ����ɵ���֤��
		HttpSession session = request.getSession();
		String sysCaptcha = session.getAttribute("KAPTCHA_SESSION_KEY").toString();
		//���û��������֤�����У�飬�����ִ�Сд
		if(captcha.equalsIgnoreCase(sysCaptcha)) {
			jsonObj.put("success", true);
			jsonObj.put("msg", "��֤����ȷ");
		} else {
			jsonObj.put("success", false);
			jsonObj.put("msg", "��֤�����");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObj);
		out.flush();
		out.close();
	}

}
