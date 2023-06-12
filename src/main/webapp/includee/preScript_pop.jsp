<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		



<!-- Custom css : 최후에 들어가야 함 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/pop.css">
<!-- <script src="/path/to/ckeditor/ckeditor.js"></script> -->



<!-- jQuery -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/sweetalert2/sweetalert2.all.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/ckeditor/ckeditor.js"></script>

<script type="text/javascript" src="${cPath}/resources/js/jquery.serializeObject.min.js"></script>
<!-- END: Assets-->


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
