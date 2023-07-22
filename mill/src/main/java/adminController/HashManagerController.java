package adminController;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.HashtagDao;
import dao.MovieDao;
import dao.Movie_HashtagDao;
import dto.MovieDto;

@WebServlet("/hash_manager")
public class HashManagerController extends HttpServlet {

	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String mode = req.getParameter("mode");
		if("checkMoviesByTag".equals(mode) || "addTag".equals(mode) || "delTag".equals(mode)) {
			this.manageTag(req, resp, mode);
		} else if("delMovietag".equals(mode) || "addMovietag".equals(mode)) {
			this.manageMovietag(req, resp, mode);
		} else 
			super.service(req, resp);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Gson gson = new Gson();
		HashtagDao hashDao = new HashtagDao(getServletContext());
		List<Object> hashList = hashDao.selectAllTags();
		MovieDao dao = new MovieDao(getServletContext());
		List<MovieDto> allMovies = dao.selectAllMovies();
		
		req.setAttribute("hashList", gson.toJson(hashList));
		req.setAttribute("allMovies", gson.toJson(allMovies));
		req.getRequestDispatcher("./Admin/HashManager.jsp").forward(req, resp);
		
	}
	protected void manageTag(HttpServletRequest req, HttpServletResponse resp, String mode) throws ServletException, IOException {
		Gson gson = new Gson();
		String strTagNum = req.getParameter("tagNum");
		int tagNum = 0;
		if(strTagNum != null) {
			tagNum = Integer.parseInt(strTagNum);
		}
		String tagName = req.getParameter("tagName");
		Movie_HashtagDao movieTagDao = new Movie_HashtagDao(req.getServletContext());
		HashtagDao tagDao = new HashtagDao(req.getServletContext());
		int res = 0;
		
		resp.setContentType("application/json; charset=utf-8");
		PrintWriter out = resp.getWriter();
		if("checkMoviesByTag".equals(mode)) {	
			List<MovieDto> movieListByTag = movieTagDao.selectMovieListByTag(tagNum);
			out.write(gson.toJson(movieListByTag));
		} else if("addTag".equals(mode)) {
			res = tagDao.checkHashtag(tagName);
			if(res==0) {				
				tagDao = new HashtagDao(req.getServletContext());			
				res = tagDao.insertHashtag(tagName);
				out.write(gson.toJson(res));
			} else {
				res = 2;
				out.write(gson.toJson(res));
			}
		} else if("delTag".equals(mode)) {
			res = tagDao.deleteHashtag(tagNum);
			out.write(gson.toJson(res));
		} 
		return;
	}
	protected void manageMovietag(HttpServletRequest req, HttpServletResponse resp, String mode) throws ServletException, IOException {
		
		String strTagNum = req.getParameter("tagNum");
		if(strTagNum == null) return;
		int tagNum = Integer.parseInt(strTagNum);
		String movieId = req.getParameter("movieId");
		int res=0;
		Gson gson = new Gson();
		Movie_HashtagDao movietagDao = new Movie_HashtagDao(req.getServletContext()); 
		resp.setContentType("application/json; charset=utf-8");
		PrintWriter out = resp.getWriter();
		
		if("delMovietag".equals(mode)) {
			res = movietagDao.deleteMovieHashtag(movieId, tagNum);
			out.write(gson.toJson(res));
		} else if("addMovietag".equals(mode)) {
			res = movietagDao.checkMovieHashtag(movieId, tagNum);
			if(res==0) {
				movietagDao = new Movie_HashtagDao(req.getServletContext()); 
				res = movietagDao.insertMovieHashtag(movieId, tagNum);
				out.write(gson.toJson(res));
			}
		}
		return;
		
	}
	
}