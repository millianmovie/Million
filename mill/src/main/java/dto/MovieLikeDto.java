package dto;

public class MovieLikeDto {
	private int movie_likenum;
	private String user_email;
	private String movie_id;
	public int getMovie_likenum() {
		return movie_likenum;
	}
	public void setMovie_likenum(int movie_likenum) {
		this.movie_likenum = movie_likenum;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}
	@Override
	public String toString() {
		return "MovieLikeDto [movie_likenum=" + movie_likenum + ", user_email=" + user_email + ", movie_id=" + movie_id
				+ "]";
	}
	public MovieLikeDto(int movie_likenum, String user_email, String movie_id) {
		super();
		this.movie_likenum = movie_likenum;
		this.user_email = user_email;
		this.movie_id = movie_id;
	}
	public MovieLikeDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
