package dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import common.JDBConnect;
import dto.UserDTO;

public class UserDAO extends JDBConnect {
	public UserDAO(ServletContext application) {
		super(application);
	}
	
	public int insertUser(UserDTO dto) {
		int res = 0;
		
		try {
			String sql = "INSERT INTO user(user_email, user_pwd, user_phone, user_tos, user_name, user_birth, user_gender, user_pwd_hint, user_pwd_hint_answer) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getUser_email());
			psmt.setString(2, dto.getUser_pwd());
			psmt.setString(3, dto.getUser_phone());
			psmt.setString(4, dto.getUser_tos());
			psmt.setString(5, dto.getUser_name());
			psmt.setDate(6, (Date) dto.getUser_birth());
			psmt.setString(7, dto.getUser_gender());
			psmt.setString(8, dto.getUser_pwd_hint());
			psmt.setString(9, dto.getUser_pwd_hint_answer());
			
			res = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("회원정보 등록 중 예외 발생");
			e.printStackTrace();
		}
		finally {
			close();
		}
		
		return res;
	}
	
	public UserDTO selectUser(String user_email) {
		UserDTO dto = null;
		try {
			String query = "SELECT * FROM user WHERE user_email = ?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, user_email);
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				dto = new UserDTO();
				dto.setUser_email(rs.getString(1));
				dto.setUser_pwd(rs.getString(2));
				dto.setUser_phone(rs.getString(3));
				dto.setUser_tos(rs.getString(4));
				dto.setUser_name(rs.getString(5));
				dto.setUser_reg_date(rs.getDate(6));
				dto.setUser_birth(rs.getDate(7));
				dto.setUser_gender(rs.getString(8));
				dto.setUser_pwd_hint(rs.getString(9));
				dto.setUser_pwd_hint_answer(rs.getString(10));
			}
		}
		catch(Exception e) {
			System.out.println("회원 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	public ArrayList<UserDTO> selectAllUser() {
		ArrayList<UserDTO> dtoList = new ArrayList<UserDTO>();
		try {
			String sql = "SELECT * FROM user";
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			UserDTO dto = null;
			while(rs.next()) {
				dto = new UserDTO();
				dto.setUser_email(rs.getString(1));
				dto.setUser_pwd(rs.getString(2));
				dto.setUser_phone(rs.getString(3));
				dto.setUser_tos(rs.getString(4));
				dto.setUser_name(rs.getString(5));
				dto.setUser_reg_date(rs.getDate(6));
				dto.setUser_birth(rs.getDate(7));
				dto.setUser_gender(rs.getString(8));
				dto.setUser_pwd_hint(rs.getString(9));
				dto.setUser_pwd_hint_answer(rs.getString(10));
				dtoList.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("전체 회원정보 조회 중 예외 발생");
			e.printStackTrace();
		}
		finally {
			close();
		}
		
		return dtoList;
	}
	
	public boolean checkEmail(String user_email) {
		psmt = null;
		ResultSet rs = null;
		boolean res = false;
		
		String sql = "SELECT user_email FROM user WHERE user_email = ?";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, user_email);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				res = true;
			}
			else {
				res = false;
			}
			
		}
		catch(SQLException e) {
			System.out.println("전자우편주소 중복 확인 중 예외 발생");
			e.printStackTrace();
		}

		return res;
	}
	
	
	public ArrayList<UserDTO> selectAllAdminUser() {
		ArrayList<UserDTO> dtoList = new ArrayList<UserDTO>();
		try {
			String sql = "SELECT * FROM user  where user_email not in ('admin@naver.com');";
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			UserDTO dto = null;
			while(rs.next()) {
				dto = new UserDTO();
				dto.setUser_email(rs.getString("user_email"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_reg_date(rs.getDate("user_reg_date"));
				dtoList.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("관리자 페이지 전체 회원정보 조회 중 예외 발생");
			e.printStackTrace();
		}
		finally {
			close();
		}
		
		return dtoList;
	}
	
    public List<UserDTO> selectAdminSearchList(String admin_searchWord){ 
        List<UserDTO> bbs = new ArrayList<UserDTO>();  // 결과(게시물 목록)를 담을 변수

        String sql = "SELECT * FROM movie.user WHERE user_email LIKE '%" + admin_searchWord+ "%' OR user_name LIKE '%" + admin_searchWord +"%' order by user_email desc;"; 


        try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();

            while (rs.next()) { 
            	UserDTO dto = new UserDTO(); 

				dto.setUser_email(rs.getString("user_email"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_reg_date(rs.getDate("user_reg_date"));

                bbs.add(dto);  // 결과 목록에 저장
            }
        } 
        catch (Exception e) {
            System.out.println(" 관리자 페이지 유저 검색 조회 중 예외 발생");
            e.printStackTrace();
        }

        return bbs;
    }
    
    public String userEmailFinder(String user_name, String user_phone, Date user_birth) throws Exception {
		String user_email = null;
		
		try {
			String sql = "SELECT user_email FROM user WHERE user_name = ? AND user_phone = ? AND user_birth = ?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, user_name);
			psmt.setString(2, user_phone);
			psmt.setDate(3, user_birth);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				user_email = rs.getString("user.user_email");
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		return user_email;
	}
	
	public String userPasswordFinder(String user_email, String user_pwd_hint, String user_pwd_hint_answer) throws Exception {
		String user_pwd = null;
		
		try {
			String sql = "SELECT user_pwd FROM user WHERE user_email = ? AND user_pwd_hint = ? AND user_pwd_hint_answer = ?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, user_email);
			psmt.setString(2, user_pwd_hint);
			psmt.setString(3, user_pwd_hint_answer);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				user_pwd = rs.getString("user.user_pwd");
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		return user_pwd;
	}
	
	public int updateUserPassword(UserDTO dto) {
		int res = 0;
		
		try {
			String sql = "UPDATE user SET user_pwd = ? WHERE user_email = ?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getUser_pwd());
			psmt.setString(2, dto.getUser_email());
			System.out.println(sql);
			
			res = psmt.executeUpdate();
		}
		catch(SQLException e) {
			System.out.println("암호 변경 중 예외 발생");
			e.printStackTrace();
		}
		
		return res;
	}
	
	public int updateUser(UserDTO dto) {
		int res = 0;
		
		try {
			String sql = "UPDATE user SET user_pwd = ?, user_phone = ?, user_tos = ?, user_name = ?, user_birth = ?, user_gender = ?, user_pwd_hint = ?, user_pwd_hint_answer = ? WHERE user_email = ?";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getUser_pwd());
			psmt.setString(2, dto.getUser_phone());
			psmt.setString(3, dto.getUser_tos());
			psmt.setString(4, dto.getUser_name());
			psmt.setDate(5, (Date) dto.getUser_birth());
			psmt.setString(6, dto.getUser_gender());
			psmt.setString(7, dto.getUser_pwd_hint());
			psmt.setString(8, dto.getUser_pwd_hint_answer());
			psmt.setString(9, dto.getUser_email());
			System.out.println(sql);
			
			res = psmt.executeUpdate();
		}
		catch(SQLException e) {
			System.out.println("회원정보 수정 중 예외 발생");
			e.printStackTrace();
		}
		
		return res;
	}
	
	public int deleteUser(String user_email){
		int res = 0;
		
		try {
			String sql = "DELETE FROM user WHERE user_email = ?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, user_email);
			res = psmt.executeUpdate();
		}
		catch(SQLException e) {
			System.out.println("회원정보 삭제 중 예외 발생");
			e.printStackTrace();
		}
		
		return res;
	}
    

}
