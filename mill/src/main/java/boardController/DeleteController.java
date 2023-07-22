package boardController;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import common.JSFunction;
import dao.BoardDao;
import dto.BoardDto;

@WebServlet("/delete")
public class DeleteController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String strNum = req.getParameter("num");
		System.out.println("delete컨트롤러에서 글번호"+strNum);
		if(strNum == null) {
			JSFunction.alertLocation(resp, "잘못된 접근입니다.", "./main");
			return;
		}
		int num = Integer.parseInt(strNum);
		BoardDao bdo = new BoardDao(req.getServletContext());
		BoardDto post = bdo.selectPost(num);
		bdo = new BoardDao(req.getServletContext());
		int res = bdo.deletePost(num);
		HttpSession session = req.getSession();
		String sessionId = String.valueOf(session.getAttribute("UserId"));
//		if( sessionId==null || post==null){
//			JSFunction.alertBack(resp, "잘못된 접근입니다.");
//			return;
//		}
//		else if(sessionId.equals(post.getUser_email())) {
		Gson gson = new Gson();
		resp.getWriter().write(gson.toJson(res));
		return;
//		if(true) {
//			if(res == 1) {
//				JSFunction.alertLocation(resp, "글 삭제가 완료되었습니다.", "./list");
//				return;
//			} else {
//				JSFunction.alertBack(resp, "글삭제 과정 중 오류가 발생했습니다.");
//			}
//		} 
//		else {
//			JSFunction.alertLocation(resp, "잘못된 접근입니다.", "./main");
//			return;
//		}
		

	}

}