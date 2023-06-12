<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<style>
.swal2-container {z-index:10000;}
</style>
        <!-- BEGIN: Content -->
        <input id="loginId" type="hidden" value="${loginId }" >
        <div class="content">
            <div class="intro-y flex flex-col sm:flex-row items-center mt-8">
                <h2 class="text-lg font-medium mr-auto">
                    &nbsp;
                </h2>
                <div class="w-full sm:w-auto flex mt-4 sm:mt-0">
                    <button class="btn btn-primary shadow-md mr-2"><i icon-name="printer" class="w-4 h-4 mr-2"></i>Print</button>
                    <div class="dropdown ml-auto sm:ml-0">
                        <button class="dropdown-toggle btn px-2 box" aria-expanded="false" data-tw-toggle="dropdown">
                            <span class="w-5 h-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="plus"></i> </span>
                        </button>
                        <div class="dropdown-menu w-40">
                            <ul class="dropdown-content">
                                <li>
                                    <a href="" class="dropdown-item"> <i icon-name="share-2" class="w-4 h-4 mr-2"></i> Share </a>
                                </li>
                                <li>
                                    <a href="" class="dropdown-item"> <i icon-name="settings" class="w-4 h-4 mr-2"></i> Settings </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="grid grid-cols-12 gap-5 mt-5">
                <!-- BEGIN: Calendar Side Menu -->
                <div class="col-span-12 xl:col-span-4 2xl:col-span-3">
                    <div class="box p-5 intro-y">  
                        <div class="flex items-center dark:border-darkmode-400 text-2xl mb-5"> <i class="mr-2" icon-name="calendar"></i> <a href="${cPath }/calendar/calendarList.do"> <spring:message code="level1Menu.calendar"/> </a> </div>
                        <a id="addSchedule" href="javascript:;" data-tw-toggle="modal" data-tw-target="#scheduleModal" class="btn btn-primary w-full mt-2"> <i class="w-4 h-4 mr-2" icon-name="edit-3"></i> 일정 등록 </a>
                        <div id="calendar-events" class="p-5 intro-y mt-5 border-t border-slate-200/60 dark:border-darkmode-400">  
                            <div class="text-slate-500 p-3 text-center" id="calendar-no-events">Loading...</div>
                        </div>
                    </div>  
                    
                    <div class="box p-5 intro-y mt-5">
	                    <div id="widget-calendar" class="intro-y mt-5"></div>
                        
                        
                        <div id="widget-events" class="p-5 intro-y mt-5 border-t border-slate-200/60 dark:border-darkmode-400"> 
<!--                             <div class="flex items-center mt-2"> -->
<!--                                 <div class="w-2 h-2 bg-pending rounded-full mr-3"></div> -->
<!--                                 <span class="truncate">Independence Day</span>  -->
<!--                                 <div class="h-px flex-1 border border-r border-dashed border-slate-200 mx-3 xl:hidden"></div> -->
<!--                                 <span class="font-medium xl:ml-auto">23th</span>  -->
<!--                             </div> -->
<!--                             <div class="flex items-center mt-2"> -->
<!--                                 <div class="w-2 h-2 bg-primary rounded-full mr-3"></div> -->
<!--                                 <span class="truncate">Memorial Day</span>  -->
<!--                                 <div class="h-px flex-1 border border-r border-dashed border-slate-200 mx-3 xl:hidden"></div> -->
<!--                                 <span class="font-medium xl:ml-auto">10th</span>  -->
<!--                             </div> -->
                            <div class="text-slate-500 p-3 text-center" id="calendar-no-events">Loading...</div>
                        </div>
                        
                        
                    </div>
                </div>
                <!-- END: Calendar Side Menu -->
                <!-- BEGIN: Calendar Content -->
                <div class="col-span-12 xl:col-span-8 2xl:col-span-9">
                    <div class="box p-5">
                        <div class="full-calendar" id="calendar"></div>
                    </div>
                </div>
                <!-- END: Calendar Content -->
            </div>
        </div>
        <!-- END: Content -->
        
        
        
        
        
