<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>   
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
#selectedList{
  	display: block;
    height: 150px;
    overflow: auto;
    box-sizing: content-box;
}
.selectFormCheckBox{
	box-sizing: content-box;
	width:23.6px;
}
.drftSetButton{
	height: 35px;
	margin:5px;
	border-color: #FFFFFF;
}
#drftBtnArea{
	padding-top: 10px; 
	display: flex;
  	justify-content: flex-end;
  
}
#approvDoc{
	border: 1px solid black;
	border-collapse: collapse;
	outline: 1.5px solid black;
	
}
#aprvContent{
    width: 649px;
    height: 473px;
}

#drftSetArea{
	background-color: #3541A8;
	height: 50px;
}
#drftSetTableArea{
	margin:50px;
}
#draftTitle{
	text-align: center;
}
/* #draftView{ */
/* 	width:780; */
/* 	height:750; */
/* } */

/* 모달 */
.modal {
  display: none; 
  position: fixed; 
  z-index: 1; 
  left: 0;
  top: 0;
  width: 100%; 
  height: 100%; 
  overflow: auto; 
  background-color: rgba(0,0,0,0.5); 
}

.modal-content {
  border-radius: 5px;
  background-color: #fefefe;
  margin: 15% auto; 
  padding: 20px;
  border: 1px solid #888;
  width: 400;
  overflow-y: auto;
  max-height: 500px;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

/*form*/

.atrzScrollable-table{
  	display: block;
    height: 150px;
    overflow: auto;
/*     width:360px; */
}
.empListTr{
	width:360px;
}

.empSelectFormBtnBox{
	padding:15px 0px;
	}
</style>
<body id="draftView">
<div>
	<div id="drftSetArea"  class="mt-5">
		<div id="drftBtnArea">
	    	<button name="action" value="temp" type="submit">임시저장</button>
	    	<input type="hidden" name="atrzFormId" value="${approval.atrzFormId }"/>
	    	<button name="action" value="draft" type="submit">상신</button>
			<form:form modelAttribute="approval" action="${cPath }/approval/draftDelete.do" method="post">
				<security:csrfInput/>
				<form:input type="hidden" path="aprvDocId" value="${approval.aprvDocId}"/>
				<form:button class="btn btn-sm btn-secondary mr-1 mb-2" type="submit" >삭제</form:button>
			</form:form>
		</div>
	</div>
	<div id="drftSetTableArea">
	<h1 id="draftTitle">${approval.atrzFormName}</h1>
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
							<td>${atrzLine.positionName }</td>
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
	        <td>${empDpmt.teamName}</td>
	        
	    </tr>
		<tr>     
	        <td>기안자</td>
	        <td >${empDpmt.empName}</td>
	        <td class="atrzLine empId"></td>
	        <td class="atrzLine empId"></td>
	        <td class="atrzLine empId"></td>
	        <td class="atrzLine empId"></td>
	        
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
	        <td class="atrzLine empId"></td>직책</td>
	        <td>직책</td>
	        <td>직책</td>
	        <td>직책</td>
	    </tr>
		<tr> 
	        <td>수신자</td>
	        <td >${approval.receiverName}[${approval.receiverDpmt}] </td>
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
	        <td>참조자</td>
	        <td>${approval.atrzRfrrList.atrzRfrrEmpDpmt} </td>
	    </tr>
	    <tr> 
	        <td>참조문서</td>
	        <td >${approval.aprvDocList.aprvDocTitle}</td>
	       	<td>이름</td>
	        <td>이름</td>
	        <td>이름</td>
	        <td>이름</td>
	    </tr>
		<tr> 
	        <td>제목</td>
	        <td colspan="6">${approval.aprvDocTitle}</td>
	    </tr>
	    <tr> 
	      <td colspan="7"><div name="aprvContent" id="aprvContent" >${approval.aprvContent}</div></td>
	  </tr>
	    <tr> <td>첨부파일</td>
	      <td colspan="6"><c:forEach items="${approval.atchFileGroup.atchFileList }" var="attatch" varStatus="vs">
				<c:url value="/approval/attatch/download.do" var="downloadURL">
					<c:param name="atchId" value="${attatch.atchId }" />
					<c:param name="atchSeq" value="${attatch.atchSeq }"/>
				</c:url>
				<a href="${downloadURL }">${attatch.atchOriginName }</a>
				
				<c:if test="${not vs.last }">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
			</c:forEach>
			</td>
	  </tr>
	
	</table>
	</div>
	<div style="width: 100%; padding: 50px; background-color: e9e9f4;"  >
		<div id="replyBody" >
		댓글
		<hr style="width:90%; margin:0px;" >
			<table>
				<c:set var="ReplyList" value="${approval.aprvReplyList }" />
						<c:if test="${not empty ReplyList }">
							<c:forEach items="${ReplyList }" var="reply">
									<tr>
										<td >${reply.empName }</td>
										<td>${reply.atrzReplyDate }</td>
										<td>
											<form id="replyDelete" action="${cPath }/approval/aprvReplyDelete.do" method="post">
											<security:csrfInput/>
											<input type="hidden" name="what" value="${reply.atrzReplyId }"/>
											<input type="hidden" name="aprvDocId" value="${reply.aprvDocId }"/>
												<button type="submit">삭제</button>
												<input type="button" onclick="updateReply(${reply.atrzReplyId })" value="수정">
											</form>
										</td>
									</tr>
									<tr>
										<td class="replycontent" id="replyId+'${reply.atrzReplyId }'" >${reply.atrzReplyContent }</td>
									</tr>
							</c:forEach>
						</c:if>
			</table>
		</div>
		<br>
		<div>
			<form:form id="replyForm" modelAttribute="aprvReply" action="${cPath }/approval/aprvReplyInsert.do" method="post">
				<security:csrfInput/>
				<form:input type="hidden" path="aprvDocId" value="${approval.aprvDocId}"/>
				<form:textarea style="width:80%;"  path="atrzReplyContent" />
				<form:button style="">등록</form:button>
			</form:form>
		</div>
	</div>
</div>





<script>
CKEDITOR.replace('aprvContent');

let modal = document.getElementById("myModal");
let btn = document.getElementById("openModalBtn");
let refernceModal = document.getElementById("refernceModal");
let referenceModalBtn = document.getElementById("openRefernceModal");
let span = document.getElementsByClassName("close");

referenceModalBtn.onclick = function() {
	event.preventDefault();
	refernceModal.style.display = "block";
	}

btn.onclick = function() {
  modal.style.display = "block";
}

span.onclick = function() {
  modal.style.display = "none";
  refernceModal.style.display = "none";
}

window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
  
  
}
let rfrrLine = document.querySelector('#rfrrLine');

