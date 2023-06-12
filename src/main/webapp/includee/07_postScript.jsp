<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>




<!-- jQuery -->
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.6.3.min.js"></script> --%>
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-ui.min.js"></script> --%>




<!-- template -->
<%-- <script src="${pageContext.request.contextPath }/resources/Rubick/dist/js/app.js"></script> --%>

<script src="${cPath }/resources/js/stompjs/stomp.umd.min.js"></script>

<!-- stomp -->
<script>
// 	let pushWs = new WebSocket("ws://\${document.location.host}${cPath}/ws/push");
// 	pushWs.onmessage=function(event){
// 		alert(event.data);
// 	}
// 	window.addEventListener("DOMContentLoaded", event=>{
// 		const alert = new StompJs.Client({
// 			brokerURL:"ws://\${document.location.host}${cPath}/ws/push",
// 			debug:function(str){
// // 				console.log(str);
// 			},
// 			onConnect:function(frame){
// 				const approval1 = this.subscribe("/topic/push", function(msgFrame){
// 					let messageVO = JSON.parse(msgFrame.body);
// 					Swal.fire({
// 						  icon: messageVO.messageType.toLowerCase(),
// 						  title: '전체 푸시 메시지',
// 						  text: messageVO.message
// 						})
// 				});
// 				const subscription2 = this.subscribe("/user/queue/private", function(msgFrame){
// 					let messageVO = JSON.parse(msgFrame.body);
// 					alert(`PRIVATE 메시지 [\${messageVO.message}]`);
// 				});
// 			}
// 		});
// 		alert.activate();
// 	});
</script>


<!-- BEGIN: JS Assets-->
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery.fancytree.js"></script> --%>
<script src="${pageContext.request.contextPath }/resources/js/lucide.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/tabulator.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/luxon.js"></script>
<%-- <script src="${pageContext.request.contextPath }/resources/js/tabulator.min.js"></script> --%>
<script src="${pageContext.request.contextPath }/resources/js/jspdf.umd.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jspdf.plugin.autotable.min.js"></script>
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
<!-- <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script> -->
<!-- <script src="https://maps.googleapis.com/maps/api/js?key=["your-google-map-api"]&libraries=places"></script> -->
<!-- END: JS Assets-->




<!-- BEGIN: JS initialization -->
<script>
    lucide.createIcons();
    var DateTime = luxon.DateTime;  
</script>
<!-- END: initialization -->