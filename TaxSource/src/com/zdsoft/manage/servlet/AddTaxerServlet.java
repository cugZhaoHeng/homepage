package com.zdsoft.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zdsoft.manage.dao.TaxerDao;
import com.zdsoft.system.dao.UserDao;

import net.sf.json.JSONObject;

/**
 * 
 * @author 赵恒
 *
 * 2017年12月20日
 */
@WebServlet("/addTaxer.do")
@MultipartConfig(location="G://Java//TaxSource")
public class AddTaxerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		JSONObject jsonObject = new JSONObject();
		//创建dao层
		TaxerDao taxerDao = new TaxerDao();
		UserDao userDao = new UserDao();
		//获取参数
		String taxerCode = request.getParameter("taxerCode");
		String taxerName = request.getParameter("taxerName");
		String mobile = request.getParameter("mobile");
		String organId = request.getParameter("organId");
		
		String sex = request.getParameter("sex");
		String birthday = request.getParameter("birthday");
		String email = request.getParameter("email");
		String mgr = request.getParameter("mgr");
		System.out.println("mgr="+mgr);
		
		String address = request.getParameter("address");
		Integer recordUserId = userDao.getIdByName(request.getSession().getAttribute("username").toString());
		//先判断数据库中是否存在该工号,如果不存在则插入数据
		Boolean b = taxerDao.hasTaxer(taxerCode);
		if(!b) {
			//将参数插入到数据库
			Object[] obj = {taxerCode, taxerName, mobile, address, sex, birthday, email, organId, mgr, recordUserId};
			int rows = taxerDao.addTaxer(obj);
			if(rows > 0) {
				jsonObject.put("success", true);
				jsonObject.put("msg", "添加成功");
			} else {
				jsonObject.put("success", false);
				jsonObject.put("msg", "添加失败");
			}
		} else {
			jsonObject.put("success", false);
			jsonObject.put("msg", "该纳税人识别号已经存在！");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
