<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>  
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<style>
.table{
	border-collapse:collapse;
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
.atrzLine{
	width: 62px;
/* 	flex-direction: row; */
	flex-wrap : wrap;
}
#openModalBtn{
	width:50px;
}
.isapprovalStatus{
	font-size:10px;
	text-align: center;
	border-top-style: hidden;
}
</style>
<body id="defaultFormView">
<div>
	<form id="editForm" action="${cPath }/approval/draftInsert.do" method="post" enctype="multipart/form-data">
	<security:csrfInput/>
	<div id="drftFormSetArea"  class="mt-5">
		<div id="drftFormBtnArea">
	    	<button name="action"  class="btn btn-sm btn-secondary mr-1 mb-2" value="temp" type="submit">임시저장</button>
	    	<input type="hidden" name="atrzFormId" value="${atrzFormId }"/>
	    	<button type="button" onclick="draftInsert()" class="btn btn-sm btn-secondary mr-1 mb-2" name="action" value="draft">상신</button>
		</div>
	</div>
		<div id="drftFormSetTableArea">
		<h1 id="draftFormTitle">${draftForm.atrzFormName}</h1>
		<table id="approvDoc" border="1">
		    <tr>
		        <td>기안번호</td>
		        <td>${approval.aprvDocId}</td>
		        <td rowspan="6"   >
		            <a id="openModalBtn">결재</a>
		        </td>
		        <td class="atrzLine position" ></td>
		        <td class="atrzLine position"></td>
		        <td class="atrzLine position"></td>
		        <td class="atrzLine position"></td>
		      </tr>
		    <tr >
		        <td>작성일자</td>
		        <td>${nowDate}</td>
		        <td rowspan="3">
		        </td>
		        <td rowspan="3">
		        </td>
		        <td rowspan="3">
		        </td>
		        <td rowspan="3">
		        </td>
		    </tr>
			<tr>       
		        <td>기안부서</td>
		        <td>${empDpmt.teamName}</td>
		    </tr>
			<tr>     
		        <td>기안자 <input type="hidden" name="empId" value="${empDpmt.empId}"/></td>
		        <td >${empDpmt.empName}</td>
		    </tr>
			<tr> 
		        <td>응급여부</td>
		        <td><input type="radio" name="isurgent" value="0" checked> 보통
					<input type="radio" name="isurgent" value="1"> 응급</td>
				<td class="atrzLine isapprovalStatus"></td>
		        <td class="atrzLine isapprovalStatus"></td>
		        <td class="atrzLine isapprovalStatus"></td>
		        <td class="atrzLine isapprovalStatus"></td>
		    </tr>
			<tr> 
		        <td  >수신자</td>
		        <td id="receiverId"></td>
		        <td class="atrzLine empId"></td>
		        <td class="atrzLine empId"></td>
		        <td class="atrzLine empId"></td>
		        <td class="atrzLine empId"></td>
		    </tr>
			<tr> 
		        <td >참조자</td>
		        <td colspan="6" id="rfrrLine"></td>
		    </tr>
		    <tr> 
		        <td >참조문서</td>
		        <td colspan="6" ><input id="rfrrDocId" name="rfrrDocId"  type="text" /><button id="openRefernceModal" >선택</button> </td>
		        
		    </tr>
			<tr> 
		        <td>제목</td>
		        <td colspan="6" ><input type="text" name="aprvDocTitle"  /></td>
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




