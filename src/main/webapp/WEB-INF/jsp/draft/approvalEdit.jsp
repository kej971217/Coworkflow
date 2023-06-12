<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>   
<style>
.drftFormSetButton{
	height: 35px;
	margin:5px;
	border-color: #FFFFFF;
}
#drftFormBtnArea{
	padding-top: 10px; 
	display: flex;
  	justify-content: flex-end;
  
}
#approvDoc{
	border: 1px solid black;
	border-collapse: collapse;
	outline: 1.5px solid black;
	
}
#content{
    width: 649px;
    height: 473px;
}

#drftFormSetArea{
	background-color: #3541A8;
	height: 50px;
}
#drftFormSetTableArea{
	margin:50px;
}
#draftFormTitle{
	text-align: center;
}
/* #approvalEditView{ */
/* 	width:780; */
/* 	height:750; */
/* } */
</style>
<body id="approvalEditView">
<div>
	<div id="drftFormSetArea"  class="mt-5">
		<div id="drftFormBtnArea">
	    	<button class="btn btn-sm btn-secondary w-24 mr-1 mb-2">상신</button> 
			<button class="btn btn-sm btn-secondary w-24 mr-1 mb-2">보관</button> 
		</div>
	</div>
	<div id="drftFormSetTableArea">
	<h1 id="draftFormTitle">휴가신청서</h1>
	<table id="approvDoc" border="1">
	    <tr>
	        <td>기안번호</td>
	        <td>${approval.aprvDocId}</td>
	        <td rowspan="6">
	            결재
	          </td>
	        <c:set var="atrzLineList" value="${approval.atrzLineList }" />
					<c:if test="${not empty atrzLineList }">
						<c:forEach items="${approvalList }" var="atrzLine">
								<td>${atrzLine.authorizationLineName }[${atrzLine.positionName }]</td>
								<td>
									<c:url value="/approval/approvalView.do" var="viewURL">
										<c:param name="what" value="${approval.aprvDocId }" />
									</c:url>
									<a href="${viewURL }">${atrzLine.atrzLineEmpId }</a>
								</td>
						</c:forEach>
					</c:if>
	      </tr>
	    <tr>
	        <td>작성일자</td>
	        <td>${approval.aprvDocDate}</td>
	          <td rowspan="2">
	            서명
	          </td>
	          <td rowspan="2">
	            서명
	          </td>
	          <td rowspan="2">
	            서명
	          </td>
	          <td rowspan="2">
	            서명
	          </td>
	    </tr>
		<tr>       
	        <td>기안부서</td>
	        <td>${empDptmt.empId}</td>
	    </tr>
		<tr>     
	        <td>기안자</td>
	        <td >${empDptmt.empId}</td>
	        <td>이름[직책]</td>
	        <td>이름[직책]</td>
	        <td>이름[직책]</td>
	        <td>이름[직책]</td>
	    </tr>
		<tr> 
	        <td>응급여부</td>
	        <td><input type="radio" name="option" value="0"> 보통
				<input type="radio" name="option" value="1"> 응급</td>
	        <td rowspan="2">
	          서명
	        </td>
	        <td rowspan="2">
	          서명
	        </td>
	        <td rowspan="2">
	          서명
	        </td>
	        <td rowspan="2">
	          서명
	        </td>
	    </tr>
		<tr> 
	        <td>수신자</td>
	        <td ><input type="text"  style="width:190"><button>선택</button> </td>
	    </tr>
		<tr> 
	        <td>첨부파일</td>
	        <td colspan="6"><input type="text" style="width:540"><button>선택</button> </td>
	    </tr>
		<tr> 
	        <td>참조자</td>
	        <td colspan="6"><input type="text" style="width:540"><button>선택</button> </td>
	    </tr>
	    <tr> 
	        <td>참조문서</td>
	        <td colspan="6"><input type="text" style="width:540"><button>선택</button> </td>
	    </tr>
		<tr> 
	        <td>제목</td>
	        <td colspan="6" ><input type="text" name="title" style="width:582"/></td>
	    </tr>
	    <tr> 
	      <td colspan="7"><textarea name="aprvContent" id="aprvContent" >${approval.aprvContent}</textarea></td>
	  </tr>
	
	</table>
	</div>
</div>
<script>
// ClassicEditor.create( document.querySelector( '#content' ) );
CKEDITOR.replace('aprvContent');
CKEDITOR.instances.aprvContent.getData()


function insertNotice() {
	if(!$("[name=title]").val().trim()){
        Swal.fire({
            icon: 'fail',
            title: '제목을 입력해주세요.',
        });
		return;
	}
	if(!aprvContent.getData().trim()){
        Swal.fire({
            icon: 'fail',
            title: '내용을 입력해주세요.',
        });
		return;
	}
	
	
    let data = {
        aprvTitle: $("[name=title]").val(),
        aprvContent : aprvContent.getData()
        
    }
    
	$.ajax({
		url: "${cPath}/approval/noticeBoardInsert.do",
		type: "post",
		data: JSON.stringify(data),
		contentType: "application/json;charset=utf-8",
        dataType:"json",
		beforeSend: function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
		},
		/* 컨트롤러에서 return값이 data로(변수명이라서 다른 거 해도 상관없음) 넘어옴  */
		success : function(data){
            if(data=="1"){
				Swal.fire({
                    icon: 'success',
                    title: '성공',
                    text: "글을 등록했습니다.",
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.href = '${cPath}/approval/approvalList.do';
                    }
                })
            } else {
                Swal.fire({
                    icon: 'fail',
                    title: '제목을 입력해주세요.',
                    text: "잠시 후 다시 시도 해주세요.",
                });
            }
		}
		
	});
}
</script>
</body>