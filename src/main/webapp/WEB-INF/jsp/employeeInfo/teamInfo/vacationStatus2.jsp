<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<style>
.fc .fc-daygrid-day.fc-day-today{background: #EDE7F6;}     
</style>
        <!-- BEGIN: Content --><!-- 인사정보-팀정보조회-팀휴가내역조회 -->
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
        <!-- BEGIN: Content -->
        <div class="content">
            <div class="intro-y flex flex-col sm:flex-row items-center mt-8">
                <h2 class="text-lg font-medium mr-auto">
                    &nbsp;
                </h2>
            </div>
            <div class="grid grid-cols-12 gap-5">
                <!-- BEGIN: Calendar Content -->    
                <div class="col-span-12 xl:col-span-12 2xl:col-span-12">  
                    <div class="box p-5">
                        <div class="full-calendar" id="calendar"></div>
                    </div>
                </div>
                <!-- END: Calendar Content -->
            </div>
        </div>
        <!-- END: Content -->
        
        
        
        
        






<script>
$(function(){
	var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      headerToolbar : { // 헤더에 표시할 툴 바
			start : 'prev next today',
			center : 'title',
			end : 'dayGridMonth,timeGridWeek,timeGridDay'
	  },
      eventSources: [

    	    // your event source
    	    {
    	      url: '${cPath}/employeeInfo/teamInfo/selectTeamVacationList.do',    
    	      method: 'GET',
//     	      extraParams: {
//     	        custom_param1: 'something',
//     	        custom_param2: 'somethingelse'
//     	      },
			  startParam: "leaveStart",
			  endParam: "leaveEnd",
    	      failure: function() {
    	        alert('there was an error while fetching events!');
    	      },
    	      color: '#4CAF50',   // a non-ajax option   
    	      textColor: 'white' // a non-ajax option  
    	    }

    	    // any other sources...

    	  ]
    });
    calendar.render();
    
    
    
});
</script>