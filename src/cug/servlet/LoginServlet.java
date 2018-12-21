package cug.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cug.dao.UserDao;
import cug.entity.UserBean;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 设置返回格式
		response.setContentType("text/json;charset=utf-8");
		JSONObject jsonObj = new JSONObject();
		
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		Object[] obj = {userName, password};
		// 连接数据库，验证登录信息
		UserDao userDao = new UserDao();
		UserBean userBean = userDao.selectUserByUserName(obj);
		
		// 设置session
		HttpSession session = request.getSession();
		
		if(userBean != null) {
			jsonObj.put("success", true);
			jsonObj.put("msg", "登录成功！");
			session.setAttribute("userName", userName);
			session.setAttribute("userId", userBean.getId());
		} else {
			jsonObj.put("success", false);
			jsonObj.put("msg", "登录用户名或密码错误！");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObj);
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
