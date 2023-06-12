<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
        <!-- BEGIN: Content -->
        <div class="content">
            <div class="grid grid-cols-12 gap-6 mt-8">
                <div class="col-span-12 lg:col-span-3 2xl:col-span-2">
                    <h2 class="intro-y text-lg font-medium mr-auto mt-2">
                    &nbsp;
                    </h2>   
                    <%-- 인사정보 좌측 사이드 메뉴 include --%>
					<jsp:include page="/includee/employeeInfoLeftMenu.jsp"></jsp:include>
                </div>
                <div class="col-span-12 lg:col-span-9 2xl:col-span-10">
                    <!-- BEGIN: Inbox Filter -->
                    <div class="intro-y flex flex-col-reverse sm:flex-row items-center">
                        <div class="w-full sm:w-auto relative mr-auto mt-3 sm:mt-0">
                            <i class="w-4 h-4 absolute my-auto inset-y-0 ml-3 left-0 z-10 text-slate-500" icon-name="search"></i> 
                            <input type="text" class="form-control w-full sm:w-64 box px-10" placeholder="Search...">
                            <div class="inbox-filter dropdown absolute inset-y-0 mr-3 right-0 flex items-center" data-tw-placement="bottom-start">
                                <i class="dropdown-toggle w-4 h-4 cursor-pointer text-slate-500" role="button" aria-expanded="false" data-tw-toggle="dropdown" icon-name="chevron-down"></i> 
                                <div class="inbox-filter__dropdown-menu dropdown-menu pt-2">
                                    <div class="dropdown-content">
                                        <div class="grid grid-cols-12 gap-4 gap-y-3 p-3">
                                            <div class="col-span-6">
                                                <label for="input-filter-1" class="form-label text-xs">From</label>
                                                <input id="input-filter-1" type="text" class="form-control flex-1" placeholder="example@gmail.com">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-2" class="form-label text-xs">To</label>
                                                <input id="input-filter-2" type="text" class="form-control flex-1" placeholder="example@gmail.com">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-3" class="form-label text-xs">Subject</label>
                                                <input id="input-filter-3" type="text" class="form-control flex-1" placeholder="Important Meeting">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-4" class="form-label text-xs">Has the Words</label>
                                                <input id="input-filter-4" type="text" class="form-control flex-1" placeholder="Job, Work, Documentation">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-5" class="form-label text-xs">Doesn't Have</label>
                                                <input id="input-filter-5" type="text" class="form-control flex-1" placeholder="Job, Work, Documentation">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-6" class="form-label text-xs">Size</label>
                                                <select id="input-filter-6" class="form-select flex-1">
                                                    <option>10</option>
                                                    <option>25</option>
                                                    <option>35</option>
                                                    <option>50</option>
                                                </select>
                                            </div>
                                            <div class="col-span-12 flex items-center mt-3">
                                                <button class="btn btn-secondary w-32 ml-auto">Create Filter</button>
                                                <button class="btn btn-primary w-32 ml-2">Search</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="w-full sm:w-auto flex">
                            <button class="btn btn-primary shadow-md mr-2"><i icon-name="printer" class="w-4 h-4 mr-2"></i>Print</button>
                            <div class="dropdown">
                                <button class="dropdown-toggle btn px-2 box" aria-expanded="false" data-tw-toggle="dropdown">
                                    <span class="w-5 h-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="plus"></i> </span>
                                </button>
                                <div class="dropdown-menu w-40">
                                    <ul class="dropdown-content">
                                        <li>
                                            <a href="" class="dropdown-item"> <i icon-name="user" class="w-4 h-4 mr-2"></i> Contacts </a>
                                        </li>
                                        <li>
                                            <a href="" class="dropdown-item"> <i icon-name="settings" class="w-4 h-4 mr-2"></i> Settings </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END: Inbox Filter -->
                    
                    
                    
                 <div class="flex">
                    <!-- BEGIN: Inbox Content 1-1 -->
                    <div class="intro-y inbox box mt-5 flex-1">
                        <div class="p-5 flex flex-col-reverse sm:flex-row border-b border-slate-200/60">
                            <div class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0 font-bold text-lg">
                            	출/퇴근 체크
                            </div>
                        </div>
                        <div class="p-5 flex flex-col sm:flex-row text-center items-center justify-center" style="padding-bottom: 0;">
                            <div id="nowTimeDiv" class="flex items-center text-3xl items-center justify-center"><%-- 현재 시간 --%></div>
                        </div>
                        <div class="p-5 flex flex-col items-center text-center sm:text-left">
                            <div class="overflow-x-auto flex flex-row items-start justify-center" style="width: 100%;">
                            	 <div id="commuteStartDiv" class="flex flex-col items-center justify-center">
	                            	 <button class="btn btn-primary w-24 mr-1 mb-2">출근하기</button>
	                            	 <span></span>
                            	 </div>
                            	 <div style="min-width: 30px;"></div>
                            	 <div id="commuteEndDiv" class="flex flex-col items-center">
	                            	 <button class="btn btn-outline-primary w-24 inline-block mr-1 mb-2">퇴근하기</button>  
	                            	 <span></span>
                            	 </div>
                            </div>
                        </div>
                    </div>
                    <!-- END: Inbox Content 1-1 -->
                    
                    
                    <div style="min-width: 20px;"></div>
                   
                    
                    <!-- BEGIN: Inbox Content 1-2 -->
                    <div class="intro-y inbox box mt-5 flex-1">     
                        <div class="p-5 flex flex-col-reverse sm:flex-row border-b border-slate-200/60">
                            <div class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0 font-bold text-lg">
                            	근무상태 변경
                            </div>
                        </div>
                        <div class="p-5 flex flex-col sm:flex-row items-center text-center sm:text-left" style="height: calc(100% - 60px);"><!-- text-slate-500 글자 연하게 -->
                            <div class="overflow-x-auto flex flex-row items-center justify-center" style="width: 100%;">	 
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
                    <!-- END: Inbox Content 1-2 -->
                 </div>
                 
                 
                    <!-- BEGIN: Inbox Content2 -->
                    <div class="intro-y inbox box mt-5">
                        <div class="p-5 flex flex-col-reverse sm:flex-row border-b border-slate-200/60">
                            <div class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0 font-bold text-lg">
                            	나의 근무 현황
                            </div>
                        </div>
                        <div class="p-5 flex flex-col sm:flex-row items-center text-center sm:text-left">
                            <div class="overflow-x-auto" style="width: 100%;">
								<div class="p-5 mt-5" style="height: 389px;">     
	                                <div style="height: 100%;">
	                                    <div style="height: 100%;">      
								    		<canvas id="myChart2"></canvas>   
								    	</div>
	                                </div>
	                            </div>
							</div>
                        </div>
                    </div>
                    <!-- END: Inbox Content2 -->


<script type="text/javascript">
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


$(function(){
	retrieveMyCommuteToday();
	getTime();
	depEmpCntDataLoad();  
});


</script>