package movieController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SearchListController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String tempSearchWord = req.getParameter("searchWord");

		String searchWord = URLEncoder.encode(tempSearchWord,"UTF-8");
		String serviceKey = "675Q32PC1C3TF79WOGF1";
		String apiURL = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y&listCount=300";
		String apiParam = "&ServiceKey=" + serviceKey + "&query=" + searchWord;
		apiURL += apiParam;
		System.out.println("searchWord:" + searchWord);
		//tempSearchWord가 null이면 제출버튼 disabled
		
		req.setAttribute("searchWord", searchWord);
		req.setAttribute("apiRes", callApi(apiURL));
		req.getRequestDispatcher("./Movie/SearchMovieList.jsp").forward(req, resp);

	}
	
	private StringBuilder callApi (String apiURL) {
		StringBuilder responseApiResult = null;
		try {
			URL url = new URL(apiURL);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			connection.connect();
			
			int responseCode = connection.getResponseCode();
			if (responseCode != 200) {
				throw new RuntimeException("Failed with HTTP error code: " + responseCode);
			}
			BufferedReader inputReader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String line;
			responseApiResult = new StringBuilder();
			while ((line = inputReader.readLine()) != null) {
				responseApiResult.append(line);
			}
			inputReader.close();
			connection.disconnect();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return responseApiResult;
	}
	
	private String encodeString (String wordToEncode) throws UnsupportedEncodingException {
		wordToEncode = URLEncoder.encode(wordToEncode,"UTF-8");
		return wordToEncode;
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String serviceKey = "675Q32PC1C3TF79WOGF1";
		String apiURL = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y&listCount=300&ServiceKey=" + serviceKey;
		
		String actor = req.getParameter("actor");		
		String actorId = req.getParameter("actorId");
		String director = req.getParameter("director");
		String directorId = req.getParameter("directorId");
		String director2 = req.getParameter("director2");
		String directorId2 = req.getParameter("director2Id");
		
		System.out.println(director2);
		
		if(actor != null) {
			actor = encodeString(actor);
			actorId = encodeString(actorId);
			req.setAttribute("actor", actor);
			req.setAttribute("actorId", actorId);
			apiURL += "&actor=" + actor;
//			System.out.println(callApi(apiURL));
			req.setAttribute("apiRes", callApi(apiURL));
			req.getRequestDispatcher("./Movie/SearchMovieList.jsp").forward(req, resp);
			return;
		} else {
			System.out.println("else문");
			director = encodeString(director);
			directorId = encodeString(directorId);
			
			if(director2!=null && directorId2!=null ) {
			director2 = encodeString(director2);
			directorId2 = encodeString(directorId2);
			req.setAttribute("directorId2", directorId2);
			}
			
			req.setAttribute("directorId", directorId);
			apiURL += "&director=" + director;
			req.setAttribute("apiRes", callApi(apiURL));
			resp.setContentType("application/json; charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.write(callApi(apiURL).toString());
//			out.println(callApi(apiURL));
		}
		
	}

	
	
}