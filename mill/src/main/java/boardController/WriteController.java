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
@WebServlet("/write")
public class WriteController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		if(session.getAttribute("user_email") == null){
			JSFunction.alertLocation(resp, "로그인 후 이용해 주십시오.", "./userLogin2");
		}
		req.getRequestDispatcher("./Board/Write.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//폼에서 받은 정보들 가지고 와서 업데이트 해주면 됨
//		BoardDao bdao = new BoardDao(req.getServletContext());
		
		HttpSession session = req.getSession();
		String user_email = (String)session.getAttribute("user_email");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String secret = "secret".equals(req.getParameter("secret")) ? "true" : "false";
		BoardDao bdao = new BoardDao(req.getServletContext());

		
		BoardDto dto = new BoardDto(user_email, title, content, secret);
		bdao = new BoardDao(req.getServletContext());
		int res = bdao.insertBoard(dto);
		if(res==1) {
			JSFunction.alertLocation(resp, "게시글 등록이 완료되었습니다.", "./list");
		} else {
			JSFunction.alertBack(resp, "게시글 등록에 실패했습니다. 잠시후 다시 시도해주세요.");
		}
	}

}