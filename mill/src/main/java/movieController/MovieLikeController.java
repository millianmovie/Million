package movieController;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MovieDao;
import dao.MovieLikeDao;
import dao.UserDAO;
import dto.MovieLikeDto;

@WebServlet("/movielike")
public class MovieLikeController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String movie_id = req.getParameter("movie_id");
		String mode = req.getParameter("mode");
		MovieLikeDao likedao = new MovieLikeDao(req.getServletContext());
		HttpSession session =req.getSession();
		String user_email = session.getAttribute("user_email").toString();
		if(mode.equals("movie_like")) {
			int res = likedao.insertMovie_like(user_email,movie_id);
			if( res ==1 ) {
				likedao.updateMovie_like(1,movie_id);
			}
		}
		else {
			int res = likedao.deleteMovie_like(user_email,movie_id);
			System.out.println("res: "+res);
			if( res == 1) {
				likedao.updateMovie_like(-1, movie_id);
			}
		}
		int res = likedao.selectMovie_like(user_email,movie_id);
		resp.getWriter().print(res); 
	}
				
}
	