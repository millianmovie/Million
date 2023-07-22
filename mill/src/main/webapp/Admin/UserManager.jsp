<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../User/Nav.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="./css/UserManager.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
<h2 class="Admin_title">유저 관리</h2>

<form action="./adminUser"> 
  <div class="admin_search">
  	<input type="text" name="admin_searchWord" placeholder="   Email or name..." value="${empty param.admin_searchWord? '': param.admin_searchWord}">
  </div>  
</form>
		<div id="id" class="modal">
              <form class="modal-content">
                  <div class="modal_container">
                      <p>삭제하시겠습니까?</p>
                      <div class="clearfix">
                       	<button type="button" onclick="User_deleteForm()" class="deletebtn">확인</button>
                        <button type="button" onclick="document.getElementById('id').style.display='none'" class="cancelbtn">취소</button>
                      </div>
                  	</div>
                </form>
        </div>

        <table>
         <tr style="border-bottom: 2px solid hsla(0, 0%, 100%, .5)">
            <th  width="3%" class="th_input"><input type="checkbox" id="cbx_chkAll">
            <label for="cbx_chkAll" class="user_Allcheck"></label>
            </th>
            <th width="30%" class="th">아이디</th>
            <th width="20%" class="th">이름</th>
            <th width="25%" class="th">가입일</th>
            <th width="15%"><button class="user_delete_btn" onclick="document.getElementById('id').style.display='block'">DELETE</button></th>
         </tr>
		 <c:forEach var="userList_dto" items="${userList}">
         	<tr>
             	<td class="td_input">
             	<input type="checkbox" name="chk" id="${userList_dto.user_email }" class="user_check_input" value="${userList_dto.user_email }">
             	<label for="${userList_dto.user_email }" class="user_check">
             	</label>
             	</td>
             	<td class="td">${userList_dto.user_email }</td>
             	<td class="td">${userList_dto.user_name }</td>
             	<td class="td">${userList_dto.user_reg_date }</td>
         	</tr>

		 </c:forEach>
         </table> 

    <script>
    
    window.onkeydown = function() {
    	var kcode = event.keyCode;
    	if(kcode == 116) {
    	history.replaceState({}, null, location.pathname);
    	}
    	}
    $(document).ready(function() {
        $("#cbx_chkAll").click(function() {
            if($("#cbx_chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
            else $("input[name=chk]").prop("checked", false);
        });
        
        $("input[name=chk]").click(function() {
            var total = $("input[name=chk]").length;
            var checked = $("input[name=chk]:checked").length;
            
            if(total != checked) $("#cbx_chkAll").prop("checked", false);
            else $("#cbx_chkAll").prop("checked", true); 
        });
    });
    
    function User_deleteForm() {
    	if($("input:checkbox[name='chk']").is(":checked")==false) {
    			alert("적어도 하나는 선택하여 주세요.");
    			document.getElementById('id').style.display='none'
    			return;
    	}
    	else{
        const valueById = document.getElementsByClassName("user_check_input");
        let value_arr = "";
        for (let i = 0; i < valueById.length; i++) {
            if (valueById[i].checked) {
                value_arr += valueById[i].value
                value_arr += " "
                console.log(value_arr)
            }
        }
        $.ajax({
                url: './AdminUserDelete?user_email=' + value_arr,
                type: 'POST',
                data: {},
                success: function(result) {
                    location.href = "./adminUser?m=active"
                    console.log('관리자모드 유저 삭제 완료')
                },
                error: function() {
                    console.log('관리자모드 유저  삭제 중 오류')
                }
        });
    	}
        
    }
    </script>
</body>
</html>