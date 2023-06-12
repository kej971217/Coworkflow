<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %> 



        <!-- BEGIN: Top Bar -->
        <div class="border-b border-white/[0.08] mt-[2.2rem] md:-mt-5 -mx-3 sm:-mx-8 px-3 sm:px-8 pt-3 md:pt-0 mb-10">
			<input id="loginId" type="hidden" value="<security:authentication property="principal.realUser.empId" />">
            <div class="top-bar-boxed flex items-center">
                <!-- BEGIN: Logo -->
                <a href="${pageContext.request.contextPath }" class="-intro-x hidden md:flex">
                    <img alt="Coworkflow" class="w-44" src="${cPath}/resources/commonImages/logo_ko.png">
<!--                     <span class="text-white text-lg ml-3">coworkflow</span> -->
                </a>
                <!-- END: Logo -->
                <!-- BEGIN: Breadcrumb -->
                <nav aria-label="breadcrumb" class="-intro-x h-full mr-auto">
                    <ol class="breadcrumb breadcrumb-light">
                        <li class="breadcrumb-item"><spring:message code="level1Menu.${level1Menu }" /></li>
                        
                        <c:if test="${not empty level2Menu }">
	                        <li class="breadcrumb-item active" aria-current="page"><spring:message code="level2Menu.${level2Menu }" /></li>
                        </c:if>
                        <c:if test="${not empty level3Menu }">
	                        <li class="breadcrumb-item active" aria-current="page" style="color: rgb(255 255 255 / 55%) !important;"><spring:message code="level3Menu.${level3Menu }" /></li>
                        </c:if>
                        
                    </ol>
                </nav>
                <!-- 로케일 설정 -->
                <div class="intro-x relative mr-3 sm:mr-6" id="localeSettingDivRegion">
	                <a href="?lang=ko" style="color: white;"><img class="w-8 h-6 inline-block mr-2" style="object-fit:cover;" alt="KOR" src="${cPath }/resources/commonImages/kor.png"></a>     
					<a href="?lang=en" style="color: white;"><img class="w-8 h-6 inline-block mr-2" style="object-fit:cover;" alt="USA" src="${cPath }/resources/commonImages/usa.png"></a>
					<a href="?lang=jp" style="color: white;"><img class="w-8 h-6 inline-block mr-2" style="object-fit:cover;" alt="JPN" src="${cPath }/resources/commonImages/jpn.png"></a>  
					<a href="?lang=de" style="color: white;"><img class="w-8 h-6 inline-block mr-2" style="object-fit:cover;" alt="DEU" src="${cPath }/resources/commonImages/deu.png"></a>
                </div>
                <!-- END: Breadcrumb -->
                <!-- BEGIN: Search -->
                <div class="intro-x relative mr-3 sm:mr-6">
                    <div class="search sm:block">  
                        <input type="text" class="search__input form-control border-transparent" placeholder="Search...">
                        <i icon-name="search" class="search__icon dark:text-slate-500"></i> 
                    </div>
                    <a class="notification notification--light sm:hidden" href=""> <i icon-name="search" class="notification__icon dark:text-slate-500"></i> </a>
                    <div class="search-result">
                        <div class="search-result__content">
                            <div class="search-result__content__title">Pages</div>
                            <div class="mb-5">
                                <a href="" class="flex items-center">
                                    <div class="w-8 h-8 bg-success/20 dark:bg-success/10 text-success flex items-center justify-center rounded-full"> <i class="w-4 h-4" icon-name="inbox"></i> </div>
                                    <div class="ml-3">Mail Settings</div>
                                </a>
                                <a href="" class="flex items-center mt-2">
                                    <div class="w-8 h-8 bg-pending/10 text-pending flex items-center justify-center rounded-full"> <i class="w-4 h-4" icon-name="users"></i> </div>
                                    <div class="ml-3">Users & Permissions</div>
                                </a>
                                <a href="" class="flex items-center mt-2">
                                    <div class="w-8 h-8 bg-primary/10 dark:bg-primary/20 text-primary/80 flex items-center justify-center rounded-full"> <i class="w-4 h-4" icon-name="credit-card"></i> </div>
                                    <div class="ml-3">Transactions Report</div>
                                </a>
                            </div>
                            <div class="search-result__content__title">Users</div>
                            <div class="mb-5">
                                <a href="" class="flex items-center mt-2">
                                    <div class="w-8 h-8 image-fit">
                                        <img alt="Coworkflow" class="rounded-full" src="${cPath }/resources/Rubick/dist/images/profile-11.jpg">
                                    </div>
                                    <div class="ml-3">Kevin Spacey</div>
                                    <div class="ml-auto w-48 truncate text-slate-500 text-xs text-right">kevinspacey@left4code.com</div>
                                </a>
                                <a href="" class="flex items-center mt-2">
                                    <div class="w-8 h-8 image-fit">
                                        <img alt="Coworkflow" class="rounded-full" src="${cPath }/resources/Rubick/dist/images/profile-1.jpg">
                                    </div>
                                    <div class="ml-3">Angelina Jolie</div>
                                    <div class="ml-auto w-48 truncate text-slate-500 text-xs text-right">angelinajolie@left4code.com</div>
                                </a>
                                <a href="" class="flex items-center mt-2">
                                    <div class="w-8 h-8 image-fit">
                                        <img alt="Coworkflow" class="rounded-full" src="${cPath }/resources/Rubick/dist/images/profile-14.jpg">
                                    </div>
                                    <div class="ml-3">Bruce Willis</div>
                                    <div class="ml-auto w-48 truncate text-slate-500 text-xs text-right">brucewillis@left4code.com</div>
                                </a>
                                <a href="" class="flex items-center mt-2">
                                    <div class="w-8 h-8 image-fit">
                                        <img alt="Coworkflow" class="rounded-full" src="${cPath }/resources/Rubick/dist/images/profile-12.jpg">
                                    </div>
                                    <div class="ml-3">Al Pacino</div>
                                    <div class="ml-auto w-48 truncate text-slate-500 text-xs text-right">alpacino@left4code.com</div>
                                </a>
                            </div>
                            <div class="search-result__content__title">Products</div>
                            <a href="" class="flex items-center mt-2">
                                <div class="w-8 h-8 image-fit">
                                    <img alt="Coworkflow" class="rounded-full" src="${cPath }/resources/Rubick/dist/images/preview-13.jpg">
                                </div>
                                <div class="ml-3">Nike Tanjun</div>
                                <div class="ml-auto w-48 truncate text-slate-500 text-xs text-right">Sport &amp; Outdoor</div>
                            </a>
                            <a href="" class="flex items-center mt-2">
                                <div class="w-8 h-8 image-fit">
                                    <img alt="Coworkflow" class="rounded-full" src="${cPath }/resources/Rubick/dist/images/preview-1.jpg">
                                </div>
                                <div class="ml-3">Nike Tanjun</div>
                                <div class="ml-auto w-48 truncate text-slate-500 text-xs text-right">Sport &amp; Outdoor</div>
                            </a>
                            <a href="" class="flex items-center mt-2">
                                <div class="w-8 h-8 image-fit">
                                    <img alt="Coworkflow" class="rounded-full" src="${cPath }/resources/Rubick/dist/images/preview-3.jpg">
                                </div>
                                <div class="ml-3">Samsung Q90 QLED TV</div>
                                <div class="ml-auto w-48 truncate text-slate-500 text-xs text-right">Electronic</div>
                            </a>
                            <a href="" class="flex items-center mt-2">
                                <div class="w-8 h-8 image-fit">
                                    <img alt="Coworkflow" class="rounded-full" src="${cPath }/resources/Rubick/dist/images/preview-10.jpg">
                                </div>
                                <div class="ml-3">Nikon Z6</div>
                                <div class="ml-auto w-48 truncate text-slate-500 text-xs text-right">Photography</div>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- END: Search -->
                <!-- BEGIN: Notifications -->
                <div  class="intro-x dropdown mr-4 sm:mr-6">
                	<!-- 요게 바로 이미지..! -->
