<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>   
<style>
.swal2-container {z-index:10060;}
</style>

<!-- BEGIN: Content -->
        <div class="content">
            <div class="intro-y flex flex-col sm:flex-row items-center mt-8">
                <h2 class="text-lg font-medium mr-auto">
                    Chat
                </h2>
                <div class="w-full sm:w-auto flex mt-4 sm:mt-0">
                <a id="addChat" href="javascript:;" data-tw-toggle="modal" data-tw-target="#chatModal" class="btn btn-primary w-full mt-2"> 새 채팅 Start New Chat </a>
<!--                  <button id="addChat" class="btn btn-primary shadow-md mr-2" >Start New Chat</button> -->
                    <div class="dropdown ml-auto sm:ml-0">
                        <button class="dropdown-toggle btn px-2 box text-slate-500" aria-expanded="false" data-tw-toggle="dropdown">
                            <span class="w-5 h-5 flex items-center justify-center"> 
<!--                             <i class="w-4 h-4" data-lucide="plus" style="z-index:100;" ></i>  -->
	<svg xmlns ="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
	 stroke-linejoin="round" icon-name="plus" class="lucide lucide-plus w-4 h-4" data-lucide="plus"></svg>
                            </span>
                        </button>
                        <div class="dropdown-menu w-40">
                            <ul class="dropdown-content">
                                <li>
     <!-- 그룹채팅 시작 -->
                                    <a href="" class="dropdown-item"> <i icon-name="users" class="w-4 h-4 mr-2"></i> Create Group </a>
                                </li>
                                
     <!-- 설정 필요할까...? 이거를 나중에 화상회의로 할까? -->
                                <li>
                                    <a href="" class="dropdown-item"> <i icon-name="settings" class="w-4 h-4 mr-2"></i> Settings </a>
                                </li>
                            </ul>
                        </div>
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
                                    <button class="nav-link w-full py-2 active" data-tw-toggle="pill" data-tw-target="#chats" type="button" role="tab" aria-controls="chats" aria-selected="true" > Chats </button>
                                </li>
                                <li id="friends-tab" class="nav-item flex-1" role="presentation">
                                    <button class="nav-link w-full py-2" data-tw-toggle="pill" data-tw-target="#friends" type="button" role="tab" aria-controls="friends" aria-selected="false" > Friends </button>
                                </li>
                                <li id="profile-tab" class="nav-item flex-1" role="presentation">
                                    <button class="nav-link w-full py-2" data-tw-toggle="pill" data-tw-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false" > Profile </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    
                    <div class="tab-content">
                        <div id="chats" class="tab-pane active" role="tabpanel" aria-labelledby="chats-tab">
                            <div class="pr-1">
                                <div class="box px-5 pt-5 pb-5 lg:pb-0 mt-5">
                                    <div class="relative text-slate-500">
                                        <input type="text" class="form-control py-3 px-4 border-transparent bg-slate-100 pr-10" placeholder="Search for messages or users...">
                                        <i class="w-4 h-4 hidden sm:absolute my-auto inset-y-0 mr-3 right-0" data-lucide="search"></i> 
                                    </div>
                                    <div class="overflow-x-auto scrollbar-hidden">
                                        <div class="flex mt-5">
                                            <a href="" class="w-10 mr-4 cursor-pointer" >
                                                <div class="w-10 h-10 flex-none image-fit rounded-full">
                                                    <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-8.jpg">
                                                    <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
                                                </div>
                                                <div class="text-xs text-slate-500 truncate text-center mt-2">Arnold Schwarzenegger</div>
                                            </a>
                                            <a href="" class="w-10 mr-4 cursor-pointer">
                                                <div class="w-10 h-10 flex-none image-fit rounded-full">
                                                    <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-2.jpg">
                                                    <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
                                                </div>
                                                <div class="text-xs text-slate-500 truncate text-center mt-2">Sylvester Stallone</div>
                                            </a>
                                            <a href="" class="w-10 mr-4 cursor-pointer">
                                                <div class="w-10 h-10 flex-none image-fit rounded-full">
                                                    <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-5.jpg">
                                                    <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
                                                </div>
                                                <div class="text-xs text-slate-500 truncate text-center mt-2">Russell Crowe</div>
                                            </a>
                                            <a href="" class="w-10 mr-4 cursor-pointer">
                                                <div class="w-10 h-10 flex-none image-fit rounded-full">
                                                    <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-4.jpg">
                                                    <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
                                                </div>
                                                <div class="text-xs text-slate-500 truncate text-center mt-2">Denzel Washington</div>
                                            </a>
                                            <a href="" class="w-10 mr-4 cursor-pointer">
                                                <div class="w-10 h-10 flex-none image-fit rounded-full">
                                                    <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-14.jpg">
                                                    <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
                                                </div>
                                                <div class="text-xs text-slate-500 truncate text-center mt-2">Arnold Schwarzenegger</div>
                                            </a>
                                            <a href="" class="w-10 mr-4 cursor-pointer">
                                                <div class="w-10 h-10 flex-none image-fit rounded-full">
                                                    <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-9.jpg">
                                                    <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
                                                </div>
                                                <div class="text-xs text-slate-500 truncate text-center mt-2">Arnold Schwarzenegger</div>
                                            </a>
                                            <a href="" class="w-10 mr-4 cursor-pointer">
                                                <div class="w-10 h-10 flex-none image-fit rounded-full">
                                                    <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-13.jpg">
                                                    <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
                                                </div>
                                                <div class="text-xs text-slate-500 truncate text-center mt-2">Al Pacino</div>
                                            </a>
                                            <a href="" class="w-10 mr-4 cursor-pointer">
                                                <div class="w-10 h-10 flex-none image-fit rounded-full">
                                                    <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-1.jpg">
                                                    <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
                                                </div>
                                                <div class="text-xs text-slate-500 truncate text-center mt-2">Nicolas Cage</div>
                                            </a>
                                            <a href="" class="w-10 mr-4 cursor-pointer">
                                                <div class="w-10 h-10 flex-none image-fit rounded-full">
                                                    <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-3.jpg">
                                                    <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
                                                </div>
                                                <div class="text-xs text-slate-500 truncate text-center mt-2">Johnny Depp</div>
                                            </a>
                                            <a href="" class="w-10 mr-4 cursor-pointer">
                                                <div class="w-10 h-10 flex-none image-fit rounded-full">
                                                    <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-7.jpg">
                                                    <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
                                                </div>
                                                <div class="text-xs text-slate-500 truncate text-center mt-2">Russell Crowe</div>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            
                    <!--채팅 리스트!!! -->     
                            <div id="msgRoomList" class="chat__chat-list overflow-y-auto scrollbar-hidden pr-1 pt-1 mt-4">
                                
                                <c:if test="${not empty msgInfoList }">	
									<c:forEach var="MsgInfo" items="${msgInfoList }" varStatus="status">
										 <div class="intro-x cursor-pointer box relative flex items-center p-5 ">
	                                    <div class="w-12 h-12 flex-none image-fit mr-1">
	                                        <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-8.jpg">
	                                        <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
	                                    </div>
	                                    <div class="ml-2 overflow-hidden">
	                                        <div class="flex items-center">
	                                            <a href="javascript:;" class="font-medium" data-room-id="${MsgInfo.msgRoomId }"> ${MsgInfo.empName } </a> 
	                                            <div class="text-xs text-slate-400 ml-auto"> &nbsp; &nbsp;  마지막 문자가 온 시간 </div>
	                                        </div>
	                                        <div class="w-full truncate text-slate-500 mt-0.5"> 마지막 문장. </div>
	                                    </div>
	                                </div>
								</c:forEach>
								</c:if>
								
                                <!-- 채팅방들 이지롱 동적으로 생성 어케? -->
