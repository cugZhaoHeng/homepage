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
import com.zdsoft.manage.entity.PayerBean;
import com.zdsoft.system.dao.UserDao;

import net.sf.json.JSONObject;

/**
 * 
 * @author 赵恒
 *
 * 2017年12月25日
 */
@WebServlet("/editPayer.do")
@MultipartConfig(location="G://Java//TaxSource")
public class EditPayerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置页面的返回值类型为json对象
		response.setContentType("text/json;charset=utf-8");
		Integer id = Integer.valueOf(request.getParameter("id") == null ? "0" : request.getParameter("id"));
		//创建dao层
		UserDao userDao = new UserDao();
		PayerDao payerDao = new PayerDao();
		PayerBean payerBean = payerDao.getPayerById(id);
		
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
		
		
		//获取法人代表身份证的图片路径，如果没有上传，则继续保持数据库中的默认值
		String legalIdCardImageURL = request.getParameter("legalIdCardImageURL") == null ? "" : request.getParameter("legalIdCardImageURL");
		if(legalIdCardImageURL.equals("")) {
			legalIdCardImageURL = payerBean.getLegalIdCardImageURL();
		}
		
		String finaceName = request.getParameter("finaceName");
		String finaceIdCard = request.getParameter("finaceIdCard");
		String finaceMobile = request.getParameter("finaceMobile");
		
		//获取财务人员身份证的图片路径，如果没有上传，则继续保持数据库中的默认值
		String finaceIdCardImageURL = request.getParameter("finaceIdCardImageURL") == null ? "" : request.getParameter("finaceIdCardImageURL");
		if(finaceIdCardImageURL.equals("")) {
			finaceIdCardImageURL = payerBean.getFinaceIdCardImageURL();
		}
		
		String taxerName = request.getParameter("taxerName");
		String taxerIdCard = request.getParameter("taxerIdCard");
		String taxerMobile = request.getParameter("taxerMobile");
		
		
		//获取财务人员身份证的图片路径，如果没有上传，则继续保持数据库中的默认值
		String taxerIdCardImageURL = request.getParameter("taxerIdCardImageURL") == null ? "" : request.getParameter("taxerIdCardImageURL");
		if(taxerIdCardImageURL.equals("")) {
			taxerIdCardImageURL = payerBean.getTaxerIdCardImageURL();
		}
		
		String bizAddressPhone = request.getParameter("bizAddressPhone");
		String userName = request.getParameter("userName");
		//通过userName获取userId
		Integer userId = userDao.getIdByName(userName);
		//创建Object对象
		Object[] obj = {payerCode, payerName, bizAddress, taxOrganId, industryId, bizScope, invoiceType,legalPerson, legalIdCard, legalMobile,legalIdCardImageURL, finaceName, finaceIdCard, finaceMobile,finaceIdCardImageURL, taxerName,taxerIdCard,taxerMobile,taxerIdCardImageURL, bizAddressPhone, userId, id};
		//创建JSON对象
		JSONObject jsonObject = new JSONObject();
		//通过dao层执行修改操作
		int rows = payerDao.editPayer(obj);
		if(rows > 0) {
			jsonObject.put("success", true);
			jsonObject.put("msg", "修改成功");
		} else {
			jsonObject.put("success", false);
			jsonObject.put("msg", "修改失败");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
