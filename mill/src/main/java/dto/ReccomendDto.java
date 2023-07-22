package dto;

public class ReccomendDto {
	private String review_num;
	private String movie_id;
	private String rating;
	private String user_email;
	private String movie_likenum;
	private int totalScore;
	
	public String getReview_num() {
		return review_num;
	}
	public void setReview_num(String review_num) {
		this.review_num = review_num;
	}
	public String getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getMovie_likenum() {
		return movie_likenum;
	}
	public void setMovie_likenum(String movie_likenum) {
		this.movie_likenum = movie_likenum;
	}
	public int getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(int totalScore) {
		this.totalScore = totalScore;
	}
	@Override
	public String toString() {
		return "ReccomendDto [review_num=" + review_num + ", movie_id=" + movie_id + ", rating=" + rating
				+ ", user_email=" + user_email + ", movie_likenum=" + movie_likenum + ", totalScore=" + totalScore
				+ "]";
	}
	public ReccomendDto(String review_num, String movie_id, String rating, String user_email, String movie_likenum,
			int totalScore) {
		super();
		this.review_num = review_num;
		this.movie_id = movie_id;
		this.rating = rating;
		this.user_email = user_email;
		this.movie_likenum = movie_likenum;
		this.totalScore = totalScore;
	}
	public ReccomendDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	

	
	
}
