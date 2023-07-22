package dto;

import java.util.Date;

public class BoardDto {
	
	private int num;
	private String user_email;
	private String title;
	private String content;
	private Date post_date;
	private String secret;
	
	@Override
	public String toString() {
		return "BoardDto [num=" + num + ", user_email=" + user_email + ", title=" + title + ", content=" + content
				+ ", post_date=" + post_date + ", secret=" + secret + "]";
	}

	public BoardDto(String user_email, String title, String content, String secret) {
		super();
		this.user_email = user_email;
		this.title = title;
		this.content = content;
		this.secret = secret;
	}

	public BoardDto() {
		super();
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getPost_date() {
		return post_date;
	}

	public void setPost_date(Date post_date) {
		this.post_date = post_date;
	}

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

}