<!--                                 <div class="intro-x cursor-pointer box relative flex items-center p-5 "> -->
<!--                                     <div class="w-12 h-12 flex-none image-fit mr-1"> -->
<%--                                         <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-8.jpg"> --%>
<!--                                         <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div> -->
<!--                                     </div> -->
<!--                                     <div class="ml-2 overflow-hidden"> -->
<!--                                         <div class="flex items-center"> -->
<!--                                             <a href="javascript:;" class="font-medium">Arnold Schwarzenegger</a>  -->
<!--                                             <div class="text-xs text-slate-400 ml-auto">01:10 PM</div> -->
<!--                                         </div> -->
<!--                                         <div class="w-full truncate text-slate-500 mt-0.5">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
                                
                            </div>
                        </div>
                        <div id="friends" class="tab-pane" role="tabpanel" aria-labelledby="friends-tab">
                            <div class="pr-1">
                                <div class="box p-5 mt-5">
                                    <div class="relative text-slate-500">
                                        <input type="text" class="form-control py-3 px-4 border-transparent bg-slate-100 pr-10" placeholder="Search for messages or users...">
                                        <i class="w-4 h-4 hidden sm:absolute my-auto inset-y-0 mr-3 right-0" data-lucide="search"></i> 
                                    </div>
                                    <button type="button" class="btn btn-primary w-full mt-3">Invite Friends</button>
                                </div>
                            </div>
                        </div>
                        
             <!-- 프로필!! -->
             			<security:authorize access="isAuthenticated()">
                        <security:authentication property="principal" var="authMember" />
                        <div id="profile" class="tab-pane" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="pr-1">
                                <div class="box px-5 py-10 mt-5">
                                    <div class="w-20 h-20 flex-none image-fit rounded-full overflow-hidden mx-auto">
                                        <img alt="Coworkflow" src="${cPath}/resources/Rubick/dist/images/profile-8.jpg">
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
                                            <div class="mt-1"><security:authentication property="principal.realUser.empDate"  /></div>
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
          
          
          
          <!-- BEGIN: Chat Content -->
                <div class="intro-y col-span-12 lg:col-span-8 2xl:col-span-9">
                    <div class="chat__box box">
                    
                    
                        <!-- BEGIN: Chat Active -->
                        
                        
                        <div class="hidden h-full flex flex-col">
                            <div class="flex flex-col sm:flex-row border-b border-slate-200/60 dark:border-darkmode-400 px-5 py-4">
                                <div class="flex items-center">
                                    <div class="w-10 h-10 sm:w-12 sm:h-12 flex-none image-fit relative">
                            <!-- img 태그 (상대방 사용자 사진 ) -->
                                        <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-8.jpg">
                                    </div>
                                    <div class="ml-3 mr-auto">
                                        <div class="font-medium text-base"><security:authentication property="principal.realUser.empName" /></div>
                                        <div class="text-slate-500 text-xs sm:text-sm">Hey, I am using chat <span class="mx-1">•</span> Online</div>
                                    	
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
                            <div id="messageArea" class="overflow-y-scroll scrollbar-hidden px-5 pt-5 flex-1">
                            
                            <!-- 이 부분 부터 메세지 하나의 모습이 되어야함. 상대방에게 온 메세지 -->
                                <div class="chat__box__text-box flex items-end float-left mb-4">
                                <!-- 상대이미지야 -->
                                    <div class="w-10 h-10 hidden sm:block flex-none image-fit relative mr-5">
                                        <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-8.jpg">
                                    </div>
                                 <!-- 상대 이미지 끝 -->
                                    <div class="bg-slate-100 dark:bg-darkmode-400 px-4 py-3 text-slate-500 rounded-r-md rounded-t-md">
                                        요거는 상대방이 보낸 메세지야! 
                                        <div class="mt-1 text-xs text-slate-500"> 로컬 시간 - 메세지 받은 시간  2 mins ago</div>
                                    </div>
                                <!-- 드롭다운 -->    
                                    <div class="hidden sm:block dropdown ml-3 my-auto">
                                        <a href="javascript:;" class="dropdown-toggle w-4 h-4 text-slate-500" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="more-vertical" class="w-4 h-4"></i> </a>
                                        <div class="dropdown-menu w-40">
                                            <ul class="dropdown-content">
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="corner-up-left" class="w-4 h-4 mr-2"></i> Reply </a>
                                                </li>
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="trash" class="w-4 h-4 mr-2"></i> Delete </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                             <!--  상대방에게 온 메세지 끝 -->   
 
 							<!-- 메세지와 메세지 사이에 하나씩 들어가서 정리해주는 역할.  -->                               
                                <div class="clear-both"></div>
 
                             <!--  내가 보낸 하나의 메세지 -->   
                                <div class="chat__box__text-box flex items-end float-right mb-4">
                                    <div class="hidden sm:block dropdown mr-3 my-auto">
                                        <a href="javascript:;" class="dropdown-toggle w-4 h-4 text-slate-500" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="more-vertical" class="w-4 h-4"></i> </a>
                                        <div class="dropdown-menu w-40">
                                            <ul class="dropdown-content">
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="corner-up-left" class="w-4 h-4 mr-2"></i> Reply </a>
                                                </li>
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="trash" class="w-4 h-4 mr-2"></i> Delete </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="bg-primary px-4 py-3 text-white rounded-l-md rounded-t-md">
                                        이게 내가 보낸 메세지얌. 
                                        <div class="mt-1 text-xs text-white text-opacity-80">1 mins ago</div>
                                    </div>
                                    <div class="w-10 h-10 hidden sm:block flex-none image-fit relative ml-5">
                                        <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-2.jpg">
                                    </div>
                                </div>
                             <!-- 내가 보낸 하나의 메세지 끝 -->   
                                
                                <div class="clear-both"></div>
                                
                      <!-- 중간에 날짜가 바뀔경우 날짜도 입력 해줘야함.  -->
                                <div class="text-slate-400 dark:text-slate-500 text-xs text-center mb-10 mt-5"> 로컬에 따른 날짜 변경이 있으면 적어줘야지 12 June 2020</div>
                      
                      
                                <div class="chat__box__text-box flex items-end float-right mb-4">
                                    <div class="hidden sm:block dropdown mr-3 my-auto">
                                        <a href="javascript:;" class="dropdown-toggle w-4 h-4 text-slate-500" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="more-vertical" class="w-4 h-4"></i> </a>
                                        <div class="dropdown-menu w-40">
                                            <ul class="dropdown-content">
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="corner-up-left" class="w-4 h-4 mr-2"></i> Reply </a>
                                                </li>
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="trash" class="w-4 h-4 mr-2"></i> Delete </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="bg-primary px-4 py-3 text-white rounded-l-md rounded-t-md">
                                        Lorem ipsum 
                                        <div class="mt-1 text-xs text-white text-opacity-80">1 secs ago</div>
                                    </div>
                                    <div class="w-10 h-10 hidden sm:block flex-none image-fit relative ml-5">
                                        <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-2.jpg">
                                    </div>
                                </div>
                                
                                <div class="clear-both"></div>
                        
                        
                         <!-- 입력중을 나타내는 태그!!!! -->
                                <div class="chat__box__text-box flex items-end float-left mb-4">
                                    <div class="w-10 h-10 hidden sm:block flex-none image-fit relative mr-5">
                                        <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-8.jpg">
                                    </div>
                                    <div class="bg-slate-100 dark:bg-darkmode-400 px-4 py-3 text-slate-500 rounded-r-md rounded-t-md">
                                        <security:authentication property="principal.realUser.empName" /> is typing 
                                        <span class="typing-dots ml-1"> <span>.</span> <span>.</span> <span>.</span> </span>
                                    </div>
                                </div>
                            </div>
                        
                        
 <!-- 밑에 내가 단어를 입력할 창인데... 고정되어있으면 좋겠다. -->                       
                            <div class="pt-4 pb-10 sm:py-4 flex items-center border-t border-slate-200/60 dark:border-darkmode-400">
										<button class="wsControl" data-role="connect">연결</button>
										<button class="wsControl" data-role="disconnect" disabled="disabled">종료</button>
										<br />
