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
 * @author 赵恒
 *
 * 2017年12月16日
 */
@WebServlet("/updatePersonPassword.do")
public class UpdatePersonPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		//创建JSON对象
		JSONObject jsonObject = new JSONObject();
		UserDao userDao = new UserDao();
		//从session中获取当前登录的用户名，并获取系统密码，改密码经过md5加密
		String userName = (String) request.getSession().getAttribute("username");
		String password = userDao.queryPasswordByName(userName);
		//获取参数
		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");
		//通过dao层连接数据库查询旧密码是否正确，并修改密码
		UserBean userBean = userDao.queryUserByUserName(userName);
		//将旧密码进行md5加密
		oldPassword = EncryptUtil.encryptMD5(oldPassword+userBean.getSalt());
		newPassword = EncryptUtil.encryptMD5(newPassword+userBean.getSalt());
		
		//将用户输入的密码与session中保存的密码进行匹配
		if(oldPassword.equals(password)) {
			//对新密码md5加密，插入到数据表中
			
			int rows = userDao.updatePassword(newPassword, userName);
			if(rows > 0) {
				jsonObject.put("success", true);
				jsonObject.put("msg", "密码修改成功，请重新登录！");
				//强制性重新登录
				request.getSession().removeAttribute("username");
			} else {
				jsonObject.put("success", false);
				jsonObject.put("msg", "密码修改失败！");
			}
		} else {
			jsonObject.put("success", false);
			jsonObject.put("msg", "旧密码输入错误，请重新输入！");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
