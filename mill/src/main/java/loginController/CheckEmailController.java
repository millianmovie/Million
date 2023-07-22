package loginController;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.UserDAO;

@WebServlet("/checkEmail.do")
public class CheckEmailController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		UserDAO udo = new UserDAO(req.getServletContext());
		PrintWriter out = resp.getWriter();
		JSONObject sobject = new JSONObject();
		if(udo.selectUser(id)!=null) {
			sobject.put("ch", "true");
			
		}else {
			sobject.put("ch", "false");
		}
		out.println(sobject.toJSONString());
		System.out.println(sobject.toJSONString());
	}
	
}
