package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import common.JDBConnect;
import dto.MovieDto;
import dto.MovieLikeDto;
import dto.ReviewDto;

public class MovieLikeDao extends JDBConnect {

	public MovieLikeDao(ServletContext application) {
		super(application);
	}

	public int updateMovie_like(int movie_likenum, String movie_id) {
		int res = 0;
		String sql = "update movie_info set movie_like = movie_like+? where movie_id = ?";
		try {
			(psmt = con.prepareStatement(sql)).setInt(1, movie_likenum);
			psmt.setString(2, movie_id);
			System.out.println(sql);
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("찜 수정 증 예외발생");
			e.printStackTrace();
		}
		return res;
	}

	public int deleteMovie_like(String user_email, String movie_id) {
		int res = 0;
		String sql = "delete from movie_like WHERE user_email =? and movie_id=?";

		try {
			(psmt = con.prepareStatement(sql)).setString(1, user_email);
			psmt.setString(2, movie_id);
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("찜 삭제 증 예외발생");
			e.printStackTrace();
		}
		return res;
	}

	public int selectMovie_like(String user_email, String movie_id) {
		int res = 0;

		String sql = "select count(*) from movie_like where user_email = ? and movie_id = ?";

		try {
			(psmt = con.prepareStatement(sql)).setString(1, user_email);
			psmt.setString(2, movie_id);
			rs = psmt.executeQuery();
			System.out.println("호출");
			if (rs.next()) {
				res = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("찜 조회 중 예외 발생");
			e.printStackTrace();
		}

		return res;
	}

	public int insertMovie_like(String user_email, String movie_id) {
		int res = 0;
		System.out.println(user_email+"/"+movie_id) ;
		String sql = "INSERT INTO movie_like(user_email,movie_id) values(?,?)";

		try {
			(psmt = con.prepareStatement(sql)).setString(1, user_email);
			psmt.setString(2, movie_id);

			res = psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("찜 등록 중 예외 발생");
			e.printStackTrace();
		}
		return res;
	}
	
	public List<MovieDto> selectMyMovieList(String user_email) {
		List<MovieDto> mml = new ArrayList<MovieDto>(); // 결과(게시물 목록)를 담을 변수

		String query = "SELECT ml.*, m.movie_id, m.movie_title, m.movie_img,m.movie_rating FROM movie_like ml INNER JOIN movie_info m ON m.movie_id = ml.movie_id where ml.user_email=?;";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, user_email);
			rs = psmt.executeQuery(); // 쿼리 실행

			while (rs.next()) { // 결과를 순화하며...
				// 한 행(게시물 하나)의 내용을 DTO에 저장
				MovieDto dto = new MovieDto();
				MovieLikeDto mlikedto = new MovieLikeDto();
				mlikedto.setUser_email(rs.getString("user_email"));
				mlikedto.setMovie_likenum(rs.getInt("movie_likenum"));
				mlikedto.setMovie_id(rs.getString("movie_id"));
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setMovie_title(rs.getString("movie_title"));
				dto.setMovie_img(rs.getString("movie_img"));
				dto.setMovie_rating(rs.getString("movie_rating"));
				
				mml.add(dto); // 결과 목록에 저장
			}
		} catch (Exception e) {
			System.out.println("마이페이지 찜목록 조회 중 예외 발생");
			e.printStackTrace();
		}

		return mml;
	}
	
	public int deleteMY_Page_like(String movie_id) {
		int res = 0;
		String sql = "delete from movie_like WHERE movie_id=?";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, movie_id);
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("마이페이지 찜하기 삭제 처리 증 예외발생");
			e.printStackTrace();
		}
		return res;
	}

	public int selectMovie_likeALL(String user_email) {
		int res = 0;

		String sql = "select count(*) from movie_like where user_email = ?";

		try {
			(psmt = con.prepareStatement(sql)).setString(1, user_email);
			psmt.setString(1, user_email);
			rs = psmt.executeQuery();
			System.out.println("호출");
			if (rs.next()) {
				res = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("찜 갯수 조회 중 예외 발생");
			e.printStackTrace();
		}

		return res;
	}
}

