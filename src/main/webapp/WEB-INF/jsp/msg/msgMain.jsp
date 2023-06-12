<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>   
<style>
.swal2-container {z-index:10060;}

#msgWriteInput {
/* 	position: fixed; */
}

</style>
<script>
var message='${message}';
if(message!="")
	alert(message);

</script>

<input id="loginId" type="hidden" value="${loginId }">
<!-- BEGIN: Content -->
        <div class="content">
            <div class="intro-y flex flex-col sm:flex-row items-center mt-8">
                <h2 class="text-lg font-medium mr-auto">
                    Chat
                </h2>
                <div class="w-full sm:w-auto flex mt-4 sm:mt-0">
<!--                 <a id="addChat" href="javascript:;" data-tw-toggle="modal" data-tw-target="#chatModal" class="btn btn-primary w-full mt-2"> 새 채팅 Start New Chat </a> -->
                 <button id="addChat" class="btn btn-primary shadow-md mr-2" data-tw-toggle="modal" data-tw-target="#chatModal" ><i class="w-4 h-4 mr-2" icon-name="message-circle" ></i>채팅하기</button>    
                    <div class="dropdown ml-auto sm:ml-0">
                        <button class="dropdown-toggle btn px-2 box text-slate-500" aria-expanded="false" data-tw-toggle="dropdown">
                            <span class="w-5 h-5 flex items-center justify-center"> 
<!--                             <i class="w-4 h-4" data-lucide="plus" style="z-index:100;" ></i>  -->
	<svg xmlns ="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
	 stroke-linejoin="round" icon-name="plus" class="lucide lucide-plus w-4 h-4" data-lucide="plus"></svg>
                            </span>
                        </button>
                    </div>
                </div>
            </div>
            <div class="intro-y chat grid grid-cols-12 gap-5 mt-5">
                <!-- BEGIN: Chat Side Menu -->
                <div class="col-span-12 lg:col-span-4 2xl:col-span-3">
                    <div class="intro-y pr-1">
                        <div class="box p-2">
                            <ul class="nav nav-pills" role="tablist">
                                <li id="chats-tab" class="nav-item flex-1" role="presentation">
                                    <button class="nav-link w-full py-2 active" data-tw-toggle="pill" data-tw-target="#chats" type="button" role="tab" aria-controls="chats" aria-selected="true" > 채팅목록 </button>
                                </li>
                                <li id="friends-tab" class="nav-item flex-1" role="presentation">
                                    <button class="nav-link w-full py-2" data-tw-toggle="pill" data-tw-target="#friends" type="button" role="tab" aria-controls="friends" aria-selected="false" > 직원목록 </button>
                                </li>
                                <li id="profile-tab" class="nav-item flex-1" role="presentation">
                                    <button class="nav-link w-full py-2" data-tw-toggle="pill" data-tw-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false" > 프로필 </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    
                    <div class="tab-content">
                        <div id="chats" class="tab-pane active" role="tabpanel" aria-labelledby="chats-tab">          
                            
                            
                    <!--채팅 리스트!!! -->     
                            <div id="msgRoomList" class="chat__chat-list overflow-y-auto scrollbar-hidden pr-1 pt-1" style="height: 70vh; min-height: 460px;">
                                
