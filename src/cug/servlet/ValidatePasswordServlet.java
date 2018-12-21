package cug.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cug.dao.UserDao;
import cug.entity.UserBean;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class ValidatePasswordServlet
 */
@WebServlet("/validatePassword.do")
public class ValidatePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValidatePasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/json;charset=utf-8");
		String userId = request.getParameter("userId");
		String prePassword = request.getParameter("prePassword");
		UserDao userDao = new UserDao();
		Object[] obj = {userId};
		UserBean userBean = userDao.selectUserById(obj);
		JSONObject jsonObject = new JSONObject();
		if(userBean.getPassword().equals(prePassword)) {
			jsonObject.put("success", true);
		} else {
			jsonObject.put("success", false);
		}
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		out.flush();
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
