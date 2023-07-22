package boardController;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.JSFunction;
import dao.BoardDao;
import dto.BoardDto;

@WebServlet("/edit")
public class UpdateController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String strNum = req.getParameter("num");
		if(strNum == null) {
			JSFunction.alertLocation(resp, "잘못된 접근입니다.", "./main");
			return;
		}
		int num = Integer.parseInt(strNum);
		BoardDao bdao = new BoardDao(req.getServletContext());
		BoardDto post = bdao.selectPost(num);
		req.setAttribute("post", post);
		HttpSession session = req.getSession();
//		String sessionId = String.valueOf(session.getAttribute("UserId"));
//		if(!sessionId.equals(post.getId())){
//			JSFunction.alertBack(resp, "작성자 본인만 수정할 수 있습니다");
//			return;
//		}
		req.getRequestDispatcher("./Board/Edit.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		int num = Integer.parseInt(req.getParameter("num"));
		BoardDto post = new BoardDto();
		post.setNum(num);
		post.setTitle(title);
		post.setContent(content);
		BoardDao bdao = new BoardDao(req.getServletContext());
		int res = bdao.updatePost(post);
		if(res==1) {
			
			JSFunction.alertLocation(resp, "글 수정이 완료되었습니다.", "./list");
		} else {
			JSFunction.alertBack(resp, "글 수정에 실패했습니다.");
		}
	}

}