<!--                     <div class="dropdown-toggle notification notification--light notification--bullet cursor-pointer" role="button" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="bell" class="notification__icon dark:text-slate-500"></i> </div> -->
                    <div id="notificationContent" class="dropdown-toggle notification notification--light notification cursor-pointer" role="button" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="bell" class="notification__icon dark:text-slate-500"></i> </div>

                    <div class="notification-content pt-2 dropdown-menu">
                        <div id="alarmMain" class="notification-content__box dropdown-content">
                            <div class="notification-content__title">Notifications</div>
                         
                        </div>
                    </div>
                </div>
                <!-- END: Notifications -->
                <!-- BEGIN: Account Menu -->
                <div class="intro-x dropdown w-8 h-8">
                    <div class="dropdown-toggle w-8 h-8 rounded-full overflow-hidden shadow-lg image-fit zoom-in scale-110" role="button" aria-expanded="false" data-tw-toggle="dropdown">
	                	<security:authentication property="principal" var="authMember" />
	                    <img id="topBarImgProfile" alt="Coworkflow" src="${cPath }/mypage/<security:authentication property="principal.realUser.mypage.profileImage.empAtchSaveName" />"/>
                    </div>
                    <div class="dropdown-menu w-56">
                        <ul class="dropdown-content bg-primary/80 before:block before:absolute before:bg-black before:inset-0 before:rounded-md before:z-[-1] text-white">
                            <li class="p-2">
                             <security:authorize access="isAuthenticated()">
                                 <security:authentication property="principal" var="authMember" />
                                <div class="font-medium"><security:authentication property="principal.realUser.empName" /></div>
                                <div class="text-xs text-white/60 mt-0.5 dark:text-slate-500"><security:authentication property="principal.realUser.position.teamName" /> <security:authentication property="principal.realUser.position.positionName" /></div>
                            </security:authorize>
                            </li>
                            
                            <li>
                                <hr class="dropdown-divider border-white/[0.08]">
                            </li>
                            <li>    
                                <a href="${cPath }/mypage/mypageEditView.do" class="dropdown-item hover:bg-white/5"> <i icon-name="user" class="w-4 h-4 mr-2"></i> 개인정보 변경 </a>
                            </li>  
                            <li>
                                <a href="" class="dropdown-item hover:bg-white/5"> <i icon-name="lock" class="w-4 h-4 mr-2"></i> 비밀번호 변경 </a>
                            </li>
                            <li>
                                <a href="" class="dropdown-item hover:bg-white/5"> <i icon-name="help-circle" class="w-4 h-4 mr-2"></i> 도움말 </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider border-white/[0.08]">
                            </li>
					<li>  
					<form id="logoutForm" action="${cPath }/logout" method="post">
						<security:csrfInput />
					</form>
                                <a href="javascript:$('#logoutForm').submit();" class="dropdown-item hover:bg-white/5"> <i icon-name="toggle-right" class="w-4 h-4 mr-2"></i> 로그아웃 </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- END: Account Menu -->
            </div>
        </div>
        <!-- END: Top Bar -->
 
