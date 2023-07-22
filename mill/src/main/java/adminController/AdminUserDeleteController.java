package adminController;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.JSFunction;
import dao.UserDAO;
import dto.UserDTO;

@WebServlet("/AdminUserDelete")
public class AdminUserDeleteController extends HttpServlet  {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String user_email = req.getParameter("user_email");
		System.out.println("user_email" + user_email);
		String[] arr = user_email.split(" "); 
		
		if(user_email == null){
			 JSFunction.alertBack(resp,"잘못된 접근입니다.");
		}

		else{
			UserDAO dao = new UserDAO(req.getServletContext());
			for(String email : arr) {
				System.out.println("email : " + email);
			int res = 0;
				res = dao.deleteUser(email);
				if(res!=1) JSFunction.alertBack(resp, "삭제에 실패했습니다.");
			
			}
			dao.close();
		}

	}
}
