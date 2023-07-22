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

@WebServlet("/reviewwrite")
public class ReviewWriteController extends HttpServlet {
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      req.getRequestDispatcher("./ReviewWrite.jsp").forward(req, resp);
   }

   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      String review_title = req.getParameter("review_title");
      String review_content = req.getParameter("review_content");
      String rating = req.getParameter("rating"); // good, bad
      double star_score = Double.parseDouble(req.getParameter("star_score"));

      HttpSession session = req.getSession();
      String user_email = session.getAttribute("user_email").toString();

      String movie_id = req.getParameter("movie_id");
      ReviewDto dto = new ReviewDto(movie_id, user_email, review_title, review_content, rating, star_score);

      ReviewDao dao = new ReviewDao(req.getServletContext());

      // 해당 영화에 대해 사용자의 리뷰가 이미 존재하는지 확인
      boolean existingReview = dao.checkExistingReview(movie_id, user_email);

      if (existingReview) {
         JSFunction.alertBack(resp, "이미 리뷰를 작성한 영화입니다.");
      } else {
         int res = dao.insertWrite(dto);
         if (res == 1) {
            resp.sendRedirect("./movieView?movie_id=" + movie_id);
         } else {
            JSFunction.alertBack(resp, "한 줄평을 10글자 이내로 작성해주세요.");
         }
      }
   }
}