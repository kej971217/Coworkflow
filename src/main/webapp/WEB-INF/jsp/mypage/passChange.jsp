<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>    
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="content">
	<form id="passChangeForm" action="${cPath }/mypage/passUpdate.do"  method="post" >
		 <security:csrfInput/>
	    <div class="grid grid-cols-12 gap-6">
	        <jsp:include page="/includee/mypageLeftMenu.jsp"></jsp:include>
	        <div class="col-span-12 lg:col-span-8 2xl:col-span-9">
	            <div class="intro-y box mt-5"> 
	                <div class="items-center p-5 border-b border-slate-200/60 dark:border-darkmode-400">
	                    <h3 class="font-medium font-bold mr-auto">         
	                        비밀번호 변경
	                    </h3>
	                </div>
	                <div class="p-5">
	                	<div class="text-slate-500 mb-6 pb-12">                            
	                    	<h2 class="text-xs">현재 비밀번호를 확인해 주세요.</h2>
	                   	</div>
	                    <div class="grid grid-cols-12 gap-x-5">
	                        <div class="col-span-12 xl:col-span-7">    
	                            <div>
	                                <label for="update-profile-form-6" class="form-label">현재 비밀번호</label>
	                                <input name="checkEmpPass" id="update-profile-form-6" type="password" class="form-control"/>
	                            </div>
	                            <br>
	                            <hr class="block" >
	                            <div class="mt-3">
	                                <label for="update-profile-form-7" class="form-label">새로운 비밀번호</label>
	                                <input  name="empPass"  id="update-profile-form-7" type="password" class="form-control"/>
	                            </div>
	                            <br>
	                            <div class="mt-3 xl:mt-0">
	                                <label for="update-profile-form-10" class="form-label">비밀번호 확인</label>  
	                                <input name="newPassCheck"  id="update-profile-form-10" type="password" class="form-control"/>
	                            </div>  
	                        </div>
	                    </div>
	                    <div class="flex justify-end mt-4">
	                        <button id="save" class="btn btn-primary w-20 mr-auto">저장</button>
	                    </div>
	                </div>
	            </div>
	        </div>
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

</script>