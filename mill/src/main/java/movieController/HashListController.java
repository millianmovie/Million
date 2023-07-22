package movieController;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.HashtagDao;
import dao.MovieDao;
import dao.Movie_HashtagDao;
import dto.MovieDto;

public class HashListController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String mode = req.getParameter("mode");

		if(mode==null || !mode.equals("tag") && !mode.equals("genre")) {
			System.out.println("장르나 태그가아니거나 널");
			return;
			//잘못된 접근 알림창 띄우고 리턴
		}
		if(mode.equals("tag")) {
			String strTagNum = req.getParameter("tag_num");
			if(strTagNum==null) return;
			//오류발생 알림창 띄우고 리턴
			int tagNum = Integer.parseInt(strTagNum);
			HashtagDao tagDao = new HashtagDao(req.getServletContext());
			String hashtag = tagDao.selectHashtagName(tagNum);
			
			Movie_HashtagDao movieTagDao = new Movie_HashtagDao(req.getServletContext());
			List<MovieDto> movieListByTag = movieTagDao.selectMovieListByTag(tagNum);
			
			if(movieListByTag.size() == 0 || hashtag==null) return;//오류 발생 알림창 띄우고 리턴
			
			Gson gson = new Gson();
			req.setAttribute("tagName", hashtag);
			req.setAttribute("movieList", gson.toJson(movieListByTag));
		}
		if(mode.equals("genre")) {
			String genre = req.getParameter("genre");
			if(genre==null) return;
			//오류발생 알림창 띄우고 리턴
			MovieDao movieDao = new MovieDao(getServletContext());
			List<MovieDto> movieListByGenre = movieDao.selectMovieListByGenre(genre);
			req.setAttribute("movieList", movieListByGenre);
		}
		
		req.getRequestDispatcher("./Movie/HashList.jsp").forward(req, resp);
	}

}