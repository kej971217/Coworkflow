<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    <style>

#myPassChangeView{
	background-color: #3541A8;
	height: 50px;
	color: #ffffff;
	font-weight:550;
}
.myPassChangLabel{
	margin-left:13px;
	width:300px;
}
</style>
<div>
	<form id="passChangeForm" action="${cPath }/mypage/passUpdate.do"  method="post" >
	 <security:csrfInput/>
        <div id="myPassChangeView">
            <p style="padding:13px;">비밀번호 변경</p>
        </div><br>
        <div>
        	<label class="myPassChangLabel">현재 비밀번호</label>
        	<input name="checkEmpPass" type="password"/>
        	<span id="checkEmpPassError" class="text-danger"></span>
        </div>
        <hr>
        <div>
        	<label class="myPassChangLabel">새로운 비밀번호</label>
        	<input name="empPass" type="password"/>
        	<span id="empPassError"  class="text-danger"></span>
        </div>
        <div>
        	<label class="myPassChangLabel">비밀번호 확인</label>
        	<input name ="newPassCheck" type="password"/>
        	<span id="newPassCheckError"  class="text-danger"></span>
        </div>
        <br>
        <div style="text-align: center;">
        	<button type="submit" id="save" >저장</button>
            <input type="button" value="취소" onclick="passPopClose()"/>
        </div>
    </form>
</div>
<script type="text/javascript">
let checkEmpPassError = $("#nowPassError");
let empPassError = $("#newPassError");
let newPassCheckError = $("#error");

let passwdForm = $("#passChangeForm").on("click", "#save", function(event){
   
	checkEmpPassError.empty();
	empPassError.empty();
	newPassCheckError.empty();
   
   if(!$("[name=checkEmpPass]").val().trim()){
	   checkEmpPassError.html("현재 비밀번호를 입력해주세요.");
      return;
   }      
   if(!$("[name=empPass]").val().trim()){
	   empPassError.html("새로운 비밀번호를 입력해주세요.");
      return;
   }   
   
   if(!$("[name=newPassCheck]").val().trim() ||
         $("[name=newPassCheck]").val() != $("[name=empPass]").val()
   ){
	   newPassCheckError.html("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
      return;
   }   
   
   passwdForm.submit(); 
})

function passPopClose(){
	window.close();
}
</script>