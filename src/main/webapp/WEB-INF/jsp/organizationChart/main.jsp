<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
        <!-- BEGIN: Content -->
        <div class="content">
            <div class="grid grid-cols-12 gap-6 mt-8">
                <div class="col-span-12 lg:col-span-3 2xl:col-span-3">
                    <h2 class="intro-y text-lg font-medium mr-auto mt-2">
                    &nbsp;
                    </h2>
                    <!-- BEGIN: Inbox Menu -->
                    <div class="intro-y box bg-primary p-5 mt-6 ">
                    	<div class="flex items-center dark:border-darkmode-400 text-white text-2xl"> <i class="mr-2" icon-name="git-pull-request"></i> <a href="${cPath }/organizationChart/main.do"> <spring:message code="level1Menu.organizationChart"/> </a> </div>  
                        <div class="border-t border-white/10 dark:border-darkmode-400 mt-6 text-white">    
	                        <div id="jsTreeOrgChart" class="mt-3"></div>
                        </div>
                    </div>
                    <!-- END: Inbox Menu --> 
                </div>
                <div class="col-span-12 lg:col-span-9 2xl:col-span-9">    
                    <!-- BEGIN: Inbox Filter -->
                    <div class="intro-y flex flex-col-reverse sm:flex-row items-center">
                        <div class="w-full sm:w-auto relative mr-auto mt-3 sm:mt-0">
                            <i class="w-4 h-4 absolute my-auto inset-y-0 ml-3 left-0 z-10 text-slate-500" icon-name="search"></i> 
                            <input type="text" class="form-control w-full sm:w-64 box px-10" placeholder="Search...">
                            <div class="inbox-filter dropdown absolute inset-y-0 mr-3 right-0 flex items-center" data-tw-placement="bottom-start">
                                <i class="dropdown-toggle w-4 h-4 cursor-pointer text-slate-500" role="button" aria-expanded="false" data-tw-toggle="dropdown" icon-name="chevron-down"></i> 
                                <div class="inbox-filter__dropdown-menu dropdown-menu pt-2">
                                    <div class="dropdown-content">
                                        <div class="grid grid-cols-12 gap-4 gap-y-3 p-3">
                                            <div class="col-span-6">
                                                <label for="input-filter-1" class="form-label text-xs">From</label>
                                                <input id="input-filter-1" type="text" class="form-control flex-1" placeholder="example@gmail.com">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-2" class="form-label text-xs">To</label>
                                                <input id="input-filter-2" type="text" class="form-control flex-1" placeholder="example@gmail.com">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-3" class="form-label text-xs">Subject</label>
                                                <input id="input-filter-3" type="text" class="form-control flex-1" placeholder="Important Meeting">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-4" class="form-label text-xs">Has the Words</label>
                                                <input id="input-filter-4" type="text" class="form-control flex-1" placeholder="Job, Work, Documentation">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-5" class="form-label text-xs">Doesn't Have</label>
                                                <input id="input-filter-5" type="text" class="form-control flex-1" placeholder="Job, Work, Documentation">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-6" class="form-label text-xs">Size</label>
                                                <select id="input-filter-6" class="form-select flex-1">
                                                    <option>10</option>
                                                    <option>25</option>
                                                    <option>35</option>
                                                    <option>50</option>
                                                </select>
                                            </div>
                                            <div class="col-span-12 flex items-center mt-3">
                                                <button class="btn btn-secondary w-32 ml-auto">Create Filter</button>
                                                <button class="btn btn-primary w-32 ml-2">Search</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="w-full sm:w-auto flex">
                            <button class="btn btn-primary shadow-md mr-2"><i icon-name="printer" class="w-4 h-4 mr-2"></i>Print</button>
                            <div class="dropdown">
                                <button class="dropdown-toggle btn px-2 box" aria-expanded="false" data-tw-toggle="dropdown">
                                    <span class="w-5 h-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="plus"></i> </span>
                                </button>
                                <div class="dropdown-menu w-40">
                                    <ul class="dropdown-content">
                                        <li>
                                            <a href="" class="dropdown-item"> <i icon-name="user" class="w-4 h-4 mr-2"></i> Contacts </a>
                                        </li>
                                        <li>
                                            <a href="" class="dropdown-item"> <i icon-name="settings" class="w-4 h-4 mr-2"></i> Settings </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END: Inbox Filter -->
                    <!-- BEGIN: Inbox Content -->
                    <div class="intro-y inbox box mt-5">
                        <div class="p-5 flex flex-col-reverse sm:flex-row border-b border-slate-200/60">
                            <div class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0 font-bold text-lg">
                            	조직도
                            </div>
                        </div>
                        <div class="p-10 flex flex-col sm:flex-row text-center sm:text-left justify-center">         
	                        <div style="width: 70%; min-height: 520px; max-width: 670px; background:url('${cPath }/resources/commonImages/orgChart.png'); background-size:100% auto; background-position:center top; background-repeat: no-repeat;"></div>         
                        </div> 
