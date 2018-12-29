package cug.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import cug.dao.UserDao;

/**
 * Servlet implementation class EditPasswordServlet
 */
@WebServlet("/editPassword.do")
public class EditPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/json;charset=utf-8");
		JSONObject jsonObj = new JSONObject();
		String userId = request.getParameter("userId");
		String setPassword = request.getParameter("setPassword");
		UserDao userDao = new UserDao();
		Object[] obj = {setPassword, userId};
		int i = userDao.editPassword(obj);
		if(i>0) {
			jsonObj.put("success", true);
			jsonObj.put("msg", "修改成功，请返回登录页面重新进入");
		} else {
			jsonObj.put("success", false);
			jsonObj.put("msg", "修改失败");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObj);
		out.flush();
		out.close();
	}

}
