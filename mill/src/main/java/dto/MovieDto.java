package dto;

public class MovieDto {
	private String movie_id;
	private String movie_title;
	private String movie_info;
	private String movie_img;
	private String movie_stills;
	private String movie_year;
	private String movie_director;
	private String movie_actors;
	private String movie_rating;
	private String movie_genre;
	private String movie_runtime;
	private int movie_like;
	private int total_score;
	
	


	public int getTotal_score() {
		return total_score;
	}

	public void setTotal_score(int total_score) {
		this.total_score = total_score;
	}

	public MovieDto() {
		super();
	}
	
	public String getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}
	public String getMovie_title() {
		return movie_title;
	}
	public void setMovie_title(String movie_title) {
		this.movie_title = movie_title;
	}
	public String getMovie_info() {
		return movie_info;
	}
	public void setMovie_info(String movie_info) {
		this.movie_info = movie_info;
	}
	public String getMovie_img() {
		return movie_img;
	}
	public void setMovie_img(String movie_img) {
		this.movie_img = movie_img;
	}
	public String getMovie_stills() {
		return movie_stills;
	}
	public void setMovie_stills(String movie_stills) {
		this.movie_stills = movie_stills;
	}
	public String getMovie_year() {
		return movie_year;
	}
	public void setMovie_year(String movie_year) {
		this.movie_year = movie_year;
	}
	public String getMovie_director() {
		return movie_director;
	}
	public void setMovie_director(String movie_director) {
		this.movie_director = movie_director;
	}
	public String getMovie_actors() {
		return movie_actors;
	}
	public void setMovie_actors(String movie_actors) {
		this.movie_actors = movie_actors;
	}
	public String getMovie_rating() {
		return movie_rating;
	}
	public void setMovie_rating(String movie_rating) {
		this.movie_rating = movie_rating;
	}
	public String getMovie_genre() {
		return movie_genre;
	}
	public void setMovie_genre(String movie_genre) {
		this.movie_genre = movie_genre;
	}

	public String getMovie_runtime() {
		return movie_runtime;
	}

	public void setMovie_runtime(String movie_runtime) {
		this.movie_runtime = movie_runtime;
	}

	public int getMovie_like() {
		return movie_like;
	}

	public void setMovie_like(int movie_like) {
		this.movie_like = movie_like;
	}

	@Override
	public String toString() {
		return "MovieDto [movie_id=" + movie_id + ", movie_title=" + movie_title + ", movie_info=" + movie_info
				+ ", movie_img=" + movie_img + ", movie_stills=" + movie_stills + ", movie_year=" + movie_year
				+ ", movie_director=" + movie_director + ", movie_actors=" + movie_actors + ", movie_rating="
				+ movie_rating + ", movie_genre=" + movie_genre + ", movie_runtime=" + movie_runtime + ", movie_like="
				+ movie_like + ", total_score=" + total_score + "]";
	}

	public MovieDto(String movie_id, String movie_title, String movie_info, String movie_img, String movie_stills,
			String movie_year, String movie_director, String movie_actors, String movie_rating, String movie_genre,
			String movie_runtime, int movie_like) {
		super();
		this.movie_id = movie_id;
		this.movie_title = movie_title;
		this.movie_info = movie_info;
		this.movie_img = movie_img;
		this.movie_stills = movie_stills;
		this.movie_year = movie_year;
		this.movie_director = movie_director;
		this.movie_actors = movie_actors;
		this.movie_rating = movie_rating;
		this.movie_genre = movie_genre;
		this.movie_runtime = movie_runtime;
		this.movie_like = movie_like;
	}


	public MovieDto(String movie_id, String movie_title, String movie_img, String movie_rating, int total_score) {
		super();
		this.movie_id = movie_id;
		this.movie_title = movie_title;
		this.movie_img = movie_img;
		this.movie_rating = movie_rating;
		this.total_score = total_score;
	}
	
	
	
	
}