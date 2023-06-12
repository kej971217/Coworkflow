<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Plugin CSS -->
<link rel="stylesheet" href='<c:url value="/resources/Rubick/dist/css/app.css" />' />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/sweetalert2/sweetalert2.min.css" >
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/fancytree/skin-lion/ui.fancytree.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/jstree/themes/default/style.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<%-- <link href="${pageContext.request.contextPath }/resources/css/select2.min.css" rel="stylesheet" /> --%>
<link href="${pageContext.request.contextPath }/resources/css/colorCalendar.theme-basic.css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/ckeditor/ckeditor.js"></script>
<!-- Custom css : 최후에 들어가야 함 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/custom.css">

<!-- jQuery -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/sweetalert2/sweetalert2.all.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-ui.min.js"></script>

<!-- JS -->
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/fancytree/modules/jquery.fancytree.js"></script> --%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/fancytree/modules/jquery.fancytree.table.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jstree/jstree.min.js"></script>
<script type="text/javascript" src="${cPath}/resources/js/jquery.serializeObject.min.js"></script>
<script type="text/javascript" src="https://cdn.tailwindcss.com"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/select2.min.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/colorCalendar.bundle.js"></script>
 
<script src="${cPath }/resources/js/stompjs/stomp.umd.min.js"></script>  
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
