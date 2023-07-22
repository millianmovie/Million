package loginController;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import dto.UserDTO;

@WebServlet("/userRegister")
public class UserRegisterController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_email = request.getParameter("user_email");
		request.getRequestDispatcher("./User/UserRegister.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = new UserDAO(request.getServletContext());
		String user_email = request.getParameter("user_email");
		String user_pwd = request.getParameter("user_pwd");
		String user_phone = request.getParameter("user_phone");
		String user_tos = request.getParameter("user_tos");
		String user_name = request.getParameter("user_name");
		java.sql.Date user_birth = java.sql.Date.valueOf(request.getParameter("user_birth"));
		String user_gender = request.getParameter("user_gender");
		String user_pwd_hint = request.getParameter("user_pwd_hint");
		String user_pwd_hint_answer = request.getParameter("user_pwd_hint_answer");
		dto.UserDTO dto = new UserDTO(user_email, user_pwd, user_phone, user_tos, user_name, user_birth, user_gender, user_pwd_hint, user_pwd_hint_answer);
		
		int res = dao.insertUser(dto);
		
		if(res == 1) {
			response.sendRedirect("./miniMain");
		}
		else {
			request.setAttribute("dto", dto);
			request.getRequestDispatcher("/userRegister/?msg=" + URLEncoder.encode("회원가입 오류", "UTF-8")).forward(request, response);
		}
	}
}
