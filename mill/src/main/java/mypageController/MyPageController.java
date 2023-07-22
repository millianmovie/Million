package mypageController;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MovieDao;
import dao.MovieLikeDao;
import dao.ReviewDao;
import dao.UserDAO;
import dto.MovieDto;
import dto.ReviewDto;
import dto.UserDTO;
@WebServlet("/myPage")
public class MyPageController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		  MovieDao moviedao = new MovieDao(req.getServletContext());
		  ReviewDao reviewdao = new ReviewDao(req.getServletContext());
		  MovieLikeDao mlikedao = new MovieLikeDao(req.getServletContext());
		  UserDAO udao = new UserDAO(req.getServletContext());
		  
		  
		  HttpSession session = req.getSession();
		  String user_email = session.getAttribute("user_email").toString();
		  
		  UserDTO user = udao.selectUser(user_email);
		  req.setAttribute("user", user);
		  
		  List<MovieDto> movieLikeLists = mlikedao.selectMyMovieList(user_email);
		  req.setAttribute("movieLikeLists", movieLikeLists);
		  
		  String movie_id = req.getParameter("movie_id");
	      req.setAttribute("movie_id", movie_id);
	      
	      int res = mlikedao.selectMovie_like(user_email, movie_id);
	      req.setAttribute("res", res);
	      
	      List<ReviewDto> reviewLists = reviewdao.selectMyList(user_email);
	      req.setAttribute("reviewLists", reviewLists);
	      
	      List<ReviewDto> reviewListsEdit = reviewdao.selectList(movie_id);

	      req.setAttribute("reviewListsEdit", reviewListsEdit);

	      
	      moviedao.close();
	      req.getRequestDispatcher("./MyPage/My.jsp").forward(req, resp);

	      
	}
	
	

}
