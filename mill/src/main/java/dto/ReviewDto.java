package dto;

import java.util.Date;

import dao.ReviewLikeDao;

public class ReviewDto {
   private int review_num;
   private String movie_id;
   private String user_email;
   private String user_name;
   private String movie_title;
   private String movie_img;
   public String getMovie_img() {
	return movie_img;
}
public void setMovie_img(String movie_img) {
	this.movie_img = movie_img;
}

private String review_title;
   private String review_content;
   private String rating;
   private double star_score;
   private Date review_post_date;
   private int review_like_num;
   private String user_gender;
   
   
   public int getReview_num() {
      return review_num;
   }
   public void setReview_num(int review_num) {
      this.review_num = review_num;
   }
   public String getMovie_id() {
      return movie_id;
   }
   public void setMovie_id(String movie_id) {
      this.movie_id = movie_id;
   }
   public String getUser_email() {
      return user_email;
   }
   public void setUser_email(String user_email) {
      this.user_email = user_email;
   }
   public String getUser_name() {
      return user_name;
   }
   public void setUser_name(String user_name) {
      this.user_name = user_name;
   }
   public String getReview_title() {
      return review_title;
   }
   public void setReview_title(String review_title) {
      this.review_title = review_title;
   }
   public String getReview_content() {
      return review_content;
   }
   public void setReview_content(String review_content) {
      this.review_content = review_content;
   }
   public String getRating() {
      return rating;
   }
   public void setRating(String rating) {
      this.rating = rating;
   }

   public double getStar_score() {
      return star_score;
   }
   public void setStar_score(double star_score) {
      this.star_score = star_score;
   }
   public Date getReview_post_date() {
      return review_post_date;
   }
   public void setReview_post_date(Date review_post_date) {
      this.review_post_date = review_post_date;
   }

   public int getReview_like_num() {
      return review_like_num;
   }
   public void setReview_like_num(int review_like_num) {
      this.review_like_num = review_like_num;
   }
   
   public ReviewDto() {
      super();
      // TODO Auto-generated constructor stub
   }
   public String getUser_gender() {
      return user_gender;
   }
   public void setUser_gender(String user_gender) {
      this.user_gender = user_gender;
   }
   
   
   
   public ReviewDto(int review_num, String movie_id, String movie_title, String review_title, String review_content,
		double star_score) {
	super();
	this.review_num = review_num;
	this.movie_id = movie_id;
	this.movie_title = movie_title;
	this.review_title = review_title;
	this.review_content = review_content;
	this.star_score = star_score;
}
public ReviewDto(int review_num, String movie_id, String user_email, String user_name, String movie_title,
		String review_title, String review_content, String rating, double star_score, Date review_post_date,
		int review_like_num, String user_gender) {
	super();
	this.review_num = review_num;
	this.movie_id = movie_id;
	this.user_email = user_email;
	this.user_name = user_name;
	this.movie_title = movie_title;
	this.review_title = review_title;
	this.review_content = review_content;
	this.rating = rating;
	this.star_score = star_score;
	this.review_post_date = review_post_date;
	this.review_like_num = review_like_num;
	this.user_gender = user_gender;
}
@Override
public String toString() {
	return "ReviewDto [review_num=" + review_num + ", movie_id=" + movie_id + ", user_email=" + user_email
			+ ", user_name=" + user_name + ", movie_title=" + movie_title + ", review_title=" + review_title
			+ ", review_content=" + review_content + ", rating=" + rating + ", star_score=" + star_score
			+ ", review_post_date=" + review_post_date + ", review_like_num=" + review_like_num + ", user_gender="
			+ user_gender + "]";
}
public String getMovie_title() {
	return movie_title;
}
public void setMovie_title(String movie_title) {
	this.movie_title = movie_title;
}
// reviewInsert
   public ReviewDto(String movie_id, String user_email, String review_title, String review_content,
         String rating, double star_score) {
      super();
      this.movie_id = movie_id;
      this.user_email = user_email;
      this.review_title = review_title;
      this.review_content = review_content;
      this.rating = rating;
      this.star_score = star_score;
   }
   
   public int getReview_like_num(String user_email, int review_num) {
      ReviewLikeDao dao = new ReviewLikeDao();
      return dao.selectReview_like(user_email, review_num);
   }
   
   // reviewUpdate
   public ReviewDto(int review_num, String movie_id, String user_email, String review_title,
         String review_content, String rating, double star_score) {
      super();
      this.review_num = review_num;
      this.movie_id = movie_id;
      this.user_email = user_email;
      this.review_title = review_title;
      this.review_content = review_content;
      this.rating = rating;
      this.star_score = star_score;
   }

   
   
   
   
   
   
   
   
   
   
   
   

}
