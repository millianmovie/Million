package dao;

import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.ServletContext;

import common.JDBConnect;
import dto.ReccomendDto;

public class RecomendDao extends JDBConnect  {
	
	public RecomendDao(ServletContext application) {
		super(application);
	}
	
	public ArrayList<ReccomendDto> selectRecommendList(String user_email) {
		ArrayList<ReccomendDto> rList = new ArrayList<ReccomendDto>(); // 결과(게시물 목록)를 담을 변수
		ArrayList<Integer> maxTotal = new ArrayList<Integer>();
		
		String query = "select * from v3 where user_email=?;";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, user_email);
			rs = psmt.executeQuery(); // 쿼리 실행
			int tmp = 0 ;
			while (rs.next()) { // 결과를 순화하며...
				// 한 행(게시물 하나)의 내용을 DTO에 저장
				tmp=0;
				ReccomendDto dto = new ReccomendDto();
				dto.setUser_email(rs.getString("user_email"));
				dto.setReview_num(rs.getString("review_num")); 
				dto.setMovie_id(rs.getString("movie_id")); 
				dto.setRating(rs.getString("rating"));
				dto.setMovie_likenum(rs.getString("movie_likenum"));
				
				if(rs.getString("review_num") != null) {
					tmp +=20;
					if(rs.getString("rating").equals("good")) {
						tmp +=10;
					}
					else if(rs.getString("rating").equals("bad")) {
						tmp-=10;
					}
					else if(rs.getString("movie_likenum") != null) {
						tmp+=10;
					}
				}
				
				dto.setTotalScore(tmp);
				rList.add(dto); // 결과 목록에 저장
				maxTotal.add(tmp);
			
			}
			 int max = Collections.max(maxTotal);
			 int max_index = maxTotal.indexOf(max);
			 ReccomendDto t = rList.get(max_index);
			 rList.add(t);
		} catch (Exception e) {
			System.out.println("추천목 조회 중 예외 발생");
			e.printStackTrace();
		}

		return rList;
	}
}