<!--                         <div class="p-5 flex flex-col sm:flex-row items-center sm:text-left">   -->
<!--                             <div class="overflow-x-auto" style="width: 100%;"> -->
<!-- 							  <table id="fancyTreeOrgChart" class="table fancytree-organization-chart table-hover"> -->
<%-- 							    <colgroup> --%>
<%-- 							    <col width="30px"></col> --%>
<%-- 							    <col width="70px"></col> --%>
<%-- 							    <col width="*"></col> --%>
<%-- 							    <col width="50px"></col> --%>
<%-- 							    <col width="30px"></col> --%>
<%-- 							    </colgroup> --%>
<!-- 							    <thead> -->
<!-- 							      <tr> <th></th> <th>#</th> <th></th> <th>Qty</th> <th>Order</th> </tr> -->
<!-- 							    </thead> -->
<!-- 							    Optionally define a row that serves as template, when new nodes are created: -->
<!-- 							    <tbody> -->
<!-- 							      <tr> -->
<!-- 							        <td></td> -->
<!-- 							        <td></td> -->
<!-- 							        <td></td> -->
<!-- 							        <td class="alignRight"></td> -->
<!-- 							        <td class="alignCenter"> -->
<!-- 							          <input type="checkbox" name="like"> -->
<!-- 							        </td> -->
<!-- 							      </tr> -->
<!-- 							    </tbody> -->
<!-- 							  </table> -->
<!-- 							</div> -->  
                        </div>
                    </div>
                    <!-- END: Inbox Content -->




<%-- 임직원 상세 정보 모달 --%>
<!-- BEGIN: Modal Content -->
<div id="empDetailModal" class="modal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <!-- BEGIN: Modal Header -->
            <div class="modal-header">
                <h2 class="font-medium text-base mr-auto"> 임직원 상세 정보</h2> 
            </div> <!-- END: Modal Header -->
            <!-- BEGIN: Modal Body -->