function rfrcDocSelectForm(){
	window.open(`rfrcDocSelectForm.do`, "참조문서 선택", "width=460, height=760")  
}

/**
 * selectedList에 입력된 tr 중 선택 된 데이터 삭제
 */
$(document).on('click', 'input[name="delete"]', function() {
	  var selectedCheckboxes = $('#selectedList input[type="checkbox"]:checked');

	  selectedCheckboxes.each(function() {
	    selectedCheckboxes.closest('tr').remove();
	  });
	});

/**
 * checkbox 사용
 */
 
$(document).ready(function() {
	  var atrzEmpAll = $('#atrzEmpAll');
	  atrzEmpAll.change(function() {
	    var checked = atrzEmpAll.prop('checked');
	    $('input[name="atrzEmp"]:visible').prop('checked', checked);
	  });
	  atrzEmpAll.prop('checked',false); 

	  var atrzEmpUnSelect = document.querySelectorAll("#teamEmpListBody input[name='atrzEmp']:visible");
	  for (let i = 0; i < atrzEmpUnSelect.length; i++) {
	    atrzEmpUnSelect[i].addEventListener('change', function() {
	      if (!this.checked) {
	        atrzEmpAll.prop('checked', false);
	      }
	    });
	  }
	});



$("[name=team]").on("change", function(event){
	$("#teamEmpListBody > tr").css("display","none");
	$("#teamEmpListBody > tr." +this.value).css("display","block");
})

