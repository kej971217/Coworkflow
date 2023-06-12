<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %> 
        <!-- BEGIN: Content -->
        <div class="content">
            <div class="grid grid-cols-12 gap-6">
                <div class="col-span-12 2xl:col-span-9">
                    <div class="grid grid-cols-12 gap-6">
                        <!-- BEGIN: General Report -->
                        <div class="col-span-12 mt-8">
                            <div class="intro-y flex items-center h-10">
                                <h2 class="text-lg font-medium truncate mr-5">
                                    &nbsp;
                                </h2>
                                <a href="" class="ml-auto flex items-center text-primary"> <i icon-name="refresh-ccw" class="w-4 h-4 mr-3"></i> Reload Data </a>
                            </div>
                            <div class="grid grid-cols-12 gap-6 mt-5">
                                <div class="col-span-12 sm:col-span-12 xl:col-span-12 intro-y">  
	                                <div class="box p-5 zoom-in">
	                                    <div class="flex">
							                <!-- BEGIN: Profile Info -->
							                <div class="intro-y px-5 pt-5 flex flex-1 flex-col">    
							                    <div class="flex flex-col lg:flex-row border-slate-200/60 dark:border-darkmode-400 pb-5 -mx-5">
							                        <div class="flex flex-1 px-5 items-center justify-center lg:justify-start">
							                            <div class="w-20 h-20 sm:w-24 sm:h-24 flex-none lg:w-32 lg:h-32 image-fit relative">
															<security:authentication property="principal" var="authMember" />
							                    			<img alt="Coworkflow" class="rounded-full" src="${cPath }/mypage/<security:authentication property="principal.realUser.mypage.profileImage.empAtchSaveName" />"/>
							                            </div>    
							                            <div class="ml-5">
							                                <div class="w-24 sm:w-40 truncate sm:whitespace-normal font-medium text-lg"> ${emp.empName } </div>
							                                <div class="text-slate-500" > ${emp.empId } </div>  
							                            </div>  
							                        </div>
							                        <div class="mt-6 lg:mt-0 flex-1 px-5 border-l border-r border-slate-200/60 dark:border-darkmode-400 border-t lg:border-t-0 pt-5 lg:pt-0">
							                            <div class="font-medium text-center lg:text-left lg:mt-3">Info</div>
							                            <div class="flex flex-col justify-center items-center lg:items-start mt-4">
							                                <div class="truncate sm:whitespace-normal flex items-center"> 
