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
 * Servlet implementation class EditEnergyServlet
 */
@WebServlet("/editEnergy.do")
public class EditEnergyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditEnergyServlet() {
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
		// 设置返回格式
			response.setContentType("text/json;charset=utf-8");
			JSONObject jsonObj = new JSONObject();
			
			String userId = request.getParameter("userId");
			String energyNum = request.getParameter("energyNum");
			String date = request.getParameter("date");
			
			System.out.println(date+energyNum);
			
			EnergyDao energyDao = new EnergyDao();
			Object[] obj = {energyNum, userId, date};
			int i = energyDao.editEnergy(obj);
			if(i>0) {
				jsonObj.put("msg", "修改成功");
				jsonObj.put("success", true);
			} else {
				jsonObj.put("msg", "修改失败");
				jsonObj.put("success", false);
			}
			PrintWriter out = response.getWriter();
			out.println(jsonObj);
			out.flush();
			out.close();
	}

}