<!-- 										<input type="text" class="wsControl" id="msgInput"  disabled="disabled"/> -->
										<button class="wsControl" data-role="send"  disabled="disabled">전송</button>
										<div id="messageArea">
										
										</div>
                                <textarea id="msgInput" onkeydown="javascript:if(keyCode==13)" class="chat__box__input form-control dark:bg-darkmode-600 h-16 resize-none border-transparent px-5 py-3 shadow-none focus:border-transparent focus:ring-0" rows="1" placeholder="Type your message..."></textarea>
                                <div class="flex absolute sm:static left-0 bottom-0 ml-5 sm:ml-0 mb-5 sm:mb-0">
                                    <div class="dropdown mr-3 sm:mr-5">
                                        <a href="javascript:;" class="dropdown-toggle w-4 h-4 sm:w-5 sm:h-5 block text-slate-500" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="smile" class="w-full h-full"></i> </a>
                                        <div class="chat-dropdown dropdown-menu">
                                            <div class="dropdown-content">
                                                <div class="chat-dropdown__box flex flex-col">
                                                    <div class="px-1 pt-1">
                                                        <div class="relative text-slate-500">
                                                            <input type="text" class="form-control border-transparent bg-slate-100 pr-10" placeholder="Search emojis...">
                                                            <i class="w-4 h-4 absolute my-auto inset-y-0 mr-3 right-0" data-lucide="search"></i> 
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="w-4 h-4 sm:w-5 sm:h-5 relative text-slate-500 mr-3 sm:mr-5">
                                        <i icon-name="paperclip" class="w-full h-full"></i> 
                                        <input type="file" class="w-full h-full top-0 left-0 absolute opacity-0">
                                    </div>
                                </div>
                                <a href="javascript:;" class="w-8 h-8 sm:w-10 sm:h-10 block bg-primary text-white rounded-full flex-none flex items-center justify-center mr-5"> <i icon-name="send" class="w-4 h-4"></i> </a>
                            </div>
                       <!-- 입력창 끝! -->
                            
                        </div>
                        <!-- END: Chat Active -->
                        
                        
                        
                        
                        <!-- BEGIN: Chat Default -->
                        <div class="h-full flex items-center">
                            <div class="mx-auto text-center">
                                <div class="w-16 h-16 flex-none image-fit rounded-full overflow-hidden mx-auto">
                                    <img alt="Coworkflow" src="${cPath}/resources/Rubick/dist/images/profile-8.jpg"> 2068번째 줄임.
                                </div>
                                <div class="mt-3">
                                    <div class="font-medium"> ${sessionScope }     Hey, Arnold Schwarzenegger!</div>
                                    <div class="text-slate-500 mt-1">Please select a chat to start messaging.</div>
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
                   <span class="msgarea">메세지가 들어가는 곳. </span>
                   <div class="mt-1 text-xs text-white text-opacity-80"> 시간 찍히는 곳. 정리필요.</div>
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
                    <span class="msgarea">메세지가 들어가는 곳.</span>
                   <div class="mt-1 text-xs text-slate-500 timearea" >  시간 찍히는 곳. 정리필요.</div>
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
                        <div class="intro-y flex flex-col-reverse sm:flex-row items-center">
                            <div class="w-full">  
                                <input type="text" id="empInfoName" name="empInfoName" class="form-control w-full " placeholder="참여자를 선택해주세요." autocomplete="off">
                                <input type="hidden" id="empInfoId" name="empInfoId" value="">
                                <div class="inbox-filter dropdown absolute inset-y-0 mr-3 right-0 flex items-center" data-tw-placement="bottom-start">
                                    <i class="dropdown-toggle w-4 h-4 cursor-pointer text-slate-500" role="button" aria-expanded="false" data-tw-toggle="dropdown" icon-name="chevron-down"></i> 
                                    <div class="inbox-filter__dropdown-menu dropdown-menu pt-2">
                                        <div class="dropdown-content">
                                            <div class="grid grid-cols-12 gap-4 gap-y-3 p-3">
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
                                                    <button class="btn btn-primary w-32 ml-auto" onClick="insertEmpId()">등록</button>
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
        
        
<script>
	const msgRoomList = $("#msgRoomList");

	const loginId = localStorage.getItem("empId");
	const messageArea = $("#messageArea");
	const msgInput = $("#msgInput");
	let ws = null;
	const wsControl = $(".wsControl").on("click", function(event){
		switch (this.dataset.role) {
		case "connect":
			ws = connectWS();
			break;

		case "disconnect":
			ws.close(1000);
			break;
			
		case "send":
			let message = msgInput.val();
			ws.send(message);
			msgInput.val("");
			break;
		}
	});
	
	
	function connectWS(){
		let ws = new WebSocket("ws://\${document.location.host}${cPath}/ws/echo");
		ws.onopen=function(event){
			console.log(event);
			messageArea.append($("<p>").html("Connect!"));
			wsControl.prop("disabled", (i,v)=>!v);
		}
		ws.onclose=function(event){
			console.log(event);
			messageArea.append($("<p>").html("DisConnect!"));
			wsControl.prop("disabled", (i,v)=>!v);
		}
		
		ws.onmessage=function(event){
			let messageVO = JSON.parse(event.data);
			
		if(messageVO.empId==loginId){
			const msgClone = myMsgTemplate.content.cloneNode(true);
// 			const allDiv = $(msgClone).find("div");
// 			console.log(allDiv);
			const ulDiv = $(msgClone).find("div").eq(2);
			const msgSpan = $(msgClone).find(".msgarea");
			const timeDiv = $(msgClone).find("div").eq(4);
			const imgDiv = $(msgClone).find("div").eq(5);
			timeDiv.html(messageVO.msgDate)
			msgSpan.html(messageVO.msgContent)
			
		messageArea.append(msgClone);	
// 			messageArea.append($("<div>").append(	
// 				$("<div>").append(
// 						$("<div>").append(
// 								$("<div>").append().html(messageVO.msgDate)
// 						).addClass("w-10 h-10 hidden sm:block flex-none image-fit relative ml-5")
// 				).addClass("bg-primary px-4 py-3 text-white rounded-l-md rounded-t-md").html(messageVO.msgContent)
// 				, $("<img>").addClass("rounded-full")
// 			).addClass("chat__box__text-box flex items-end float-right mb-4"));		
			// 줄 바꾸기
		messageArea.append($("<div>").addClass("clear-both"))
		}else{
			const msgClone = nonMyMsgTemplate.content.cloneNode(true);
			const allDiv= $(msgClone).find("div");
			const imgDiv = $(msgClone).find("div").eq(1);
			const msgSpan = $(msgClone).find(".msgarea");
			const timeDiv = $(msgClone).find("div").eq(3);
			const ulDiv = $(msgClone).find("div").eq(5);
			timeDiv.html(messageVO.msgDate)	
			msgSpan.html(messageVO.msgContent)
			
			messageArea.append(msgClone);
// 			messageArea.append($("<div>").append(	
// 					$("<div>").append(
// 							$("<img>").append().addClass("rounded-full")
// 							).addClass("w-10 h-10 hidden sm:block flex-none image-fit relative mr-5")
// 					, $("<div>").append(
// 							$("<div>").append().html(messageVO.msgDate)	
// 					).addClass("bg-slate-100 dark:bg-darkmode-400 px-4 py-3 text-slate-500 rounded-r-md rounded-t-md").html(messageVO.msgContent)	
// 				).addClass("chat__box__text-box flex items-end float-left mb-4"));
			// 줄 바꾸기	
			messageArea.append($("<div>").addClass("clear-both"))
			}
	}
		
		
		
// 		.addAlt("Coworkflow").addSrc("${cPath}/resources/Rubick/dist/images/profile-2.jpg")
// 		ws.onmessage=function(event){
// 			console.log(event);
// 			let messageVO = JSON.parse(event.data);
// 			messageArea.append($("<p>").append(
// 				$("<span>").addClass("sender").html(messageVO.sender)	
// 				, $("<span>").addClass("message").html(messageVO.message)	
// 			));
// 		}
		return ws;
	}
	
	$(function(){
		$(".chat__chat-list").children().each(function () {
		    $(this).on("click", function () {
		      $(".chat__box").children("div:nth-child(2)").fadeOut(300, function () {
		        $(".chat__box").children("div:nth-child(1)").fadeIn(300, function (el) {
		          $(el).removeClass("hidden").removeAttr("style");
		        });
		      });
		    });
	      });
	});
	
	
