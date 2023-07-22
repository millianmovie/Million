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

@WebServlet("/reviewView")
public class ReviewViewController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		HttpSession session = req.getSession();
		if(session.getAttribute("UserEmail") == null){
			JSFunction.alertLocation(resp, "로그인 후 이용해 주십시오.", "./userLogin2");
		}
		
		else {
		 ReviewDao dao = new ReviewDao(req.getServletContext());
		 String snum = req.getParameter("review_num");
		 int num = Integer.parseInt(snum);

	     String strmovieid = req.getParameter("movie_id");
	     int movie_id = Integer.parseInt(strmovieid);

		 ReviewDto dto = dao.selectView(movie_id);
		 req.setAttribute("dto", dto);
		 req.getRequestDispatcher("./ReviewView.jsp").forward(req, resp);
		} 
		 
	}
	
}
