<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>리뷰 목록들</title>
<link rel="stylesheet" href="./css/ReviewList.css" />
<link rel="stylesheet" href="./css/ReviewWrite.css" />
<link rel="stylesheet" href="./css/ReviewEdit.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
</head>

<body>
   <div class="RL_ccon">
      <div class="RL_container">

         <div class="RL_totalcount">
            <p class="RL_totalReview">총 ${totalCount }개의 리뷰가 작성되어 있습니다.</p>
            <button class="RL_write" id="RL_modal-bttn">리뷰작성</button>
         </div>
         <%@ include file="ReviewWrite.jsp" %> 
         <div class="RL_full_review_wrap">
            <c:forEach var="dto" items="${reviewLists}">
               <div class="RL_full_review">
                  <div class="RL_review">
                     <div id="RL_text">
                        <c:choose>
                           <c:when test="${dto.rating=='good'}">
                              <img src="./etc/good.png" class="RL_good" alt="rate" />
                           </c:when>
                           <c:otherwise>
                              <img src="./etc/bad.png" class="RL_good" alt="rate" />
                           </c:otherwise>
                        </c:choose>
                        <div class="RL_star_rating_1">⭐ ${dto.star_score }</div>
                        <div class="RL_title_1">${ dto.review_title}</div>
                        <div class="RL_re_bottom">
                           <span class="RL_date_1">${dto.review_post_date }</span>
                           <div class="RL_review_like_num">${ch = dto.getReview_like_num(user_email, dto.review_num)==1 }</div>
                           <c:choose>
                              <c:when test='${ch}'>
                                 <button class='RL_like_logo' onclick='unlike(this);'
                                    data-cnt='${dto.review_num }' data-check='true'>
                                    <img src="./etc/like_after.png" class="RL_like_img" />
                                    <div class="RL_like_num">${dto.review_like_num }</div>
                                 </button>
                              </c:when>
                              <c:otherwise>
                                 <button class='RL_like_logo' onclick='like(this);'
                                    data-cnt='${dto.review_num }' data-check='false'>
                                    <img src="./etc/like.png" class="RL_like_img" />
                                    <div class="RL_like_num">${dto.review_like_num }</div>
                                 </button>
                              </c:otherwise>
                           </c:choose>
                           <button type="button"
                              class="RL_fullreview ${dto.review_num }">FullReview</button>
                        </div>
                        <%@include file="ReviewView.jsp"%>
                     </div>

                  </div>
                  <div class="RL_bottom_name">
                     <c:choose>
                        <c:when test="${dto.user_gender eq 'Woman' }">
                           <img src="./etc/woman.png" class="RL_sex" alt="여자" />
                        </c:when>
                        <c:when test="${dto.user_gender eq 'Man'}">
                           <img src="./etc/man.png" class="RL_sex" alt="남자" />
                        </c:when>
                        <c:otherwise>
                           <img src="./etc/no.png" class="RL_sex" alt="성별 선택 안 함" />
                        </c:otherwise>
                     </c:choose>
                     <div class="RL_writer">${dto.user_name }</div>
                  </div>
               </div>
            </c:forEach>
         </div>

      </div>


 
</div>
  <script>
  // viewModal
  $(".RV_close").on("click", function() {
     $(this).parent().parent().css('display', 'none');
  });
  $(".RL_fullreview").on("click", function() {
     let className = $(this).attr('class').split(' ')[1];
     console.log(className)
     console.log(".RV_myModal." + className)
     $(".RV_modal" + className).css('display', 'block');
  });    

  // deleteModal
  function deleteForm() {
     //console.log(${dto.review_num}) 
     var confirmed = confirm("정말로 삭제하시겠습니까?");
     let num = $("#RV_reviewNum").text();
     console.log(num)
     if (confirmed) {
        $.ajax({
           url : './reviewdelete?review_num=' + num,
           type : 'POST',
           data : {},
           success : function(result) {
              console.log('리뷰 삭제 완료')
              const myModal = document.querySelector(".RV_myModal")
              myModal.style.display = "none";
              location.reload();
           },
           error : function() {
              console.log('리뷰 삭제 중 오류')
           }
        });
     }
  }

  function like(btn) {
     console.log(btn)
     let review_num = btn.getAttribute('data-cnt')
     console.log(review_num)
     $.ajax({
        url : './reviewlike?review_num=' + review_num + '&mode=like',
        type : 'GET',
        success : function(result) {
           console.log(result)
           btn.firstChild.nextElementSibling.src = './etc/like_after.png';
           btn.firstChild.nextElementSibling.nextElementSibling.innerText = Number(btn.firstChild.nextElementSibling.nextElementSibling.innerText)+1
           btn.setAttribute("onClick", "unlike(this)")
           btn.setAttribute("data-cnt", review_num);
           console.log($(".RV_modal"+review_num).find(".RV_like_img")[0].src)
           $(".RV_modal"+review_num).find(".RV_like_img")[0].src="./etc/like_after.png";
           $(".RV_modal"+review_num).find(".RV_like_num")[0].innerText = btn.firstChild.nextElementSibling.nextElementSibling.innerText;
           $(".RV_modal"+review_num).find(".RV_like_logo")[0].setAttribute("onClick", "unlike2(this)")
           $(".RV_modal"+review_num).find(".RV_like_logo")[0].setAttribute("data-cnt", review_num);
        },
        error : function(request, status, error) {
           alert("code:" + request.status + "\n" + "message:"
                 + request.responseText + "\n" + "error:" + error)
        }
     });
  }

  function unlike(btn) {
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
           btn.setAttribute("onClick", "like(this)")
           btn.setAttribute("data-cnt", review_num);
           console.log($(".RV_modal"+review_num).find(".RV_like_logo")[0])
           console.log($(".RV_modal"+review_num).find(".RV_like_img")[0].src)
           $(".RV_modal"+review_num).find(".RV_like_img")[0].src="./etc/like.png";
           $(".RV_modal"+review_num).find(".RV_like_num")[0].innerText = btn.firstChild.nextElementSibling.nextElementSibling.innerText;
           $(".RV_modal"+review_num).find(".RV_like_logo")[0].setAttribute("onClick", "like2(this)")
           $(".RV_modal"+review_num).find(".RV_like_logo")[0].setAttribute("data-cnt", review_num);
        },
        error : function(request, status, error) {
           alert("code:" + request.status + "\n" + "message:"
                 + request.responseText + "\n" + "error:" + error)
        }
     });
  }

   // reviewEdit
     $(".RE_CloseBtn").on("click", function() {
        $(this).parent().parent().parent().css('display', 'none');
//         $(".editModal" + className).css('z-index', '-1');
     });
     $(".RV_edit").on("click", function() {
        let className = $(this).attr('class').split(' ')[1];
        console.log(className)
        console.log("#editedit" + className)
        $("#editedit" + className).css('display', 'block');
        $(".RV_myModal.RV_modal" + className).css('display', 'none');
   });
  
     $('.RE_Like_check').click(function(e){
        $(this).parent().find("input").prop("checked", true)
        console.log($(this).parent().find("input"))
     });

  
    
</script>

</body>
</html>