package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import common.JDBConnect;
import dto.MovieDto;
import dto.ReviewDto;

public class ReviewDao extends JDBConnect {

	public ReviewDao(ServletContext application) {
		super(application);
	}

	public int selectCount(String movie_id) {
		int totalCount = 0;
		String query = "SELECT COUNT(*) FROM review WHERE movie_id=? ORDER BY movie_id DESC";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, movie_id);
			rs = psmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}

	// 검색 조건에 맞는 게시물 목록을 반환합니다.
	public List<ReviewDto> selectList(String movie_id) {
		List<ReviewDto> bbs = new ArrayList<ReviewDto>(); // 결과(게시물 목록)를 담을 변수

		String query = "SELECT r.* , u.user_gender,u.user_name FROM movie.review AS r INNER JOIN user AS u ON u.user_email = r.user_email where movie_id=? order by review_num desc;";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, movie_id);
			rs = psmt.executeQuery(); // 쿼리 실행

			while (rs.next()) { // 결과를 순화하며...
				// 한 행(게시물 하나)의 내용을 DTO에 저장
				ReviewDto dto = new ReviewDto();
				dto.setUser_email(rs.getString("user_email"));
				dto.setReview_num(rs.getInt("review_num")); // 일련번호
				dto.setReview_title(rs.getString("review_title")); // 제목
				dto.setReview_content(rs.getString("review_content")); // 내용
				dto.setReview_post_date(rs.getTimestamp("review_post_date")); // 작성일
				dto.setUser_name(rs.getString("user_name"));
				dto.setRating(rs.getString("rating"));
				dto.setStar_score(rs.getInt("star_score"));
				dto.setReview_like_num(rs.getInt("review_like_num"));
				dto.setUser_gender(rs.getString("user_gender"));
				bbs.add(dto); // 결과 목록에 저장
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}

		return bbs;
	}
	
	public List<ReviewDto> selectMyList(String user_email) {
		List<ReviewDto> mrl = new ArrayList<ReviewDto>(); // 결과(게시물 목록)를 담을 변수

		String query = "SELECT r.*, m.movie_title, m.movie_img FROM movie.review AS r INNER JOIN movie_info AS m ON m.movie_id = r.movie_id where r.user_email=?;";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, user_email);
			rs = psmt.executeQuery(); // 쿼리 실행

			while (rs.next()) { // 결과를 순화하며...
				// 한 행(게시물 하나)의 내용을 DTO에 저장
				ReviewDto dto = new ReviewDto();
				dto.setUser_email(rs.getString("user_email"));
				dto.setReview_num(rs.getInt("review_num")); // 일련번호
				dto.setMovie_title(rs.getString("movie_title")); // 제목
				dto.setMovie_img(rs.getString("movie_img")); // 제목
				dto.setReview_title(rs.getString("review_title")); // 제목
				dto.setReview_content(rs.getString("review_content")); // 내용
				dto.setReview_post_date(rs.getTimestamp("review_post_date")); // 작성일
				dto.setRating(rs.getString("rating"));
				dto.setStar_score(rs.getInt("star_score"));
				dto.setReview_like_num(rs.getInt("review_like_num"));
				mrl.add(dto); // 결과 목록에 저장
			}
		} catch (Exception e) {
			System.out.println("마이페이지 리뮤목록 조회 중 예외 발생");
			e.printStackTrace();
		}

		return mrl;
	}
	

	 public int insertWrite(ReviewDto dto) {
         int res = 0;
         
         String sql ="INSERT INTO review(review_title, review_content, user_email, rating, star_score, movie_id) values(?, ?, ?, ?, ?, ?)";
        
         try {
           psmt = con.prepareStatement(sql);
           psmt.setString(1, dto.getReview_title());
           psmt.setString(2, dto.getReview_content());
           psmt.setString(3, dto.getUser_email());
           psmt.setString(4, dto.getRating());
           psmt.setDouble(5, dto.getStar_score());
           psmt.setString(6, dto.getMovie_id());
           
           
           res = psmt.executeUpdate();
        }
        catch(SQLException e) {
           System.out.println("리뷰 작성 중 예외 발생");
           e.printStackTrace();
        }
        return res;
     }
	 
	    // 리뷰 존재 여부를 확인하는 메서드
     public boolean checkExistingReview(String movie_id, String user_email) {
        String query = "SELECT COUNT(*) FROM review WHERE movie_id = ? AND user_email = ?";

        try {
           psmt = con.prepareStatement(query);
           psmt.setString(1, movie_id);
           psmt.setString(2, user_email);
           rs = psmt.executeQuery();

           if (rs.next()) {
              int count = rs.getInt(1);
              return count > 0;
           }
        } catch (SQLException e) {
           System.out.println("중복 리뷰 조회 중 예외 발생");
           e.printStackTrace();
        } finally {
           closeResources(con, psmt, rs);
        }

        return false;
     }

     private void closeResources(Connection con, PreparedStatement psmt, ResultSet rs) {   
  	}
     private Connection getConnection() {
     return null;
  }


	public ReviewDto selectView(int review_num) {
		ReviewDto dto = null;

		String sql = "SELECT R.*, U.user_name " + "FROM user U INNER JOIN review R" + " ON U.user_email = R.user_email"
				+ " WHERE review_num=?";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, review_num);
			rs = psmt.executeQuery();
			System.out.println("호출");
			if (rs.next()) {
				dto = new ReviewDto();
				dto.setUser_email(rs.getString("R.user_email"));
				System.out.println("db조회 이메일 : " + rs.getString("R.user_email"));
				dto.setReview_num(rs.getInt("review_num"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setReview_title(rs.getString("review_title"));
				dto.setReview_content(rs.getString("review_content"));
				dto.setRating(rs.getString("rating"));
				dto.setStar_score(rs.getInt("star_score"));
				dto.setReview_post_date(rs.getTimestamp("review_post_date"));
				dto.setReview_like_num(rs.getInt("review_like_num"));
				dto.setMovie_id(rs.getString("movie_id"));

			}
		} catch (SQLException e) {
			System.out.println("리뷰 조회 중 예외 발생");
			e.printStackTrace();
		}

		return dto;
	}

	public int selectStar_score(String movie_id) {

		int res = 0;

		String sql = "select round(avg(star_score),1)from review " + " where movie_id=? group by movie_id";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, movie_id);
			rs = psmt.executeQuery();

			if (rs.next()) {

				res = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("평점 평균 구하는 중 예외 발생");
			e.printStackTrace();
		}

		return res;
	}

	public int updateEdit(ReviewDto dto) {
		int res = 0;
		String sql = "UPDATE review SET review_title=?, review_content=?, rating=?, star_score=?, user_email=? WHERE review_num=?";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getReview_title());
			psmt.setString(2, dto.getReview_content());
			psmt.setString(3, dto.getRating());
			psmt.setDouble(4, dto.getStar_score());

			psmt.setString(5, dto.getUser_email());
			psmt.setInt(6, dto.getReview_num());
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("수정 처리 중 예외 발생");
			e.printStackTrace();
		}
		return res;
	}

	public int deleteView(int review_num) {
		int res = 0;
		String sql = "delete from review WHERE review_num=?";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, review_num);
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("삭제 처리 증 예외발생");
			e.printStackTrace();
		}
		return res;
	}
	
	public int selectCountAll(String user_email) {
		int totalCount = 0;
		String query = "SELECT COUNT(*) FROM review WHERE user_email=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, user_email);
			rs = psmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("리뷰 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	

}