<!-- 알람 하나 템플릿. -->
<template id="alarmTemplate">
	<div class="cursor-pointer relative flex items-center mt-5 cursor-user" data-alarmnum="5">
		<input id=alarmNum type="hidden" value="">
	    <div id="imgTag" class="w-12 h-12 flex-none image-fit mr-1">
 <!-- 이미지 꽂아줄건데 뭐꽂아주지? -->
<%-- 	        <span id="imgTag"><img alt="Coworkflow" class="rounded-full" src="${cPath }/resources/Rubick/dist/images/profile-1.jpg"></span> --%>
	        <span id="imgTag"></span>
<!-- 	        <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white"></div> -->
	    </div>
	    <div class="ml-2 overflow-hidden">
         <!-- 여기에 알람 내용 꽂아주면됨. -->
	        <div class="flex items-center">
	            <a href="javascript:;" class="font-medium truncate mr-5"><!-- 알람보내는 사람 --></a> 
	            <div class="text-xs text-slate-400 ml-auto whitespace-nowrap"><!-- 시간.--></div>
	        </div>
	        <div class="w-full truncate text-slate-500 mt-0.5"><!-- 내용 들어갈 곳. --> </div>
	    </div>
	</div>
 </template> 
        
<script>
var alarmMain = $('#alarmMain');
var notificationContent = $('#notificationContent');

