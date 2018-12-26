package cug.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import cug.dao.EnergyDao;

/**
 * Servlet implementation class RemoveEnergyServlet
 */
@WebServlet("/removeEnergy.do")
public class RemoveEnergyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveEnergyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/json;charset=utf-8");
		JSONObject jsonObj = new JSONObject();
		String userId = request.getParameter("userId");
		String date = request.getParameter("date");
		Object[] obj = {userId, date};
		EnergyDao energyDao = new EnergyDao();
		int i = energyDao.removeEnergy(obj);
		if(i>0) {
			jsonObj.put("success", true);
			jsonObj.put("msg", "删除成功");
		} else {
			jsonObj.put("success", false);
			jsonObj.put("msg", "删除失败");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObj);
		out.flush();
		out.close();
	}

}
