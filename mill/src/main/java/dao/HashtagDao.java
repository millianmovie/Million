package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;


public class HashtagDao extends common.JDBConnect{

	public HashtagDao(ServletContext application) {
		super(application);
	}
	
	public int checkHashtag (String hashtag_name) {
		int res = 0;
		String query = "SELECT COUNT(*) FROM hashtag WHERE hashtag_name=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, hashtag_name);
			rs = psmt.executeQuery();
			if(rs.next()) {
				res = rs.getInt(1);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			close();
		}
		return res;
	}
	
	public int insertHashtag(String hashtag_name) {
		int res = 0;
		String query = "INSERT INTO hashtag(hashtag_name) VALUES(?)";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, hashtag_name);
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("해시태그 추가중 오류 발생");
			e.printStackTrace();
		}
		finally {
			close();
		}
		return res;
	}
	public int updateHashtag(String old_name, String new_name) {
		int res = 0;
		String query = "UPDATE hashtag SET hashtag_name=? WHERE hashtag_name=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, new_name);
			psmt.setString(2, old_name);
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("해시태그 업데이트중 오류 발생");
			e.printStackTrace();
		}
		finally {
			close();
		}
		return res;
	}
	
	public List<Object> selectAllTags () {
		List<Object> hashtagList = new ArrayList<Object>();
		String query = "";
		query += "SELECT * FROM hashtag";
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			while(rs.next()) {
				hashtagList.add(rs.getString("hashtag_num"));
				hashtagList.add(rs.getString("hashtag_name"));
			}
		}
		catch (Exception e) {
	        System.out.println("모든 해시태그 정보 조회 중 예외 발생");
	        e.printStackTrace();
	    }
	    finally {
	    	close();
	    }
		
	    return hashtagList;	
	}
	
	public int selectHashtagNum (String hashtag_name) {
		int hashtag_num = 0;
		String query = "SELECT hashtag_num FROM hashtag WHERE hashtag_name=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, hashtag_name);
			rs = psmt.executeQuery();
			if(rs.next()) {
				hashtag_num = rs.getInt("hashtag_num");
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			close();
		}
		return hashtag_num;
	}
	
	public String selectHashtagName (int hashtag_num) {
		String hashtag_name = null;
		String query = "SELECT hashtag_name FROM hashtag WHERE hashtag_num=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, hashtag_num);
			rs = psmt.executeQuery();
			if(rs.next()) {
				hashtag_name = rs.getString("hashtag_name");
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			close();
		}
		return hashtag_name;
	}
	public int deleteHashtag (int hashtag_num) {
		int res = 0;
		String query = "DELETE FROM hashtag WHERE hashtag_num=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, hashtag_num);
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
}