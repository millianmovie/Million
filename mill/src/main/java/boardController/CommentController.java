package boardController;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.Gson;

import dao.BoardDao;
import dao.CommentDao;
import dto.CommentDto;

@WebServlet("/comment")
public class CommentController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String mode = req.getParameter("mode");
		if("del".equals(mode)) {
			this.doDelete(req, resp);
		}else if("mody".equals(mode)) {
			this.doPatch(req, resp);
		}
		else {			
			super.service(req, resp);
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Gson gson = new Gson();
		resp.setContentType("application/json; charset=utf-8");
		PrintWriter out = resp.getWriter();
		
		String temp = req.getParameter("bno");
		int bno = 0;
		if(temp!=null) bno = Integer.parseInt(temp);
		CommentDao dao = new CommentDao(req.getServletContext());
		CommentDto comments = dao.selectComment(bno);
		out.println(gson.toJson(comments));
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Gson gson = new Gson();
		resp.setContentType("application/json; charset=utf-8");
		PrintWriter out = resp.getWriter();
		CommentDao dao = new CommentDao(req.getServletContext());
		
		int bno=0;
		int res = dao.countComment(bno);
		if(res>0) {
			out.println(gson.toJson("답글이 이미 있습니다."));
			return;
		}
		
		String temp = req.getParameter("bno");
		if(temp!=null) bno = Integer.parseInt(temp);
		String comment = req.getParameter("comment");
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("user_email");
		CommentDto dto = new CommentDto(bno, comment, id);
		dao = new CommentDao(req.getServletContext());
		res = dao.insertComment(dto);
		
		resp.setContentType("application/json; charset=utf-8");
		out.println(gson.toJson(res));
	}
	
	private void doPatch(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		String strBno = req.getParameter("bno");
		if(strBno == null) return;
		int bno = Integer.parseInt(strBno);
		String comment = req.getParameter("comment");
		CommentDao dao = new CommentDao(req.getServletContext());		
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("user_email");
		CommentDto dto = new CommentDto(bno, comment, id);
		System.out.println(dto);
		int res = dao.updateComment(dto);
		System.out.println(res);
		Gson gson = new Gson();
		resp.setContentType("application/json; charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.println(gson.toJson(res));
	}
	
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String strBno = req.getParameter("bno");
		if(strBno == null) return;
		int bno = Integer.parseInt(strBno);

		CommentDao dao = new CommentDao(req.getServletContext());
		int res = dao.deleteComment(bno);
		Gson gson = new Gson();
		resp.setContentType("application/json; charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.println(gson.toJson(res));
	}

}
