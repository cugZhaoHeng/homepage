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
 * @author �Ժ�
 *
 * 2017��12��14��
 */
@WebServlet("/addPayer.do")
@MultipartConfig(location="G://Java//TaxSource")
public class AddPayerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		//��ȡ����
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
		
		//��userNameת��ΪuserId
		Integer userId = new UserDao().getIdByName(userName);
		//����Object������Ϊ����
		Object[] obj = {payerCode, payerName, bizAddress, taxOrganId, industryId, bizScope, invoiceType, legalPerson, legalIdCard, legalMobile,legalIdCardImageURL, finaceName, finaceIdCard, finaceMobile,finaceIdCardImageURL, taxerName,taxerIdCard,taxerMobile,taxerIdCardImageURL, bizAddressPhone, userId};
		//����JSON����
		JSONObject jsonObject = new JSONObject();
		//ͨ��dao��ִ����Ӳ���
		PayerDao payerDao = new PayerDao();
		boolean b = payerDao.hasPayer(payerCode);
		if(!b) {
			int rows = payerDao.addTaxer(obj);
			if(rows > 0) {
				jsonObject.put("success", true);
				jsonObject.put("msg", "��ӳɹ�");
			} else {
				jsonObject.put("success", false);
				jsonObject.put("msg", "���ʧ��");
			}
		} else {
			jsonObject.put("success", false);
			jsonObject.put("msg", "����˰��ʶ����Ѿ����ڣ�");
		}
		
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
