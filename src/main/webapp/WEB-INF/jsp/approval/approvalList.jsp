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
<!--             <div class="hidden xl:block mx-auto text-slate-500"> -->
<%--             	<input type="button" value="<spring:message code="search" />" id="searchBtn" class="btn btn-primary"/> --%>
<!--             </div> -->
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



		
		
<script src="${cPath }/resources/js/approval/approvalList.js"></script>

<script>
	function draftOpen(atrzFormId){
        window.open(`draft.do?what=\${atrzFormId}`, "결재문서", "width=650, height=760")   
    }
</script>
