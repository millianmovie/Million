<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>리뷰 상세보기</title>
<link rel="stylesheet" href="./css/ReviewView.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<style>
</style>

<body>
   <div class="RV_modal${dto.review_num } RV_myModal">
      <div class="RV_modal-content">
         <input type="hidden" name="movie_id" value="${movie_id }">
         <span class="RV_close">X</span>
         <div class="RV_title">${dto.review_title }</div>
         <div class="RV_name">${dto.user_name }</div>
         <div class="RV_one_line">
            <div class="RV_date">${dto.review_post_date }</div>
            <div class="RV_star_rating">⭐ ${dto.star_score }</div>
            <div class="RV_review_like_num">${ch = dto.getReview_like_num(user_email, dto.review_num)==1 }</div>
            <c:choose>
               <c:when test='${ch}'>
                  <button class='RV_like_logo' onclick='unlike2(this);'
                     data-cnt='${dto.review_num }' data-check='true'>
                     <img src="./etc/like_after.png" class="RV_like_img" />
                     <div class="RV_like_num">${dto.review_like_num }</div>
                  </button>
               </c:when>
               <c:otherwise>
                  <button class='RV_like_logo' onclick='like2(this);'
                     data-cnt='${dto.review_num }' data-check='false'>
                     <img src="./etc/like.png" class="RV_like_img" />
                     <div class="RV_like_num">${dto.review_like_num }</div>
                  </button>
               </c:otherwise>
            </c:choose>
         </div>
         <div class="RV_content">${dto.review_content }</div>
         <div class="RV_edit_delete">

            <c:if test="${ sessionScope.user_email != null && sessionScope.user_email eq dto.user_email || sessionScope.user_email == 'admin@naver.com'}">
               <button class="RV_edit ${dto.review_num}">수정</button>
               <div id="RV_reviewNum">${dto.review_num }</div>
               <button class="RV_delete" onclick="deleteForm();">삭제</button>
            </c:if>
         </div>

      </div>
   </div>
   <%@ include file="ReviewEdit.jsp" %>

   <script>
   
      function like2(btn) {
         console.log(btn)
         let review_num = btn.getAttribute('data-cnt')
         console.log(review_num)
         $.ajax({
            url : './reviewlike?review_num=' + review_num + '&mode=like',
            type : 'GET',
            success : function(result) {
               btn.firstChild.nextElementSibling.src = './etc/like_after.png';
               btn.firstChild.nextElementSibling.nextElementSibling.innerText = Number(btn.firstChild.nextElementSibling.nextElementSibling.innerText)+1
               btn.setAttribute("onClick", "unlike2(this)")
               btn.setAttribute("data-cnt", review_num);
               $(".RV_modal"+review_num).parent().find(".RL_like_img")[0].src="./etc/like_after.png";
               $(".RV_modal"+review_num).parent().find(".RL_like_num")[0].innerText = btn.firstChild.nextElementSibling.nextElementSibling.innerText;
               $(".RV_modal"+review_num).parent().find(".RL_like_logo")[0].setAttribute("onClick", "unlike(this)")
               $(".RV_modal"+review_num).parent().find(".RL_like_logo")[0].setAttribute("data-cnt", review_num);
            },
            error : function(request, status, error) {
               alert("code:" + request.status + "\n" + "message:"
                     + request.responseText + "\n" + "error:" + error)
            }
         });
      }

      function unlike2(btn) {
         console.log(btn)
         let review_num = btn.getAttribute('data-cnt')
         console.log(review_num)
         $.ajax({
            url : './reviewlike?review_num=' + review_num + '&mode=unlike',
            type : 'GET',
            success : function(result) {
               console.log(result)
               btn.firstChild.nextElementSibling.src = './etc/like.png';
               btn.firstChild.nextElementSibling.nextElementSibling.innerText = Number(btn.firstChild.nextElementSibling.nextElementSibling.innerText)-1
               btn.setAttribute("onClick", "like2(this)")
               btn.setAttribute("data-cnt", review_num);
               $(".RV_modal"+review_num).parent().find(".RL_like_img")[0].src="./etc/like.png";
               $(".RV_modal"+review_num).parent().find(".RL_like_num")[0].innerText = btn.firstChild.nextElementSibling.nextElementSibling.innerText;
               $(".RV_modal"+review_num).parent().find(".RL_like_logo")[0].setAttribute("onClick", "like(this)")
               $(".RV_modal"+review_num).parent().find(".RL_like_logo")[0].setAttribute("data-cnt", review_num);
            },
            error : function(request, status, error) {
               alert("code:" + request.status + "\n" + "message:"
                     + request.responseText + "\n" + "error:" + error)
            }
         });
      }
   </script>
</body>

</html>