<!-- 결재라인 지정모달  -->
<div id="myModal" class="modal">
  <div class="modal-content">
    <span id="lineClose">&times;</span>
    <div>
    <div>결재라인지정</div>
    <hr>
    	<div>
    	<div>소속명<br>
					<select name="team" class="form-select">
						<option value="">전체</option>
						<c:forEach  items="${teamInfo }" var="team">
							<option class="${team.belongTeam }" value="${team.teamId }">${team.teamName }</option>
						</c:forEach>
					</select>
					<br>
				<div class="empSelectFormBtnBox">
					<input type="button" value="결재" onclick="updateSelectedList(event)" class="btn btn-outline-secondary w-24 inline-block mr-1 mb-2">
					<input type="button" value="참조" onclick="updateSelectedList(event)" class="btn btn-outline-secondary w-24 inline-block mr-1 mb-2">
					<input type="button" value="수신" onclick="updateSelectedList(event)" class="btn btn-outline-secondary w-24 inline-block mr-1 mb-2">
				</div>
				<div>
					<table border="1" style="width:364.8px; text-align: center; border-collapse: collapse;" class="table">
					<thead >
						<tr>
							<td colspan=2 >
							<input class="selectFormCheckBox" type="checkbox" id="atrzEmpAll"/>부서/사원선택</td>
						</tr>
					</thead>
					<tbody id="teamEmpListBody" class="atrzScrollable-table" style="border: hidden; text-align: left;">
						<c:forEach items="${teamEmpList }" var="teamEmp">
							<tr class="${teamEmp.teamId } empListTr">
								<td><input class="selectFormCheckBox" type="checkbox" name="atrzEmp" data-empid="${teamEmp.empId }" data-empname="${teamEmp.empName}"  data-teamname="${teamEmp.teamName }" data-positionname="${teamEmp.positionName }"/></td>
								<td>[${teamEmp.teamName }] ${teamEmp.positionName } ${teamEmp.empName }</td>
							</tr>
						</c:forEach>
					</tbody>
					</table>
				</div>
				</div>
				<br>
				<div class="empSelectFormBtnBox">
					<input name="delete" type="button" value="삭제" class="btn btn-outline-secondary w-24 inline-block mr-1 mb-2">
				</div>
				<div>
				
				<div>
				<table border="1" style="width:364.8px; text-align: center; border-collapse: collapse;" id="selectedRcv" class="table">

					</table>
					<br>
				<table  border="1" style="width:364.8px; text-align: center; border-collapse: collapse;" >
						<tr>
							<td class="selectFormCheckBox"><input type="checkbox"/></td>
							<td class="whitespace-nowrap">no</td>
							<td class="whitespace-nowrap">구분</td>
							<td class="whitespace-nowrap">부서</td>
							<td class="whitespace-nowrap">직책</td>
							<td class="whitespace-nowrap">이름</td>
						</tr>
						<tbody id="selectedRfrr" >

						</tbody>
					</table>
				</div>
					<br>
				<div style="width:100%;">
				<table  border="1" style="width:364.8px; text-align: center; border-collapse: collapse;" class="table">
						<tr>
							<td class="selectFormCheckBox"><input type="checkbox"/></td>
							<td class="whitespace-nowrap">no</td>
							<td class="whitespace-nowrap">구분</td>
							<td class="whitespace-nowrap">부서</td>
							<td class="whitespace-nowrap">직책</td>
							<td class="whitespace-nowrap">이름</td>
						</tr>
						<tbody id="selectedList" class="table">
							<tr>
								<td><input type='checkbox' class='selectFormCheckBox'/></td>
								<td id="atrztrun" data-atrztrun="1">1</td>
								<td id="atrztype" data-atrztype="결재">결재</td>
								<td>${empDpmt.teamName}</td>
								<td id="position" data-positionname="${empDpmt.positionName}">${empDpmt.positionName}</td>
								<td id="empId" data-empid="${empDpmt.empId}">${empDpmt.empName}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			</div>
		</div>
		<div style="text-align: center">
			<input type="button" value="저장" onclick="inputAtrz()" class="btn btn-outline-secondary w-24 inline-block mr-1 mb-2"/>
	</div>
  </div>
</div>

















<div id="refernceModal" class="modal">
   <div class="overflow-x-auto">
     <div class="modal-content">
         <span id="rfrrClose">&times;</span>
         <div>
           <div>첨부문서선택</div>
           <hr>
           <div style="height:350px; display:block; overflow: auto;">
             <table class="table">
               <thead class="table-dark">
                 <tr>
                   <th class="whitespace-nowrap"><input type="checkbox"></th>
                   <th class="whitespace-nowrap">문서정보</th>
                   <th class="whitespace-nowrap">제목</th>
                   <th class="whitespace-nowrap">작성일자</th>
                 </tr>
               </thead>
               <tbody id="rfrrDocSelectList">
                 <c:if test="${not empty rfrrDocList }">
                   <c:forEach items="${rfrrDocList }" var="rfrrDoc">
                     <tr>
                       <td><input type="checkbox" id="selectRfrrInfo" type="hidden" name="rfrrDocId" value="${rfrrDoc.aprvDocId}"/> </td>
                       <td>${rfrrDoc.aprvDocId}<br>${rfrrDoc.atrzFormName}</td>
                       <td class="formSelect">
                         ${rfrrDoc.aprvDocTitle}
                       </td>
                       <td>${rfrrDoc.aprvDocDate}</td>
                     </tr>
                   </c:forEach>
                 </c:if>
                 <c:if test="${empty rfrrDocList }">
                   <tr>
                     <td colspan="7">결재양식없음</td>
                   </tr>
                 </c:if>
               </tbody>
             </table>
           </div>
         </div>
         <div style="display: flex; justify-content: center;" class="empSelectFormBtnBox">
           <input type="button" value="저장" onclick="inputReference()"/>
         </div>
     </div>
   </div>
 </div>