<%--                                 <c:if test="${not empty msgInfoList }">	 --%>
<%-- 									<c:forEach var="MsgInfo" items="${msgInfoList }" varStatus="status"> --%>
<!-- 										 <div class="intro-x cursor-pointer box relative flex items-center p-5 mt-5"> -->
<!-- 	                                    <div class="w-12 h-12 flex-none image-fit mr-1"> -->
<%-- 	                                        <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-8.jpg"> --%>
<!-- 	                                        <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div> -->
<!-- 	                                    </div> -->
<!-- 	                                    <div class="ml-2 overflow-hidden"> -->
<!-- 	                                        <div class="flex items-center"> -->
<%-- 	                                            <a href="javascript:;" class="font-medium" data-room-id="${MsgInfo.msgRoomId }"> ${MsgInfo.apponentName } </a>  --%>
<%-- 	                                            <div class="text-xs text-slate-400 ml-auto"> &nbsp; &nbsp;  ${MsgInfo.lastMsgDate } </div>   --%>
<!-- 	                                        </div> -->
<%-- 	                                        <div class="w-full truncate text-slate-500 mt-0.5"> ${MsgInfo.lastMsgContent } <!--  마지막 문장이 들어갈 자리.--> </div> --%>
<!-- 	                                    </div> -->
<!-- 	                                </div> -->
<%-- 								</c:forEach> --%>
<%-- 								</c:if> --%>
								
                            </div>
                        </div>
                        <div id="friends" class="tab-pane" role="tabpanel" aria-labelledby="friends-tab">
                            <div class="pr-1">
                                <div class="box p-5 mt-5">
                                    <div class="relative text-slate-500">
                                        <input id="searchEmp" onkeydown="javascript:if(event.keyCode==13){$('#searchEmpBtn').trigger('click')}" type="text" class="form-control py-3 px-4 border-transparent bg-slate-100 pr-10" placeholder="Search for users...">
                                        <i class="w-4 h-4 hidden sm:absolute my-auto inset-y-0 mr-3 right-0" data-lucide="search"></i>   
                                    </div>
                                    <button id="searchEmpBtn"  class="btn btn-primary w-full mt-3">직원 검색</button>
                                </div>
                            </div>
                            <!-- 직원목록 꽂아줄 리스트 -->
                            <div id="msgEmpList" class="chat__user-list overflow-y-auto scrollbar-hidden pr-1 pt-1">
                            
                            </div>
                        </div>
                        
             <!-- 프로필!! -->
             			<security:authorize access="isAuthenticated()">
                        <security:authentication property="principal" var="authMember" />
                        <div id="profile" class="tab-pane" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="pr-1">
                                <div class="box px-5 py-10 mt-5">
                                    <div class="w-20 h-20 flex-none image-fit rounded-full overflow-hidden mx-auto">
                                        <security:authentication property="principal" var="authMember" />
							        	<img alt="Coworkflow" class="rounded-full" src="${cPath }/mypage/<security:authentication property="principal.realUser.mypage.profileImage.empAtchSaveName" />"/>
                                    </div>  
                                    
                                    <div class="text-center mt-3">
                                        <div class="font-medium text-lg"><security:authentication property="principal.realUser.empName" /></div>
                                        <div class="text-slate-500 mt-1"><security:authentication property="principal.realUser.rank.rankName" /></div>
                                    </div>
                                  
                                </div>
                                <div class="box p-5 mt-5">
                                    <div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5">
                                        <div>
                                            <div class="text-slate-500">Department</div>
                                            <div class="mt-1"><security:authentication property="principal.realUser.position.teamName" /></div>
                                        </div>
                                        <i icon-name="globe" class="w-4 h-4 text-slate-500 ml-auto"></i> 
                                    </div>
                                    <div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 py-5">
                                        <div>
                                            <div class="text-slate-500">Phone</div>
                                            <div class="mt-1"><security:authentication property="principal.realUser.employeeInfo.infoHp" /></div>
                                        </div>
                                        <i icon-name="mic" class="w-4 h-4 text-slate-500 ml-auto"></i> 
                                    </div>
                                    <div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 py-5">
                                        <div>
                                            <div class="text-slate-500">Email</div>
                                            <div class="mt-1"><security:authentication property="principal.realUser.employeeInfo.infoEmail" /></div>
                                        </div>
                                        <i icon-name="mail" class="w-4 h-4 text-slate-500 ml-auto"></i> 
                                    </div>
                                    <div class="flex items-center pt-5">
                                        <div>
                                            <div class="text-slate-500">Joined Date</div>
