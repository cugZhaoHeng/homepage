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
 * Servlet implementation class AddEnergyServlet
 */
@WebServlet("/addEnergy.do")
public class AddEnergyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddEnergyServlet() {
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
		String date = request.getParameter("date");
		String energyNum = request.getParameter("energyNum");
		
		EnergyDao energyDao = new EnergyDao();
		Object[] obj = {userId, date};
		Object[] obj1 = {userId, date, energyNum};
		if(energyDao.dateExist(obj)) {
			jsonObj.put("msg", "该日能量已存在，若修改请选择编辑");
			jsonObj.put("success", false);
		} else {
			int i = energyDao.addEnergy(obj1);
			if(i>0) {
				jsonObj.put("msg", "添加成功");
				jsonObj.put("success", true);
			} else {
				jsonObj.put("msg", "添加失败");
				jsonObj.put("success", false);
			}
		}
		PrintWriter out = response.getWriter();
		out.println(jsonObj);
		out.flush();
		out.close();
	}

}
