package reviewController;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ReviewDao;
import dao.ReviewLikeDao;
import dao.UserDAO;
import dto.ReviewLikeDto;

@WebServlet("/reviewlike")
public class ReviewLikeController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String review_num = req.getParameter("review_num");
		String mode = req.getParameter("mode");
		ReviewLikeDao likedao = new ReviewLikeDao(req.getServletContext());
		HttpSession session =req.getSession();
		String user_email = session.getAttribute("user_email").toString();
		if(mode.equals("like")) {
			int res = likedao.insertReview_like(user_email,Integer.parseInt(review_num));
			if( res ==1 ) {
				likedao.updateReview_like(1, Integer.parseInt(review_num));
			}
		}
		else {
			int res = likedao.deleteReview_like(user_email,Integer.parseInt(review_num));
			if( res == 1) {
				likedao.updateReview_like(-1, Integer.parseInt(review_num));
			}
		}
		int totalLikeNum = likedao.selectAllLike(Integer.parseInt(review_num));
		int res = likedao.selectReview_like(user_email, Integer.parseInt(review_num));
		resp.getWriter().print(res);
		System.out.println(totalLikeNum);
	}
				
}
	