<%--                                             <div class="mt-1"> <security:authentication property="principal.realUser.empDate" /></div> --%>
                                            <div id="empDate" class="mt-1">  </div>    
                                        </div>
                                        <i icon-name="clock" class="w-4 h-4 text-slate-500 ml-auto"></i> 
                                    </div>
                                </div>
                            </div>
                        </div>
                 		 </security:authorize>
                    </div>
                </div>
          <!-- END: Chat Side Menu -->
          
          <!--  채팅방 입장 Tap -->
          <!-- BEGIN: Chat Content -->
                <div class="intro-y col-span-12 lg:col-span-8 2xl:col-span-9">
                    <div class="chat__box box" style="height: 80vh; min-height: 500px; max-height: 1080px;">
                    
                        <!-- BEGIN: Chat Active -->
                        
                        <div class="hidden h-full flex flex-col" style="position: relative;">
                            <div class="flex flex-col sm:flex-row border-b border-slate-200/60 dark:border-darkmode-400 px-5 py-4">
                                <div class="flex items-center">
                                    <div class="w-10 h-10 sm:w-12 sm:h-12 flex-none image-fit relative">
                            <!-- img 태그 (상대방 사용자 사진 ) -->
                                        <img id="yourProfile" alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-8.jpg">
                                    </div>
                                    <div class="ml-3 mr-auto">
                                        <div id="opponent" class="font-medium text-base"><!--  요거 상대방으로 변경해야함. MsgInfoVO에서 꺼내자.--><security:authentication property="principal.realUser.empName" /></div>
                                        <div id="lastDate" class="text-slate-500 text-xs sm:text-sm">Hey, I am using chat <span class="mx-1">•</span> Online</div>
                                    </div>
                                </div>
                                <div class="flex items-center sm:ml-auto mt-5 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-3 sm:pt-0 -mx-5 sm:mx-0 px-5 sm:px-0">
                                    <a href="javascript:;" class="w-5 h-5 text-slate-500"> <i icon-name="search" class="w-5 h-5"></i> </a>
                                    <a href="javascript:;" class="w-5 h-5 text-slate-500 ml-5"> <i icon-name="user-plus" class="w-5 h-5"></i> </a>
                                    <div class="dropdown ml-auto sm:ml-3">
                                        <a href="javascript:;" class="dropdown-toggle w-5 h-5 text-slate-500" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="more-vertical" class="w-5 h-5"></i> </a>
                                        <div class="dropdown-menu w-40">
                                            <ul class="dropdown-content">
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="share-2" class="w-4 h-4 mr-2"></i> Share Contact </a>
                                                </li>
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="settings" class="w-4 h-4 mr-2"></i> Settings </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                    <!-- 채팅 방 div -->
                            <div id="messageArea" class="overflow-y-auto scrollbar-hidden px-5 pt-5" style="height: calc(100% - 2rem - 127px);">    
                            
                            </div>      
                        
 <!-- 밑에 내가 단어를 입력할 창인데... 고정되어있으면 좋겠다. -->                       
                            <div id="msgWriteInput" class="pt-4 pb-10 sm:py-4 flex items-center border-t border-slate-200/60 dark:border-darkmode-400" style="position: absolute; bottom: 0; width: 100%;">
                                <textarea id="msgInput" onkeypress=" javascript:if(event.keyCode==13){$('#sendBtn').trigger('click');}" class="chat__box__input form-control dark:bg-darkmode-600 h-16 resize-none border-transparent px-5 py-3 shadow-none focus:border-transparent focus:ring-0" rows="1" placeholder="Type your message..."></textarea>
                                <div class="flex absolute sm:static left-0 bottom-0 ml-5 sm:ml-0 mb-5 sm:mb-0">
                                    <div class="dropdown mr-3 sm:mr-5">  
                                        <a href="javascript:;" id="emoji_btn" class="dropdown-toggle w-4 h-4 sm:w-5 sm:h-5 block text-slate-500" aria-expanded="false"> <i icon-name="smile" class="w-full h-full"></i> </a>
                                    </div>
                                    <div class="w-4 h-4 sm:w-5 sm:h-5 relative text-slate-500 mr-3 sm:mr-5">
                                        <i icon-name="paperclip" class="w-full h-full"></i> 
                                        <input type="file" class="w-full h-full top-0 left-0 absolute opacity-0">
                                    </div>  
                                </div>
                                <a id="sendBtn" href="javascript:;" class="w-8 h-8 sm:w-10 sm:h-10 block bg-primary text-white rounded-full flex-none flex items-center justify-center mr-5"> <i icon-name="send" class="w-4 h-4"></i> </a>
                            </div>
                       <!-- 입력창 끝! -->
                            
                        </div>
                        <!-- END: Chat Active -->
                        
                        
                        <!-- BEGIN: Chat Default -->
                        <div class="h-full flex items-center">
                            <div class="mx-auto text-center">
                                <div class="w-16 h-16 flex-none image-fit rounded-full overflow-hidden mx-auto">
                                    <security:authentication property="principal" var="authMember" />
							        <img alt="Coworkflow" class="rounded-full" src="${cPath }/mypage/<security:authentication property="principal.realUser.mypage.profileImage.empAtchSaveName" />"/>
                                </div>  
                                <div class="mt-3">