<!-- 							                                <span class="text-success"> -->
							                                소　속　|　${emp.teamName } </div>    
							                                <div class="truncate sm:whitespace-normal flex items-center mt-3"> 
							                                직　급　|　${emp.rankName } </div>
							                                <div class="truncate sm:whitespace-normal flex items-center mt-3"> 
							                                직　책　|　${emp.positionName } </div>
							                                <div class="truncate sm:whitespace-normal flex items-center mt-3"> 
							                                직　무　|　${emp.jobName } </div>
							                            </div>
							                        </div>
							                        <div class="mt-6 lg:mt-0 flex-1 px-5 border-l border-slate-200/60 dark:border-darkmode-400 border-t lg:border-t-0 pt-5 lg:pt-0">
							                            <div class="font-medium text-center lg:text-left lg:mt-3">Contact</div>      
							                            <div class="flex flex-col justify-center items-center lg:items-start mt-4">  
							                                <div class="truncate sm:whitespace-normal flex items-center"> 
							                                내　선　|　${emp.comTel } </div>     
							                                <div class="truncate sm:whitespace-normal flex items-center mt-3"> 
							                                모바일　|　${emp.infoHp } </div>
							                                <div class="truncate sm:whitespace-normal flex items-center mt-3"> 
							                                이메일　|　${emp.infoEmail } </div>  
							                                <div class="truncate sm:whitespace-normal flex items-center mt-3"> 
							                                &nbsp;
							                                </div>
							                            </div>    
							                        </div>  
							                    </div>  
							                </div>
							                <!-- END: Profile Info -->
	                                    </div>
	                                </div>
                                </div>
                            </div>
                        <!-- BEGIN: General Report -->  
                        <div class="col-span-12 grid grid-cols-12 gap-6 mt-8">
                            <div class="col-span-12 sm:col-span-6 2xl:col-span-6 intro-y">
                                <div class="box p-5 zoom-in" style="min-height: 230px;">
                                    <div class="items-center">  
                                        <div class="w-2/4">
                                            <div class="text-lg font-medium truncate">출/퇴근 체크</div>  
                                        </div>
                                        <div class="flex-none ml-auto relative m-5">      
											<div class="overflow-x-auto flex flex-row items-start justify-center mb-5" style="padding-bottom: 0;">    
												<div id="nowTimeDiv" class="flex items-center text-3xl items-center justify-center"><%-- 현재 시간 --%></div>
											</div>  
											<div class="overflow-x-auto flex flex-row items-start justify-center" style="width: 100%;">  
				                            	 <div id="commuteStartDiv" class="flex flex-col items-center justify-center">
					                            	 <button class="btn btn-primary w-24 mr-1 mb-2">출근하기</button>
					                            	 <span>　</span>
				                            	 </div>
				                            	 <div style="min-width: 30px;"></div>
				                            	 <div id="commuteEndDiv" class="flex flex-col items-center">
					                            	 <button class="btn btn-outline-primary w-24 inline-block mr-1 mb-2">퇴근하기</button>  
					                            	 <span>　</span>
				                            	 </div>
				                            </div>   
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-span-12 sm:col-span-6 2xl:col-span-6 intro-y">  
                                <div class="flex box p-5 zoom-in" style="min-height: 230px; flex-direction: column;">  
                                    <div class="flex">
                                        <div class="text-lg font-medium truncate mr-3">근무상태 변경</div>
                                    </div>  
                                    <div class="flex flex-1 m-3">                          
				                        <div class="p-5 flex flex-1 flex-col sm:flex-row items-center text-center sm:text-left">  
				                            <div class="overflow-x-auto flex flex-1 flex-row items-center justify-center" style="width: 100%;">	 
				                            	 <div id="updateMeetingDiv" class="flex flex-col items-center commute-status-div">  
					                            	 <button class="btn btn-outline-dark w-24 inline-block mr-1 mb-2">회의</button>
				                            	 </div>
				                            	 <div style="min-width: 10px;"></div>
				                            	 <div id="updateOutsideDiv" class="flex flex-col items-center commute-status-div">
					                            	 <button class="btn btn-outline-dark w-24 inline-block mr-1 mb-2">외근</button>
				                            	 </div>
				                            	 <div style="min-width: 10px;"></div>
				                            	 <div id="updateBusinessTripDiv" class="flex flex-col items-center commute-status-div">
					                            	 <button class="btn btn-outline-dark w-24 inline-block mr-1 mb-2">출장</button>
				                            	 </div>
				                            	 <div style="min-width: 10px;"></div>
				                            	 <div id="updateHomeDiv" class="flex flex-col items-center commute-status-div">
					                            	 <button class="btn btn-outline-dark w-24 inline-block mr-1 mb-2">재택</button>
				                            	 </div>
				                            </div>
				                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- END: General Report -->
                        <!-- 메일 & 결재 시작 -->
                            <div class="grid grid-cols-12 gap-6 mt-10">       
                                <div class="col-span-6 sm:col-span-6 xl:col-span-6 intro-y box">   
	                                <div class="box p-5 zoom-in" style="min-height: 380px;">  
	                                    <div class="flex">
	                                    	<div class="flex flex-1 flex-col">     
												<ul class="nav nav-boxed-tabs" role="tablist">
												    <li id="mail-1-tab" class="nav-item flex flex-1 fix-width" role="presentation" > 
												    	<button class="nav-link w-full py-2 active" data-tw-toggle="pill" data-tw-target="#mail-1-tab" type="button" role="tab" aria-controls="mail-1-tab" aria-selected="true"> 받은메일함 </button> 
												    </li>
												    <li id="mail-2-tab" class="nav-item flex flex-1 fix-width" role="presentation"> 
												    	<button class="nav-link w-full py-2" data-tw-toggle="pill" data-tw-target="#mail-2-tab" type="button" role="tab" aria-controls="mail-2-tab" aria-selected="false"> 보낸메일함 </button> 
												    </li>
												</ul>
												<div class="tab-content mt-5">
												    <div id="mail-1-tab" class="tab-pane leading-relaxed active" role="tabpanel" aria-labelledby="mail-1-tab">
														<div class="overflow-x-auto">
														    <table class="table table-border-none">
														    	<thead >
														    		<tr>
														    			<td colspan="2" class="text-right">  
															    			<a href="${cPath }/mail/mailInbox/mailInboxOpen.do" class="ml-2 text-primary truncate text-sm">Show More</a>
														    			</td>
														    		</tr>
														    	</thead>
														        <tbody id="rMailTbody">
														            <tr>
														                <td colspan="2">Loading...</td>
														            </tr>
														        </tbody>
														    </table>
														</div>
												    </div>
												    <div id="mail-2-tab" class="tab-pane leading-relaxed" role="tabpanel" aria-labelledby="mail-2-tab">
												    	<div class="overflow-x-auto">
														    <table class="table table-border-none">  
														    	<thead >
														    		<tr>
														    			<td colspan="2" class="text-right">  
															    			<a href="${cPath }/mail/mailSent/sentOpenDB.do" class="ml-2 text-primary truncate text-sm">Show More</a>
														    			</td>
														    		</tr>
														    	</thead>
														        <tbody id="sMailTbody">
														            <tr>
														                <td colspan="2">Loading...</td>
														            </tr>
														        </tbody>
														    </table>
														</div>
												    </div>
												</div>
	                                    	</div>
	                                    </div>
	                                </div>
                                </div>
                                <div class="col-span-6 sm:col-span-6 xl:col-span-6 intro-y">    
	                                <div class="box p-5 zoom-in" style="min-height: 380px;">
	                                    <div class="flex">
	                                    	<div class="flex flex-1 flex-col">
												<ul class="nav nav-boxed-tabs" role="tablist">
												    <li id="approval-1-tab" class="nav-item flex-1 fix-width" role="presentation"> <button class="nav-link w-full py-2 active" data-tw-toggle="pill" data-tw-target="#approval-1-tab" type="button" role="tab" aria-controls="approval-1-tab" aria-selected="true"> 상신함 </button> </li>
												    <li id="approval-2-tab" class="nav-item flex-1 fix-width" role="presentation"> <button class="nav-link w-full py-2" data-tw-toggle="pill" data-tw-target="#approval-2-tab" type="button" role="tab" aria-controls="approval-2-tab" aria-selected="false"> 미결함 </button> </li>
												</ul>
												<div class="tab-content mt-5">
												    <div id="approval-1-tab" class="tab-pane leading-relaxed active" role="tabpanel" aria-labelledby="approval-1-tab">
												    	<div class="overflow-x-auto">
														    <table class="table table-border-none">
														    	<thead >
														    		<tr>
														    			<td colspan="2" class="text-right">  
															    			<a href="${cPath }/" class="ml-2 text-primary truncate text-sm">Show More</a>
														    			</td>
														    		</tr>
														    	</thead>
														        <tbody id="approvalTbody">
														            <tr>
														                <td colspan="2">Loading...</td>
														            </tr>
														        </tbody>
														    </table>
														</div>
												    </div>
												    <div id="approval-2-tab" class="tab-pane leading-relaxed" role="tabpanel" aria-labelledby="approval-2-tab">
												    	<div class="overflow-x-auto">
														    <table class="table table-border-none">
														    	<thead >
														    		<tr>
														    			<td colspan="2" class="text-right">  
															    			<a href="${cPath }/" class="ml-2 text-primary truncate text-sm">Show More</a>
														    			</td>
														    		</tr>
														    	</thead>
														        <tbody id="unsetApprovalTbody">
														            <tr>
														                <td colspan="2">Loading...</td>
														            </tr>
														        </tbody>
														    </table>
														</div>
												    </div>
												</div>
	                                    	</div>
	                                    </div>
	                                </div>
                                </div>
                            </div>  
                        </div>
                        <!-- 메일 & 결재 끝 -->  
                       	<!-- 공지사항 시작 -->  
                        <div class="col-span-12 mt-6">
                            <div class="intro-y block sm:flex items-center h-10">
                                <h2 class="text-lg font-medium truncate mr-5">
                                <i class="fa-solid fa-bullhorn mr-2"> </i>공지사항 <a href="${cPath }/board/notice/noticeBoardList.do" class="ml-2 text-primary truncate text-sm">Show More</a> 
                                </h2>
                            </div>
                            <div class="intro-y overflow-auto lg:overflow-visible mt-8 sm:mt-0">
                                <table class="table table-report sm:mt-2">
                                    <thead>
                                        <tr>
                                            <th class="whitespace-nowrap">번호</th>
                                            <th class="whitespace-nowrap">제목</th>
                                            <th class="text-center whitespace-nowrap">작성자</th>
                                            <th class="text-center whitespace-nowrap">작성일시</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="zoom-in">   
                                            <td class="w-40">
                                            	${notice.postList[0].postId }  
                                            </td>
                                            <td>
                                                <a href="${cPath }/board/notice/noticeBoardView.do?what=${notice.postList[0].postId }" class="font-medium whitespace-nowrap">${notice.postList[0].postTitle }</a>       
                                                <div class="text-slate-500 text-xs whitespace-nowrap mt-0.5">${notice.postList[0].postContent }</div>    
                                            </td>  
                                            <td class="w-40">
                                                <div class="flex items-center justify-center">${notice.postList[0].empName }</div>
                                            </td>
                                            <td class="table-report__action w-56">
                                                <div class="flex justify-center items-center">${notice.postList[0].postDate }</div>
                                            </td>
                                        </tr>
                                        <tr class="zoom-in">   
                                            <td class="w-40">
                                            	${notice.postList[1].postId }  
                                            </td>
                                            <td>
                                                <a href="${cPath }/board/notice/noticeBoardView.do?what=${notice.postList[1].postId }" class="font-medium whitespace-nowrap">${notice.postList[1].postTitle }</a>     
                                                <div class="text-slate-500 text-xs whitespace-nowrap mt-0.5">${notice.postList[1].postContent }</div>
                                            </td>
                                            <td class="w-40">
                                                <div class="flex items-center justify-center">${notice.postList[1].empName }</div>
                                            </td>
                                            <td class="table-report__action w-56">
                                                <div class="flex justify-center items-center">${notice.postList[1].postDate }</div>
                                            </td>
                                        </tr>
                                        <tr class="zoom-in">   
                                            <td class="w-40">
                                            	${notice.postList[2].postId }  
                                            </td>
                                            <td>
                                                <a href="${cPath }/board/notice/noticeBoardView.do?what=${notice.postList[2].postId }" class="font-medium whitespace-nowrap">${notice.postList[2].postTitle }</a>     
                                                <div class="text-slate-500 text-xs whitespace-nowrap mt-0.5">${notice.postList[2].postContent }</div>
                                            </td>
                                            <td class="w-40">
                                                <div class="flex items-center justify-center">${notice.postList[2].empName }</div>
                                            </td>
                                            <td class="table-report__action w-56">
                                                <div class="flex justify-center items-center">${notice.postList[2].postDate }</div>
                                            </td>
                                        </tr>
                                        <tr class="zoom-in">   
                                            <td class="w-40">
                                            	${notice.postList[3].postId }    
                                            </td>
                                            <td>
                                                <a href="${cPath }/board/notice/noticeBoardView.do?what=${notice.postList[3].postId }" class="font-medium whitespace-nowrap">${notice.postList[3].postTitle }</a>     
                                                <div class="text-slate-500 text-xs whitespace-nowrap mt-0.5">${notice.postList[3].postContent }</div>
                                            </td>
                                            <td class="w-40">
                                                <div class="flex items-center justify-center">${notice.postList[3].empName }</div>
                                            </td>
                                            <td class="table-report__action w-56">
                                                <div class="flex justify-center items-center">${notice.postList[3].postDate }</div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="intro-y flex flex-wrap sm:flex-row sm:flex-nowrap items-center mt-3">
                            </div>
                        </div>
                        <!-- 공지사항 끝 --> 
                        <!-- 통계 1 시작 -->
                        <div class="col-span-12 lg:col-span-6 mt-1">
                            <div class="intro-y block sm:flex items-center h-10">  
                                <h2 class="text-lg font-medium truncate mr-5">
                                    <i class="fa-solid fa-diagram-project mr-2"></i>부서별 인원 수
                                </h2>
                            </div>  
                            <div class="box p-5 mt-5 zoom-in" style="height: 389px;">     
                                <div style="height: 100%;">
                                    <div style="height: 100%;">    
							    		<canvas id="myChart2"></canvas>   
							    	</div>
                                </div>
                            </div>
                        </div>
                        <!-- 통계 1 끝 -->
                        <!-- 통계 2 시작 -->
                        <div class="col-span-12 sm:col-span-6 lg:col-span-3 mt-1">
                            <div class="intro-y flex items-center h-10">
                                <h2 class="text-lg font-medium truncate mr-5">
                                    <i class="fa-solid fa-list mr-2"></i>직급별 인원 수
                                </h2>
                            </div>
                            <div class="box p-5 mt-5 zoom-in" style="height: 389px;"> 
                                <div style="height: 100%;">  
                                    <div style="height: 100%;">
                                        <canvas id="myChart1"></canvas>  
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 통계 2 끝 -->  
                        <!-- 통계 3 시작 -->
                        <div class="col-span-12 sm:col-span-6 lg:col-span-3 mt-1">  
                            <div class="intro-y flex items-center h-10">
                                <h2 class="text-lg font-medium truncate mr-5">
                                    <i class="fa-solid fa-venus-mars mr-2"></i>성별 인원 수
                                </h2>
                            </div>
                            <div class="box p-5 mt-5 zoom-in" style="height: 389px;"> 
                                <div style="height: 100%;">  
                                    <div style="height: 100%;"> 
                                        <canvas id="myChart21"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 통계 3 끝 -->
                    </div>
                </div>
                <div class="col-span-12 2xl:col-span-3">
                    <div class="2xl:border-l -mb-10 pb-10">
                        <div class="2xl:pl-6 grid grid-cols-12 gap-x-6 2xl:gap-x-0 gap-y-6">

                            <!-- 일정 시작 -->
                            <div class="col-span-12 md:col-span-6 xl:col-span-4 2xl:col-span-12 xl:col-start-1 xl:row-start-2 2xl:col-start-auto 2xl:row-start-auto mt-7">    
                                <div class="intro-x flex items-center h-10">
                                    <h2 class="text-lg font-medium truncate mr-5">
                                        <i class="fa-solid fa-calendar-days mr-2"></i>일정
                                    </h2>
                                    <a href="" class="ml-auto text-primary truncate flex items-center"> <i icon-name="plus" class="w-4 h-4 mr-1"></i> 일정 등록 </a>
                                </div>
                                <div class="mt-5">
                                    <div class="box zoom-in">  
                                        <div class="p-5">
                                           	<%-- 캘린더 --%>
                                           	<div id="widget-calendar" class="intro-y"></div>
                                        </div>
                                        <div id="widget-events" class="border-t border-slate-200/60 p-5">
                                            <div class="flex items-center text-slate-500">
                                            Loading...
                                            </div>
