package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import common.JDBConnect;
import dto.MovieDto;

public class Movie_HashtagDao extends JDBConnect{
//INSERT나 UPDATE하기 전에는 새로 변경할 정보로 미리 조회를 해서 값이 null일때만 조회
	public Movie_HashtagDao(ServletContext application) {
		super(application);
	}
	
	public int checkMovieHashtag (String movie_id, int hashtag_num) {
		int res = 0;
		String query = "select count(*) from movie_hashtag where movie_id=? and hashtag_num = ?;";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, movie_id);
			psmt.setInt(2, hashtag_num);
			rs = psmt.executeQuery();
			while(rs.next()) {
				res = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("무비해시태그 조회중 오류 발생");
			e.printStackTrace();
		}
		finally {
			close();
		}
		return res;
	}
	
	public int insertMovieHashtag (String movie_id, int hashtag_num) {
		int res = 0;
		String query = "INSERT INTO movie_hashtag VALUES(?,?)";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, movie_id);
			psmt.setInt(2, hashtag_num);
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("무비해시태그 추가중 오류 발생");
			e.printStackTrace();
		}
		finally {
			close();
		}
		return res;
	}
	public int deleteMovieHashtag (String movie_id, int hashtag_num) {
		int res = 0;
		String query = "DELETE FROM movie_hashtag WHERE hashtag_num=? AND movie_id=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, hashtag_num);
			psmt.setString(2, movie_id);
			res = psmt.executeUpdate();
		}
		catch(SQLException e) {
			System.out.println("영화해시태그 삭제 중 오류발생");
			e.printStackTrace();
		}
		finally {
			close();
		}
		return res;
	}
	public List<Object> selectHashtags (String movie_id) {
		List<Object> hashtagList = new ArrayList<Object>();
		String query = "";
		query += "SELECT H.hashtag_name, H.hashtag_num "
				+ " FROM movie_hashtag AS M_H"
				+ " JOIN hashtag AS H"
				+ " ON M_H.hashtag_num = H.hashtag_num"
				+ " WHERE M_H.movie_id = ?"
				+ " ORDER BY H.hashtag_num ASC";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, movie_id);
			rs = psmt.executeQuery();
			while(rs.next()) {
				hashtagList.add(rs.getString("hashtag_num"));
				hashtagList.add(rs.getString("hashtag_name"));
			}
		}
		catch (Exception e) {
	        System.out.println("영화의 모든 해시태그 조회 중 예외 발생");
	        e.printStackTrace();
	    }
	    finally {
	    	close();
	    }
		
	    return hashtagList;	
	}
	public List<MovieDto> selectMovieListByTag (int hashtag_num) {
		List<MovieDto> movieList = new ArrayList<MovieDto>();
		String query = "";
		query += "SELECT M.movie_id, M.movie_title, M.movie_img, M.movie_rating"
				+ " FROM movie_hashtag AS M_H"
				+ " JOIN movie_info AS M"
				+ " ON M.movie_id = M_H.movie_id"
				+ " WHERE M_H.hashtag_num = ?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, hashtag_num);
			rs = psmt.executeQuery();
			while(rs.next()) {
				MovieDto dto = new MovieDto();
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setMovie_title(rs.getString("movie_title"));
				dto.setMovie_img(rs.getString("movie_img"));
				dto.setMovie_rating(rs.getString("movie_rating"));
				movieList.add(dto);
			}
		}
		catch (Exception e) {
	        System.out.println("태그이름으로 영화 조회 중 예외 발생");
	        e.printStackTrace();
	    }
	    finally {
	    	close();
	    }
		
	    return movieList;	
	}
	        
	
}