window.addEventListener("DOMContentLoaded", ()=>{
	
// 현재 로그인 된 아이디 확인.
let thisEmpId = $("#loginId").val();	
// 알람이 찍히는 곳.	

// 알림 리스트 받아오기 실행.
loadAlarmList();

// 확인하지 않은 리스트를 DB에서 가져오는 메서드
function loadAlarmList(){	
	
	let sendEmpId = {
			empId : thisEmpId
	}
	$.ajax({
		url : "${cPath}/alarm/checkAlarmList",
		type : "post",
		data : JSON.stringify(sendEmpId),
// 		data : thisEmpId,
		beforeSend : function(xhrToController){
	         xhrToController.setRequestHeader(headerName, headerValue);
	         xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	    },
		contentType : "application/json",
		success : function(res) {
			
	
		if(res.alarmList.length==0 || res.alarmList==null ){
			notificationContent.attr("class","dropdown-toggle notification notification--light notification cursor-pointe")
			
			alarmMain.empty();	
				
			let content = "새로운 알람이 없습니다.";
			alarmMain.append(content);
		}else{
			notificationContent.attr("class","dropdown-toggle notification notification--light notification--bullet cursor-pointe")
			
			alarmMain.empty();	
				
			for(var i=0; i<res.alarmList.length; i++){		
				
				// 받을 알람객체 생성
				let alertVO = res.alarmList[i]
				// 알람 템플릿 복사.
				let template = alarmTemplate.content.cloneNode(true);
				const alarmImg = $(template).find("#imgTag");
				const alarmEmp = $(template).find(".font-medium");
				const alarmContent = $(template).find(".w-full");
				const alarmTime = $(template).find(".text-xs");
				const almInput = $(template).find("#alarmNum")
				almInput.val(alertVO.almNum);
				alarmTime.html(alertVO.almDate);
				alarmEmp.html(alertVO.almApponentName);
				alarmContent.html(alertVO.almContent);
				
				let content
				
				if(alertVO.almType == 'CHAT'){
					content =`<svg xmlns="http://www.w3.org/2000/svg" width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" icon-name="message-circle" data-lucide="message-circle" class="lucide lucide-message-circle block mx-auto"><path d="M21 11.5a8.38 8.38 0 01-.9 3.8 8.5 8.5 0 01-7.6 4.7 8.38 8.38 0 01-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 01-.9-3.8 8.5 8.5 0 014.7-7.6 8.38 8.38 0 013.8-.9h.5a8.48 8.48 0 018 8v.5z"></path></svg>`;
				}else if(alertVO.almType == 'NOTICE'){
					content = `<svg xmlns="http://www.w3.org/2000/svg" width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" icon-name="file-text" data-lucide="file-text" class="lucide lucide-file-text block mx-auto"><path d="M14.5 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V7.5L14.5 2z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><line x1="10" y1="9" x2="8" y2="9"></line></svg>`
				}else if(alertVO.almType == 'CALENDAR'){
					content = `<svg xmlns="http://www.w3.org/2000/svg" width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" icon-name="calendar" data-lucide="calendar" class="lucide lucide-calendar block mx-auto"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>`;
				}
				
					alarmImg.html(content);
				alarmMain.append(template);
				}
		}	
			
		},
		error : function(request, status, error) {
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: 'Something went wrong!'
			});
		}
	});	
}	
	