function inputAtrz(){
	  event.preventDefault();

	  var selectListAtrzPostion = document.querySelectorAll('#selectedList td[id="position"]');
	  var selectListAtrztrun = document.querySelectorAll('#selectedList td[id="atrztrun"]');
	  var selectListEmp = document.querySelectorAll('#selectedList td[id="empId"]');
	  

	  var atrzLines = document.querySelectorAll('.atrzLine');
	  	console.log("atrzLines ", atrzLines)
	  
	  var atrzLinePosition = document.querySelectorAll('.position');
	  var atrzLineEmp = document.querySelectorAll('.empId');

	  for (var i = 0; i < selectListAtrzPostion.length; i++) {
		  
	    var atrzPosition = atrzLinePosition[i];
	    var atrzEmp = atrzLineEmp[i];
		
	    //
	    var putAtrzPosition = selectListAtrzPostion[i];
		var putAtrztrun = selectListAtrztrun[i];
	  	var putEmp = selectListEmp[i];
	  	console.log("selectListEmp 여기여기 ",i,selectListEmp[i])
	  	var putEmpId = putEmp.getAttribute("data-empid");

	  	
	    if (putAtrzPosition) {
	      var selectedDataType = putAtrzPosition.textContent; 
	      var selectedDataTurn = putAtrztrun.textContent; 
	      atrzPosition.innerHTML = selectedDataType+`<input type='hidden' name='atrzTrun' value=\${selectedDataTurn} >`
												      +`<input type='hidden' name='empId' value=\${putEmpId} >`;
	      var selectedDataEmp = putEmp.textContent;
			atrzEmp.innerHTML = selectedDataEmp; 
	    } else {
	    	atrzPosition.innerHTML = '';
			atrzEmp.innerHTML = ''; 
	    }
	  }
	  

	  var selectListRfrrPostion = document.querySelectorAll('#selectedRfrr td[id="position"]');
	  var selectListEmp = document.querySelectorAll('#selectedRfrr td[id="empId"]');

	  
	  for (var i = 0; i < selectListRfrrPostion.length; i++) {
	      var putRfrrPosition = selectListRfrrPostion[i];
	      console.log(putRfrrPosition);
	      var putEmp = selectListEmp[i];
	      console.log(putEmp);
	      var putEmpId = putEmp.getAttribute("data-empid");
	      console.log(putEmpId);

	      
	    if (putRfrrPosition) {
	      var selectedData = putRfrrPosition.textContent; 
	      console.log(selectedData);
	      var selectedDataEmp = putEmp.textContent;
	      console.log(selectedDataEmp);
	      <!-- rfrrPosition.innerHTML = selectedData+`<input type='hidden' name='empId' value=\${putEmpId} >`; -->
	      
	      $(rfrrLine).val(selectedData+"["+selectedDataEmp+"]")
	      alert($(rfrrLine).val())
	      rfrrLine.innerHTML += `<input type='hidden' name='empId' value=\${putEmpId} >`
	      rfrrLine.innerHTML += rfrrLine.value
	    } else {
	      rfrrLine.innerHTML = '';
	    }
	    
	  }

	  modal.style.display = "none";
}

