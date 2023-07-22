package movieController;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.MovieDao;
import dao.MovieLikeDao;
import dao.Movie_HashtagDao;
import dao.ReviewDao;
import dao.ReviewLikeDao;
import dao.UserDAO;
import dto.MovieDto;
import dto.ReviewDto;

@WebServlet("/movieView")
public class MovieViewController extends HttpServlet {

   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      String movie_id = req.getParameter("movie_id");
      System.out.println("movie_id" + movie_id);
      if(movie_id==null) {
         return;
      }
      MovieDao dao = new MovieDao(req.getServletContext());
      ReviewDao reviewdao = new ReviewDao(req.getServletContext());
      MovieDto movie = dao.selectMovie(movie_id);
      Gson gson = new Gson(); 
      Movie_HashtagDao tagDao = new Movie_HashtagDao(req.getServletContext());
      List<Object> tags = tagDao.selectHashtags(movie_id);
      req.setAttribute("tags", gson.toJson(tags));
      req.setAttribute("movie", gson.toJson(movie));
      req.setAttribute("Movie", movie);
      System.out.println(movie);
      
      
      req.setAttribute("movie_id", movie_id);
      int star_score = reviewdao.selectStar_score(movie_id);
      req.setAttribute("star_score", star_score);
      System.out.println(star_score);
      
      UserDAO ddao = new UserDAO(req.getServletContext());
      ReviewLikeDao likedao = new ReviewLikeDao(req.getServletContext());
   
      int totalCount = reviewdao.selectCount(movie_id);
      req.setAttribute("totalCount", totalCount);
      System.out.println(totalCount);
      req.setAttribute("movie_id", movie_id);

      List<ReviewDto> reviewLists = reviewdao.selectList(movie_id);

      req.setAttribute("reviewLists", reviewLists);

      Date now= new Date();
   
      req.setAttribute("today", now);
      
      
      HttpSession session = req.getSession();
      String user_email = session.getAttribute("user_email").toString();
      
      MovieLikeDao mlikedao = new MovieLikeDao(req.getServletContext());
      int res = mlikedao.selectMovie_like(user_email, movie_id);
      req.setAttribute("res", res);
      System.out.println(res);
      dao.close();
      req.getRequestDispatcher("./Movie/MovieView.jsp").forward(req, resp);

      
   }

}