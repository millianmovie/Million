package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletContext;

import common.JDBConnect;
import dto.BoardDto;
import dto.CommentDto;

public class CommentDao extends JDBConnect {
	public CommentDao(ServletContext application) {
		super(application);
	}
	
	public int insertComment(CommentDto c) {
		int res = 0;
		String sql = "insert into comment(bno, comment, commenter) values (?, ?, ?)";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, c.getBno());
			psmt.setString(2, c.getComment());
			psmt.setString(3, c.getCommenter());
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("회원입력중 오류 발생");
			e.printStackTrace();
		}
		return res;
	}
	public int countComment(int bno) {
		int res = 0;
		try {
			String query = "select count(*) from comment where bno=?";
			psmt = con.prepareStatement(query);
			psmt.setInt(1, bno);
			rs = psmt.executeQuery();
			if(rs.next()) {
				res = rs.getInt(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
	}
	public CommentDto selectComment(int bno) {
		String sql = "select * from comment where bno=?";
		CommentDto c = null;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1,  bno);
			rs = psmt.executeQuery();
			if(rs.next()) {
				c = new CommentDto();
				c.setCno(rs.getInt(1));
				c.setBno(rs.getInt(2));
				c.setComment(rs.getString(3));
				c.setCommenter(rs.getString(4));
				c.setReg_date(rs.getTimestamp(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return c;
	}
//	
//	public ArrayList<CommentDto> selectAllComments(int bno) {
//		ArrayList<CommentDto> comments = new ArrayList<CommentDto>();
//		try {
//			String sql = "select * from comment where bno=? ORDER BY reg_date DESC, cno DESC";
//			pstmt = con.prepareStatement(sql);
//			pstmt.setInt(1,  bno);
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				CommentDto c = new CommentDto();
//				c.setCno(rs.getInt(1));
//				c.setBno(rs.getInt(2));
//				c.setComment(rs.getString(3));
//				c.setCommenter(rs.getString(4));
//				c.setReg_date(rs.getTimestamp(5));
//				comments.add(c);
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return comments;
//	}
	
	public int updateComment (CommentDto c) {
		int res = 0;
		try {
			String query = "UPDATE comment SET comment = ?, reg_date = now() WHERE bno = ? AND commenter = ?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, c.getComment());
			psmt.setInt(2, c.getBno());
			psmt.setString(3, c.getCommenter());
			res = psmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
	}
	
	public int deleteComment (int bno) {
		int res = 0;
		String query = "DELETE FROM comment WHERE bno=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, bno);
			res = psmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
		
	}
}