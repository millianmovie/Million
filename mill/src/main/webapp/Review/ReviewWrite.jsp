<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ReviewWrite</title>
<link rel="stylesheet" href="./css/ReviewWrite.css">

</head>
<body>
   <!-- 모달 팝업창 -->
        <div id="RW_Modal" class="RW_Review-modal">
        <div id="overlay"></div>
            <div id="RW_Modal-con">
    <form action="./reviewwrite" method="post" onsubmit="return WriteformCheck(this)">
                <span id="RW_CloseModal" class="RW_CloseBtn">X</span>
                <div class="RW_Reviewtitle">리뷰작성하기</div>
                <div class="msg"></div>
                <input type="hidden" name="movie_id" value="${movie_id }">
                <hr>
                <div id="RW_Contents">
               <div class="RW_Likebox">
                  <div class="RW_Like_all">
                     <input type="radio" name="rating" value="good" id="good"> 
                     <label for="good" class="RW_Like_check">
                        <div class="RW_Speechbubble_left">
                           <img src="etc/good_hot.png" width="30%"> 
                           <span class="RW_Txt">추천해요!</span>
                        </div>
                     </label>
                  </div>
               </div>
                <div id="RW_Miniposter" style="background-image:url(${Movie.movie_img })"></div>
               <div class="RW_Likebox">
                  <div class="RW_Like_all">
                     <input type="radio" name="rating" value="bad" id="bad"> <label
                        for="bad" class="RW_Like_check">
                        <div class="RW_Speechbubble_right">
                           <img src="etc/bad.png" width="30%"> <span class="RW_Txt">별로예요;</span>
                        </div>
                     </label>
                  </div>
               </div>
            </div>
            <div id="RW_Star">
               <span class="RW_Star_score"> ★★★★★ <span>★★★★★</span> 
               <input type="range" id="reviewStar_score" name="star_score" oninput="drawStar(this)" value="0" step="1" min="0" max="10">
               </span>
            </div>
            <hr>
            <div id="RW_Alltitle">
               <img src="etc/큰 따옴표 왼쪽.png" width=35px height=35px> 
               <input id="reviewTitle" name="review_title" placeholder="한줄평을 입력해주세요." type="text" autocomplete="off" maxlength="100">
               <img src="etc/큰 따옴표 오른쪽.png" width=35px height=35px><br> <br>
            </div>
            <div id="RW_Allcontent">
            <img src="etc/왼쪽 대괄호.png" height=120px>
               <textarea id="reviewContent" name="review_content"
                  placeholder="영화에 대한 생각을 입력해주세요." cols="60" rows="5"></textarea>
            <img src="etc/오른쪽 대괄호.png" height=120px>
               <br> <br>
            </div>
            <div id="RW_btn">
               <button type="reset" class="RW_bttn">다시 작성</button>
               <button type="submit" class="RW_bttn">등록</button>
            </div>

         </form>
            </div>
    </div>
    <script> 
    // 별점
       const drawStar = (target) => {
       console.log("드래그 됨");
       let RW_Star_score = document.querySelector('.RW_Star_score span');
       console.log(target);
       console.log(target.value * 10+'%');
       RW_Star_score.style.width = target.value * 10+'%';
    }
    
    // 글쓰기 체크
    
      function WriteformCheck(form) {
         console.log(form.rating.value=="");
         console.log(form.review_content.value);
         
         if(form.rating.value=="") {
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


    // review Write
   // 모달을 열기 위한 버튼을 선택
   const modalBtn = document.getElementById("RL_modal-bttn");

   // 모달 요소를 선택
   const modal = document.getElementById("RW_Modal");
   const modalCon = document.getElementById("RW_Modal-con")

   // 모달 요소 내부의 닫기 버튼을 선택
   const closeBtn = document.getElementById("RW_CloseModal");
   const overlay = document.getElementById("overlay");
   console.log(overlay)
 
   modalBtn.addEventListener("click", function(){

       modal.style.display = "block";
       modalCon.style.display = "block";
       console.log("리뷰작성 클릭")
   }); 
   // 닫기 버튼을 클릭하면 모달이 사라짐
   closeBtn.onclick = function() {
       modal.style.display = "none";
   }
   
  </script>
</body>
</html>