<!-- 일정추가와 일정을 누르면 나오는 모달(수정/등록 모달) -->
<!-- BEGIN: Modal Content -->
<div id="scheduleModal" class="modal" tabindex="-1" aria-hidden="true" style="z-index:1000;">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- BEGIN: Modal Header -->
			<div class="modal-header">
				<h2 id="scheduleModalHeader" class="font-medium text-base mr-auto">일정 등록</h2>
			</div>
			
			<!-- END: Modal Header -->
			<!-- BEGIN: Modal Body -->
			
			<div class="modal-body grid grid-cols-12 gap-4 gap-y-3">
			<input type="hidden" id="schdlId">
				<div class="col-span-12 sm:col-span-12">
					<label for="schdlTitle" class="form-label">제목</label>
					 <input id="schdlTitle" type="text" class="form-control" placeholder="제목을 입력해주세요." autocomplete="off">
				</div>
				<div class="col-span-12 sm:col-span-12">
					<label for="schdlTypeCode" class="form-label">카테고리</label>
					<select name="schdlTypeCode" id="schdlTypeCode" class="form-select">
						<c:forEach items="${schdlTypeList}" var="comm" varStatus="status">
							<option value="${comm.commId}">${comm.commName }</option>
						</c:forEach>
					</select>
				</div>
				<!-- 참석자 filter시작 -->
				<div class="col-span-12 sm:col-span-12">
					<label for="empId" class="form-label">참석자</label> 
					 <!-- BEGIN: 참석자 Filter -->
                        <div class="intro-y flex flex-col-reverse sm:flex-row items-center">
                            <div class="w-full">  
                                <input type="text" id="empInfoName" name="empInfoName" class="form-control w-full " placeholder="참석자를 선택해주세요." autocomplete="off">
                                <input type="hidden" id="empInfoId" name="empInfoId" value="">
                                <div id="myDropdownSelect" class="inbox-filter dropdown absolute inset-y-0 mr-3 right-0 flex items-center" data-tw-placement="bottom-start">
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
                                                    <button class="btn btn-primary w-32 ml-auto" onClick="insertEmpId(); myDropdownSelect.hide();">등록</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
					</div>
				 <!-- END: 참석자 Filter 끝-->
				<div class="col-span-12 sm:col-span-12">
					<label for="schdlBgn" class="form-label">시작일</label> 
					<input id="schdlBgn" type="datetime-local" class="form-control"> 
				</div>
				<div class="col-span-12 sm:col-span-12">
					<label for="schdlEnd" class="form-label">종료일</label> 
					<input id="schdlEnd" type="datetime-local" class="form-control">
						
				</div>
				<div class="col-span-12 sm:col-span-12">
					<label for="schdlPlace" class="form-label">장소</label> 
					<input id="schdlPlace" type="text" class="form-control" placeholder="장소를 입력해주세요." autocomplete="off">
				</div>
				<div class="col-span-12 sm:col-span-12">
					<label for="schdlMovetime" class="form-label">이동 시간</label> 
					<select name="schdlMovetime" id="schdlMovetime" class="form-select" >
						<c:forEach items="${travelTimeList}" var="travel" varStatus="status">
							<option value="${travel.commId}">${travel.commName }</option>
						</c:forEach>
					</select>
				</div>


				
				<div class="col-span-12 sm:col-span-12">
					<label for="isopen" class="form-label">공개 여부</label> 
					<select name="isopen" id="isopen" class="form-select">
						<c:forEach items="${isOpenList}" var="open" varStatus="status">
							<option value="${open.commId}">${open.commName }</option>
						</c:forEach>
					</select>
				</div>
				
				<div class="col-span-12 sm:col-span-12">
					<label for="schdlDetail" class="form-label">비고</label> 
					<input id="schdlDetail" type="text" class="form-control" autocomplete="off">
				</div>
			</div>
			<!-- END: Modal Body -->
			<!-- BEGIN: Modal Footer -->
			<div class="modal-footer">
				<button data-tw-dismiss="modal" class="btn btn-outline-secondary w-20 mr-1">취소</button>
				<button class="btn btn-danger w-20" id="modalDelete" onclick="allDelete()">삭제</button>
				<button class="btn btn-primary w-20" id="modalSubmit" onclick="allSave()">등록</button>
				<button class="btn btn-primary w-20" id="modalUpdate" onclick="allUpdate()">수정</button>
			</div>
			<!-- END: Modal Footer -->
		</div>
	</div>
</div>
<!-- END: Modal Content -->



 
<!-- BEGIN: Show Modal Toggle -->
<!-- <div class="text-center">  -->
<!-- 	<a id="programmatically-show-modal" href="javascript:;" onclick="colorCalendarModal.show();" class="btn btn-primary mr-1 mb-2">Show Modal</a>  -->
<!-- </div> -->

