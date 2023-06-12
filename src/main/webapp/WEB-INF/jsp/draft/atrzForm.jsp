<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <style>

#myPassChangeView{
	background-color: #3541A8;
	height: 50px;
	color: #ffffff;
	font-weight:550;
}
.myPassChangLabel{
	margin-left:13px;
	width:300px;
}
</style>
<div>
	<form id="draftForm" action="${cPath }/approval/signup.do"  method="post" >
	 <security:csrfInput/>
        <div id="myPassChangeView">
            <p style="padding:13px;">결재</p>
        </div>
        <hr>
        <div>
        	<input type="hidden" name="aprvDocId" value="${aprvDocId }"/>
        	<input type="radio" name="isapprovalStatus" value="1" checked="checked"/> 승인
        	<input type="radio" name="isapprovalStatus" value="2"/> 반려
        </div>
        <div>
        	<label class="myPassChangLabel">결재사유</label>
        	<input type="text" name="isapprovalReason"/>
        </div>
        <br>
        <div style="text-align: center;">
        	<input type="button" onclick="sign()" value="저장"/>
            <input type="button" value="취소"/>
        </div>
    </form>
</div>
<script>
var header = '${_csrf.headerName}';
var token = '${_csrf.token}'
function sign() {
	console.log("sfsdfsdfsdfsdf")
	event.preventDefault();
	let isapproval = {
		isapprovalStatus :$("[name=isapprovalStatus]:checked").val(),
		aprvDocId : $("[name=aprvDocId]").val(),
		isapprovalReason : $("[name=isapprovalReason]").val(),
	};

	$.ajax({
		method : "post",
		url : "${cPath}/approval/signup.do",
		data : JSON.stringify(isapproval),
		contentType : "application/json;charset=utf-8", 
		dataType : "json",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(rslt) {
			
			Swal.fire({
                text: "결재했습니다.",
			}).then((result) => {
					window.close()
                    opener.location.href= opener.location.href;
            })
			
// // 			alert("결재했습니다.")
// 			window.close()
// 			opener.location.href= opener.location.href;
// // 			opener.view_alert("결재했습니다.");
		}
	})
}

</script>