</script>
<script>
	window.addEventListener('DOMContentLoaded', function() {
		
		//모달 선택하기
		var chatModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#chatModal"));
		
		//모달 등록버튼 선택하기
		var modalSubmit = $('#modalSubmit');
		
		// 새로운 채팅 추가 버튼 눌렀을떄
		const addChatBtn = $('#addChat');
		addChatBtn.on("click", function() {

			//모달 비우기
			$('#chatTitle').val('');
			$('#empInfoId').val('');
			$('#empInfoName').val('');
			
			// 모달 보여주기
			chatModal.show();
		});
// 		loadChatroomList();  // 이거 채팅 리스트 다시 받아오는거임.  -> 수정 필요.
	});
	
	
	//등록 버튼을 눌렀을 때, 등록이벤트
	function allSave() {
// 	addChat.addEventListener("click", event=>{
		chatModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#chatModal"));

		let chatTitle = $('#chatTitle').val();
		let empInfoId = $('#empInfoId').val();
		let empId = $('#empId').val();
		

		// JSON 데이터 생성
		let sendData = {
				chatTitle : chatTitle,
				empInfoId : empInfoId,
		};

		// AJAX 요청
		$.ajax({
			url : "${cPath}/chatting/makeRoom",
			type : "post",
			data : JSON.stringify(sendData),
			beforeSend : function(xhrToController){
		         xhrToController.setRequestHeader(headerName, headerValue);
		         xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		    },
			contentType : "application/json",
			success : function(res) {
				if(res.result){
					loadChatroomList();
					chatModal.hide();
					// 모달 내용 비우기
					$('#chatTitle').val('');
					$('#empInfoId').val('');
					$('#empInfoName').val('');
				}else{
					loadChatroomList();
					Swal.fire({
						  icon: 'error',
						  title: 'Oops...',
						  text: 'Something went wrong!zzzzzz'
					});
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
	
function modalClose() {
	$("#chatModal #empId").val("");
}
function modalEmpClose(){
	$("#chatEmp #empInfoName").val("");
// 	$("#chatEmp #empInfoName").val("");
}

	//팀명 선택시 해당 팀원 이름만 나오게 만드는 온 체인지
	$('#departList').on('change', function(){
		
		//선택한 요소의 value값을 얻어온다
		depart = $('option:selected', this).val();
// 		alert(depart);
		
		$.ajax({
			url : '${cPath}/calendar/empList',
			type : 'post',
			
			//data : "gu=" + lgu, ==>일반 문자열 방식
			data : {  "depart" : depart  },  //==>json 객체타입 방식
			beforeSend : function(xhrToController){
		         xhrToController.setRequestHeader(headerName, headerValue);
		      },
			success : function(res){
				//데이타가 있는지 없는지 비교
				code = "";
				if(res.result){
					$.each(res.empList, function(i,v){
						code += `<option id="empId" value="\${v.empId}">\${v.empName}</option>`
					})
					
					$('#empId').html(code);
					$('#empId').trigger('change');
				}else{
					code += `<option value="0">데이터없음</option>`;
				}
			},
			error : function(xhr){
				Swal.fire({
					  icon: 'error',
					  title: 'Oops...',
					  text: 'Something went wrong!'
				});
			},
		})
	})
	
	function insertEmpId(){
		$("#empInfoId").val("");
		$("#empInfoName").val("");
		
		var empId = $("#empId").val();
		$("#empInfoId").val($("#empInfoId").val()+""+empId);
		
		var empNameList = $("#empId option:selected");
		empNameList.each(function(){
		    var empName = $(this).text();
			$("#empInfoName").val($("#empInfoName").val()+empName+",");
		});
		$("#empInfoName").val(  ($("#empInfoName").val()).slice(0, ($("#empInfoName").val()).length-1)  );
	}
	
	function loadChatroomList(){
		$.ajax({
			url : "${cPath}/msg/messageResetList.do",
			method : "post",
			data : {},
			dataType : "json",
			beforeSend : function(xhrToController){
		         xhrToController.setRequestHeader(headerName, headerValue);
		    },
		    contentType : "application/json",
		}).done(function(resp, textStatus, jqXHR) {
			console.log(resp.msgInfoList);
		}).fail(function(jqXHR, status, error) {
			console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
		});
	}
</script>
<script>
 window.addEventListener("DOMContentLoaded", ()=>{
	 msgRoomList.addEventListener("click", event=>{
		if(event.target.classList.contains("room")){ 
 			let roomTag = event.target; 
 			let roomId = roomTag.dataset.roomId; 
 			const windowFeatures = "left=100,top=100,width=320,height=320" 
			window.open(`${cPath}/chatting/enter/\${roomId}`, "mozillaWindow", windowFeatures);
 		} 
	});
	
//  	const updateRooms = function(room){
//  		let newLi = document.createElement("li");
//  		newLi.classList.add("room"); 
//  		newLi.dataset.roomId=room.roomId; 
// 	newLi.innerHTML = `\${room.roomTitle}[\${room.owner}]`;
// 	roomUL.appendChild(newLi); 
// 	} 
	
	
 	const client = new StompJs.Client({ 
		brokerURL:"ws://\${document.location.host}${cPath}/ws/rooms",
		debug:function(str){ 
 			console.log(str);
 		}, 
 		onConnect:function(frame){ 
			const subscription1 = this.subscribe("/chatting/roomList", function(msgFrame){ 
 				let room = JSON.parse(msgFrame.body); 
 				updateRooms(room); 
		}); 
 		} 
 	}); 
 	client.activate(); 
//  }); 


</script> 



        