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
 * 验证登录页面的用户名和密码
 * @author 赵恒
 *
 * 2017年12月13日
 */
@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		//创建返回到Ajax的json对象
		JSONObject jsonObj = new JSONObject();
		//获取用户填写的用户名和密码
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		//通过dao层获取用户的信息，和所对应的税务人员的信息
		UserDao userDao = new UserDao();
		UserBean userBean = userDao.queryUserByUserName(userName);
		//设置session，并添加Cookie
		HttpSession session = request.getSession();
		Cookie cookie = new Cookie("username", userName);
		cookie.setMaxAge(3600*24*7);
		cookie.setPath("/");
		response.addCookie(cookie);
		//对用户输入的密码加上盐值进行md5加密
		password = EncryptUtil.encryptMD5(password+userBean.getSalt());
		//判断密码是否输入正确
		String password2 = userDao.queryPasswordByName(userName);
		if(password.equals(password2)) {
			//将用户信息和税务人员的信息保存到session中
			session.setAttribute("username", userName);
			session.setAttribute("taxerId", userBean.getTaxerId());
			
			jsonObj.put("success", true);
			jsonObj.put("msg", "登录成功");
		} else {
			jsonObj.put("success", false);
			jsonObj.put("msg", "密码错误");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObj);
		out.flush();
		out.close();
	}

}
