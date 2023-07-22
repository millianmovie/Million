package adminController;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import dto.MovieDto;
import dto.UserDTO;

@WebServlet("/adminUser")
public class AdminUserController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		UserDAO userdao = new UserDAO(req.getServletContext());
		 
		String admin_searchWord= req.getParameter("admin_searchWord");
		List<UserDTO> userList = null;
		if(admin_searchWord==null || "".equals(admin_searchWord)) {
			userList = userdao.selectAllAdminUser();
		}else {
			userList = userdao.selectAdminSearchList(admin_searchWord);
		}

		req.setAttribute("userList", userList);
		req.getRequestDispatcher("./Admin/UserManager.jsp").forward(req, resp);
	}
	

}