// Stomp 설정.
const alert = new StompJs.Client({
	
	brokerURL:`ws://\${document.location.host}${cPath}/ws/alarm`,
	debug:function(str){
// 		console.log(str);
	},
	// 받는쪽 설정.
	onConnect:function(frame){
		
		const noticeAlarmResetAll = this.subscribe("/topic/alarm/reset", function(msgFrame){
			loadAlarmList();
			
		});

		const noticeAlarmReset = this.subscribe("/user/alarm/reset", function(msgFrame){
			loadAlarmList();
			
		});
		const noticeAlarm = this.subscribe("/topic/alarm/newNotice", function(msgFrame){
			
			let alertVO = JSON.parse(msgFrame.body);
			
			let sendData = {
					almApponent : alertVO.empId,
					almContent : alertVO.alarmContent,
					almType : alertVO.almType
			};
			
// 			debugger;
			
			$.ajax({
				url : "${cPath}/alarm/allEmpAlarm",
				type : "post",
				data : JSON.stringify(sendData),
				beforeSend : function(xhrToController){
			         xhrToController.setRequestHeader(headerName, headerValue);
			         xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
			    },
				contentType : "application/json",
				success : function(res){
					
// 					debugger;
					
// 					for(i=0; i<res.newAlarmList.length; i++){
// 					 let alertEmpId = res.newAlarmList[i].empId
// 					 console.log("--------------", alertEmpId);

// 					 alert.publish({
// 							destination:`/user/\${alertEmpId}/alarm/reset` 
// 						});
				
// 					}
// 					 alert.publish({
// 							destination:"/topic/alarm/reset" 
// 						});
					
// 					console.log("이게 되나 안되나--------------------------------------")
// 					debugger;
					
				},
				error : function(request, status, error) {
					Swal.fire({
						  icon: 'error',
						  title: 'Oops...',
						  text: 'Something went wrong!'
					});
				}
			});
			
			
			
			
			loadAlarmList();
				
				
			});
		
		// 알림용.  
		const subscription = this.subscribe("/user/alarm/newAlarm", function(msgFrame){
			alarmMain.empty();
			// 받을 알람객체 생성
			let alertVO = JSON.parse(msgFrame.body);
// 			alert("도착했닝?" + msgFrame.body);
			console.log(alertVO);
			console.log("알람왔닝?");
			// 알람 템플릿 복사.
			let template = alarmTemplate.content.cloneNode(true);
			//각각 노드 검색(꽂아주기 위해서)
			const alarmImg = $(template).find("#imgTag");
			const alarmEmp = $(template).find(".font-medium");
			const alarmContent = $(template).find(".w-full");
			const alarmTime = $(template).find(".text-xs");
			
let sendData = {
		empId : alertVO.apponent,
		almContent : alertVO.alarmContent,
		almApponent : alertVO.empId,
		almType : alertVO.almType
};
			
			$.ajax({
				url : "${cPath}/alarm/insertAlarm",
				type : "post",
				data : JSON.stringify(sendData),
				beforeSend : function(xhrToController){
			         xhrToController.setRequestHeader(headerName, headerValue);
			         xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
			    },
				contentType : "application/json",
				success : function(res) {
					
				alarmTime.html(res.newAlarm.almDate);
				alarmEmp.html(res.newAlarm.almApponentName)
				alarmContent.html(res.newAlarm.empName +" "+ res.newAlarm.almContent)
				
				if(res.newAlarm.almType == 'CHAT'){
					let content =`<svg xmlns="http://www.w3.org/2000/svg" width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" icon-name="message-circle" data-lucide="message-circle" class="lucide lucide-message-circle block mx-auto"><path d="M21 11.5a8.38 8.38 0 01-.9 3.8 8.5 8.5 0 01-7.6 4.7 8.38 8.38 0 01-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 01-.9-3.8 8.5 8.5 0 014.7-7.6 8.38 8.38 0 013.8-.9h.5a8.48 8.48 0 018 8v.5z"></path></svg>`;
					alarmImg.html(content);
				}
				
			alarmMain.append(template);	
			loadAlarmList();
				},
				error : function(request, status, error) {
					Swal.fire({
						  icon: 'error',
						  title: 'Oops...',
						  text: 'Something went wrong!'
					});
				}
			});
			 
		});
	}
});
alert.activate();

// 동적으로 생성된 HTML
$(document).on("click", ".cursor-user", function () {
   let almNum = $(this).find(":input").val();
   
   $.ajax({
		url : "${cPath}/alarm/readAlarm",
		type : "post",
		data : almNum,
		beforeSend : function(xhrToController){
	         xhrToController.setRequestHeader(headerName, headerValue);
	         xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	    },
		contentType : "application/json",
		success : function(res) {
// 			console.log("성공했는지");
				loadAlarmList();
		},
		error : function(request, status, error) {
// 			console.log("실패했는지");
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: 'Something went wrong!'
			});
		}
	});   
   
   
});

});

</script>