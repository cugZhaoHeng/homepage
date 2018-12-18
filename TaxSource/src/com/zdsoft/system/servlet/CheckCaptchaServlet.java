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
 * 对登录页面输入的验证码进行校验
 * @author 赵恒
 *
 * 2017年12月13日
 */
@WebServlet("/checkcaptcha.do")
public class CheckCaptchaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		//创建返回到Ajax的json对象
		JSONObject jsonObj = new JSONObject();
		//获取登录页面的填写的验证码
		String captcha = request.getParameter("captcha");
		
		//从session中获取系统自动生成的验证码
		HttpSession session = request.getSession();
		String sysCaptcha = session.getAttribute("KAPTCHA_SESSION_KEY").toString();
		//对用户输入的验证码进行校验，不区分大小写
		if(captcha.equalsIgnoreCase(sysCaptcha)) {
			jsonObj.put("success", true);
			jsonObj.put("msg", "验证码正确");
		} else {
			jsonObj.put("success", false);
			jsonObj.put("msg", "验证码错误");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObj);
		out.flush();
		out.close();
	}

}
