<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>  

<style>
.defaultFormDiv{
/* 	display : none; */
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
/* #approvDoc{ */
/* /*    border: 1px solid black; */ */
/*    border-collapse: collapse; */
/* /*    outline: 1.5px solid black; */ */
   
/* } */
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
/*    width:780; */
/*    height:750; */
/* } */
/* .modal { */
/*   display: none;  */
/*   position: fixed;  */
/*   z-index: 1;  */
/*   left: 0; */
/*   top: 0; */
/*   width: 100%;  */
/*   height: 100%;  */
/*   overflow: auto;  */
/*   background-color: rgba(0,0,0,0.5);  */
/* } */

/* .modal-content { */
/*   border-radius: 5px; */
/*   background-color: #fefefe; */
/*   margin: 15% auto;  */
/*   padding: 20px; */
/*   border: 1px solid #888; */
/*   width: 400; */
/*   overflow-y: auto; */
/*   max-height: 500px; */
/* } */

/* .close { */
/*   color: #aaa; */
/*   float: right; */
/*   font-size: 28px; */
/*   font-weight: bold; */
/*   cursor: pointer; */
/* } */

/* .close:hover, */
/* .close:focus { */
/*   color: black; */
/*   text-decoration: none; */
/*   cursor: pointer; */
/* } */

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
   hieght: 24px;
/*    flex-direction: row; */
   flex-wrap : wrap;
}
#openModalBtn{
/*    width:15px; */
}
.isapprovalStatus{
   font-size:10px;
   text-align: center;
   border-top-style: hidden;
}
#draftFormListFrom{
	display:none;
}
.heightTr{
 height: 40px;
/*  width : 562px; */
}
.heightTr td:first-child {{
	width: 25px;
}
</style>  

<div class="grid grid-cols-12 gap-6 mt-8">
	<div class="col-span-12 lg:col-span-3 2xl:col-span-2">
		  <%-- 결재 좌측 사이드 메뉴 include --%>
		<jsp:include page="/includee/aprvLeftMenu.jsp"></jsp:include>
	</div>
	<div class="col-span-12 lg:col-span-9 2xl:col-span-10" id="approvalListFrom">
        <div class="grid grid-cols-12 gap-6 mt-5">
            <div id="searchUI" class="intro-y col-span-12 flex flex-wrap xl:flex-nowrap items-center mt-2">
             	<div style="margin:0 20px;">
	              	<input type="radio" name="searchUrgent" checked> 전체
	              	<input type="radio" name="searchUrgent" value="0"> 보통
					<input type="radio" name="searchUrgent" value="1"> 응급
             	</div>
            <div class="flex w-full sm:w-auto">
           		<input type="date" class="form-control box pr-10" style="margin-right:8px;">
                <input type="date" class="form-control box pr-10" style="margin-right:8px;">
                <div class="w-48 relative text-slate-500">
                   <input name="searchWord" type="text" class="form-control w-48 box pr-10" placeholder="검색 내용">
                   <i class="w-4 h-4 absolute my-auto inset-y-0 mr-3 right-0" icon-name="search"></i> 
                </div>
                <select name="searchType" class="form-select box ml-2">
                   <option value>전제</option>
                   <option value="searchWord">제목</option>
                   <option value="empName">작성자</option>
                </select>
            </div>
            <div class="hidden xl:block mx-auto text-slate-500">
            	<input type="button" value="<spring:message code="search" />" id="searchBtn" class="btn btn-primary"/>
            </div>
            <div class="w-full xl:w-auto flex items-center mt-3 xl:mt-0">
                <div class="dropdown">
                </div>
            </div>
            </div>
            <div id="listTableBody" class="aprvList intro-y col-span-12 overflow-auto 2xl:overflow-visible" data-view-url="${cPath}/approval/draftView.do">
                <table class="table table-report -mt-2" >
                	<thead>
	                	<tr>
					        <th class="whitespace-nowrap">
					            <input class="form-check-input" type="checkbox">
					        </th>
					        <th class="whitespace-nowrap">문서정보</th>
					        <th class="whitespace-nowrap">제목</th>
					        <th class="whitespace-nowrap">작성자</th>
					        <th class="whitespace-nowrap">작성일자</th>
				    	</tr>
			    	</thead>
			    	<tbody class="listTableBody">
			    	
			    	</tbody>
                
                </table>
            </div>
            <div class="pagingArea intro-y col-span-12 flex flex-wrap sm:flex-row sm:flex-nowrap items-center">
                </div>
            </div>
	</div>
            
    <%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	
    <div class="col-span-12 lg:col-span-9 2xl:col-span-10" id="draftFormListFrom">
    	<form id="editForm" action="${cPath }/approval/draftInsert.do" method="post" enctype="multipart/form-data">
		    <security:csrfInput/>
		    <input type="hidden" name="atrzFormId" value="${atrzFormId }"/>
			<div class="intro-y col-span-12 flex flex-wrap xl:flex-nowrap items-center mt-2 right">
            <div class="flex w-full sm:w-auto">
            <div class="w-48 relative text-slate-500">
	            <input name="searchWord" type="text" class="form-control w-48 box pr-10" placeholder="검색 내용">
	            <i class="w-4 h-4 absolute my-auto inset-y-0 mr-3 right-0" icon-name="search"></i> 
            </div>
            <div class="ml-5">
	             <select name="searchType" class="form-select box ml-2">
	                 <option value>전제</option>
	                 <option value="searchWord">제목</option>
	                 <option value="empName">작성자</option>
	             </select>
         	</div>
            <div class="ml-10">
            	<button type="button" class="btn btn-primary-soft flex w-24 inline-block mr-1 mb-2" 
            			name="action" value="temp" type="submit"> 임시저장 </button>
        	</div>
            <div class="ml-3">
            	<button type="button" class="btn btn-primary-soft flex w-24 inline-block mr-1 mb-2" 
            			onclick="draftInsert()" name="action" value="draft" > <i icon-name="file-text" class="w-4 h-4 mr-2"></i> 상신 </button>
        	</div>
            </div>
            <div class="hidden xl:block mx-auto text-slate-500"></div>
            	<div class="w-full xl:w-auto flex items-center mt-3 xl:mt-0">
	                 <div class="dropdown">
	                 </div>
            	</div>
			</div>
				<div class="grid grid-cols-12 gap-5 mt-5">
<!-- 					<div class="col-span-12 xl:col-span-8 2xl:col-span-3"> -->
	               		<div id="listTableBody" class="aprvList intro-y col-span-12 overflow-auto 2xl:overflow-visible" data-view-url="${cPath}/approval/draftView.do">
		                   	<table class="listTableBody table table-report -mt-2" >
		                   	</table>
	                   	</div>
<!--         			</div> -->
<!-- 					<div class="col-span-12 xl:col-span-8 2xl:col-span-9"> -->
<!-- 						<div id="defaultFormDiv" class="box p-5 intro-y" > -->
<!-- 						      <div id="drftFormSetTableArea"> -->
<%-- 						      <h1 id="draftFormTitle">${draftForm.atrzFormName}</h1> --%>
<!-- 						      		<div > -->
<!-- 						      			<div  rowspan="6"   style="background-color: green; width: 10px;"> -->
<!-- 						                  <a id="openModalBtn" data-tw-toggle="modal" data-tw-target="#aprvModal">결재</a> -->
<!-- 						              	</div> -->
<!-- 							      		<div> -->
<!-- 							      			<div class="atrzLine position" style="background-color: yellow; "></div> -->
<!-- 							             	<div class="atrzLine position"></div> -->
<!-- 							              	<div class="atrzLine position"></div> -->
<!-- 							              	<div class="atrzLine position"></div> -->
<!-- 							      		</div> -->
<!-- 							      		<div> -->
<!-- 							      			<div class="aprvImgDiv" style="background-color: gray;"> -->
<!-- 								            </div> -->
<!-- 								            <div class="aprvImgDiv" > -->
<!-- 								            </div> -->
<!-- 								            <div class="aprvImgDiv" > -->
<!-- 								            </div> -->
<!-- 								            <div class="aprvImgDiv" > -->
<!-- 								            </div> -->
<!-- 							      		</div> -->
<!-- 							      		<div> -->
<!-- 							      			<div class="atrzLine isapprovalStatus" ></div> -->
<!-- 							              	<div class="atrzLine isapprovalStatus"></div> -->
<!-- 							              	<div class="atrzLine isapprovalStatus"></div> -->
<!-- 							              	<div class="atrzLine isapprovalStatus"></div> -->
<!-- 							      		</div> -->
<!-- 							      		<div> -->
<!-- 							      			<div class="atrzLine empId" style="background-color: orange;"></div> -->
<!-- 							              	<div class="atrzLine empId"></div> -->
<!-- 							              	<div class="atrzLine empId"></div> -->
<!-- 							              	<div class="atrzLine empId"></div> -->
<!-- 							      		</div> -->
<!-- 						      		</div> -->
						      
<!-- 						      <table id="approvDoc" style="width:100%;"> -->
<!-- 						          <tr class="heightTr"> -->
<!-- 						              <td>작성일자</td> -->
<%-- 						              <td>${nowDate}</td> --%>
<!-- 						          </tr> -->
<!-- 						          <tr class="heightTr">       -->
<!-- 						              <td>기안부서</td> -->
<%-- 						              <td>${empDpmt.teamName}</td> --%>
						              
<!-- 						          </tr> -->
<!-- 						          <tr class="heightTr">    -->
<%-- 						              <td>기안자 <input type="hidden" name="empId" value="${empDpmt.empId}"/></td> --%>
<%-- 						              <td >${empDpmt.empName}</td> --%>
<!-- 						          </tr> -->
<!-- 						          <tr class="heightTr"> -->
<!-- 						              <td>응급여부</td> -->
<!-- 						              <td><input type="radio" name="isurgent" value="0" checked> 보통 -->
<!-- 						               <input type="radio" name="isurgent" value="1"> 응급</td> -->
<!-- 						          </tr> -->
<!-- 						          <tr class="heightTr"> -->
<!-- 						              <td  >수신자</td> -->
<!-- 						              <td id="receiverId"></td> -->
<!-- 						          </tr> -->
<!-- 						          <tr class="heightTr"> -->
<!-- 						              <td >참조자</td> -->
<!-- 						              <td id="rfrrLine"></td> -->
<!-- 						          </tr> -->
<!-- 						          <tr class="heightTr"> -->
<!-- 						              <td ><a id="openRefernceModal"  data-tw-toggle="modal" data-tw-target="#refernceModal">참조문서</a></td> -->
<!-- 						              <td ><input class="form-control" id="rfrrDocId" name="rfrrDocId"  type="text" /></td> -->
<!-- 						          </tr> -->
<!-- 						         <tr class="heightTr"> -->
<!-- 						              <td>제목</td> -->
<!-- 						              <td ><input class="form-control" type="text" name="aprvDocTitle"  /></td> -->
<!-- 						          </tr> -->
<!-- 						          <tr>  -->
<%-- 						          	<td colspan="2"><textarea name="aprvContent" id="aprvContent"> ${draftForm.atrzFormContent }</textarea></td> --%>
<!-- 						         </tr> -->
<!-- 						         <tr class="heightTr"> <td>첨부파일</td> -->
<!-- 						         	<td><input type="file" name="atrzFiles" /> -->
<!-- 						         	</td> -->
<!-- 						     	 </tr> -->
<!-- 						      </table> -->
<!-- 						      </div> -->
<!-- 						</div> -->
<!-- 			        </div> -->
			        
       			</div>
	   </form>
             </div>
	</div>
               
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

    
    
        <form name="searchForm" method="post">
			<security:csrfInput/>
			<input type="hidden" name="listType" placeholder="listType"/>
			<input type="hidden" name="page" placeholder="page"/>
			<input type="hidden" name="searchBgn" placeholder="searchBgn"/>
			<input type="hidden" name="searchEnd" placeholder="searchEnd"/>
			<input type="hidden" name="searchUrgent" placeholder="searchUrgent"/>
			<input type="hidden" name="searchType" placeholder="searchType"/>
			<input type="hidden" name="searchWord" placeholder="searchWord"/>
		</form>
		
		
		
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
		
<!-- <!-- 결재라인 지정모달  --> -->
<!-- <div id="aprvModal" class="modal" data-tw-backdrop="static" tabindex="-1" aria-hidden="true"> -->
<!-- 	<div class="modal-dialog modal-lg">    -->
<!-- 		<div class="modal-content">   -->
<!--     <div class="modal-header"> -->
<!-- 				<h2 class="font-medium text-xl mr-auto">결재라인지정</h2>   -->
<!-- 			</div> -->
<!--     <hr> -->
<!--        <div class="modal-body p-10"> -->
<!--        <div>소속명 -->
<!--                <select name="team" class="form-select"> -->
<!--                   <option value="">전체</option> -->
<%--                   <c:forEach  items="${teamInfo }" var="team"> --%>
<%--                      <option class="${team.belongTeam }" value="${team.teamId }">${team.teamName }</option> --%>
<%--                   </c:forEach> --%>
<!--                </select> -->
<!--                <br> -->
<!--                <div>직원명 <input name="atrzEmpName"/> <input type="submit" value="검색"/></div> -->
<!--             <div class="empSelectFormBtnBox"> -->
<!--                <input type="button" value="결재" onclick="updateSelectedList(event)"> -->
<!--                <input type="button" value="참조" onclick="updateSelectedList(event)"> -->
<!--                <input type="button" value="수신" onclick="updateSelectedList(event)"> -->
<!--             </div> -->
<!--             <div> -->
<!--                <table border="1"> -->
<!-- 	               <thead> -->
<!-- 	                  <tr> -->
<!-- 	                     <td colspan=2 > -->
<!-- 	                     <input class="selectFormCheckBox" type="checkbox" id="atrzEmpAll"/>부서/사원선택</td> -->
<!-- 	                  </tr> -->
<!-- 	               </thead> -->
<!-- 	               <tbody id="teamEmpListBody" class="atrzScrollable-table"> -->
<%-- 	                  <c:forEach items="${teamEmpList }" var="teamEmp"> --%>
<%-- 	                     <tr class="${teamEmp.teamId } empListTr"> --%>
<%-- 	                        <td><input class="selectFormCheckBox" type="checkbox" name="atrzEmp" data-empid="${teamEmp.empId }" data-empname="${teamEmp.empName}"  data-teamname="${teamEmp.teamName }" data-positionname="${teamEmp.positionName }"/></td> --%>
<%-- 	                        <td>[${teamEmp.teamName }] ${teamEmp.positionName } ${teamEmp.empName }</td> --%>
<!-- 	                     </tr> -->
<%-- 	                  </c:forEach> --%>
<!-- 	               </tbody> -->
<!--                </table> -->
<!--             </div> -->
<!--             </div> -->
<!--             <div class="empSelectFormBtnBox"> -->
<!--                <input name="delete" type="button" value="삭제"> -->
<!--             </div> -->
<!--             <div> -->
<!--             <div> -->
<!--             <table border="1" style="width:364.8px; text-align: center;" id="selectedRcv"> -->

<!--                </table> -->
<!--                <br> -->
<!--             <table border="1" style="width:364.8px; text-align: center;"> -->
<!--                   <tr> -->
<!--                      <td class="selectFormCheckBox"><input type="checkbox"/></td> -->
<!--                      <td>no</td> -->
<!--                      <td>구분</td> -->
<!--                      <td>부서</td> -->
<!--                      <td>직책</td> -->
<!--                      <td>이름</td> -->
<!--                   </tr> -->
<!--                   </table> -->
<!--                <table border="1" style="width:364.8px; text-align: center;" id="selectedRfrr"> -->

<!--                </table> -->
<!--             </div> -->
<!--                <br> -->
<!--             <div> -->
<!--             <table border="1" style="width:364.8px; text-align: center;"> -->
<!--                   <tr> -->
<!--                      <td class="selectFormCheckBox"><input type="checkbox"/></td> -->
<!--                      <td>no</td> -->
<!--                      <td>구분</td> -->
<!--                      <td>부서</td> -->
<!--                      <td>직책</td> -->
<!--                      <td>이름</td> -->
<!--                   </tr> -->
<!--                   </table> -->
<!--                <table border="1" style="width:364.8px; text-align: center;" id="selectedList"> -->
<!--                   <tr> -->
<!--                      <td><input type='checkbox' class='selectFormCheckBox'/></td> -->
<!--                      <td id="atrztrun" data-atrztrun="1">1</td> -->
<!--                      <td id="atrztype" data-atrztype="결재">결재</td> -->
<%--                      <td>${empDpmt.teamName}</td> --%>
<%--                      <td id="position" data-positionname="${empDpmt.positionName}">${empDpmt.positionName}</td> --%>
<%--                      <td id="empId" data-empid="${empDpmt.empId}">${empDpmt.empName}</td> --%>
<!--                   </tr> -->
<!--                </table> -->
<!--             </div> -->
<!--          </div> -->
<!--          </div> -->
<!--       </div> -->
<!--      <div class="modal-footer"> -->
<!-- 		<button class="btn btn-primary w-24 mr-1 mb-2"  -->
<!-- 			onclick="updateFolderName();">확인</button> -->
<!-- 		<button data-tw-dismiss="modal" -->
<!-- 			class="btn btn-outline-primary w-24 mr-1 mb-2">닫기</button> -->
<!-- 	</div> -->
<!--   </div> -->
<!-- </div> -->

<!-- <div id="refernceModal" class="modal" data-tw-backdrop="static" tabindex="-1" aria-hidden="true"> -->
<!--    <div class="modal-dialog modal-lg">    -->
<!-- 		<div class="modal-content">   -->
<!--     <div class="modal-header"> -->
<!-- 				<h2 class="font-medium text-xl mr-auto">참조문서</h2>   -->
<!-- 			</div> -->
<!--     <hr> -->
<!--     <div style="height:350px; display:block; overflow: auto;"> -->
<!--    <table border="1" > -->
<!--    <thead> -->
<!--        <tr> -->
<!--            <th> -->
<!--                <input type="checkbox"> -->
<!--            </th> -->
<!--            <th >문서정보</th> -->
<!--            <th >제목</th> -->
<!--            <th >작성일자</th> -->
<!--        </tr> -->
<!--    </thead> -->
<!--    <tbody id="rfrrDocSelectList"> -->
<%--       <c:if test="${not empty rfrrDocList }"> --%>
<%--           <c:forEach items="${rfrrDocList }" var="rfrrDoc"> --%>
<!--               <tr> -->
<%--                  <td><input type="checkbox" id="selectRfrrInfo" type="hidden" name="rfrrDocId" value="${rfrrDoc.aprvDocId}"/> </td> --%>
<%--                   <td>${rfrrDoc.aprvDocId}<br>${rfrrDoc.atrzFormName}</td> --%>
<!--                   <td class="formSelect"> -->
<%--                       ${rfrrDoc.aprvDocTitle} --%>
<!--                   </td> -->
<%--                   <td>${rfrrDoc.aprvDocDate}</td> --%>
<!--               </tr> -->
<%--           </c:forEach> --%>
<%--       </c:if> --%>
<%--       <c:if test="${empty rfrrDocList }"> --%>
<!--           <tr> -->
<!--               <td colspan="7">결재양식없음</td> -->
<!--           </tr> -->
<%--       </c:if> --%>
<!--         </tbody> -->
<!-- </table> -->
<!-- </div> -->
<!-- <div class="modal-footer"> -->
<!-- 		<button class="btn btn-primary w-24 mr-1 mb-2"  -->
<!-- 			onclick="updateFolderName();">확인</button> -->
<!-- 		<button data-tw-dismiss="modal" -->
<!-- 			class="btn btn-outline-primary w-24 mr-1 mb-2">닫기</button> -->
<!-- 	</div> -->
<!-- </div> -->
<!-- </div> -->
<!-- </div> -->



		
		
<script src="${cPath }/resources/js/approval/approvalList.js"></script>

<script>

var header = '${_csrf.headerName}';
var token = '${_csrf.token}'


 
var aprvModal;
var refernceModal;

CKEDITOR.replace('aprvContent');

	
	
$(function (){
	
	

	
	
	aprvModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#aprvModal"));
	refernceModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#refernceModal"));

	
	   let rfrrLine = document.querySelector('#rfrrLine');
	   
	
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
	        console.log(selectListEmp);
	        if(selectListEmp!=null){
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
		            rfrrLine.innerHTML += `<input type='hidden' name='receiver' value=\${putEmpId} >`
		            rfrrLine.innerHTML += rfrrLine.value
		            
		          } else {
		             rcv.innerHTML = '';
		          }
		          
		        }
	        }
	        var selectedRcv = document.querySelector("#selectedRcv");
	        var selectedRcvList = document.querySelectorAll('#selectedRcv td[id="empId"]');
	        console.log("받는사람",selectedRcvList);
	        
	        if(selectedRcvList.length != 0){
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
	//          let atrzEmpId = $("#selectedList td[id='empId']");
	               
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
	   event.preventDefault();
	    let approval = {
	       aprvDocTitle: $("[name=aprvDocTitle]").val(),
	       aprvContent : CKEDITOR.instances.aprvContent.getData(),
	        isurgent : $("[name=isurgent]:checked").val(),
	        atrzFormId : $("[name=atrzFormId]").val(),
	        receiver : $("[name=receiver]").val(),
	        aprvDocReference : $("[name=rfrrDocId]").val()
	        
	    };
	    let aprvLines = [];
	    let positions = document.querySelectorAll(".atrzline.position");
	    console.log("positions",positions);
	    for(let i=0; i<position.length; i++){
	        let position = positions[i];
	        let aprvLine = {};
	        console.log("포지션 칠드런 ",position.children)
	       if(position.children.length != 0){
	           aprvLine.aprvTurn = position.children[0].value;
	           aprvLine.empId = position.children[1].value;
	           aprvLines.push(aprvLine);
	       }
	    }
	    
	       console.log(rfrrLine.children.length)
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
	      url: "${cPath}/approval/draftInsert.do",
	      type: "post",
	      data: JSON.stringify(approval),
	      contentType: "application/json;charset=utf-8",
	        dataType:"json",
	      beforeSend: function(xhr){
	         xhr.setRequestHeader(header, token);
	      },
	      success : function(data){
	         
	         alert("결재가 등록되었습니다.")
	         window.close()
	         
	         let draftEmp = $("[name=empId]").val();
	//       let recieveEmp = aprvLines.empId;
	      
	      for ( i = 0; i < aprvLines.length; i++){
	//          var draftEmp = $("[name=empId]").val(),
	//          var recieveEmp = aprvLines.empId;
	         let recieveEmp = aprvLines[i].empId;
	         console.log(recieveEmp)
	            // 알람용 json 데이터 생성.
	            let alarmData = {
	               // 현재 알람을 보내는 사람 ID
	               empId : draftEmp, // 결재 상신자
	               // 알람을 받아야하는 사람 ID
	               apponent : recieveEmp, // 결재 직원 
	               alarmContent : `님 확인하실 결재가 있습니다.`,
	               almType : `APRV`
	            };
	            
	            // 알람을 띄우기 위한 publish
	            client.publish({
	               destination:`/user/${empId}/alarm/newAlarm`, 
	               body:JSON.stringify(alarmData),
	               headers:{
	                  "content-type":"application/json"
	               }
	            });
	      	}
	      }
	   });
	}
});
</script>