function updateSelectedList(e) {
	let lastCountOfAtrzes = 0;
	let lastCountOfRfrrs = 0;
	let btnAtrzType = e.target.value;
	let typeOfAtrzes="";
    
    let checkBoxes = document.querySelectorAll("#teamEmpListBody input[type='checkbox']:checked");
	for(let i=0; i< checkBoxes.length; i++){
		checkBoxes[i].checked = false;
	}
	/* 버튼의 결재 타입*/
console.log("@1, btnAtrzType ::: ", btnAtrzType )
    /* ("#selectedList");의 변수 선언 */
    var selectedList = document.querySelector("#selectedList");
    var selectedRfrr = document.querySelector("#selectedRfrr");
	// selectedList 에 tr 태그가 있는지
	if (selectedList && selectedList.querySelector('tr')) {
		
debugger;
		let atrzTypeTd = $("#selectedList td[id='atrztype']");
//			let atrzEmpId = $("#selectedList td[id='empId']");
				
		for (var i = 0; i < atrzTypeTd.length; i++ ){
			// 등록된 td의 결재 타입
			lastCountOfAtrzes += 1;
		}
	}

	
	if (selectedRfrr && selectedRfrr.querySelector('tr')) {
		let rfrrTypeTd = $("#selectedRfrr td[id='atrztype']");
		for (var i = 0; i < rfrrTypeTd.length; i++ ){
			// 등록된 td의 결재 타입
			lastCountOfRfrrs += 1;
			
		}
	}
	
    for (var i = 0; i < checkBoxes.length; i++) {
   	var empId = checkBoxes[i].getAttribute("data-empid")
   	
        var tr = document.createElement("tr");
        var td1 = document.createElement("td");
        var td2 = document.createElement("td");
        var td3 = document.createElement("td");
        var td4 = document.createElement("td");
        var td5 = document.createElement("td");
        var td6 = document.createElement("td"); 
        
        var atrzTurn = parseInt(td2.getAttribute("data-atrzturn"));
        td1.innerHTML = "<input type='checkbox' class='selectFormCheckBox'/>";
        td2.setAttribute("id", "atrztrun");
		td3.setAttribute("id", "atrztype");
		td3.setAttribute("data-atrztype", btnAtrzType);
		td3.innerHTML = btnAtrzType;

        if (selectedList && selectedList.querySelector('tr')) {
	        if(btnAtrzType=="결재"){
		        td2.setAttribute("data-atrzturn", (lastCountOfAtrzes + 1));
		        td2.innerHTML = lastCountOfAtrzes + 1;
		        lastCountOfAtrzes ++;
	        }else{
	        	console.log("lastCountOfRfrrs==",lastCountOfRfrrs);
	        	
	        	td2.setAttribute("data-atrzturn", (lastCountOfRfrrs + 1));
		        td2.innerHTML = lastCountOfRfrrs + 1;
		        lastCountOfRfrrs ++;
	        }
		}else{
			td2.setAttribute("data-atrzturn", (i + 1));
		 	td2.innerHTML = i + 1;

		}
        
        td4.innerHTML = checkBoxes[i].getAttribute("data-teamname"); // 부서 입력
        td5.setAttribute("id", "position");
        td5.setAttribute("data-positionname", checkBoxes[i].getAttribute("data-positionname"));
        td5.innerHTML= checkBoxes[i].getAttribute("data-positionname");
        td6.setAttribute("id", "empId");
        td6.setAttribute("data-empid", checkBoxes[i].getAttribute("data-empid"));
        td6.innerHTML = checkBoxes[i].getAttribute("data-empname") + "<input type='hidden' data-empid='" + checkBoxes[i].getAttribute("data-empid") + "' />"; // 이름 입력

        tr.appendChild(td1);
        tr.appendChild(td2);
        tr.appendChild(td3);
        tr.appendChild(td4);
        tr.appendChild(td5);
        tr.appendChild(td6);

        if(btnAtrzType=="결재"){
        	selectedList.appendChild(tr);
	        
        }else{
        	selectedRfrr.appendChild(tr);
        }
    }
    

    
}
function draftInsert (){ 
let approval = {
	aprvDocTitle: $("[name=aprvDocTitle]").val(),
    postContent : aprvContent.getData(),
    isurgent : $("[name=isurgent]:checked").val(),
    atrzFormId : $("[name=atrzFormId]").val()
};
let aprvfLines = [];
let tds = document.querySelectorAll(".position");
for(let i=0; i<tds.length; i++){
    let td = tds[i];
    let aprvfLine = {};
    aprvfLine.atrzTrun = td.children[0].value;
    aprvfLine.empId = td.children[1].value;
    aprvfLines.push(aprvfLine);
}

	console.log(rfrrLine.children.length)
let rfrrLines = [];
for(let i=0; i<rfrrLine.children.length; i++){
    let rfrrEmps = {};
    rfrrEmps.empId=rfrrLine.children.$("[name=empId]").val();
    rfrrLines.push(rfrrEmps);
}

console.log("rfrrLines 확인",rfrrLines);  // [] => List, {} => VO, Map,  [{},{}] =>  {atrzLinrList:[{}]} List<VO>, List<Map> 

approval.atrzLineList = aprvfLines;
approval.atrzRfrrList = rfrrLines;
$.ajax({
	url: "${cPath}/approval/draftInsert.do",
	type: "post",
	data: JSON.stringify(approval),
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
window.close
}

</script>
</body>