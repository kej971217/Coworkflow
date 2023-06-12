/**
 * 
 */
let listTableBody = $(".listTableBody");
let viewUrl = listTableBody.data("viewUrl");
let pagingArea = $(".pagingArea");
const fn_makeTable = function(pagination){

console.log("pagination 값 >>> ",pagination)
	let retHtml=``;
	
	if(!pagination.dataList){
	    for(let i=0; i<pagination.length; i++){
	        let draft = pagination[i];
	        retHtml += `
	        <tr>
               <td>${draft.atrzFormId }</td>
               <td class="formSelect">
                   <a onclick="draftOpen(${draft.atrzFormId })">${draft.atrzFormName }</a>
               </td>
           </tr>
	        `; 
	    }
    }else{
    	retHtml=+`
		    <tr>
		        <th class="whitespace-nowrap">
		            <input class="form-check-input" type="checkbox">
		        </th>
		        <th class="whitespace-nowrap">문서정보</th>
		        <th class="whitespace-nowrap">제목</th>
		        <th class="whitespace-nowrap">작성자</th>
		        <th class="whitespace-nowrap">작성일자</th>
		    </tr>
	    `;
	    
    	for(let i=0; i<pagination.dataList.length; i++){
	        let approval = pagination.dataList[i];
	        retHtml += `
	        <tr>
	            <td><input class="form-check-input" type="checkbox"></td>
	            <td>${approval.aprvDocId}<br>${approval.atrzFormName}</td>
	            <td class="formSelect">
	                <a onclick=draft(${approval.aprvDocId})>${approval.aprvDocTitle}</a>
	            </td>
	            <td>${approval.empName}</td>
	            <td>${approval.aprvDocDate}</td>
	        </tr>
	        `;
    	}
    }
    
    
    
    console.log("ppp",listTableBody)
    listTableBody.html(retHtml);
}

function draft(aprvDocId){
    window.open(`draftView.do?what=${aprvDocId}`, "결재문서", "width=780, height=760")  

}






/**
 *  기본
 */
let searchForm = $("[name=searchForm]").on("submit", function(event){
	
   event.preventDefault();
   let url = this.action;
   let method = this.method;
   let data = $(this).serialize();
   $.ajax({
      url : url,
      method : method,
      data : data,
      dataType : "json"
   }).done(function(resp, textStatus, jqXHR) {
    console.log(resp)
      listTableBody.empty();
      pagingArea.empty();
      
      fn_makeTable(resp)
      
   });
   return false;
});

let searchUI = $("#searchUI").on("click", "#searchBtn" , function(){
   $(this).parents("#searchUI").find(":input[name]").each(function(idx, input){
      let iptName = input.name;
      let iptValue = $(input).val();
      searchForm.find(`[name=${iptName}]`).val(iptValue);
   });
   searchForm.submit();
});

let fn_paging = function(page, event){
   searchForm.find("[name=page]").val(page);
   searchForm.submit();
   searchForm.find("[name=page]").val("");
   return false;
}

/**
* 양식
*/
function draftFormList(){
	draftFormListFrom.style.display = "block";
	approvalListFrom.style.display = "none";
	
	searchForm.find("[name='listType']").val("draftFormList")
	searchForm.attr("action","draftFormList")
	searchForm.submit();

}

/**
* 임시저장문서
*/
function tempApprovalList(){
	draftFormListFrom.style.display = "none";
	approvalListFrom.style.display = "block";
	searchForm.find("[name='listType']").val("tempAprvList")
	searchForm.attr("action","tempApprovalList")
	searchForm.submit();

}
approvalListJson()

/**
* 상신함
*/
function approvalListJson(){
	draftFormListFrom.style.display = "none";
	approvalListFrom.style.display = "block";
	searchForm.find("[name='listType']").val("aprvList")
	searchForm.attr("action","approvalListJson")
	searchForm.submit();

}
approvalListJson()



/**
* 수신함
*/
function approvalReciveList(){
	draftFormListFrom.style.display = "none";
	approvalListFrom.style.display = "block";
	searchForm.find("[name='listType']").val("receiveAprvList")
	searchForm.attr("action","approvalReciveList")
	searchForm.submit();

}

/**
* 미결함
*/
function unsetApprovalList(){
	draftFormListFrom.style.display = "none";
	approvalListFrom.style.display = "block";
	searchForm.find("[name='listType']").val("unsetAprvList")
	searchForm.attr("action","unsetApprovalList")
	searchForm.submit();

}

/**
* 예결함
*/
function preApprovalList(){
	draftFormListFrom.style.display = "none";
	approvalListFrom.style.display = "block";
	searchForm.find("[name='listType']").val("preAprvList")
	searchForm.attr("action","preApprovalList")
	searchForm.submit();

}

/**
* 대결함
*/
function deputyApprovalList(){
	draftFormListFrom.style.display = "none";
	approvalListFrom.style.display = "block";
	searchForm.find("[name='listType']").val("dptAprvList")
	searchForm.attr("action","deputyApprovalList")
	searchForm.submit();

}

/**
* 참조함
*/
function rfrrApprovalList(){
	draftFormListFrom.style.display = "none";
	approvalListFrom.style.display = "block";
	searchForm.find("[name='listType']").val("rfrrAprvList")
	searchForm.attr("action","rfrrApprovalList")
	searchForm.submit();

}

/**
* 기결함
*/
function atrzApprovalList(){
	draftFormListFrom.style.display = "none";
	approvalListFrom.style.display = "block";
	searchForm.find("[name='listType']").val("atrzAprvList")
	searchForm.attr("action","atrzApprovalList")
	searchForm.submit();

}

/**
* 결재진행중인문서
*/
function runApprovalList(){
	draftFormListFrom.style.display = "none";
	approvalListFrom.style.display = "block";
	searchForm.find("[name='listType']").val("runAprvList")
	searchForm.attr("action","runApprovalList")
	searchForm.submit();

}

/**
* 승인종결된문서
*/
function aprvAtrzEndList(){
	draftFormListFrom.style.display = "none";
	approvalListFrom.style.display = "block";
	searchForm.find("[name='listType']").val("AprvAtrzEndList")
	searchForm.attr("action","retrieveAprvAtrzEndList")
	searchForm.submit();

}

/**
* 반려함
*/
function rejectApprovalList(){
	draftFormListFrom.style.display = "none";
	approvalListFrom.style.display = "block";
	searchForm.find("[name='listType']").val("rejectAprvList")
	searchForm.attr("action","rejectApprovalList")
	searchForm.submit();

}




