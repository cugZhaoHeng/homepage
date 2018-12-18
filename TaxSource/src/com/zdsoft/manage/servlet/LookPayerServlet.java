package com.zdsoft.manage.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zdsoft.manage.dao.PayerDao;
import com.zdsoft.manage.entity.PayerBean;
/**
 * 
 * @author �Ժ�
 *
 * 2017��12��16��
 */
@WebServlet("/lookPayer.do")
public class LookPayerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		Integer id = Integer.parseInt(request.getParameter("id"));
		//ͨ��id��ȡָ������˰����Ϣ
		PayerDao payerDao = new PayerDao();
		PayerBean payerBean = payerDao.getPayerById(id);
		
		if(payerBean!=null) {
			request.setAttribute("payerBean", payerBean);
			request.getRequestDispatcher("manage/lookPayer.jsp").forward(request, response);
		} else {
			request.getRequestDispatcher("manage/listPayer.jsp").forward(request, response);
		}
	}

}