<!--             <div class="modal-body grid grid-cols-12 gap-4 gap-y-3"> -->
            <div class="modal-body intro-y box px-5 pt-5">    
                <div class="flex flex-col lg:flex-row border-b border-slate-200/60 dark:border-darkmode-400 pb-5 -mx-5">
                    <div class="flex flex-1 px-5 items-center justify-center lg:justify-start">
                        <div id="empDiv0" class="w-20 h-20 sm:w-24 sm:h-24 flex-none lg:w-32 lg:h-32 image-fit relative">
                            <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-5.jpg">
                        </div>
                        <div id="empDiv1" class="ml-5">
                            <div class="font-medium text-xl"> 조욱제 </div>  
                            <div class="text-slate-500" > a100001 </div>  
                        </div>
                    </div>
               </div>
               <div class="flex flex-col lg:flex-row border-b border-slate-200/60 dark:border-darkmode-400 pb-5 -mx-5">
                    <div class="mt-6 lg:mt-0 flex-1 px-5 border-l border-r border-slate-200/60 dark:border-darkmode-400 border-t lg:border-t-0 pt-5 lg:pt-0">
                        <div class="font-medium text-center lg:text-left lg:mt-3">Info</div>
                        <div id="empDiv2" class="flex flex-col justify-center items-center lg:items-start mt-4">
                            <div class="truncate sm:whitespace-normal flex items-center"> 
	                            소　속　|　  
	                            <span> katewinslet@left4code.com </span> 
                            </div>
                            <div class="truncate sm:whitespace-normal flex items-center mt-3"> 
	                            직　급　|　
	                            <span> Instagram Kate Winslet </span>
                            </div>
                            <div class="truncate sm:whitespace-normal flex items-center mt-3"> 
	                            직　책　|　
	                            <span> Twitter Kate Winslet </span>
                            </div>
                            <div class="truncate sm:whitespace-normal flex items-center mt-3"> 
	                            직　무　|　
	                            <span> Twitter Kate Winslet </span>
                            </div>
                        </div>
                    </div>
               </div>
               <div class="flex flex-col lg:flex-row border-slate-200/60 dark:border-darkmode-400 pb-5 -mx-5">  
                    <div class="mt-6 lg:mt-0 flex-1 px-5 border-l border-r border-slate-200/60 dark:border-darkmode-400 border-t lg:border-t-0 pt-5 lg:pt-0">
                        <div class="font-medium text-center lg:text-left lg:mt-3">Contact</div>
                        <div id="empDiv3" class="flex flex-col justify-center items-center lg:items-start mt-4">
                            <div class="truncate sm:whitespace-normal flex items-center"> 
	                            내　선　|　
	                            <span> Twitter Kate Winslet </span>  
                            </div>
                            <div class="truncate sm:whitespace-normal flex items-center mt-3"> 
	                            모바일　|　
	                            <span> Instagram Kate Winslet </span>
                            </div>
                            <div class="truncate sm:whitespace-normal flex items-center mt-3"> 
	                            이메일　|　
	                            <span> katewinslet@left4code.com </span>
                            </div>
                        </div>
                    </div>
               </div>
            </div>
            <div class="modal-footer"> 
            	<button data-tw-dismiss="modal" class="btn btn-primary w-20 mr-1"> 닫기 </button> </div> <!-- END: Modal Footer -->
        </div>
<!--     </div> -->
</div> <!-- END: Modal Content -->




<script type="text/javascript">
var empDetailModal;
document.addEventListener('DOMContentLoaded', function(){
	empDetailModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#empDetailModal"));
});



