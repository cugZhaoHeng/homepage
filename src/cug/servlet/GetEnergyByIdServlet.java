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

import net.sf.json.JSONObject;
import cug.dao.EnergyDao;

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
		String pageStr = request.getParameter("page");
		String rowsStr = request.getParameter("rows");
		if(pageStr == null || pageStr.equals("")) {
			pageStr = "1";
			rowsStr = "5";
		}
		int page = Integer.parseInt(pageStr);
		int rows = Integer.parseInt(rowsStr);
		int start = (page-1)*rows;
		
		EnergyDao energyDao = new EnergyDao();
		Object[] obj = {userId, start, rows};
		Object[] obj1 = {userId};
		List<Map<String,String>> list = energyDao.getEnergyByPage(obj);
		List<Map<String,String>> list1 = energyDao.getEnergyById(obj1);
		int total = list1.size();
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("rows", list);
		jsonObj.put("total", total);
		jsonObj.put("all", list1);
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