<!--                                             <div class="flex items-center mt-4"> -->
<!--                                                 <div class="w-2 h-2 bg-primary rounded-full mr-3"></div> -->
<!--                                                 <span class="truncate">VueJs Frontend Development</span> <span class="font-medium xl:ml-auto">10th</span>  -->
<!--                                             </div> -->
<!--                                             <div class="flex items-center mt-4"> -->
<!--                                                 <div class="w-2 h-2 bg-warning rounded-full mr-3"></div> -->
<!--                                                 <span class="truncate">Laravel Rest API</span> <span class="font-medium xl:ml-auto">31th</span>  -->
<!--                                             </div> -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- 일정 끝 -->    
                            <!-- 오늘의 휴가자 시작 -->
                            <div class="col-span-12 md:col-span-6 xl:col-span-4 2xl:col-span-12 mt-3 2xl:mt-8">
                                <div class="intro-x flex items-center h-10">
                                    <h2 class="text-lg font-medium truncate mr-5">
                                    <i class="fa-solid fa-mug-hot mr-2"></i>오늘의 휴가자
                                    </h2>
                                </div>
                                <div class="mt-5">
                                	<div id="todayVacationDiv" >
	                                    <div class="intro-x">         
	                                        <div class="box px-5 py-3 mb-3 flex items-center zoom-in" style="min-height: 64px;">
	                                            <div class="ml-1 mr-auto">  
	                                                <div class="font-medium text-slate-500">Loading...</div>   
	                                            </div>
	                                        </div>
	                                    </div>
                                    </div>
                                    <a href="${cPath }/employeeInfo/teamInfo/vacationStatus.do" class="intro-x w-full block text-center rounded-md py-3 border border-dotted border-slate-400 dark:border-darkmode-300 text-slate-500">팀 휴가현황 조회</a> 
                                </div>
                            </div>
                            <!-- 오늘의 휴가자 끝 -->
                            <!-- 웹 크롤링 시작 -->
                            <div class="col-span-12 md:col-span-6 xl:col-span-12 xl:col-start-1 xl:row-start-1 2xl:col-start-auto 2xl:row-start-auto mt-3">
                                <div class="intro-x flex items-center h-10">
                                    <h2 class="text-lg font-medium truncate mr-auto">
                                        <i class="fa-regular fa-newspaper mr-2"></i>뉴스
                                    </h2>
									<div class="search sm:block">
				                        <input id="newsKeyword" type="text" class="search__input form-control border-transparent" 
				                        onkeydown="javascript: if(event.keyCode == 13){crawling();}" value="" placeholder="Search...">
				                        <i icon-name="search" class="search__icon dark:text-slate-500" onclick="crawling();" style="cursor: pointer;"></i>  
				                    </div>  
                                </div>
                                <div class="mt-5 intro-x" style="min-height: 1000px;">      
                                    <div class="box">  
                                        <div class="tiny-slider" id="newsListDiv">  
                                            <div class="p-5">
                                                <div class="font-medium text-slate-500">검색어를 입력하세요.</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- 웹 크롤링 끝 -->  
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END: Content -->
<script>

