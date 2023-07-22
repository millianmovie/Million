package loginController;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.JSFunction;
import dao.UserDAO;
import dto.UserDTO;

@WebServlet("/userDelete")
public class UserDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public UserDeleteController() {
        super();
    }
    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    		HttpSession session = request.getSession();
		String user_email = request.getParameter("user_email");
		UserDAO dao = new UserDAO(request.getServletContext());
		
		try {
			dao.deleteUser(user_email);
			session.invalidate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("./miniMain");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