<script>
var header = '${_csrf.headerName}';
var token = '${_csrf.token}'

CKEDITOR.replace('aprvContent');

	let modal = document.querySelector("#myModal");
	let btn = document.querySelector("#openModalBtn");
	let refernceModal = document.querySelector("#refernceModal");
	let referenceModalBtn = document.querySelector("#openRefernceModal");
	let span = document.querySelector("#lineClose");
	let rfrrSpan = document.querySelector("#rfrrClose");
	

	referenceModalBtn.onclick = function() {
		event.preventDefault();
		refernceModal.style.display = "block";
		}

	btn.onclick = function() {
	  modal.style.display = "block";
	}

	span.onclick = function() {
	  modal.style.display = "none";
// 	  refernceModal.style.display = "none";
	}
	
	rfrrSpan.onclick = function() {
// 	  modal.style.display = "none";
	  refernceModal.style.display = "none";
	}

	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	  
	  
	}
	
	let rfrrLine = document.querySelector('#rfrrLine');
	console.log("rfrrLine 입니다 ",rfrrLine)
	
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
		modal.style.display = "none";
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

		  if (selectedRfrr.children.length>0){
			  for (var i = 0; i < selectListRfrrPostion.length; i++) {
			      var putRfrrPosition = selectListRfrrPostion[i];
			      console.log(putRfrrPosition);
			      var putEmp = selectListEmp[i];
			      console.log(putEmp);
			      var putEmpId = putEmp.getAttribute("data-empid");
			      console.log(putEmpId);
		 
			      var selectedData = putRfrrPosition.textContent; 
			      console.log(selectedData);
			      var selectedDataEmp = putEmp.textContent;
			      console.log(selectedDataEmp);
			      <!-- rfrrPosition.innerHTML = selectedData+`<input type='hidden' name='empId' value=\${putEmpId} >`; -->
			      
				  
				  $(rfrrLine).val(selectedData+"["+selectedDataEmp+"]")
			      rfrrLine.innerHTML += `<input type='hidden' name='receiver' value=\${putEmpId} >`
			      rfrrLine.innerHTML += rfrrLine.value
			      console.log("어어123",rfrrLine);
		      
			  }
		    
		  }else {
		    	rfrrLine.innerHTML = '';
		  }
		  
		  if(selectedRcv.children.length>0){
			  var selectRcvPostion = document.querySelector('#selectedRcv td[id="position"]');
			  console.log("포지션",selectRcvPostion);
			  var selectRcv = document.querySelector('#selectedRcv td[id="empId"]');
			  console.log("이름",selectRcvPostion);
			  
			  var rcvPosition = selectRcvPostion.getAttribute("data-positionname")
			  var rcvName = selectRcv.textContent;

			  rcv = document.querySelector("#receiverId");
			  $(rcv).val(rcvPosition+"["+rcvName+"]");
		      rcv.innerHTML += `<input type='hidden' name='receiver' value=\${putEmpId} >`
		      rcv.innerHTML += rcv.value;
		  }
		  modal.style.display = "none";
	}

	function inputReference(){
		event.preventDefault();
		var selectRfrrInfo = $("[name=rfrrDocId]:checked").val();
		console.log(selectRfrrInfo);
		
	    $("#rfrrDocId").val(selectRfrrInfo);
		console.log($("#rfrrDocId").val());
	    
	    refernceModal.style.display = "none";
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
	    var selectedRcv = document.querySelector("#selectedRcv");
		// selectedList 에 tr 태그가 있는지
		if (selectedList && selectedList.querySelector('tr')) {
			

			let atrzTypeTd = $("#selectedList td[id='atrztype']");
// 			let atrzEmpId = $("#selectedList td[id='empId']");
					
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
		        }else if(btnAtrzType=="참조"){
		        	console.log("lastCountOfRfrrs==",lastCountOfRfrrs);
		        	
		        	td2.setAttribute("data-atrzturn", (lastCountOfRfrrs + 1));
			        td2.innerHTML = lastCountOfRfrrs + 1;
			        lastCountOfRfrrs ++;
		        }
			}else{
				if(btnAtrzType=="수신"){
					td2.innerHTML = ""
				}else{
					td2.setAttribute("data-atrzturn", (i + 1));
				 	td2.innerHTML = i + 1;
				}

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
		        
	        }else if(btnAtrzType=="참조"){
	        	selectedRfrr.appendChild(tr);
	        }else{
	        	selectedRcv.appendChild(tr);
	        }
	    }
	    
	
	    
}
function draftInsert (){ 
	debugger;
	let formData = new FormData();// new FormData(form객체);, 얘를 써야 multi-part/formData

    let approval = {
    	aprvDocTitle: $("[name=aprvDocTitle]").val(),
    	aprvContent : CKEDITOR.instances.aprvContent.getData(),
        isurgent : $("[name=isurgent]:checked").val(),
        atrzFormId : $("[name=atrzFormId]").val(),
        receiver : $("[name=receiver]").val(),
        aprvDocReference : $("[name=rfrrDocId]").val()
        
    };
	
	/*
	formData.append("aprvDocTitle",$("[name=aprvDocTitle]").val());
	formData.append("aprvContent",CKEDITOR.instances.aprvContent.getData());
	formData.append("isurgent",$("[name=isurgent]").val());
	formData.append("atrzFormId",$("[name=atrzFormId]").val());
	formData.append("receiver",$("[name=receiver]").val());
	formData.append("aprvDocReference",$("[name=rfrrDocId]").val());
	formData.append("atrzFiles",$("[name=atrzFiles]")[0].files[0]);
	*/
	if($("[name=atrzFiles]")[0].files[0]){
		formData.append("ejFile",$("[name=atrzFiles]")[0].files[0]);
	}
	
    let aprvLines = [];
    let positions = document.querySelectorAll(".atrzline.position");
    console.log("positions",positions);
    for(let i=0; i<positions.length; i++){
        let position = positions[i];
        let aprvLine = {};
    	if(position.children[0]){
	        aprvLine.aprvTurn = position.children[0].value;
	        aprvLine.empId = position.children[1].value;
	        aprvLines.push(aprvLine);
    	}
    }
    
    let rfrrLines = [];
	    for(let i=0; i<rfrrLine.children.length; i++){
	        let rfrrEmps = {};
	        rfrrEmps.empId=rfrrLine.children[0].value;
	        rfrrLines.push(rfrrEmps);
    }
    
	    
    approval.atrzLineList = aprvLines;
    approval.atrzRfrrList = rfrrLines;
	formData.append('approval', new Blob([ JSON.stringify(approval) ], {type : "application/json"}))

    
	/*
	console.log("체킁 ",aprvLines)
	console.log("체킁 ",rfrrLines)
	*/

//	formData.append('atrzLineList', new Blob([ JSON.stringify(aprvLines) ], {type : "application/json"}))
//	formData.append('atrzRfrrList', new Blob([ JSON.stringify(rfrrLines) ], {type : "application/json"}))

// 	formData.append("atrzRfrrList",JSON.stringify(rfrrLines));
	
	
// 	for(let key of formData.keys()){
// 		console.log("key",key)
// 	}
// 	for(let val of formData.values()){
// 		console.log("val",val)
// 	}
	
	$.ajax({
		url: "${cPath}/approval/draftInsert.do",
		type: "post",
		data:formData,
		//data: JSON.stringify(approval),
		//contentType: "application/json;charset=utf-8",
		contentType:false,
		processData:false,
		cache:false,
        dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
		success : function(data){
			alert("결재를 등록했습니다.")
// 			if(rslt=="success"){
// 				Swal.fire({
//                     icon: 'success',
//                     title: '성공',
//                     text: "결재를 등록했습니다.",
// 				})
// 			}
			window.close()
		}
	});
}


</script>
</body>