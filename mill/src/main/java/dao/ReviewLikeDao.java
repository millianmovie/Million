package dao;

import java.sql.SQLException;

import javax.servlet.ServletContext;

import common.JDBConnect;
import dto.ReviewDto;
import dto.ReviewLikeDto;



public class ReviewLikeDao extends JDBConnect {
	
	public ReviewLikeDao(ServletContext application) {
		super(application);
	}
	
	public ReviewLikeDao() {
		super();
	}
	
    public int updateReview_like(int like, int review_num) {
    	int res = 0;
    	String sql = "update review set review_like_num = review_like_num+? where review_num = ?";
    	try {
			(psmt = con.prepareStatement(sql)).setInt(1,like);
			psmt.setInt(2, review_num);
			System.out.println(sql);
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("좋아요 추가 처리 증 예외발생");
			e.printStackTrace();
		}
    	return res;
    }

    public int deleteReview_like(String user_email, int review_num) {
    	int res = 0;
    	String sql ="delete from review_like WHERE user_email =? and review_num=?";
    	
    	try {
    		(psmt = con.prepareStatement(sql)).setString(1,user_email);
			psmt.setInt(2, review_num);
			res = psmt.executeUpdate();
		}
		catch(SQLException e) {
			System.out.println("좋아요 삭제 처리 증 예외발생");
			e.printStackTrace();
		}
		return res;
    }
    
    public int selectReview_like(String user_email, int review_num){ 
    	int res = 0;

        String sql = "select count(*) from review_like where user_email = ? and review_num = ?";
        
        try {
        	(psmt = con.prepareStatement(sql)).setString(1,user_email);
        	psmt.setInt(2, review_num);
			rs = psmt.executeQuery();
			System.out.println("호출");
            if(rs.next()) {  
                res = rs.getInt(1);
            }
        } 
        catch (SQLException e) {
            System.out.println("좋아요 조회 중 예외 발생");
            e.printStackTrace();
        }

        return res;
    }
    
	 public int insertReview_like(String user_email, int review_num) {
	    	int res = 0;
	    	
	    	String sql ="INSERT INTO review_like(user_email,review_num) values(?,?)";
			
	    	try {
	    		(psmt = con.prepareStatement(sql)).setString(1,user_email);
				psmt.setInt(2, review_num);
				
				res = psmt.executeUpdate();
			}
			catch(SQLException e) {
				System.out.println("좋아요 등록 중 예외 발생");
				e.printStackTrace();
			}
			return res;
		}
	 
		public int selectAllLike(int review_num) {
			int res = 0;
			
			String sql = "SELECT COUNT(*) FROM review_like where review_num=?";
			
			System.out.println(sql);
			
			try {
				(psmt = con.prepareStatement(sql)).setInt(1,review_num);
		            rs = psmt.executeQuery();
		            if(rs.next())
		            	res = rs.getInt(1);
			}
			catch(Exception e) {
				System.out.println("전체좋아 수를 구하는 중 예외 발생");
				e.printStackTrace();
			}
			return res;
		}
 

}