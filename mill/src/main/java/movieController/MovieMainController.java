package movieController;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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
import dao.RecomendDao;
import dao.ReviewDao;
import dto.MovieDto;
import dto.ReccomendDto;

@WebServlet("/movieMain")
public class MovieMainController extends HttpServlet  {
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

      
      
      RecomendDao rdao = new RecomendDao(req.getServletContext());
      MovieDao movieDao = new MovieDao(getServletContext());
      MovieLikeDao movieLikeDao = new MovieLikeDao(getServletContext());
      ReviewDao reviewDao = new ReviewDao(getServletContext());

      
      HttpSession session = req.getSession();
      String user_email = session.getAttribute("user_email").toString();
      
      
      int movie_like_list = movieLikeDao.selectMovie_likeALL(user_email);
      int review_list = reviewDao.selectCountAll(user_email);
      
      if(movie_like_list != 0 || review_list !=0) {
         ArrayList<ReccomendDto> totalcount = rdao.selectRecommendList(user_email);
         String reccomendMovie_id = totalcount.get(totalcount.size()-1).getMovie_id();
         System.out.println("movie_id : "+ reccomendMovie_id);
         movieDao = new MovieDao(getServletContext());
         
         
         String recommendGenre = movieDao.selectReccomendByGenre(reccomendMovie_id);
         System.out.println("genre : "+ recommendGenre);
         
         String[] R_genre = recommendGenre.split(",");
         
         String r1 = R_genre[0];
         String r2 = R_genre[1];
         
         movieDao = new MovieDao(getServletContext());
         List<MovieDto> recommendListByGenre = movieDao.selectReccomendMovieListByGenre(r1,r2);
         req.setAttribute("recommendListByGenre", recommendListByGenre);
         
      }
      movieDao = new MovieDao(getServletContext());
      List<MovieDto> top20List = movieDao.getTopRatedMovies();
      req.setAttribute("top20List", top20List);
      
      
      movieDao = new MovieDao(getServletContext());
      // 영화 데이터 저장
      Gson gson = new Gson(); 
      List<MovieDto> romanceListByGenre = movieDao.selectMovieListByGenre("로맨스");
      romanceListByGenre =  initMovies(romanceListByGenre);
      movieDao = new MovieDao(getServletContext());

      List<MovieDto> fantasyListByGenre = movieDao.selectMovieListByGenre("판타지");
      fantasyListByGenre =  initMovies(fantasyListByGenre);
      movieDao = new MovieDao(getServletContext());
      List<MovieDto> comedyListByGenre = movieDao.selectMovieListByGenre("코메디");
      comedyListByGenre =  initMovies(comedyListByGenre);
      movieDao = new MovieDao(getServletContext());
      List<MovieDto> thrillerListByGenre = movieDao.selectMovieListByGenre("스릴러"); 
      thrillerListByGenre =  initMovies(thrillerListByGenre);
      movieDao = new MovieDao(getServletContext());
      List<MovieDto> dramaListByGenre = movieDao.selectMovieListByGenre("드라마");
      dramaListByGenre =  initMovies(dramaListByGenre);

      // 장르별 영화 목록을 리퀘스트 속성에 저장
      req.setAttribute("romanceListByGenre", romanceListByGenre);
      req.setAttribute("fantasyListByGenre", fantasyListByGenre);
      req.setAttribute("comedyListByGenre", comedyListByGenre);
      req.setAttribute("thrillerListByGenre", thrillerListByGenre);
      req.setAttribute("dramaListByGenre", dramaListByGenre);
      
      


      // JSP 파일로 포워딩하면서 데이터 전달
      req.getRequestDispatcher("./Movie/MovieMain.jsp").forward(req, resp);

   }
   
   public ArrayList<MovieDto> initMovies(List<MovieDto> list) {
        ArrayList<MovieDto> newList = new ArrayList<MovieDto>();
         for(int i=0; i<21; i++) {
            newList.add(list.get(i));
         }
      return newList;
      
   }
   
}