// jsTree ajax demo
$("#jsTreeOrgChart").jstree({
	"core" : {
		"animation" : 0,
		"multiple" : false,
		"data" : {
			"url" : "${cPath}/organizationChart/jstree",
			"dataType" : "json" // needed only if you do not supply JSON headers
		},
		"themes" : {
			"variant" : "large"
		},
		"checkbox" : {
			"keep_selected_style" : false
		},
	},
//		'types' : {
//			"default" : {
//				 "icon" : "fa-solid fa-network-wired",
//			},
//			"team" : {
//				 "icon" : "fa-solid fa-network-wired",
//			},
//			"employee" : {
//				 "icon" : "fa-solid fa-network-wired",
//			}
//		},
	"sort" : function(a, b){
		a1 = this.get_node(a);
		b1 = this.get_node(b);
		if(a1.icon == b1.icon){
			return (a1.text < b1.text) ? 1 : -1;
		}else{
			return (a1.icon < b1.icon) ? 1 : -1;
		}
	},
	'plugins' : [
		"types", "themes", "html_data", "ui", "crrm", "sort", "grid", "wholerow"
// 		, "checkbox"
	]
}).on("changed.jstree", function(e, data) { //노드에 변화가 있을 때 (똑같은 노드 다시 클릭해도 변화는 없기 때문에 두 번째 모달은 뜨지 않음)

}).on("activate_node.jstree Event", function(e, data){ //노드 클릭했을 때 (클릭했다가 모달 닫았다가 똑같은 노드 다시 클릭했을 때 또 모달 띄우려면 사용해야 함)
	if(data == undefined || data.node == undefined || data.node.id == undefined) return;
// 	console.log("e");
// 	console.log(e);
// 	console.log("data");    
// 	console.log(data);
	if(data.node.icon == "fa-solid fa-user"){
		$.ajax({
			url : "${cPath}/organizationChart/empDetail.do",
			method : "get",
			data : {"empId" : data.node.id},
			dataType : "json"
		}).done(function(resp, textStatus, jqXHR) {
// 			console.log(resp);
			$("#empDiv0 img").attr('src', '${cPath}/mypage/' + resp.mypage.profileImage.empAtchSaveName); // 오브젝트는 문자열이 아니므로 따옴표 쓰면 안됨    
			
			$("#empDiv1 div").eq(0).html(resp.empName);
			$("#empDiv1 div").eq(1).html(resp.empId);
			
			$("#empDiv2 div span").eq(0).html(resp.teamName);
			$("#empDiv2 div span").eq(1).html(resp.rankName);
			$("#empDiv2 div span").eq(2).html(resp.positionName);
			$("#empDiv2 div span").eq(3).html(resp.jobName);
			
			$("#empDiv3 div span").eq(0).html(resp.comTel);
			$("#empDiv3 div span").eq(1).html(resp.infoHp);
			$("#empDiv3 div span").eq(2).html(resp.infoEmail);
			
			empDetailModal.show();
		}).fail(function(jqXHR, status, error) {
			console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
		});
	}
	if(data.node.icon == "fa-solid fa-hotel"){ // 본부 클릭 시
		
	}
	if(data.node.icon == "fa-solid fa-sitemap"){ // CEO실 클릭 시
		
	}
}).on("loaded.jstree",function(e, data){
// 	$("#jsTreeOrgChart").jstree("open_all");
// 	$("#jsTreeOrgChart").jstree("opne_node", "#");
// 	$("#jsTreeOrgChart").jstree("toggle_node", "#");
});



// function selectEmpDetail(){
// 	$.ajax({
// 		url : "empDetail.do",
// 		method : "",
// 		data : {},
// 		dataType : ""
// 	}).done(function(resp, textStatus, jqXHR) {

// 	}).fail(function(jqXHR, status, error) {
// 		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
// 	});
// }




/*
$(function(){
  // Attach the fancytree widget to an existing <div id="tree"> element
  // and pass the tree options as an argument to the fancytree() function:
  $("#fancyTreeOrgChart").fancytree({
    extensions: ["table"],
    checkbox: true,
    table: {
      indentation: 20,      // indent 20px per node level
      nodeColumnIdx: 2,     // render the node title into the 3rd column
      checkboxColumnIdx: 0  // render the checkboxes into the 1st column
    },
    source: {
      url: "https://cdn.jsdelivr.net/gh/mar10/fancytree@72e03685/demo/ajax-tree-products.json"
    },
    tooltip: function(event, data){
      return data.node.data.author;
    },
    lazyLoad: function(event, data) {
      data.result = {url: "https://cdn.jsdelivr.net/gh/mar10/fancytree@72e03685/demo/ajax-sub2.json"}
    },
    renderColumns: function(event, data) {
      var node = data.node,
        $tdList = $(node.tr).find(">td");

      // (index #0 is rendered by fancytree by adding the checkbox)
      $tdList.eq(1).text(node.getIndexHier());
      // (index #2 is rendered by fancytree)
      $tdList.eq(3).text(node.data.qty);
      // Rendered by row template:
      // $tdList.eq(4).html("<input type='checkbox' name='like' value='" + node.key + "'>");
    }
  });
	// Handle custom checkbox clicks
  $("#fancyTreeOrgChart").on("click", "input[name=like]", function(e){
    var node = $.ui.fancytree.getNode(e),
      $input = $(e.target);

    e.stopPropagation();  // prevent fancytree activate for this row
    if($input.is(":checked")){
      alert("like " + node);
    }else{
      alert("dislike " + node);
    }
  });
});
*/





</script>