<%--                                     <div class="font-medium"> ${sessionScope }     Hey, Arnold Schwarzenegger!</div> --%>
                                    <div class="font-medium">  <security:authentication property="principal.realUser.empName" /> 님 안녕하세요! </div>
                                    <div class="text-slate-500 mt-1">다른 사람과 메신저를 시작해 볼까요?</div>
                                </div>
                            </div>
                        </div>
                        <!-- END: Chat Default -->
                    </div>
                </div>
                <!-- END: Chat Content -->
                
                
            </div>
        </div>
        <!-- END: Content -->
        <!-- 내가 보낸 메시지 템플릿. -->
        <template id="myMsgTemplate" >
        <div class="chat__box__text-box flex items-end float-right mb-4">
               <div class="hidden sm:block dropdown mr-3 my-auto">
                   <a href="javascript:;" class="dropdown-toggle w-4 h-4 text-slate-500" aria-expanded="false" data-tw-toggle="dropdown"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" icon-name="more-vertical" class="lucide lucide-more-vertical w-4 h-4"><circle cx="12" cy="12" r="1"></circle><circle cx="12" cy="5" r="1"></circle><circle cx="12" cy="19" r="1"></circle></svg> </a>
                   <div class="dropdown-menu w-40">
                       <ul class="dropdown-content">
                           <li>
                               <a href="" class="dropdown-item"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" icon-name="corner-up-left" class="lucide lucide-corner-up-left w-4 h-4 mr-2"><polyline points="9 14 4 9 9 4"></polyline><path d="M20 20v-7a4 4 0 0 0-4-4H4"></path></svg> Reply </a>
                           </li>
                           <li>
                               <a href="" class="dropdown-item"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" icon-name="trash" class="lucide lucide-trash w-4 h-4 mr-2"><path d="M3 6h18"></path><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path></svg> Delete </a>
                           </li>
                       </ul>
                   </div>
               </div>
               <div class="bg-primary px-4 py-3 text-white rounded-l-md rounded-t-md">
                   <span class="msgarea"><!--  메세지가 들어가는 곳.--> </span>
                   <div class="mt-1 text-xs text-white text-opacity-80"><!--  시간 찍히는 곳. 정리필요. --></div>
               </div>
               <div class="w-10 h-10 hidden sm:block flex-none image-fit relative ml-5">
                   <img alt="Coworkflow" class="rounded-full" src="/Coworkflow/resources/Rubick/dist/images/profile-2.jpg">
               </div>
           </div>
        </template>
        
        <!-- 내가 보내지 않은 메시지 템플릿. -->
        <template id="nonMyMsgTemplate">
        <div class="chat__box__text-box flex items-end float-left mb-4">
           <!-- 상대이미지야 -->
               <div class="w-10 h-10 hidden sm:block flex-none image-fit relative mr-5">
                   <img alt="Coworkflow" class="rounded-full" src="/Coworkflow/resources/Rubick/dist/images/profile-8.jpg">
               </div>
            <!-- 상대 이미지 끝 -->
               <div class="bg-slate-100 dark:bg-darkmode-400 px-4 py-3 text-slate-500 rounded-r-md rounded-t-md">
                    <span class="msgarea"><!--  메세지가 들어가는 곳.--></span>
                   <div class="mt-1 text-xs text-slate-500 timearea" ><!--  시간 찍히는 곳. 정리필요. --></div>
               </div>
           <!-- 드롭다운 -->    
               <div class="hidden sm:block dropdown ml-3 my-auto">
                   <a href="javascript:;" class="dropdown-toggle w-4 h-4 text-slate-500" aria-expanded="false" data-tw-toggle="dropdown"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" icon-name="more-vertical" class="lucide lucide-more-vertical w-4 h-4"><circle cx="12" cy="12" r="1"></circle><circle cx="12" cy="5" r="1"></circle><circle cx="12" cy="19" r="1"></circle></svg> </a>
                   <div class="dropdown-menu w-40">
                       <ul class="dropdown-content">
                           <li>
                               <a href="" class="dropdown-item"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" icon-name="corner-up-left" class="lucide lucide-corner-up-left w-4 h-4 mr-2"><polyline points="9 14 4 9 9 4"></polyline><path d="M20 20v-7a4 4 0 0 0-4-4H4"></path></svg> Reply </a>
                           </li>
                           <li>
                               <a href="" class="dropdown-item"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" icon-name="trash" class="lucide lucide-trash w-4 h-4 mr-2"><path d="M3 6h18"></path><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path></svg> Delete </a>
                           </li>
                       </ul>
                   </div>
               </div>
           </div>
        </template>
        
        
        <!-- 새로운 채팅을 누르면 나오는 모달 -->
