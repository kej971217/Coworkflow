<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>  
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<style>
.atrzLine{
	width: 62px;
/* 	flex-direction: row; */
	flex-wrap : wrap;
}
#selectedList{
  	display: block;
    height: 150px;
    overflow: auto;
    box-sizing: content-box;
}
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
/* #defaultFormView{ */
/* 	width:780; */
/* 	height:750; */
/* } */
</style>
<body id="EditFormView">
<div>
	<form id="editForm" action="${cPath }/approval/draftUpdate.do" method="post" enctype="multipart/form-data">
	<security:csrfInput/>
	<div id="drftFormSetArea"  class="mt-5">
		<div id="drftFormBtnArea">
	    	<button name="action" value="temp" type="submit">임시저장</button>
	    	<input type="hidden" name="atrzFormId" value="${atrzFormId }"/>
	    	<button onclick="draftInsert()" name="action" value="draft" type="submit">상신</button>
		</div>
	</div>
		<div id="drftFormSetTableArea">
		<h1 id="draftFormTitle">${draftForm.atrzFormName}</h1>
		<table id="approvDoc" border="1">
	   	    <tr>
	        <td>기안번호</td>
	        <td>${approval.aprvDocId}</td>
	        <td rowspan="8">
	            결재
	          </td>
	        <c:set var="atrzLineList" value="${approval.atrzLineList }" />
					<c:if test="${not empty atrzLineList }">
						<c:forEach items="${atrzLineList }" var="atrzLine">
							<td class="atrzLine atrztype">${atrzLine.positionName }</td>
						</c:forEach>
					</c:if>
					<c:if test="${empty atrzLineList }">
						<td class="atrzLine atrztype"></td>
				        <td class="atrzLine atrztype"></td>
				        <td class="atrzLine atrztype"></td>
				        <td class="atrzLine atrztype"></td>
					</c:if>
	      </tr>
	    <tr>
	        <td>작성일자</td>
	        <td>${approval.aprvDocDate}</td>
	          <td rowspan="2">
	            
	          </td>
	          <td rowspan="2">
	            
	          </td>
	          <td rowspan="2">
	            
	          </td>
	          <td rowspan="2">
	            
	          </td>
	    </tr>
		<tr>       
	        <td>기안부서</td>
	        <td>${empDpmt.teamName}</td>
	        
	    </tr>
		<tr>     
	        <td>기안자</td>
	        <td >${empDpmt.empName}</td>
					<c:if test="${not empty atrzLineList }">
						<c:forEach items="${atrzLineList }" var="atrzLine">
							<td class="atrzLine empId">${atrzLine.empName }</td>
						</c:forEach>
					</c:if>
					<c:if test="${empty atrzLineList }">
						<td class="atrzLine empId"></td>
				        <td class="atrzLine empId"></td>
				        <td class="atrzLine empId"></td>
				        <td class="atrzLine empId"></td>
					</c:if>
	        
	    </tr>
		<tr> 
	        <td>응급여부</td>
	        <td>
	        	<c:if test="${approval.isurgent == '1'}">
				    응급
				</c:if>
	        	<c:if test="${approval.isurgent == '0'}">
				    보통
				</c:if>
			</td>
	        <td class="atrzLine empId"></td>
	        <td></td>
	        <td></td>
	        <td></td>
	    </tr>
		<tr> 
	        <td>수신자</td>
	        <td >${approval.receiverName}[${approval.receiverDpmt}] </td>
	        <td rowspan="2">
	          
	        </td>
	        <td rowspan="2">
	          
	        </td>
	        <td rowspan="2">
	          
	        </td>
	        <td rowspan="2">
	          
	        </td>
	    </tr>
		<tr> 
	        <td>참조자</td>
	        <td>${approval.atrzRfrrList.atrzRfrrEmpDpmt} </td>
	    </tr>
		    <tr> 
		        <td>참조문서</td>
		        <td><input id="rfrrDocId" name="rfrrDocId"  type="text" /><button id="openRefernceModal" >선택</button> </td>
		        <td class="atrzLine empId"></td>
		        <td class="atrzLine empId"></td>
		        <td class="atrzLine empId"></td>
		        <td class="atrzLine empId"></td>
		    </tr>
			<tr> 
		        <td>제목</td>
		        <td colspan="6" ><input type="text" name="aprvDocTitle" value="${approval.aprvDocTitle}" /></td>
		    </tr>
		    <tr> 
		      <td colspan="7"><textarea name="aprvContent" id="aprvContent"> ${draftForm.atrzFormContent }</textarea></td>
		  </tr>
			    <tr> <td>첨부파일</td>
	      <td colspan="6"><input type="file" name="atrzFiles" />
			</td>
	  </tr>
		</table>
		</div>
	</form>
</div>
<script>
// ClassicEditor.create( document.querySelector( '#content' ) );
CKEDITOR.replace('aprvContent');
// CKEDITOR.instances.content.getData()

var header = '${_csrf.headerName}';
var token = '${_csrf.token}'


function draftUpdate (){ 
	debugger;
	event.preventDefault();
    let approval = {
    	aprvDocTitle: $("[name=aprvDocTitle]").val(),
    	aprvContent : CKEDITOR.instances.aprvContent.getData(),
        isurgent : $("[name=isurgent]:checked").val(),
        atrzFormId : $("[name=atrzFormId]").val(),
        receiver : $("[name=receiver]").val(),
        aprvDocReference : $("[name=rfrrDocId]").val()
        
    };
    
    let rfrrLines = [];
    for(let i=0; i<rfrrLine.children.length; i++){
        let rfrrEmps = {};
        rfrrEmps.empId=rfrrLine.children[0].value;
        rfrrLines.push(rfrrEmps);
    }

    console.log("rfrrLines 확인",rfrrLines);  // [] => List, {} => VO, Map,  [{},{}] =>  {atrzLinrList:[{}]} List<VO>, List<Map> 
    
    approval.atrzLineList = aprvLines;
    approval.atrzRfrrList = rfrrLines;
    console.log("approval 확인",approval);   
	$.ajax({
		url: "${cPath}/approval/draftUpdate.do",
		type: "post",
		data: JSON.stringify(approval),
		contentType: "application/json;charset=utf-8",
        dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
		success : function(data){
			
			alert("결재가 수정되었습니다.")
			window.close()
		}
	});
}


</script>
</body>