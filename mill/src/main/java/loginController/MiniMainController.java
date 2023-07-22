package loginController;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.Date;

import dao.UserDAO;
import dto.UserDTO;

@WebServlet("/miniMain")
public class MiniMainController extends HttpServlet {
	dao.UserDAO dao = null;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("./User/miniMain.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_email = request.getParameter("user_email");
		String user_pwd = request.getParameter("user_pwd");
		
		dao = new dao.UserDAO(request.getServletContext());
		
		dto.UserDTO dto = dao.selectUser(user_email);
		if(dto != null && user_email.equals(dto.getUser_email()) && user_pwd.equals(dto.getUser_pwd())) {
				HttpSession session = request.getSession();
				
				session.setAttribute("user_email", dto.getUser_email());
				session.setAttribute("user_name", dto.getUser_name());
				
				response.sendRedirect("./movieMain");
			}
		else {
				try {
					response.setContentType("text/html; charset=utf-8");
					PrintWriter pw = response.getWriter();
					pw.write("<script>alert('이메일 혹은 암호를 다시 확인 바랍니다.');history.back();</script>");
					pw.flush();
					pw.close();
			    } catch(Exception e) {
					e.printStackTrace();
			    }
			
		}
		
	}
}