<!-- END: Show Modal Toggle -->
<!-- BEGIN: Modal Content -->
<div id="programmatically-modal" class="modal" data-tw-backdrop="static" tabindex="-1" aria-hidden="true">  
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
        	<div class="modal-header">
				<h2 id="scheduleModalHeader" class="font-medium text-base mr-auto">일정 상세</h2>
			</div>
            <div class="modal-body p-10 text-center">  
				<div class="overflow-x-auto">
				    <table class="table table-bordered">
				        <thead class="table-dark">
				            <tr>
				                <th class="whitespace-nowrap">번호</th>
				                <th class="whitespace-nowrap">제목</th>
				                <th class="whitespace-nowrap">시작일</th>
				                <th class="whitespace-nowrap">종료일</th>
				            </tr>
				        </thead>
				        <tbody>
				            <tr>
				                <td>1</td>
				                <td>Angelina</td>
				                <td>Jolie</td>
				                <td>@angelinajolie</td>
				            </tr>
				            <tr>
				                <td>2</td>
				                <td>Brad</td>
				                <td>Pitt</td>
				                <td>@bradpitt</td>
				            </tr>
				            <tr>
				                <td>3</td>
				                <td>Charlie</td>
				                <td>Hunnam</td>
				                <td>@charliehunnam</td>
				            </tr>
				        </tbody>
				    </table>
				</div>
            </div>
            <div class="modal-footer">
            	<a id="programmatically-hide-modal" href="javascript:;" onclick="colorCalendarModal.hide();" data-tw-dismiss="modal" class="btn btn-primary mr-1">닫기</a>
            </div>  
        </div>  
    </div>
</div>
<!-- END: Modal Content -->
<script>

const calendarAlarm = new StompJs.Client({
	brokerURL:`ws://\${document.location.host}${cPath}/ws/chatting`,
	debug:function(str){
			console.log(str);
	},
	onConnect:function(frame){
// 		console.log('캘런더 알람 확인;')
	}
});
calendarAlarm.activate();
// var cc = [
//     {
//       id: 1,
//       name: "French class",
//       start: "2023-05-07T06:00:00",
//       end: "2023-05-09T20:30:00"
//     },
//     {
//       id: 2,
//       name: "ba 101",
//       start: "2023-05-20T10:00:00",
//       end: "2023-05-20T11:30:00"
//     }
//   ]
  
var myColorCalendar;
var colorCalendarModal;

// myCal.setEventsData( [{
//     id: 3,
//     name: "French class",
//     start: "2023-05-01T06:00:00",
//     end: "2023-05-02T20:30:00"
// }]);

