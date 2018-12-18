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
 * @author �Ժ�
 *
 * 2017��12��25��
 */
@WebServlet("/editPayer.do")
@MultipartConfig(location="G://Java//TaxSource")
public class EditPayerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����ҳ��ķ���ֵ����Ϊjson����
		response.setContentType("text/json;charset=utf-8");
		Integer id = Integer.valueOf(request.getParameter("id") == null ? "0" : request.getParameter("id"));
		//����dao��
		UserDao userDao = new UserDao();
		PayerDao payerDao = new PayerDao();
		PayerBean payerBean = payerDao.getPayerById(id);
		
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
		
		
		//��ȡ���˴������֤��ͼƬ·�������û���ϴ���������������ݿ��е�Ĭ��ֵ
		String legalIdCardImageURL = request.getParameter("legalIdCardImageURL") == null ? "" : request.getParameter("legalIdCardImageURL");
		if(legalIdCardImageURL.equals("")) {
			legalIdCardImageURL = payerBean.getLegalIdCardImageURL();
		}
		
		String finaceName = request.getParameter("finaceName");
		String finaceIdCard = request.getParameter("finaceIdCard");
		String finaceMobile = request.getParameter("finaceMobile");
		
		//��ȡ������Ա���֤��ͼƬ·�������û���ϴ���������������ݿ��е�Ĭ��ֵ
		String finaceIdCardImageURL = request.getParameter("finaceIdCardImageURL") == null ? "" : request.getParameter("finaceIdCardImageURL");
		if(finaceIdCardImageURL.equals("")) {
			finaceIdCardImageURL = payerBean.getFinaceIdCardImageURL();
		}
		
		String taxerName = request.getParameter("taxerName");
		String taxerIdCard = request.getParameter("taxerIdCard");
		String taxerMobile = request.getParameter("taxerMobile");
		
		
		//��ȡ������Ա���֤��ͼƬ·�������û���ϴ���������������ݿ��е�Ĭ��ֵ
		String taxerIdCardImageURL = request.getParameter("taxerIdCardImageURL") == null ? "" : request.getParameter("taxerIdCardImageURL");
		if(taxerIdCardImageURL.equals("")) {
			taxerIdCardImageURL = payerBean.getTaxerIdCardImageURL();
		}
		
		String bizAddressPhone = request.getParameter("bizAddressPhone");
		String userName = request.getParameter("userName");
		//ͨ��userName��ȡuserId
		Integer userId = userDao.getIdByName(userName);
		//����Object����
		Object[] obj = {payerCode, payerName, bizAddress, taxOrganId, industryId, bizScope, invoiceType,legalPerson, legalIdCard, legalMobile,legalIdCardImageURL, finaceName, finaceIdCard, finaceMobile,finaceIdCardImageURL, taxerName,taxerIdCard,taxerMobile,taxerIdCardImageURL, bizAddressPhone, userId, id};
		//����JSON����
		JSONObject jsonObject = new JSONObject();
		//ͨ��dao��ִ���޸Ĳ���
		int rows = payerDao.editPayer(obj);
		if(rows > 0) {
			jsonObject.put("success", true);
			jsonObject.put("msg", "�޸ĳɹ�");
		} else {
			jsonObject.put("success", false);
			jsonObject.put("msg", "�޸�ʧ��");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
