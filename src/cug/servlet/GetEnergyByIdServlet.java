package cug.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cug.dao.EnergyDao;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class GetEnergyByIdServlet
 */
@WebServlet("/getEnergyById.do")
public class GetEnergyByIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetEnergyByIdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/json;charset=utf-8");
		String userId = request.getParameter("userId");
		EnergyDao energyDao = new EnergyDao();
		Object[] obj = {userId};
		List<Map<String,String>> list = energyDao.getEnergyById(obj);
		JSONArray jsonArray = JSONArray.fromObject(list);
		System.out.println(userId+list);
		PrintWriter out = response.getWriter();
		out.println(jsonArray);
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