var myDropdownSelect;


	document.addEventListener('DOMContentLoaded', function() {
		
		
		 
		 // Show modal 
		 const el = document.querySelector("#programmatically-modal"); 
		 colorCalendarModal = tailwind.Modal.getOrCreateInstance(el); 
		 
		 // Hide modal 
// 		 colorCalendarModal.hide(); 
		 
		 // Toggle modal 
// 		 colorCalendarModal.toggle();   
		 
		 
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
// 			weekdayDisplayType: "long-upper",
			customWeekdayValues: ["일", "월", "화", "수", "목", "금", "토"],  
			eventsData: [],
			selectedDateClicked: function(currentDate, filteredMonthEvents){
// 				console.log(currentDate); // 현재 날짜
// 				console.log(filteredMonthEvents); // 클릭한 날짜의 이벤트
				widgetContentBox.html("");
// 				colorCalendarModal.show();
				
				if(filteredMonthEvents.length != null && filteredMonthEvents.length > 0){  
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
			}
		});
		
		
		
		
		//모달 선택하기
		var scheduleModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#scheduleModal"));
		
		//모달 안에 있는 폼태그 선택하기
		scheduleModalForm = $('#scheduleModalForm')[0];
		
		//모달 제목 선택하기
		const scheduleModalHeader = document.getElementById('scheduleModalHeader');

		//모달 등록버튼 선택하기
		var modalSubmit = $('#modalSubmit');

		//모달 수정버튼 선택하기
		var modalUpdate = $('#modalUpdate');

		//모달 삭제버튼 선택하기
		var modalDelete = $('#modalDelete');

		
		
		
		// 풀캘린더 시작
		var calendarEl = document.getElementById('calendar');
		$(calendarEl).data("modal", scheduleModal);
		
		// 풀캘린더 객체 생성
		var calendar = new FullCalendar.Calendar(calendarEl, {

			initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
			headerToolbar : { // 헤더에 표시할 툴 바
				start : 'prev next today',
				center : 'title',
				end : 'dayGridMonth,timeGridWeek,timeGridDay'
			},
			titleFormat : function(date) {
				return date.date.year + '년 ' + (parseInt(date.date.month) + 1) + '월';
			},
			selectable : true, // 달력 일자 드래그 설정가능
// 			select : function(arg) {
// 				var title = prompt('일정 제목을 입력해주세요.');
// 				if (title) {
// 					calendar.addEvent({
// 						title : title,
// 						start : arg.start,
// 						end : arg.end,
// 						allDay : arg.allDay
// 					})
// 				}
// 				calendar.unselect();
// 			},
			//이벤트소스
			events : '${cPath}/calendar/calendarList_FC',
			droppable : true,
			editable : true,
			nowIndicator : true, // 현재 시간 마크
			locale : 'ko', // 한국어 설정
			timeZone : 'local',
			eventClick : function(info) {
// 				console.log(info.event.extendedProps.source);
// 				웹에서 콘솔 확인해보면 event 안에 _def, extendProps, range에 있음 --> 이거 보고 내용 넣으면 댐!!
				var schdlId = info.event.extendedProps.source.schdlId;
				var title = info.event.extendedProps.source.schdlTitle;
				var start = info.event.extendedProps.source.schdlBgn;
				var end = info.event.extendedProps.source.schdlEnd;
				var empId = info.event.extendedProps.source.empId;
				var empInfoId = info.event.extendedProps.source.empInfoId;
				var empInfoName = info.event.extendedProps.source.empInfoName;
				var isopen = info.event.extendedProps.source.isopen;
				var schdlDetail = info.event.extendedProps.source.schdlDetail;
				var schdlMovetime = info.event.extendedProps.source.schdlMovetime;
				var schdlPlace = info.event.extendedProps.source.schdlPlace;
				var schdlTypeCode = info.event.extendedProps.source.schdlTypeCode;
				var schdlDetail = info.event.extendedProps.source.schdlDetail;

				// 모달 내용 채우기
				scheduleModalHeader.innerHTML = "일정 수정";
				$('#schdlId').val(schdlId);
				$('#schdlTitle').val(title);
				$('#schdlBgn').val(start.toLocaleString());
				$('#schdlEnd').val(end.toLocaleString());
				$('#schdlTypeCode').val(schdlTypeCode);
				$('#empInfoId').val(empInfoId);
				$('#empInfoName').val(empInfoName);
				$('#isopen').val(isopen);
				$('#schdlDetail').val(schdlDetail);
				$('#schdlMovetime').val(schdlMovetime);
				$('#schdlPlace').val(schdlPlace);
				$('#schdlDetail').val(schdlDetail);

				// 수정버튼 보이고 등록버튼 감추기
				modalUpdate.show();
				modalDelete.show();
				modalSubmit.hide();

				// 모달 보여주기
				scheduleModal.show();
			},
			eventDrop : function(eventDropInfo){
// 				console.log(eventDropInfo);
// 				console.log(eventDropInfo.event.startStr); // 새로 옮긴 날짜 시작일 문자열
// 				console.log(eventDropInfo.event.start); // 새로 옮긴 날짜 시작일 날짜
// 				console.log(eventDropInfo.event.endStr); // 새로 옮긴 날짜 종료일 문자열
// 				console.log(eventDropInfo.event.end); // 새로 옮긴 날짜 종료일 날짜
// 				console.log(eventDropInfo.event.extendedProps.source); // 기존 데이터
				
				var oldData = eventDropInfo.event.extendedProps.source;
				
				// JSON 데이터 생성
				let sendData = {
					schdlId : oldData.schdlId,
					schdlTitle : oldData.schdlTitle,
					schdlTypeCode : oldData.schdlTypeCode,
//		 			empId : empId,      
					empInfoId : oldData.empInfoId,
					schdlBgn : eventDropInfo.event.start,
					schdlEnd : eventDropInfo.event.end,
					schdlPlace : oldData.schdlPlace,
					schdlMovetime : oldData.schdlMovetime,
					isopen : oldData.isopen,
					schdlDetail : oldData.schdlDetail
				};

				// AJAX 요청
				$.ajax({
					url : "${cPath}/calendar/CalendarUpdate",
					type : "post",
					data : JSON.stringify(sendData),
					beforeSend : function(xhrToController){
				         xhrToController.setRequestHeader(headerName, headerValue);
				         xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
				    },
					contentType : "application/json",
					success : function(res) {
						if(res.result){
							loadMySchdlList();
// 							let calendar = $("#calendar").data("calendar");
// 							let scheduleModal = $("#calendar").data("modal");
// 							console.log(calendar);
// 							calendar.refetchEvents();
// 							calendar.render();
// 							scheduleModal.hide();
						}else{
							Swal.fire({
								  icon: 'error',
								  title: 'Oops...',
								  text: 'Something went wrong!'
							});
						}
					}
				});
			},
			eventSourceSuccess: function(content, response) {
// 				console.log(content);
// 				console.log(response);
				var newDataArr = [];
				content.forEach(function(data){
					var newDataObj = {
						id: data.id,
						name: data.title,
						start: data.start,
						end: data.end
					};
					newDataArr.push(newDataObj);
// 					console.log(data);
				});
				
// 				console.log(newDataArr);
				
				// 풀캘린더 json 데이터를 칼라캘린더 형식에 맞게 변환하여 Setting
				myColorCalendar.setEventsData(newDataArr);
				return content.eventArray;
			}
			
		}); //풀캘린더 객체 끝
		
		
		$(calendarEl).data("calendar", calendar)
		calendar.render();

		const addScheduleBtn = $('#addSchedule');
		addScheduleBtn.on("click", function() {

			// 모달 제목 바꿔주기
			scheduleModalHeader.innerHTML = "일정 등록";

			// 등록버튼 보이고 수정버튼 감추기
			modalSubmit.show();
			modalUpdate.hide();
			modalDelete.hide();

			//모달 비우기
			$('#schdlTitle').val('');
			$('#schdlTypeCode').val('');
			$('#empInfoId').val('');
			$('#empInfoName').val('');
			$('#schdlBgn').val('');
			$('#schdlEnd').val('');
			$('#schdlPlace').val('');
			$('#schdlMovetime').val('');
			$('#isopen').val('');
			$('#schdlDetail').val('');
			
			// 모달 보여주기
			scheduleModal.show();

		});
		
		
		loadMySchdlList();
		
		
		// 컬러캘린더 강제 클릭 이벤트: day-today 안에 있는 day-box가 선택되어야 클릭이벤트가 발생됨  
		$(".calendar__day-today .calendar__day-box").trigger("click");
		    
		
		
		
		myDropdownSelect = tailwind.Dropdown.getOrCreateInstance(document.querySelector("#myDropdownSelect"));
		 
	});
	
	

	//등록 버튼을 눌렀을 때, 등록이벤트
	function allSave() {

		let schdlTitle = $('#schdlTitle').val();
		let schdlTypeCode = $('#schdlTypeCode').val();
		let empInfoId = $('#empInfoId').val();
// 		let empId = $('#empId').val();
		let schdlBgn = $('#schdlBgn').val();
		let schdlEnd = $('#schdlEnd').val();
		let schdlPlace = $('#schdlPlace').val();
		let schdlMovetime = $('#schdlMovetime').val();
		let isopen = $('#isopen').val();
		let schdlDetail = $('#schdlDetail').val();

		// JSON 데이터 생성
		let sendData = {
			schdlTitle : schdlTitle,
			schdlTypeCode : schdlTypeCode,
			empInfoId : empInfoId,
			schdlBgn : schdlBgn,
			schdlEnd : schdlEnd,
			schdlPlace : schdlPlace,
			schdlMovetime : schdlMovetime,
			isopen : isopen,
			schdlDetail : schdlDetail
		};
		  
// 		console.log("empInfoId", empInfoId);
			 		
		let empListID = empInfoId.split(",");
// 		console.log(empListID);
		
		// AJAX 요청
		$.ajax({
			url : "${cPath}/calendar/calendarInsert",
			type : "post",
			data : JSON.stringify(sendData),
			beforeSend : function(xhrToController){
		         xhrToController.setRequestHeader(headerName, headerValue);
		         xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		    },
			contentType : "application/json",
			success : function(res) {
				if(res.result){
					loadMySchdlList();
					let calendar = $("#calendar").data("calendar");
					let scheduleModal = $("#calendar").data("modal");
// 					console.log(calendar);
					calendar.refetchEvents();
					calendar.render();
					scheduleModal.hide();
					// 모달 내용 비우기
					$('#schdlTitle').val('');
					$('#schdlTypeCode').val('');
					$('#empInfoId').val('');
					$('#empInfoName').val('');
					$('#schdlBgn').val('');
					$('#schdlEnd').val('');
					$('#schdlPlace').val('');
					$('#schdlMovetime').val('');
					$('#isopen').val('');
					$('#schdlDetail').val('');
				}else{
					Swal.fire({
						  icon: 'error',
						  title: 'Oops...',
						  text: 'Something went wrong!'
					});
				}
		
		let loginId = $('#loginId').val();
			
// 		console.log("loginId",loginId);
// 		for(let i = 0; i<empListID.length; i++){
			
// 			let empId = empListID[i];
			let empId = 'a100005';
				
			console.log("calendarEmp",empId);
				// 알람용 json 데이터 생성.
			let alarmData = {
					// 현재 알람을 보내는 사람 ID
					empId : loginId,
					// 알람을 받아야하는 사람 ID
					apponent : empId,
					alarmContent : `님 새로운 일정이 등록되었습니다.`,
					almType : `CALENDAR`
				};
				console.log(empId);
				console.log("여기는 타는지?");
				console.log(alarmData);
				
// 				let destination = "/user/"+empId+"/alarm/newAlarm";
// 				alert(`/user/${loginId}/alarm/newAlarm`);
				// 알람을 띄우기 위한 publish
				calendarAlarm.publish({
					destination:"/topic/alarm/newNotice", 
// 					destination:`/user/\${empId}/alarm/newAlarm`, 
// 					destination:destination, 
					body:JSON.stringify(alarmData),
					headers:{
						"content-type":"application/json"
					}
				});
// 				alert("오는지 안오는지 모르겠다.");
// 			console.log("제발...")
// 		}		
				
				
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

	//수정 버튼을 눌렀을 때, 수정이벤트
	function allUpdate() {
		
		let schdlId=$('#schdlId').val();
		let schdlTitle = $('#schdlTitle').val();
		let schdlTypeCode = $('#schdlTypeCode').val();
		let empId = $('#empId').val();
		let empInfoId=$('#empInfoId').val();
		let schdlBgn = $('#schdlBgn').val();
		let schdlEnd = $('#schdlEnd').val();
		let schdlPlace = $('#schdlPlace').val();
		let schdlMovetime = $('#schdlMovetime').val();
		let isopen = $('#isopen').val();
		let schdlDetail = $('#schdlDetail').val();

		// JSON 데이터 생성
		let sendData = {
			schdlId : schdlId,
			schdlTitle : schdlTitle,
			schdlTypeCode : schdlTypeCode,
// 			empId : empId,      
			empInfoId : empInfoId,
			schdlBgn : schdlBgn,
			schdlEnd : schdlEnd,
			schdlPlace : schdlPlace,
			schdlMovetime : schdlMovetime,
			isopen : isopen,
			schdlDetail : schdlDetail
		};

		// AJAX 요청
		$.ajax({
			url : "${cPath}/calendar/CalendarUpdate",
			type : "post",
			data : JSON.stringify(sendData),
			beforeSend : function(xhrToController){
		         xhrToController.setRequestHeader(headerName, headerValue);
		         xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		    },
			contentType : "application/json",
			success : function(res) {
				if(res.result){
					loadMySchdlList();
					let calendar = $("#calendar").data("calendar");
					let scheduleModal = $("#calendar").data("modal");
// 					console.log(calendar);
					calendar.refetchEvents();
					calendar.render();
					scheduleModal.hide();
					// 모달 내용 비우기
					$('#schdlTitle').val('');
					$('#schdlTypeCode').val('');
					$('#empInfoId').val('');
					$('#empInfoName').val('');
					$('#schdlBgn').val('');
					$('#schdlEnd').val('');
					$('#schdlPlace').val('');
					$('#schdlMovetime').val('');
					$('#isopen').val('');
					$('#schdlDetail').val('');
				}else{
					Swal.fire({
						  icon: 'error',
						  title: 'Oops...',
						  text: 'Something went wrong!'
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

	//삭제 버튼을 눌렀을 때, 삭제이벤트
	function allDelete() {
		Swal.fire({
			  title: '일정을 삭제하시겠습니까?',
			  text: "삭제하시면 다시 복구시킬 수 없습니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#1e40af',
			  cancelButtonColor: '#dc2626',
			  confirmButtonText: '삭제',
			  cancelButtonText: '취소'
		}).then((result) => {
		  if (result.value) {
              //"삭제" 버튼을 눌렀을 때 작업할 내용을 이곳에 넣어주면 된다. 
			  let schdlId=$('#schdlId').val();
				$.ajax({
					url : "${cPath}/calendar/CalendarDelete",
					type : "post",
					data : {"schdlId" : schdlId} ,
					beforeSend : function(xhrToController){
				         xhrToController.setRequestHeader(headerName, headerValue);
				      },
					
					success : function(res) {
						if(res.result){
							loadMySchdlList();
							let calendar = $("#calendar").data("calendar");
							let scheduleModal = $("#calendar").data("modal");
// 							console.log(calendar);
							calendar.refetchEvents();
							calendar.render();
							scheduleModal.hide();
							// 모달 내용 비우기
							
						}else{
		 					Swal.fire({
		 						  icon: 'error',
		 						  title: 'Oops...',
		 						  text: 'Something went wrong!'
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
		})
	}
	
	//팀명 선택시 해당 팀원 이름만 나오게 만드는 온체인지
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
						code += `<option id="empId" value="\${v.empId}">\${v.empName}</option>`;
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
		$("#empInfoId").val($("#empInfoId").val() + "" + empId);
		
		
// 		$("#empId option:selected")로 반환되는 것은 jQuery 객체로, 이 객체는 JavaScript 배열과 달리 forEach 메소드를 가지고 있지 않음
// 		--> 사용 불가능
// 		var empNameList = $("#empId option:selected");
// 		empNameList.forEach(function(data){
// 			console.log(data.text);
// 		});
		
		var empNameList = $("#empId option:selected");
		empNameList.each(function(){
// 		    console.log($(this).text());
		    var empName = $(this).text();
			$("#empInfoName").val($("#empInfoName").val() + empName + ",");
		});
		
		$("#empInfoName").val(  ($("#empInfoName").val()).slice(0, ($("#empInfoName").val()).length-1)  );

		
// 		var empNameList = Array.from($("#empId option:selected"));
// 		empNameList.forEach(function(data){
// 			console.log(data.text);
// 		});

	
	}
	
	function loadMySchdlList(){
		$.ajax({
			url : "${cPath}/calendar/mySchdlList",
			method : "post",
			data : {},
			dataType : "json",
			beforeSend : function(xhrToController){
		         xhrToController.setRequestHeader(headerName, headerValue);
		    },
		    contentType : "application/json",
		}).done(function(resp, textStatus, jqXHR) {
// 			console.log(resp);
			
			
			var contentBox = $("#calendar-events");
			contentBox.html("");
			
			if(resp.result){
				for(var i=0; i<resp.mySchdlList.length; i++){
					
					// calendar-events 
                    
                    var content = 
				                    `<div class="relative">
				                        <div class="event p-3 -mx-3 cursor-pointer transition duration-300 ease-in-out hover:bg-slate-100 dark:hover:bg-darkmode-400 rounded-md flex items-center">
				                            <div class="w-2 h-2 bg-pending rounded-full mr-3"></div>
				                            <div class="pr-10">
				                                <div class="event__title truncate">\${resp.mySchdlList[i].schdlTitle}</div>
				                                <div class="text-slate-500 text-xs mt-0.5"> <span class="event__days">\${resp.mySchdlList[i].schdlBgn.split("T")[0]}</span> <span class="mx-1">•</span> \${resp.mySchdlList[i].schdlBgn.split("T")[1]} </div>
				                            </div>
				                        </div>
				                        <a class="flex items-center absolute top-0 bottom-0 my-auto right-0" href=""> <i icon-name="edit" class="w-4 h-4 text-slate-500"></i> </a>
				                    </div>`;
				    contentBox.append(content);
				}
				lucide.createIcons();
			}else{
				contentBox.append(`<div class="text-slate-500 p-3 text-center" id="calendar-no-events">등록된 일정이 없습니다.</div>`);
			}
			
			
			
		}).fail(function(jqXHR, status, error) {
			console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
		});
	}
</script>