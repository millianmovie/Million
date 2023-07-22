package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import dto.MovieDto;

public class MovieDao extends common.JDBConnect{
	public MovieDao (ServletContext application) {
		super(application);
	}
    public int checkMovie (String movie_id){
    	int res = 0;
    	String query = "SELECT * FROM movie_info WHERE movie_id=?" ;
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, movie_id);
    		rs = psmt.executeQuery();
    		if(rs.next()) {
    			res = 1;
    		}
    	}
    	catch (Exception e) {
            System.out.println("영화 상세정보 조회 중 예외 발생");
            e.printStackTrace();
        }
        finally {
    		close();
    	}
    	return res;
    }
    
    public int insertMovie(MovieDto m) {
    	int res = 0;
    	try {
    		String query = "INSERT INTO movie_info (movie_id, movie_title, movie_info, movie_img, movie_stills, movie_year, movie_director, movie_actors, movie_rating, movie_genre, movie_runtime) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, m.getMovie_id());
    		psmt.setString(2, m.getMovie_title());
    		psmt.setString(3, m.getMovie_info());
    		psmt.setString(4, m.getMovie_img());
    		psmt.setString(5, m.getMovie_stills());
    		psmt.setString(6, m.getMovie_year());
    		psmt.setString(7, m.getMovie_director());
    		psmt.setString(8, m.getMovie_actors());
    		psmt.setString(9, m.getMovie_rating());
    		psmt.setString(10, m.getMovie_genre());
    		psmt.setString(11, m.getMovie_runtime());
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
    
    //무비id로 상세정보 조회.
    public MovieDto selectMovie (String movie_id){
    	MovieDto dto = null;
    	String query = "SELECT * FROM movie_info WHERE movie_id=?" ;
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, movie_id);
    		rs = psmt.executeQuery();
    		if(rs.next()) {
    			dto = new MovieDto();
    			dto.setMovie_id(rs.getString("movie_id"));
    			dto.setMovie_title(rs.getString("movie_title"));
    			dto.setMovie_info(rs.getString("movie_info"));
    			dto.setMovie_img(rs.getString("movie_img"));
    			dto.setMovie_stills(rs.getString("movie_stills"));
    			dto.setMovie_year(rs.getString("movie_year"));
    			dto.setMovie_director(rs.getString("movie_director"));
    			dto.setMovie_actors(rs.getString("movie_actors"));
    			dto.setMovie_rating(rs.getString("movie_rating"));
    			dto.setMovie_genre(rs.getString("movie_genre"));
    			dto.setMovie_runtime(rs.getString("movie_runtime"));
    		}
    	}
    	catch (Exception e) {
    		System.out.println("DB에 영화가 있는지 확인 중 예외 발생");
            e.printStackTrace();
        }
        finally {
    		close();
    	}
    	return dto;
    }
    
    //장르로 영화조회
    public List<MovieDto> selectMovieListByGenre (String genre){
    	List<MovieDto> movieList = new ArrayList<MovieDto>();
    	String query = "SELECT movie_id, movie_title, movie_img, movie_rating FROM movie_info WHERE movie_genre LIKE ? ORDER BY RAND()";
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, "%"+genre+"%");
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
            System.out.println("장르로 영화정보 조회 중 예외 발생");
            e.printStackTrace();
        }
        finally {
    		close();
    	}
    	return movieList;
    }
    
    //추천장로 영화조회
    public List<MovieDto> selectReccomendMovieListByGenre (String genre1, String genre2){
    	List<MovieDto> movieList = new ArrayList<MovieDto>();
    	String query = "SELECT M.movie_id, M.movie_title, M.movie_img, M.movie_rating"
    			+ " FROM movie.movie_info as M join movie.review R "
    			+ " ON R.movie_id = M.movie_id "
    			+ "WHERE movie_genre LIKE ? or movie_genre Like ?"
    			+ " GROUP BY M.movie_id "
    			+ " ORDER BY COUNT(R.movie_id) DESC;";
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, "%"+genre1+"%");
    		psmt.setString(2, "%"+genre2+"%");
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
            System.out.println("장르로 영화정보 조회 중 예외 발생");
            e.printStackTrace();
        }
        finally {
    		close();
    	}
    	return movieList;
    }
    
    public String selectReccomendByGenre(String movie_id){
    	String genre = null;
    	String query = "SELECT movie_genre FROM movie.movie_info where movie_id=?;";
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, movie_id);
    		
    		rs = psmt.executeQuery();
    		if(rs.next()) {
    			
    			genre=rs.getString("movie_genre");
    		}
    	}
    	catch (Exception e) {
            System.out.println("추천 장르 조회 중 오류 발생");
            e.printStackTrace();
        }
        finally {
    		close();
    	}
    	return genre;
    }
    
    
    
    public List<MovieDto> selectAllMovies (){
    	List<MovieDto> movieList = new ArrayList<MovieDto>();
    	String query = "SELECT movie_id, movie_title, movie_img, movie_rating FROM movie_info";
    	try {
    		psmt = con.prepareStatement(query);
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
            System.out.println("모든 영화의 정보 조회 중 예외 발생");
            e.printStackTrace();
        }
        finally {
    		close();
    	}
    	return movieList;
    }


    
	public int deleteMovie (String movie_id) {
		int res = 0;
		String query = "DELETE FROM movie_info WHERE movie_id=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, movie_id);
			res = psmt.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			close();
		}
		return res;
	}
	
	
	// top20 평점 높은순으로 불러오기
	public List<MovieDto> getTopRatedMovies() {
        List<MovieDto> top20List = new ArrayList<MovieDto>();

        try  {
        	String sql = "SELECT M.movie_id, M.movie_title, M.movie_img, M.movie_rating, V.total_score "
                    + "FROM movie_info M "
                    + "JOIN v4 V ON M.movie_id = V.movie_id "
                    + "ORDER BY V.total_score DESC LIMIT 20";
        	
        	psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery(); // 쿼리 실행

            while (rs.next()) {
            	MovieDto dto = new MovieDto();
                dto.setMovie_id(rs.getString(1));
                dto.setMovie_title(rs.getString(2));
                dto.setMovie_img(rs.getString(3));
                dto.setMovie_rating(rs.getString(4));
                dto.setTotal_score(rs.getInt(5));
                System.out.println("dto : " + dto);
                top20List.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
        	close();
        }

        return top20List;
    }

}