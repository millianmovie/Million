<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ReviewEdit</title>
<link rel="stylesheet" href="./css/My_Review_edit.css">
</head>
<body>
   <!-- 모달 팝업창 -->

        <div id="editedit${review_list_dto.review_num }" class="RE_Modal">
            <div class="RE_Modal-con">
             <form class="review_edit" action="./myPageReviewEdit?review_num=${review_list_dto.review_num }" method="post" onsubmit="return editReviewformCheck(this)">
                <span class="RE_CloseModal RE_CloseBtn">X</span>
                <div class="RE_Reviewtitle">리뷰수정하기</div>
                <input type="hidden" name="movie_id" value="${movie_id }">
                <input type="hidden" name="user_email" value="${user_email }"> <!-- 있어야함. updateContoller에서 필요 -->
                <hr>
                <div class="RE_Contents">
               <div class="RE_Likebox">
                  <div class="RE_Like_all">
                     <input type="radio" name="rating" value="good" id="ratingGood" class="rating RE_Good" ${review_list_dto.rating eq 'good' ? 'checked' : '' }> 
                     <label for="ratingGood" class="RE_Like_check">
                        <div class="RE_Rating_left">
                           <img src="etc/good_hot.png" width="30%"> 
                           <span class="RE_Txt">추천해요!</span>
                        </div>
                     </label>
                  </div>
               </div>
               <div id="RE_Miniposter" style="background-image:url(${review_list_dto.movie_img })"></div>
               <div class="RE_Likebox">
                  <div class="RE_Like_all">
                     <input type="radio" name="rating" value="bad" id="ratingBad" class="rating RE_Bad" ${review_list_dto.rating eq 'bad' ? 'checked' : '' }> 
                     <label for="ratingBad" class="RE_Like_check">
                        <div class="RE_Rating_right">
                           <img src="etc/bad.png" width="30%"> <span class="RE_Txt">별로예요;</span>
                        </div>
                     </label>
                  </div>
               </div>
            </div>
            
            <div class="RE_Star">
               <span class="RE_Star_score" id="RE_Star_score${review_list_dto.review_num }"> ★★★★★ 
                     <span id="RE_span${review_list_dto.review_num }" style="width:${review_list_dto.star_score*10 }%">★★★★★</span> 
                     <input type="range" id="editStar_score ${review_list_dto.review_num }" name="star_score" oninput="editDrawStar(this)" value="${review_list_dto.star_score}" step="1" min="0" max="10">
               </span>
            </div>
            <hr>
            <div class="RE_Alltitle">
               <img src="./etc/큰 따옴표 왼쪽.png" width="35px" height="35px"> 
               <input id="editTitle ${review_list_dto.review_num }" class="RE_Title" name="review_title" placeholder="한줄평을 입력해주세요." type="text"  value="${review_list_dto.review_title}" autocomplete="off" maxlength="100">
               <img src="./etc/큰 따옴표 오른쪽.png" width="35px" height="35px"><br> <br>
            </div>
            <div class="RE_Allcontent">
               <img src="etc/왼쪽 대괄호.png" height=120px>
               <textarea id="editContent ${review_list_dto.review_num }" class="RE_Content" name="review_content"
                  placeholder="영화에 대한 생각을 입력해주세요." cols="60" rows="5">${review_list_dto.review_content}</textarea>
               <img src="etc/오른쪽 대괄호.png" height=120px>
               <br> <br>
            </div>
            <div id="RE_Btn">
               <button type="reset" class="RE_Bttn" id="reset">다시 작성</button>
               <button type="submit" class="RE_Bttn">등록</button>
            </div>

            </form>
            </div>
    </div>
    <script>
    // 별점
       var editDrawStar = (target) => {
       console.log("드래그 됨");
       let RE_Star_score  = target.parentNode.firstChild.nextSibling  ;
       console.log(RE_Star_score)
      
       console.log(target.value * 10+'%');
       RE_Star_score.style.width = target.value * 10+'%';
       console.log("RE_Star_score.style.width", RE_Star_score.style.width);
  
    }
   
       // 글쓰기 체크
      function editReviewformCheck(form) {
         console.log(form.review_title.value);
         console.log(form.review_content.value);
         
         if(form.rating.value=="") {
//             setMessage("항목을 선택해주세요." , form.rating);
             alert("항목을 선택해주세요.");
             return false;
          }
         if(form.star_score.value==0) {
            alert("별점을 입력하세요.");
            return false;
         }
         if(form.review_title.value.trim()=="") {
            alert("제목을 입력하세요.");
            form.review_title.focus();
            return false;
         }
         if(form.review_content.value.trim()=="") {
            alert("내용을 입력하세요.");
            form.review_content.focus();
            return false;
         }
         return true;
      }

    </script>
</body>
</html>