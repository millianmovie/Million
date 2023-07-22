package dto;

public class HashTagDto {
	private int hashtag_num;
	private String hashtag_name;
	
	
	public int getHashtag_num() {
		return hashtag_num;
	}
	public void setHashtag_num(int hashtag_num) {
		this.hashtag_num = hashtag_num;
	}
	public String getHashtag_name() {
		return hashtag_name;
	}
	public void setHashtag_name(String hashtag_name) {
		this.hashtag_name = hashtag_name;
	}
	
	
	public HashTagDto(int hashtag_num, String hashtag_name) {
		super();
		this.hashtag_num = hashtag_num;
		this.hashtag_name = hashtag_name;
	}

	public HashTagDto() {}
	
	@Override
	public String toString() {
		return "HashTagDto [hashtag_num=" + hashtag_num + ", hashtag_name=" + hashtag_name + "]";
	}
	
	
}