//출퇴근 체크
const commuteStartBtn = $("#commuteStartDiv button");
const commuteEndBtn = $("#commuteEndDiv button");

//눌릴 수 있느냐 없느냐
var startCheck = false;
var endCheck = false;


//근무상태 변경
const updateMeetingBtn = $("#updateMeetingDiv button");
const updateOutsideBtn = $("#updateOutsideDiv button");
const updateBusinessTripBtn = $("#updateBusinessTripDiv button");
const updateHomeBtn = $("#updateHomeDiv button");





             	
    
commuteStartBtn.on("click", function(){
	if(startCheck){
		$.ajax({
			url : "${cPath}/employeeInfo/dutyManagement/createMyCommute.do",
			method : "post", 
			data : {},
			//dataType : "json",
			beforeSend : function(xhrToController){
				xhrToController.setRequestHeader(headerName, headerValue);
		        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
			}
		}).done(function(resp, textStatus, jqXHR) {
// 			console.log("성공");
			retrieveMyCommuteToday();
		}).fail(function(jqXHR, status, error) {
			console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
		});
	}else{
		Swal.fire({
			  icon: 'error',
			  title: 'Alert',
			  text: '이미 출근했습니다.'
		});
	}
});

commuteEndBtn.on("click", function(){
	if(endCheck){
		$.ajax({
			url : "${cPath}/employeeInfo/dutyManagement/modifyMyCommute.do",
			method : "post", 
			data : {}, 
			//dataType : "json",
			beforeSend : function(xhrToController){
				xhrToController.setRequestHeader(headerName, headerValue);
		        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
			}
		}).done(function(resp, textStatus, jqXHR) {
// 			console.log("성공");
			retrieveMyCommuteToday();
		}).fail(function(jqXHR, status, error) {
			console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
		});
	}else{
		Swal.fire({
			  icon: 'error',
			  title: 'Alert',
			  text: '이미 퇴근했습니다.'
		});
	}
});


