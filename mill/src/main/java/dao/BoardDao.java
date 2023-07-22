package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import common.JDBConnect;
import dto.BoardDto;

public class BoardDao extends JDBConnect {

	public BoardDao(ServletContext application) {
		super(application);
	}
	
	//검색 조건에 맞는 게시물의 개수 반환
	public int selectCount() {
		int totalCount = 0; //결과(게시물수) 담을 변수
		//게시글 수를 얻어오는 쿼리문 작성
		String query = "SELECT COUNT(*) FROM board";
		try {
			psmt = con.prepareStatement(query);
			rs =psmt.executeQuery(query);
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외발생");
			e.printStackTrace();
		}
		finally {
			close();
		}
		return totalCount;
	}
	
    public int insertBoard(BoardDto b) {
	  	int res = 0;
	  	try {
	  		String query = "INSERT INTO board (user_email, title, content, secret) VALUES(?, ?, ?, ?)";
	  		psmt = con.prepareStatement(query);
	  		psmt.setString(1, b.getUser_email());
	  		psmt.setString(2, b.getTitle());
	  		psmt.setString(3, b.getContent());
	  		psmt.setString(4, b.getSecret());
	  		res = psmt.executeUpdate();
	  	}
	  	catch (SQLException e) {
	  		e.printStackTrace();
	  	}
	  	finally {
	  		close();
	  	}
	  	return res;
  }

	//검색 조건에 맞는 게시물 목록을 반환하는 함수
    public List<BoardDto> selectList(Map<String, Object> map) { 
        List<BoardDto> postList = new ArrayList<BoardDto>();  // 결과(게시물 목록)를 담을 변수
        String query = "SELECT * FROM board ORDER BY num DESC ";
        query += "LIMIT " + map.get("offset") + "," + map.get("pageSize");
        try {
            stmt = con.createStatement();   // 쿼리문 생성
            rs = stmt.executeQuery(query);  // 쿼리 실행
            while (rs.next()) {  // 결과를 순화하며...
                // 한 행(게시물 하나)의 내용을 DTO에 저장
                BoardDto b = new BoardDto();
                b.setNum(rs.getInt("num")); // 일련번호
                b.setUser_email(rs.getString("user_email"));
                b.setTitle(rs.getString("title")); // 제목
                b.setContent(rs.getString("content")); // 내용
                b.setPost_date(rs.getTimestamp("post_date")); // 작성일
                b.setSecret(rs.getString("secret")); // 비밀글여부
                postList.add(b); // 결과 목록에 저장
            }
        }
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }
        finally {
			close();
		}

        return postList;
    }
    
	public int updateViewCnt (int num) {
		String sql = "UPDATE board SET view_cnt = view_cnt+1 WHERE num=?";
		int res=0;
		try {
			psmt=con.prepareStatement(sql);
			psmt.setInt(1, num);
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("조회수 증가 중 예외 발생");
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
}

	public BoardDto selectPost(int num) {
		BoardDto b = null;
		
		String query = "SELECT * from board WHERE num=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, num);
			rs = psmt.executeQuery();
			if(rs.next()) {
                b = new BoardDto(); 
                b.setNum(rs.getInt("num"));          // 일련번호
                b.setUser_email(rs.getString("user_email"));
                b.setTitle(rs.getString("title"));      // 제목
                b.setContent(rs.getString("content"));  // 내용
                b.setPost_date(rs.getTimestamp("post_date"));  // 작성일
                b.setSecret(rs.getString("secret"));  // 비밀글여부
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return b;
	}
	
	public int deletePost (int num) {
		int res = 0;
		String query = "DELETE FROM board WHERE num=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, num);
			res = psmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
		
	}
	
	public int updatePost (BoardDto b) {
		int res = 0;
		try {
			String query = "UPDATE board SET title = ?, content = ? WHERE num = ?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, b.getTitle());
			psmt.setString(2, b.getContent());
			psmt.setInt(3, b.getNum());
			res = psmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
	}

	public int updateReLevel(int ref, int re_level) {
    	int res = 0;
    	try {
    		String query = "UPDATE board SET re_level = re_level+1 WHERE ref = ? AND re_level > ?";
    		psmt = con.prepareStatement(query);
    		psmt.setInt(1, ref);
    		psmt.setInt(2, re_level);
    		psmt.executeUpdate();
    	}
    	catch (SQLException e) {
    		res = -1;
    		System.out.println("레벨증가 시행 중 오류발생");
    		e.printStackTrace();
    	}
    	finally {
    		close();
    	}
    	return res;
	}
	
}