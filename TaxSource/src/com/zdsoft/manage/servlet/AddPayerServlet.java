package com.zdsoft.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zdsoft.manage.dao.PayerDao;
import com.zdsoft.system.dao.UserDao;
import net.sf.json.JSONObject;

/**
 * 
 * @author 赵恒
 *
 * 2017年12月14日
 */
@WebServlet("/addPayer.do")
@MultipartConfig(location="G://Java//TaxSource")
public class AddPayerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		//获取参数
		String payerCode = request.getParameter("payerCode");
		String payerName = request.getParameter("payerName");
		String bizAddress = request.getParameter("bizAddress");
		Integer taxOrganId = Integer.valueOf(request.getParameter("taxOrganId"));
		Integer industryId = Integer.valueOf(request.getParameter("industryId"));
		String bizScope = request.getParameter("bizScope");
		String invoiceType = request.getParameter("invoiceType");
		
		String legalPerson = request.getParameter("legalPerson");
		String legalIdCard = request.getParameter("legalIdCard");
		String legalMobile = request.getParameter("legalMobile");
		String legalIdCardImageURL = request.getParameter("legalIdCardImageURL") == null ? "" : request.getParameter("legalIdCardImageURL");
		
		
		String finaceName = request.getParameter("finaceName");
		String finaceIdCard = request.getParameter("finaceIdCard");
		String finaceMobile = request.getParameter("finaceMobile");
		String finaceIdCardImageURL = request.getParameter("finaceIdCardImageURL") == null ? "" : request.getParameter("finaceIdCardImageURL");
		
		String taxerName = request.getParameter("taxerName");
		String taxerIdCard = request.getParameter("taxerIdCard");
		String taxerMobile = request.getParameter("taxerMobile");
		String taxerIdCardImageURL = request.getParameter("taxerIdCardImageURL") == null ? "" : request.getParameter("taxerIdCardImageURL");
		
		String bizAddressPhone = request.getParameter("bizAddressPhone");
		String userName = request.getParameter("userName");
		
		//将userName转化为userId
		Integer userId = new UserDao().getIdByName(userName);
		//创建Object数组作为参数
		Object[] obj = {payerCode, payerName, bizAddress, taxOrganId, industryId, bizScope, invoiceType, legalPerson, legalIdCard, legalMobile,legalIdCardImageURL, finaceName, finaceIdCard, finaceMobile,finaceIdCardImageURL, taxerName,taxerIdCard,taxerMobile,taxerIdCardImageURL, bizAddressPhone, userId};
		//创建JSON对象
		JSONObject jsonObject = new JSONObject();
		//通过dao层执行添加操作
		PayerDao payerDao = new PayerDao();
		boolean b = payerDao.hasPayer(payerCode);
		if(!b) {
			int rows = payerDao.addTaxer(obj);
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
