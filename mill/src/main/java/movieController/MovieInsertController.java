package movieController;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.MovieDao;
import dto.MovieDto;

public class MovieInsertController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StringBuilder reqbody = new StringBuilder();		
		BufferedReader inputReader = new BufferedReader(new InputStreamReader(req.getInputStream()));
        String line;
        while ((line = inputReader.readLine()) != null) {
        	reqbody.append(line);
        }
        inputReader.close();
        String jsonStrMovie = reqbody.toString();
   		
        Gson g = new Gson();
        MovieDto movie = g.fromJson(jsonStrMovie, MovieDto.class);
		MovieDao dao = new MovieDao(req.getServletContext());
		String movie_id = movie.getMovie_id();
		
		int res = dao.checkMovie(movie_id);
		//이미 DB에 저장된 영화일 경우 return, 뷰 컨트롤러로이동
		if(res!=0) {
			return;
		}
		dao = new MovieDao(req.getServletContext());
		dao.insertMovie(movie);
	}
}