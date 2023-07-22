package mypageController;
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

// 서블릿과 요청명을 edit로 연결
@WebServlet("/myPageReviewEdit")
public class MyPageReviewUpdateController extends HttpServlet {
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	  System.out.println("---1243");
      String strReviewNum = req.getParameter("review_num");
      if(strReviewNum==null) {
         JSFunction.alertLocation(resp, "잘못된 접근입니다.", "./myPage");
         return;
      }
      int review_num = Integer.parseInt(strReviewNum); // 일련번호
      ReviewDao dao = new ReviewDao(req.getServletContext()); // DAO 생성
      ReviewDto dto = dao.selectView(review_num); // 게시물 가져오기
      
      String movie_id = req.getParameter("movid_id");
      
      req.setAttribute("movie_id", movie_id);
      req.setAttribute("dto", dto);
      
      HttpSession session = req.getSession();
      String user_email = session.getAttribute("user_email").toString();

      dao.close(); // DB연결 해제
      req.getRequestDispatcher("./MyPage_ReviewEdit.jsp").forward(req, resp);
   }

   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      String strReviewNum = req.getParameter("review_num");
      String review_title = req.getParameter("review_title");
      String review_content = req.getParameter("review_content");
      String rating = req.getParameter("rating");
      double star_score = Double.parseDouble(req.getParameter("star_score"));
      
      if(strReviewNum==null) {
         JSFunction.alertLocation(resp, "잘못된 접근입니다." , "./myPage");
         return;
      }
      
      int review_num = Integer.parseInt(strReviewNum); 
      String user_email = req.getParameter("user_email");
      System.out.println("user_email: " + user_email);

      
      String movie_id = req.getParameter("movie_id");
      System.out.println("업데이트컨트롤러 무비아이디" + movie_id);
      ReviewDto dto = new ReviewDto(review_num, movie_id, user_email, review_title, review_content, rating, star_score);
      
      ReviewDao dao = new ReviewDao(req.getServletContext());
      int res = dao.updateEdit(dto);
      if(res==1) {
         resp.sendRedirect("./myPage?m=active");
      }
      else {
         JSFunction.alertBack(resp, "잠시 후 다시 시도해주슈.");
      }
      dao.close();
   }
}
