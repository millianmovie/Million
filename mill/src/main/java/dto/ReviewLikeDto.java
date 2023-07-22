package dto;

public class ReviewLikeDto {
	private int like_num;
	private String user_email;
	private int review_num;
	public int getLike_num() {
		return like_num;
	}
	public void setLike_num(int like_num) {
		this.like_num = like_num;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	@Override
	public String toString() {
		return "ReviewLikeDto [like_num=" + like_num + ", user_email=" + user_email + ", review_num=" + review_num
				+ "]";
	}
	public ReviewLikeDto(int like_num, String user_email, int review_num) {
		super();
		this.like_num = like_num;
		this.user_email = user_email;
		this.review_num = review_num;
	}
	public ReviewLikeDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	
}