<!-- BEGIN: Modal Content -->
<div id="chatModal" class="modal" tabindex="-1" aria-hidden="true" style="z-index:1000;">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- BEGIN: Modal Header -->
			<div class="modal-header">
				<h2 id="chatModalHeader" class="font-medium text-base mr-auto">새로운 채팅</h2>
			</div>
			
			<!-- END: Modal Header -->
			<!-- BEGIN: Modal Body -->
			<div class="modal-body grid grid-cols-12 gap-4 gap-y-3">
<!-- 			<input type="hidden" id="schdlId"> -->
				<div class="col-span-12 sm:col-span-12">
					<label for="chatTitle" class="form-label">제목</label>
					 <input id="chatTitle" type="text" class="form-control" placeholder="방 제목을 입력해주세요." autocomplete="off">
				</div>
				<!-- 참석자 filter시작 -->
				<div id="chatEmp" class="col-span-12 sm:col-span-12">
					<label for="empId" class="form-label">참석자</label> 
					 <!-- BEGIN: 참석자 Filter -->
                        <div  class="intro-y flex flex-col-reverse sm:flex-row items-center">
                            <div id="empParticipants" class="w-full">  
                                <input type="text" id="empInfoName" name="empInfoName" class="form-control w-full " placeholder="참여자를 선택해주세요." autocomplete="off">
                                <input type="hidden" id="empInfoId" name="empInfoId" value="">
                                <div id="myDropdownSelect" class="inbox-filter dropdown absolute inset-y-0 mr-3 right-0 flex items-center" data-tw-placement="bottom-start">
                                    <i class="dropdown-toggle w-4 h-4 cursor-pointer text-slate-500" role="button" aria-expanded="false" data-tw-toggle="dropdown" icon-name="chevron-down"></i> 
                                    <div class="inbox-filter__dropdown-menu dropdown-menu pt-2">
                                        <div class="dropdown-content">
                                            <div id="empModal" class="grid grid-cols-12 gap-4 gap-y-3 p-3">
                                                <div class="col-span-6">
                                                    <label for="input-filter-2" class="form-label text-xs">부서</label>
                                                    <select id="departList" name="departList" id="departList" class="form-select">
														<c:forEach items="${departList}" var="departList" varStatus="status">
																<option value="${departList.teamName}">${departList.teamName }</option>
														</c:forEach>
													</select>
                                                </div>
                                                <div class="col-span-6">
                                                    <label for="input-filter-1" class="form-label text-xs">이름</label>
                                                    <select id="empId" class="form-select" multiple="multiple"  style="background:none">
													</select>
                                                </div>
                                                <div class="col-span-12 flex items-center mt-3">
                                                    <button class="btn btn-primary w-32 ml-auto" onClick="insertEmpId(); myDropdownSelect.hide();">등록</button>
													<button data-tw-dismiss="modal" onclick="modalEmpClose()" class="btn btn-outline-secondary w-20 mr-1">취소</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
					</div>
				 <!-- END: 참석자 Filter 끝-->
				
			</div>
			<!-- END: Modal Body -->
			<!-- BEGIN: Modal Footer -->
			<div class="modal-footer">
				<button data-tw-dismiss="modal" onclick="modalClose()" class="btn btn-outline-secondary w-20 mr-1">취소</button>
				<button class="btn btn-primary w-20" id="modalSubmit" onclick="allSave()">등록</button>
			</div>
			<!-- END: Modal Footer -->
		</div>
	</div>
</div>
<!-- END: Modal Content -->

<script src="${cPath }/resources/js/msg/msgMain.js"></script>        
<script src="https://cdn.jsdelivr.net/npm/@joeattardi/emoji-button@3.0.3/dist/index.min.js"></script>
<script>
	const button = document.querySelector("#emoji_btn");
	const picker = new EmojiButton({
		position: 'auto',
		i18n: {
			  search: '이모지 검색',        
			  categories: {
			    recents: '최근 사용',
			    smileys: '감정표현',
			    people: '사람',
			    animals: '동물',
			    food: '음식',
			    activities: '활동',
			    travel: '여행',
			    objects: '물건',
			    symbols: '심볼',
			    flags: '깃발'
			  },
			  notFound: '이모지 없음'  
			} 
	});

    button.addEventListener('click', () => {
    	picker.togglePicker(button);
    	document.querySelector('.emoji-picker.light').parentNode.style="position: absolute; right: 0; bottom: 0; z-index: 9999;"    
    });

	picker.on('emoji', emoji => {
  		const text_box = document.querySelector('#msgInput');
  		text_box.value += emoji;  
	});
</script>  