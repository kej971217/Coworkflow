<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.6/index.global.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.6/index.global.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.6/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.6/daygrid.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.6/timegrid.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.6/interaction.min.js'></script>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {

			initialView : 'timeGridWeek', // 초기 로드 될때 보이는 캘린더 화면
			headerToolbar : { // 헤더에 표시할 툴 바
				start : 'prev next today',
				center : 'title',
				end : 'dayGridMonth,timeGridWeek,timeGridDay'
			},
			titleFormat : function(date) {
				return date.date.year + '년 ' + (parseInt(date.date.month) + 1)
						+ '월';
			},
			selectable : true, // 달력 일자 드래그 설정가능
			select : function(arg) {
				var title = prompt('Event Title:');
				if (title) {
					calendar.addEvent({
						title : title,
						start : arg.start,
						end : arg.end,
						allDay : arg.allDay
					})
				}
				calendar.unselect()
			},
			//이벤트소스
			eventSources : [ {
				events : [ {
					"title" : "event1",
					"start" : "2023-05-13"
				}, {
					"title" : "event2",
					"start" : "2023-01-05",
					"end" : "2023-05-07"
				}, {
					"title" : "event3",
					"start" : "2023-05-09T12:30:00",
					"allDay" : false
				} ]
			} ],
			//
			droppable : true,
			editable : true,
			nowIndicator : true, // 현재 시간 마크
			locale : 'ko', // 한국어 설정
			timeZone : 'local'

		});
		calendar.render();
	});
</script>
</head>
<body>
  <div class="col-span-12 lg:col-span-6 mt-8">
	<div class="intro-y block sm:flex items-center h-10">
		<h1 class="text-lg font-medium truncate mr-5">회의실예약</h1>
	</div>
</div>
		<div class="col-span-12 xl:col-span-8 2xl:col-span-9">
			<div class="box p-5">
				<div id='calendar'></div>
			</div>
		</div>
</body>


</html>