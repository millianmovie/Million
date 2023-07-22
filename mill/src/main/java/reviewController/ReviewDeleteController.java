package reviewController;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.JSFunction;
import dao.ReviewDao;
import dto.ReviewDto;
@WebServlet("/reviewdelete")
public class ReviewDeleteController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("-----");
		String snum = req.getParameter("review_num");

		if(snum == null){
			 JSFunction.alertBack(resp,"잘못된 접근입니다.");
		}

		else{
			int num = Integer.parseInt(snum);
			ReviewDao dao = new ReviewDao(req.getServletContext());
			ReviewDto dto = dao.selectView(num);
			
			HttpSession session = req.getSession();
			String email = session.getAttribute("user_email").toString();
			int res = 0;
			if(email==null || dto== null){
			 	JSFunction.alertBack(resp,"잘못된 접근입니다.");
			}

			else if(dto.getUser_email().equals(email)){
			 	res = dao.deleteView(num);
			 	dao.close();
			 	if(res==1) resp.sendRedirect("./movie_view");
			 	else JSFunction.alertBack(resp, "삭제에 실패했습니다.");
			}

			else {JSFunction.alertBack(resp, "잘못된 접근입니다.");}
		}



	}

}