updateMeetingBtn.on("click", function(){
	$.ajax({
		url : "${cPath}/employeeInfo/dutyManagement/modifyMyCommuteStatus.do?status=meeting",
		method : "post",
		data : {},
// 		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log("성공");
		retrieveMyCommuteToday();
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
});

updateOutsideBtn.on("click", function(){
	$.ajax({
		url : "${cPath}/employeeInfo/dutyManagement/modifyMyCommuteStatus.do?status=outside",
		method : "post",
		data : {},
// 		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log("성공");
		retrieveMyCommuteToday();
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
});

updateBusinessTripBtn.on("click", function(){
	$.ajax({
		url : "${cPath}/employeeInfo/dutyManagement/modifyMyCommuteStatus.do?status=businessTrip",
		method : "post",
		data : {},
// 		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log("성공");
		retrieveMyCommuteToday();
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
});

updateHomeBtn.on("click", function(){
	$.ajax({
		url : "${cPath}/employeeInfo/dutyManagement/modifyMyCommuteStatus.do?status=home",
		method : "post",
		data : {},
// 		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log("성공");
		retrieveMyCommuteToday();
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
});





function retrieveMyCommuteToday(){
	$.ajax({
		url : "${cPath}/employeeInfo/dutyManagement/retrieveMyCommuteToday.do",
		method : "get",
		data : {},
		 //dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log("성공");
// 		console.log("resp", resp);
// 		console.log("jqXHR", jqXHR);
		
		if(resp.commuteStart == null){  // 출근을 안함 
			startCheck = true;
			endCheck = false;
			$("#commuteEndDiv button").attr("class", "btn btn-outline-secondary w-24 inline-block mr-1 mb-2");
// 			$("#commuteEndDiv button")[0].disabled = true;
			
		}else if(resp.commuteStart != null && resp.commuteEnd == null){ // 출근은 하고, 퇴근은 안함
			startCheck = false;
			endCheck = true;
			$("#commuteStartDiv button").attr("class", "btn btn-outline-secondary w-24 inline-block mr-1 mb-2");
			$("#commuteEndDiv button").attr("class", "btn btn-primary w-24 inline-block mr-1 mb-2");
		}else { // 출근을 함, 근데 퇴근도 함
			startCheck = false;
			endCheck = false;
			$("#commuteEndDiv button").attr("class", "btn btn-outline-secondary w-24 inline-block mr-1 mb-2");
			$("#commuteStartDiv button").attr("class", "btn btn-outline-secondary w-24 inline-block mr-1 mb-2");
		}
		
// 		const updateMeetingBtn = $("#updateMeetingDiv button");
// 		const updateOutsideBtn = $("#updateOutsideDiv button");
// 		const updateBusinessTripBtn = $("#updateBusinessTripDiv button");
// 		const updateHomeBtn = $("#updateHomeDiv button");

		if(resp.commuteStatus == "E007"){
// 			console.log("회의");
			$("#updateMeetingDiv button").attr("class", "btn btn-outline-secondary w-24 inline-block mr-1 mb-2");
			$("#updateOutsideDiv button").attr("class", "btn btn-outline-dark w-24 inline-block mr-1 mb-2");
			$("#updateBusinessTripDiv button").attr("class", "btn btn-outline-dark w-24 inline-block mr-1 mb-2");
			$("#updateHomeDiv button").attr("class", "btn btn-outline-dark w-24 inline-block mr-1 mb-2");
		}else if(resp.commuteStatus == "E003"){
// 			console.log("외근");
			$("#updateMeetingDiv button").attr("class", "btn btn-outline-dark w-24 inline-block mr-1 mb-2");
			$("#updateOutsideDiv button").attr("class", "btn btn-outline-secondary w-24 inline-block mr-1 mb-2");
			$("#updateBusinessTripDiv button").attr("class", "btn btn-outline-dark w-24 inline-block mr-1 mb-2");
			$("#updateHomeDiv button").attr("class", "btn btn-outline-dark w-24 inline-block mr-1 mb-2");
		}else if(resp.commuteStatus == "E008"){
// 			console.log("출장");
			$("#updateMeetingDiv button").attr("class", "btn btn-outline-dark w-24 inline-block mr-1 mb-2");
			$("#updateOutsideDiv button").attr("class", "btn btn-outline-dark w-24 inline-block mr-1 mb-2");
			$("#updateBusinessTripDiv button").attr("class", "btn btn-outline-secondary w-24 inline-block mr-1 mb-2");
			$("#updateHomeDiv button").attr("class", "btn btn-outline-dark w-24 inline-block mr-1 mb-2");
		}else if(resp.commuteStatus == "E009"){
// 			console.log("재택");
			$("#updateMeetingDiv button").attr("class", "btn btn-outline-dark w-24 inline-block mr-1 mb-2");
			$("#updateOutsideDiv button").attr("class", "btn btn-outline-dark w-24 inline-block mr-1 mb-2");
			$("#updateBusinessTripDiv button").attr("class", "btn btn-outline-dark w-24 inline-block mr-1 mb-2");
			$("#updateHomeDiv button").attr("class", "btn btn-outline-secondary w-24 inline-block mr-1 mb-2");
		}
		
		
		$("#commuteStartDiv span").html(resp.commuteStart);
		$("#commuteEndDiv span").html(resp.commuteEnd);
		
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}  

function getTime(){
	var now = new Date();
	
	var hour = padStartZero(now.getHours());
	var minute = padStartZero(now.getMinutes());
	var second = padStartZero(now.getSeconds());
	
	var nowTimeDiv = $("#nowTimeDiv");
	
	
	var time = `\${hour}:\${minute}:\${second}`;
	
	nowTimeDiv.html(time);
	setTimeout(getTime, 1000);
	
	
// 	setTimeout(() => {
// 		getTime();
// 	}, 1000);
	
	
}


function padStartZero(num){
	return (num).toString().padStart(2,'0');
}
  
//받은메일함 목록 불러오기
function receiveMailLoad(){
	$.ajax({
		url : "${cPath}/recieveMailBox.do",    
		method : "get",
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
// 	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		}
	}).done(function(resp, textStatus, jqXHR) {
//		console.log(resp);    
// 		console.log(resp.mailList.dataList);  
		$("#rMailTbody").html("");
		var defaultNo = 5; 
		if(resp.mailList.dataList.length == 0){
			var content =
			`<tr>D
				<td>목록이 없습니다.</td>
			</tr>`;
			$("#rMailTbody").append(content);
		}else{
			if(resp.mailList.dataList.length<5){  
				defaultNo = resp.mailList.dataList.length;
			}
			for(var i=0; i< defaultNo; i++){
				var content =
				`<tr>
					<td>\${resp.mailList.dataList[i].mailInboxTitle}</td>  
					<td align="right">\${resp.mailList.dataList[i].mailInboxDate[0]}-\${padStartZero(resp.mailList.dataList[i].mailInboxDate[1])}-\${padStartZero(resp.mailList.dataList[i].mailInboxDate[2])}</td>  
				</tr>`;  
				$("#rMailTbody").append(content);
			}  
		} 
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}
  
//보낸메일함 목록 불러오기
function sentMailLoad(){
	$.ajax({
		url : "${cPath}/sentMailBox.do",    
		method : "get",  
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
// 	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); 
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);     
// 		console.log(resp.mailList.dataList);
		$("#sMailTbody").html("");
		var defaultNo = 5; 
		if(resp.mailList.dataList.length == 0){
			var content =
			`<tr>
				<td>목록이 없습니다.</td>
			</tr>`;
			$("#sMailTbody").append(content);
		}else{
			if(resp.mailList.dataList.length<5){  
				defaultNo = resp.mailList.dataList.length;
			}
			for(var i=0; i< defaultNo; i++){
				var content =
				`<tr>
					<td>\${resp.mailList.dataList[i].mailInboxTitle}</td>  
					<td align="right">\${resp.mailList.dataList[i].mailSendDate[0]}-\${padStartZero(resp.mailList.dataList[i].mailSendDate[1])}-\${padStartZero(resp.mailList.dataList[i].mailSendDate[2])}</td>       
				</tr>`;    
				$("#sMailTbody").append(content);
			}  
		} 
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}

// 상신함 목록 불러오기
function approvalLoad(){
	$.ajax({
		url : "${cPath}/approval/approvalListJson",    
		method : "get",
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
// 	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
		$("#approvalTbody").html("");
		var defaultNo = 5; 
		if(resp.dataList.length == 0){
			var content =
			`<tr>  
				<td>목록이 없습니다.</td>
			</tr>`;  
			$("#approvalTbody").append(content);
		}else{  
			if(resp.dataList.length<5){  
				defaultNo = resp.dataList.length;
			}
			for(var i=0; i< defaultNo; i++){
				var content =  
				`<tr>
					<td>\${resp.dataList[i].aprvDocTitle}</td>  
					<td align="right">\${resp.dataList[i].aprvDocDate.substring(0,10)}</td>        
				</tr>`;  
				$("#approvalTbody").append(content);  
			}      
		}  
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}


// 미결함 목록 불러오기
function unsetApprovalLoad(){
	$.ajax({
		url : "${cPath}/approval/unsetApprovalList",    
		method : "get",
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
// 	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);  
		$("#unsetApprovalTbody").html("");
		var defaultNo = 5; 
		if(resp.dataList.length == 0){
			var content =
			`<tr>  
				<td>목록이 없습니다.</td>
			</tr>`;  
			$("#unsetApprovalTbody").append(content);
		}else{  
			if(resp.dataList.length<5){  
				defaultNo = resp.dataList.length;
			}
			for(var i=0; i< defaultNo; i++){
				var content =  
				`<tr>
					<td>\${resp.dataList[i].aprvDocTitle}</td>  
					<td align="right">\${resp.dataList[i].aprvDocDate.substring(0,10)}</td>        
				</tr>`;  
				$("#unsetApprovalTbody").append(content);  
			}      
		}   
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}


//부서별 직원 수 차트에 뽑는 함수
function depEmpCntDataLoad(){
	$.ajax({
		url : "${cPath}/employeeInfo/reports/depEmpCnt.do",
		method : "post",
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
// 	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
		let labels = [];
		let data = [];
		
		var depEmpSumCnt = 0;
		for (let i=0; i<resp.depEmpCntList.length; i++) {
			labels.push(resp.depEmpCntList[i].teamName);
			data.push(resp.depEmpCntList[i].teamCnt);
			depEmpSumCnt += resp.depEmpCntList[i].teamCnt;
		}
		
		var myChart2 = document.getElementById('myChart2');
		new Chart(myChart2, {
		  type: 'bar', 	
		  data: {
		    labels: labels,
		    datasets: [{
		      label: '[현재 총: ' + depEmpSumCnt + '명] 부서별 인원 수 ',
		      data: data,
		      backgroundColor: [
		          'rgba(255, 99, 132, 0.2)',
		          'rgba(255, 159, 64, 0.2)',
		          'rgba(255, 205, 86, 0.2)',
		          'rgba(75, 192, 192, 0.2)',
		          'rgba(54, 162, 235, 0.2)',
		          'rgba(153, 102, 255, 0.2)',
		          'rgba(201, 203, 207, 0.2)'
		      ],
		      borderColor: [
		          'rgb(255, 99, 132)',
		          'rgb(255, 159, 64)',
		          'rgb(255, 205, 86)',
		          'rgb(75, 192, 192)',
		          'rgb(54, 162, 235)',
		          'rgb(153, 102, 255)',
		          'rgb(201, 203, 207)'
		      ],
		      borderWidth: 1,
		    }]
		  },
		  options: {
			layout: {
		        padding: {
		            left: 80,
		            right: 80    
		        }
		    }, 
		    indexAxis: 'y',
		    elements: {
		        bar: {
		          borderWidth: 2,
		        }
		    },
		    responsive: true,
		    maintainAspectRatio: false,
		    plugins: {
// 		      datalabels: {display: false}    
// 	 	      legend: {position: 'right'},
//	 	      title: {display: true, text: '부서별 인원'}  
		    },
			scales: {
		      y: {beginAtZero: true},
// 		      x: {display: false}
		    }
		  }
		});
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}   

//직급별 인원 수 차트에 뽑는 함수
function rankCntDataLoad(){
	$.ajax({  
		url : "${cPath}/employeeInfo/reports/rankCnt.do",
		method : "post",  
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
// 	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
		var labels = resp.rankCntList.map(function(item) { return item.rankName; });
		var data = resp.rankCntList.map(function(item) { return item.rankCnt; });
		
		var rankSumCnt = resp.rankCntList.reduce(function(sum, item) {
			return sum + item.rankCnt;
		}, 0);
		
		var myChart1 = document.getElementById('myChart1');
		new Chart(myChart1, {
		  type: 'pie',
		  data: {
		    labels: labels,
		    datasets: [{
		      label: '[현재 총: ' + rankSumCnt + '명] 직급별 인원 수 ',
		      data: data,
		      backgroundColor: [
		          'rgba(255, 99, 132, 0.2)',
		          'rgba(255, 159, 64, 0.2)',
		          'rgba(255, 205, 86, 0.2)',
		          'rgba(75, 192, 192, 0.2)',
		          'rgba(54, 162, 235, 0.2)',
		          'rgba(153, 102, 255, 0.2)',
		          'rgba(201, 203, 207, 0.2)'],
		      borderColor: [
		          'rgb(255, 99, 132)',
		          'rgb(255, 159, 64)',
		          'rgb(255, 205, 86)',
		          'rgb(75, 192, 192)',
		          'rgb(54, 162, 235)',
		          'rgb(153, 102, 255)',
		          'rgb(201, 203, 207)'],
		      borderWidth: 1
		    }]
		  },
		  options: {
			responsive: true,
			maintainAspectRatio: false,  
// 			layout: {
// 		        padding: {left: 50}  
// 		    },
		    plugins: {
// 		    	datalabels: {display: false},    
// 		    	legend: {display: false},  
			 },
		    scales: {  
		      x: {display: false},
		      y: {display: false, beginAtZero: true},
		    }
		  }
		});
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}

//성별 인원 수 차트에 뽑는 함수
function depGendRatioLoad(){
	$.ajax({
		url : "${cPath}/employeeInfo/reports/depGendRatio.do",
		method : "post",
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
		let labels = [];
		let data1 = [];
		let data2 = [];
		for (let i=0; i<resp.depGendRatioList.length; i++) {
			labels.push(resp.depGendRatioList[i].teamName);
			data1.push(resp.depGendRatioList[i].femaleCnt);
			data2.push(resp.depGendRatioList[i].maleCnt);  
		}
		var myChart21 = document.getElementById('myChart21');
		var myChart21Data = {
		  labels: labels,
			  datasets: [
				{type: 'bar',
			    label: '여성',
			    data: data1,
			    borderColor: 'rgb(255, 99, 132)',
			    backgroundColor: 'rgba(255, 99, 132, 0.2)',
			    borderWidth: 1}, 
			    {type: 'bar',
			    label: '남성',  
			    data: data2,
			    borderColor: 'rgb(54, 162, 235)',
			    backgroundColor: 'rgba(54, 162, 235, 0.2)',
			    borderWidth: 1}
			  ]
			};  
		  
		new Chart(myChart21, {
		  type: 'bar',
		  data: myChart21Data,
		  options: {
			    indexAxis: 'y',
			    elements: {
			        bar: {
			          borderWidth: 2,
			        }
			    },
			    responsive: true,
			    maintainAspectRatio: false,
			  scales: {
			  	x: {stacked: true},  
		        y: {stacked: true, beginAtZero: true}  
		    }
		  }
		});
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}


function colorCalnedarDataLoad(){
	$.ajax({
		url : "${cPath}/calendar/calendarList_FC",
		method : "get",
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
		var newDataArr = [];
		resp.forEach(function(data){
			var newDataObj = {
				id: data.id,
				name: data.title,
				start: data.start,
				end: data.end
			};  
		newDataArr.push(newDataObj);  
// 		console.log(data);
		});
//		console.log(newDataArr);
		
		// 풀캘린더 json 데이터를 칼라캘린더 형식에 맞게 변환하여 Setting
		myColorCalendar.setEventsData(newDataArr);
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}

// 오늘의 휴가자
function todayVacationListLoad(){
	$.ajax({
		url : "${cPath}/todayTeamVacationList.do",
		method : "get",
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
// 		console.log(resp.todayList);  
		$("#todayVacationDiv").html("");
		if(resp.todayList.length != 0){
			for(var i=0; i<resp.todayList.length; i++){
				var content =
				             `<div class="intro-x">
				                <div class="box px-5 py-3 mb-3 flex items-center zoom-in">
				                    <div class="w-10 h-10 flex-none image-fit rounded-full overflow-hidden">
				                        <img alt="Coworkflow" src="${cPath }/mypage/\${resp.todayList[i].mypage.profileImage.empAtchSaveName}">
				                    </div>    
				                    <div class="ml-4 mr-auto">
				                        <div class="font-medium">\${resp.todayList[i].empName}</div>
				                        <div class="text-slate-500 text-xs mt-0.5">\${resp.todayList[i].leaveStart.substring(0,10)} ~ \${resp.todayList[i].leaveEnd.substring(5,10)}</div>
				                    </div>
				                    <div class="text-danger">\${resp.todayList[i].leaveKind}</div>  
				                </div>
				            </div>`;
				$("#todayVacationDiv").append(content);
			}	
		}else{
			var content =
			           `<div class="intro-x">
			                <div class="box px-5 py-3 mb-3 flex items-center zoom-in" style="min-height: 60px;">
			                    <div class="ml-1 mr-auto">
			                        <div class="font-medium text-slate-500">휴가자가 없습니다.</div>
			                    </div>
			                </div>
			            </div>`;    
			$("#todayVacationDiv").append(content);
		}
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);    
	});
}

function crawling(){
	$.ajax({
		url : "${cPath}/crawling.do",
		method : "post",
		data : $("#newsKeyword").val(),
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
	        xhrToController.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
// 		console.log(resp.newsList.length);
		$("#newsListDiv").html("");
		if(resp.newsList.length != 0){
			for(var i=0; i<resp.newsList.length; i++){
				var content =
							`<div class="p-5">
						        <div class="text-base font-medium truncate">\${resp.newsList[i].title}</div>
						        <div class="text-slate-400 mt-1">\${resp.newsList[i].beforeTime}</div>
						        <div class="text-slate-500 text-justify mt-1">\${resp.newsList[i].description}</div>
						        <div class="font-medium flex mt-5">
						            <a href="\${resp.newsList[i].addr}" target="_blank" class="btn btn-outline-secondary py-1 px-2 ml-auto mr-auto">기사 보기</a>
						        </div>    
						    </div>`;
				$("#newsListDiv").append(content);
			}
		}else{
			var content =
				`<div class="p-5">
			        <div class="font-medium text-slate-500">검색 결과가 없습니다.</div>
			    </div>`;  
			$("#newsListDiv").append(content);
		}
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}




var myColorCalendar;


$(function(){
	// 컬러 캘린더 콘텐츠 초기화
	var widgetContentBox = $("#widget-events");
	widgetContentBox.html("");
	
	// 컬러 캘린더 객체 생성
	 myColorCalendar = new Calendar({
		id: "#widget-calendar",
		calendarSize: "large",
		dropShadow: "none",
		primaryColor: "#1e40af",
		headerColor: "#1e40af",
		fontFamilyHeader: "Pretendard",
		fontFamilyWeekdays: "Pretendard",
		fontFamilyBody: "Pretendard",
//		weekdayDisplayType: "long-upper",
		customWeekdayValues: ["일", "월", "화", "수", "목", "금", "토"],  
		eventsData: [],
		selectedDateClicked: function(currentDate, filteredMonthEvents){
//			console.log(currentDate); // 현재 날짜
// 			console.log(filteredMonthEvents); // 클릭한 날짜의 이벤트
			widgetContentBox.html("");
//			colorCalendarModal.show();
			
			if(filteredMonthEvents.length != 0 && filteredMonthEvents.length > 0){  
				for(var i=0; i<filteredMonthEvents.length; i++){
					var widgetContent =
				                          `<div class="flex items-center mt-2">
				                              <div class="w-2 h-2 bg-pending rounded-full mr-3"></div>
				                              <span class="truncate">\${filteredMonthEvents[i].name}</span> 
				                              <div class="h-px flex-1 border border-r border-dashed border-slate-200 mx-3 xl:hidden"></div>
				                              <span class="font-medium xl:ml-auto">\${filteredMonthEvents[i].start.split("T")[0]}</span> 
				                          </div>`;
					widgetContentBox.append(widgetContent);
				}
				lucide.createIcons();
			}else{
				widgetContentBox.append(`<div class="text-slate-500 p-3 text-center" id="calendar-no-events">등록된 일정이 없습니다.</div>`);
			}
		},
		
	});

	colorCalnedarDataLoad();
	
	
	retrieveMyCommuteToday();
	getTime();
	
	receiveMailLoad();    
	sentMailLoad();  
	approvalLoad();    
	unsetApprovalLoad();
	depEmpCntDataLoad();
	rankCntDataLoad();
	depGendRatioLoad();
	
	todayVacationListLoad();
	
// 	crawling();
	
	
	// 요소의 로딩이 느리므로 강제클릭 이벤트가 안 먹히는 경우가 있어서 시간차를 줌
	 setTimeout(function(){
		// 컬러캘린더 강제 클릭 이벤트: day-today 안에 있는 day-box가 선택되어야 클릭이벤트가 발생됨  
		$(".calendar__day-today .calendar__day-box").trigger("click");
	 }, 8000);
	 
	
})
</script>