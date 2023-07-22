package mypageController;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.JSFunction;
import dao.MovieLikeDao;
import dto.MovieLikeDto;

@WebServlet("/movie_likedelete")

public class MyPageMovieLikeDeleteController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String movie_id = req.getParameter("movie_id");
		System.out.println("movie_id "+movie_id);
		HttpSession session = req.getSession();
		String user_email = session.getAttribute("user_email").toString();
		String[] arr = movie_id.split(" ");

		if(movie_id == null){
			 JSFunction.alertBack(resp,"잘못된 접근입니다.");
		}

		else{
			MovieLikeDao dao = new MovieLikeDao(req.getServletContext());
			for(String id : arr) {
				System.out.println("id : " + id);
			int res = 0;
			 	res = dao.deleteMY_Page_like(id);
			 	//if(res==1) resp.sendRedirect("./myPage");
			 	if(res!=1) JSFunction.alertBack(resp, "삭제에 실패했습니다.");
			
			}
			dao.close();
		}
	}
	
}