package dto;

import java.util.Date;

public class UserDTO {
	private String user_email;
	private String user_pwd;
	private String user_phone;
	private String user_tos;
	private String user_name;
	private Date user_reg_date;
	private Date user_birth;
	private String user_gender;
	private String user_pwd_hint;
	private String user_pwd_hint_answer;
	
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_tos() {
		return user_tos;
	}
	public void setUser_tos(String user_tos) {
		this.user_tos = user_tos;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public Date getUser_reg_date() {
		return user_reg_date;
	}
	public void setUser_reg_date(Date user_reg_date) {
		this.user_reg_date = user_reg_date;
	}
	public Date getUser_birth() {
		return user_birth;
	}
	public void setUser_birth(Date user_birth) {
		this.user_birth = user_birth;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public String getUser_pwd_hint() {
		return user_pwd_hint;
	}
	public void setUser_pwd_hint(String user_pwd_hint) {
		this.user_pwd_hint = user_pwd_hint;
	}
	public String getUser_pwd_hint_answer() {
		return user_pwd_hint_answer;
	}
	public void setUser_pwd_hint_answer(String user_pwd_hint_answer) {
		this.user_pwd_hint_answer = user_pwd_hint_answer;
	}
	
	public UserDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public UserDTO(String user_email, String user_pwd) {
		super();
		this.user_email = user_email;
		this.user_pwd = user_pwd;
	}
	
	public UserDTO(String user_email, String user_pwd, String user_phone, String user_tos, String user_name,
			Date user_birth, String user_gender, String user_pwd_hint, String user_pwd_hint_answer) {
		super();
		this.user_email = user_email;
		this.user_pwd = user_pwd;
		this.user_phone = user_phone;
		this.user_tos = user_tos;
		this.user_name = user_name;
		this.user_birth = user_birth;
		this.user_gender = user_gender;
		this.user_pwd_hint = user_pwd_hint;
		this.user_pwd_hint_answer = user_pwd_hint_answer;
	}
	
	@Override
	public String toString() {
		return "UserDTO [user_email=" + user_email + ", user_pwd=" + user_pwd
				+ ", user_phone=" + user_phone + ", user_tos=" + user_tos + ", user_name=" + user_name
				+ ", user_reg_date=" + user_reg_date + ", user_birth=" + user_birth + ", user_gender=" + user_gender + ", user_pwd_hint=" + user_pwd_hint
				+ ", user_pwd_hint_answer=" + user_pwd_hint_answer + "]";
	}
}
