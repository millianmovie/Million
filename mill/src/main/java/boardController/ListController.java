package boardController;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.JSFunction;
import common.PageHandler;
import common.SearchCondition;
import dao.BoardDao;
import dto.BoardDto;

@WebServlet("/list")
public class ListController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		if(session.getAttribute("user_email") == null){
			JSFunction.alertLocation(resp, "로그인 후 이용해 주십시오.", "./userLogin2");
		}
		
		String email = (String)session.getAttribute("user_email");
		BoardDao bdao = new BoardDao(req.getServletContext());
		
		int pageSize = Integer.parseInt(req.getServletContext().getInitParameter("PageSize"));
		SearchCondition sc = null;
		PageHandler ph = null;
		int page = 1;
		String pageTemp = req.getParameter("page");
		if(pageTemp != null && !pageTemp.equals(""))
			page = Integer.parseInt(pageTemp);
		sc = new SearchCondition(page, pageSize);
		
		int totalCount = bdao.selectCount();
		System.out.println(totalCount);
		ph = new PageHandler(totalCount, sc);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("offset", sc.getOffset(page));
		param.put("pageSize", pageSize);
		
		bdao = new BoardDao(req.getServletContext());
		List<BoardDto> postList = bdao.selectList(param);
		//뷰에서 처리하도록 request영역에 pageHandeler, 게시글목록 저장
		req.setAttribute("ph", ph);
		req.setAttribute("postList", postList);
		System.out.println("postlist"+postList);
		//날짜 정보 출력 위한 오늘날짜 저장
		Date now = new Date();
		req.setAttribute("today", now);	
		req.getRequestDispatcher("./Board/List.jsp").forward(req, resp);		
	}
}