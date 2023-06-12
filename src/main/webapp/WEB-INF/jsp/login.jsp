<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>  

<!DOCTYPE html>
<html lang="en" class="light">
    <!-- BEGIN: Head -->
    <head>
        <meta charset="utf-8">
<!--         <link href="dist/images/logo.svg" rel="shortcut icon"> -->
        <link href="/resources/Rubic/dist/images/logo.svg" rel="shortcut icon">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Midone admin is su`per flexible, powerful, clean & modern responsive tailwind admin template with unlimited possibilities.">
        <meta name="keywords" content="admin template, Midone Admin Template, dashboard template, flat admin template, responsive admin template, web app">
        <meta name="author" content="LEFT4CODE">
       <security:csrfMetaTags/>
       
        <title>Login - Coworkflow</title>
        
<!-- BEGIN: Assets-->
<link rel="stylesheet" href='<c:url value="/resources/Rubick/dist/css/app.css" />' />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/sweetalert2/sweetalert2.min.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/fancytree/skin-lion/ui.fancytree.css"><!-- 조직도 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/jstree/themes/default/style.min.css"><!-- 조직도 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Custom css : 최후에 들어가야 함 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/custom.css">

<!-- jQuery -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/sweetalert2/sweetalert2.all.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-ui.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/fancytree/modules/jquery.fancytree.js"></script><!-- 조직도 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/fancytree/modules/jquery.fancytree.table.js"></script><!-- 조직도 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jstree/jstree.min.js"></script><!-- 조직도 -->
<script type="text/javascript" src="${cPath}/resources/js/jquery.serializeObject.min.js"></script>
<script src="https://cdn.tailwindcss.com"></script>
<!-- END: Assets-->

<script>
	let headerName = $("meta[name='_csrf_header']").attr("content");
	let headerValue = $("meta[name='_csrf']").attr("content");
	let headers = {}
	headers[headerName] = headerValue;
	
	$.CPATH = "${cPath}";
	$(document).ajaxError(function(event, jqXHR, settings, error){
		console.log(`비동기 요청[\${settings.url}, \${settings.type}] 실패, 상태코드 : \${jqXHR.status}, 에러메시지 : \${error}`);
	});
</script>

<%-- <script type="text/javascript" src="${cPath}/resources/js/sweetalert2/sweetalert2.all.min.js"></script> --%>
<%-- <link rel="stylesheet" href="${cPath}/resources/js/sweetalert2/sweetalert2.min.css" > --%>

<%-- <script type="text/javascript" src="${cPath}/resources/js/jquery-3.6.3.min.js"></script> --%>
<%-- <script type="text/javascript" src="${cPath}/resources/js/jquery.serializeObject.min.js"></script> --%>
<!-- <script src="https://cdn.tailwindcss.com"></script> -->

   <script type="text/javascript">
   /* jshint esversion: 6 */
    	function fnEmpSelect(event){
    		for(let op of event.target.options){
    			if(op.selected){
    				document.loginForm.empId.value = op.dataset.empId??"";
    				document.loginForm.empPass.value = op.dataset.empPass??"";
    			}
    		}	
    	}
    </script>

<c:if test="${not empty message }">
	<script type="text/javascript">
		window.addEventListener("DOMContentLoaded", function(){
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: '${message}'
				})
		});
	</script>
</c:if>
        
  <script>      
// 아이디 저장 체크박스 기능 구현
$(function(){
	// 로컬스토리지에 저장된 것 있나 없나 확인.
	const loginId = localStorage.getItem("empId");
	console.log(loginId);
	
	let empIdInput = $("#empId");
	let rememberMe = $("#rememberMe");
	
	if (loginId != null) {
		empIdInput.val(loginId);
		rememberMe.prop('checked', true);
	}
	
	 $("#loginForm").on("submit", function(event) {
// 		 event.preventDefault();
		
	   if (rememberMe.is(':checked')) {
	      localStorage.setItem("empId", empIdInput.val());
	   } else {
	      localStorage.removeItem("empId");
	   }
	})
});
 	</script>  
 
 <style>
 .swal2-container {
 			z-index:10060;
 }
                 
</style>	
 	
 </head>
    <!-- END: Head -->
    <body class="login">
    
     <form id="loginForm" name="loginForm" method="post">
      <security:csrfInput/>
        <div class="container sm:px-10">
            <div class="block xl:grid grid-cols-2 gap-4" >
                <!-- BEGIN: Login Info -->
                <div class="hidden xl:flex flex-col min-h-screen">
                    <a href="" class="-intro-x flex items-center pt-5"  >
                        <img alt="Coworkflow" class="w-44" src="${cPath}/resources/commonImages/logo_ko.png">
<!--                         <span class="text-white text-lg ml-3"> Coworkflow </span>  -->
                    </a>
                    <div class="my-auto">
                        <img alt="Coworkflow" class="-intro-x w-1/2 -mt-16" src="${cPath}/resources/commonImages/illustration.svg">
                        <div class="-intro-x text-white font-medium text-4xl leading-tight mt-10">
                        소통과 협업 
                        </div>
                        <div class="-intro-x mt-5 text-lg text-white text-opacity-70 dark:text-slate-400">
                        소통과 협업을 책임지는 코워크플로우 그룹웨어는<br>언제 어디서나 막힘 없는 소통과 협업이 가능한 <br>온라인 업무환경을 제공합니다.  
                        </div>
                    </div>  
                </div>
                <!-- END: Login Info -->
                <!-- BEGIN: Login Form -->
               
                <div class="h-screen xl:h-auto flex py-5 xl:py-0 my-10 xl:my-0">
                    <div class="my-auto mx-auto xl:ml-20 bg-white dark:bg-darkmode-600 xl:bg-transparent px-5 sm:px-8 py-8 xl:p-0 rounded-md shadow-md xl:shadow-none w-full sm:w-3/4 lg:w-2/4 xl:w-auto">
                        <h2 class="intro-x font-bold text-2xl xl:text-3xl text-center xl:text-left">
                            로그인 
                        </h2>
                        <div class="intro-x mt-2 text-slate-400 xl:hidden text-center">소통과 협업을 책임지는 코워크플로우 그룹웨어는 <br>언제 어디서나 막힘 없는 소통과 협업이 가능한 <br>온라인 업무환경을 제공합니다.</div>
                        <div class="intro-x mt-8">
                            <input id="empId" type="text" name="empId" required="required" class="intro-x login__input form-control py-3 px-4 block" placeholder="Id">
                            <input id = "empPass" type="password" name="empPass" required="required" class="intro-x login__input form-control py-3 px-4 block mt-4" placeholder="Password">
                            <select class="intro-x login__input form-control py-3 px-4 block mt-4" onchange="fnEmpSelect(event);">
					          	<option>로그인 유저 선택</option>
					          	<option data-emp-id="a100242" data-emp-pass="java">품질보증팀 팀원 이상훈(a100242)</option>
					          	<option data-emp-id="a100239" data-emp-pass="java">인사팀 팀원 김현지(a100239)</option>
					          	<option data-emp-id="a100005" data-emp-pass="java">인사팀 파트장 조은주(a100005)</option>
					          	<option data-emp-id="a100004" data-emp-pass="java">경영지원본부 본부장 박세진(a100004)</option>
					          	<option data-emp-id="a100002" data-emp-pass="java">CEO실 최고경영자 조욱제(a100002)</option>
					         </select>  
                        </div>
                        <div class="intro-x flex text-slate-600 dark:text-slate-500 text-xs sm:text-sm mt-4">
                            <div class="flex items-center mr-auto">
                                <input id="rememberMe" type="checkbox" class="form-check-input border mr-2" name="">
                                <label class="cursor-pointer select-none" for="remember-me">아이디 기억하기</label>
                            </div>
                            <a id="forgetPassword" href="javascript:;" data-tw-toggle="modal" data-tw-target="#forgotPasswordModal">비밀번호 찾기</a> 
<%--                             <a href="${cPath}/passwordFindForm" >Forgot Password?</a>  --%>
                        </div> 
                        <div class="intro-x mt-5 xl:mt-8 text-center xl:text-left">
                            <button class="btn btn-primary py-3 px-4 w-full xl:w-32 xl:mr-3 align-top">로그인</button>
<!--                             등록 버튼은 우선 화면에 안보이게 -->
<!--                             <button class="btn btn-outline-secondary py-3 px-4 w-full xl:w-32 mt-3 xl:mt-0 align-top">Register</button> -->
                        </div>
                    </div>
                </div>
                  
                <!-- END: Login Form -->
            </div>
        </div>
          </form>
          
        <!-- 비밀번호 찾기 누르면 나오는 모달 -->
	<!-- BEGIN: Modal Content -->      
<div id="forgotPasswordModal" class="modal" tabindex="-1" aria-hidden="true" style="z-index: 1000">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- BEGIN: Modal Header -->
			<div class="modal-header">
				<h2 id="forgetpasswordHeader" class="font-medium text-base mr-auto">비밀번호 찾기</h2>
			</div>
			
			<!-- END: Modal Header -->
			<!-- BEGIN: Modal Body -->
			
			<div class="modal-body grid grid-cols-12 gap-4 gap-y-3">
				<div class="col-span-12 sm:col-span-12">
					<label for="findPasswordId" class="form-label">ID 입력</label>
					<input id="findPasswordId" type="text" class="form-control" placeholder="ID를 입력해주세요." >
				</div>
			</div>
			<!-- END: Modal Body -->
			<!-- BEGIN: Modal Footer -->
			<div class="modal-footer">
				<button onclick="modalClose()" data-tw-dismiss="modal" class="btn btn-outline-secondary w-20 mr-1">취소</button>
				<button class="btn btn-primary w-20" id="modalSubmit" onclick="allSave()">전송</button>
			</div>
			<!-- END: Modal Footer -->
		</div>
	</div>
</div>
<!-- END: Modal Content -->
<script>
	document.addEventListener('DOMContentLoaded', function() {
		
		//모달 선택하기
		var scheduleModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#forgotPasswordModal"));
	});

//모달 전송버튼 선택하기
var modalSubmit = $('#modalSubmit');

//등록 버튼을 눌렀을 때, 등록이벤트
function allSave() {

	let findPasswordId = $('#findPasswordId').val();
	scheduleModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#forgotPasswordModal"));
	// JSON 데이터 생성
	let sendData = {
		findPasswordId : findPasswordId
	};

	// AJAX 요청
	$.ajax({
		url : "${cPath}/passwordFindSMS",  
		type : "post",
		data : JSON.stringify(sendData),
		beforeSend : function(xhrToController){
	         xhrToController.setRequestHeader(headerName, headerValue);
	         xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	      },
		contentType : "application/json",
		success : function(res) {
				scheduleModal.hide();

				Swal.fire({
				  icon: '완료',
				  title: '비밀번호 찾기',
				  text: '등록하신 핸드폰으로 임시비밀번호가 발송되었습니다.'
			});
// 				// 모달 내용 비우기
				$('#findPasswordId').val('');
		},
		error : function(request, status, error) {
			
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: '해당 ID는 존재하지 않습니다.'
			});
			
				$('#findPasswordId').val('');
				scheduleModal.hide();
		}
	});
}
function modalClose() {
	$("#forgotPasswordModal #empId").val("");
}
</script>   
        
        <!-- BEGIN: Dark Mode Switcher-->
<!--         기존에 있던 다크모드 버튼 우선 주석처리 -->
<!--         <div data-url="login-dark-login.html" class="dark-mode-switcher cursor-pointer shadow-md fixed bottom-0 right-0 box border rounded-full w-40 h-12 flex items-center justify-center z-50 mb-10 mr-10"> -->
<!--             <div class="mr-4 text-slate-600 dark:text-slate-200">Dark Mode</div> -->
<!--             <div class="dark-mode-switcher__toggle border"></div> -->
<!--         </div> -->
        <!-- END: Dark Mode Switcher-->
        
        <!-- BEGIN: JS Assets-->
<!-- 		 기존에 있던 app.js 는 우선 주석처리 -->
<!--         <script src="dist/js/app.js"></script> --> 
        <!-- END: JS Assets-->
    </body>
<!-- BEGIN: JS Assets-->
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery.fancytree.js"></script><!-- 조직도/ fancytree --> --%>
<script src="${pageContext.request.contextPath }/resources/js/lucide.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/tabulator.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jspdf.umd.min.js"></script><!-- tabulator PDF 출력 -->
<script src="${pageContext.request.contextPath }/resources/js/jspdf.plugin.autotable.min.js"></script><!-- tabulator 영역 조정 -->
<%-- <script src="${pageContext.request.contextPath }/resources/js/tailwindcss3.3.1.js"></script> --%>
<script src="${pageContext.request.contextPath }/resources/js/chart.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/simplebar.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/tom-select.complete.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/dayjs.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/litepicker.js"></script>
<%-- <script src="${pageContext.request.contextPath }/resources/js/tabulator.es2015.js"></script> --%>
<script src="${pageContext.request.contextPath }/resources/js/dropzone.min.js"></script>
<%-- <script src="${pageContext.request.contextPath }/resources/js/lucide.js"></script> --%>
<script  src="${pageContext.request.contextPath }/resources/js/tiny-slider.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/tippy/popper.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/tippy/tippy-bundle.umd.min.js"></script>
<script type="module" src="${pageContext.request.contextPath }/resources/js/zoom-vanilla.min.js"></script>
<script type="module" src="${pageContext.request.contextPath }/resources/js/pristine.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/toastify.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/fullcalendar.js"></script>
<%-- 강조 효과
<script src="${pageContext.request.contextPath }/resources/js/highlight.js/core.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/highlight.js/highlight.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/highlight.js/index.js"></script>
--%>
<script src="${pageContext.request.contextPath }/resources/js/xlsx.full.min.js"></script>
<script type="module" src="${pageContext.request.contextPath }/resources/js/tw-starter/starter.js"></script>
<script type="module" src="${pageContext.request.contextPath }/resources/js/twStarterSet.js"></script>
<!-- 구글 지도 --><!-- 한국에서는 카카오맵 추천 -->
<!-- <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script> -->
<!-- <script src="https://maps.googleapis.com/maps/api/js?key=["your-google-map-api"]&libraries=places"></script> -->
<!-- END: JS Assets-->




<!-- BEGIN: JS initialization -->
<!-- 아이콘 -->
<script>
    lucide.createIcons();
</script>
</html>