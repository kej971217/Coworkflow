<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
        <!-- BEGIN: Content --><!-- 인사정보-내정보조회-내근무현황조회 -->
        <div class="content">
            <div class="grid grid-cols-12 gap-6 mt-8">
                <div class="col-span-12 lg:col-span-3 2xl:col-span-2">
                    <h2 class="intro-y text-lg font-medium mr-auto mt-2">
                    &nbsp;
                    </h2>
                    <%-- 인사정보 좌측 사이드 메뉴 include --%>
					<jsp:include page="/includee/employeeInfoLeftMenu.jsp"></jsp:include>
                </div>
                <div class="col-span-12 lg:col-span-9 2xl:col-span-10">
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
		                <div class="w-full sm:w-auto flex mt-4 sm:mt-0">
		                    <div class="dropdown ml-auto sm:ml-0">    
		                        <button class="dropdown-toggle btn px-2 box" aria-expanded="false" data-tw-toggle="dropdown">
		                            <span class="w-5 h-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="plus"></i> </span>
		                        </button>
		                        <div class="dropdown-menu w-40">
		                            <ul class="dropdown-content">
		                                <li>
		                                    <a href="" class="dropdown-item"> <i icon-name="file-plus" class="w-4 h-4 mr-2"></i> New Category </a>
		                                </li>
		                                <li>
		                                    <a href="" class="dropdown-item"> <i icon-name="users" class="w-4 h-4 mr-2"></i> New Group </a>
		                                </li>
		                            </ul>
		                        </div>
		                    </div>
		                </div>
                    </div>
                    <!-- END: Inbox Filter -->
                    
                    
                    
            <!-- BEGIN: HTML Table Data -->
            <div class="intro-y box p-5 mt-5">
                <div class="flex flex-col sm:flex-row sm:items-end xl:items-start">
                    <form id="myCommuteListTab-html-filter-form" class="xl:flex sm:mr-auto" >
                        <div class="sm:flex items-center sm:mr-4">
                            <label class="w-12 flex-none xl:w-auto xl:flex-initial mr-2">Field</label>
                            <select id="myCommuteListTab-html-filter-field" class="form-select w-full sm:w-32 2xl:w-full mt-2 sm:mt-0 sm:w-auto">
                                <option value="commuteStart">출근 시간</option>
                                <option value="commuteEnd">퇴근 시간</option>
                                <option value="commuteStatusValue">근무 상태</option>
                            </select>
                        </div>
                        <div class="sm:flex items-center sm:mr-4 mt-2 xl:mt-0">
                            <label class="w-12 flex-none xl:w-auto xl:flex-initial mr-2">Type</label>
                            <select id="myCommuteListTab-html-filter-type" class="form-select w-full mt-2 sm:mt-0 sm:w-auto" >
                                <option value="like" selected>like</option>
                                <option value="=">=</option>
                                <option value="<">&lt;</option>
                                <option value="<=">&lt;=</option>
                                <option value=">">></option>
                                <option value=">=">>=</option>
                                <option value="!=">!=</option>
                            </select>
                        </div>
                        <div class="sm:flex items-center sm:mr-4 mt-2 xl:mt-0">
                            <label class="w-12 flex-none xl:w-auto xl:flex-initial mr-2">Value</label>
                            <input id="myCommuteListTab-html-filter-value" type="text" class="form-control sm:w-40 2xl:w-full mt-2 sm:mt-0" placeholder="Search...">
                        </div>
                        <div class="mt-2 xl:mt-0">
                            <button id="myCommuteListTab-html-filter-go" class="btn btn-primary w-full sm:w-16" >Go</button>
                            <button id="myCommuteListTab-html-filter-reset" class="btn btn-secondary w-full sm:w-16 mt-2 sm:mt-0 sm:ml-1" >Reset</button>
                        </div>
                    </form>
                    <div class="flex mt-5 sm:mt-0">
                        <button id="myCommuteListTab-print" class="btn btn-outline-secondary w-1/2 sm:w-auto mr-2"> <i icon-name="printer" class="w-4 h-4 mr-2"></i> Print </button>
                        <div class="dropdown w-1/2 sm:w-auto">
                            <button  class="dropdown-toggle btn btn-outline-secondary w-full sm:w-auto" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> Export <i icon-name="chevron-down" class="w-4 h-4 ml-auto sm:ml-2"></i> </button>
                            <div class="dropdown-menu w-40">
                                <ul class="dropdown-content">
                                    <li>
                                        <a id="myCommuteListTab-export-csv" href="javascript:;" class="dropdown-item"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> Export CSV </a>
                                    </li>
                                    <li>
                                        <a id="myCommuteListTab-export-json" href="javascript:;" class="dropdown-item"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> Export JSON </a>
                                    </li>
                                    <li>
                                        <a id="myCommuteListTab-export-xlsx" href="javascript:;" class="dropdown-item"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> Export XLSX </a>
                                    </li>
                                    <li>
                                        <a id="myCommuteListTab-export-html" href="javascript:;" class="dropdown-item"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> Export HTML </a>
                                    </li> 
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="overflow-x-auto scrollbar-hidden">
                    <div id="myCommuteListTab" class="mt-5 table-report table-report--tabulator"></div>
                </div>
            </div>
            <!-- END: HTML Table Data -->



<script type="text/javascript" src="${cPath }/resources/js/margun.js"></script>
<script>
$(function(){
	
	//Define variables for input elements
	var fieldEl = document.getElementById("myCommuteListTab-html-filter-field");
	var typeEl = document.getElementById("myCommuteListTab-html-filter-type");
	var valueEl = document.getElementById("myCommuteListTab-html-filter-value");

	//Custom filter example
	function customFilter(data){
	    return data.car && data.rating < 3;
	}




	//Trigger setFilter function with correct parameters
	function updateFilter(){
		var filterVal = fieldEl.options[fieldEl.selectedIndex].value;
		var typeVal = typeEl.options[typeEl.selectedIndex].value;
		
		var filter = filterVal == "function" ? customFilter : filterVal;
		
		if(filterVal == "function" ){
		  typeEl.disabled = true;
		  valueEl.disabled = true;
		}else{
		  typeEl.disabled = false;
		  valueEl.disabled = false;
		}
		
		if(filterVal){
		  table.setFilter(filter,typeVal, valueEl.value);
		}
	}

	//Update filters on value change
	document.getElementById("myCommuteListTab-html-filter-field").addEventListener("change", updateFilter);
	document.getElementById("myCommuteListTab-html-filter-type").addEventListener("change", updateFilter);
	document.getElementById("myCommuteListTab-html-filter-value").addEventListener("keyup", updateFilter);



	//Clear filters on "Clear Filters" button click
	document.getElementById("myCommuteListTab-html-filter-reset").addEventListener("click", function(){
		fieldEl.value = "";
		typeEl.value = "like";
		valueEl.value = "";
		
		table.clearFilter();
	});
	
	//Build Tabulator
	var table = new Tabulator("#myCommuteListTab", {
		ajaxURL: "${cPath}/employeeInfo/myInfo/selectMyCommuteList.do",
		// ajaxParams:{key1:"value1", key2:"value2"}, //ajax parameters
		ajaxResponse: function (url, params, response) {
// 			console.log("url : " + url);
// 			console.log(params);
// 			console.log(response);
	        return response;
		},
		ajaxFiltering: true,
		ajaxSorting: true,
		printAsHtml: true,
		printStyled: true,
		pagination: "remote",
		paginationSize: 10,
		paginationSizeSelector: [10, 20, 30, 40],
		layout: "fitColumns",
		responsiveLayout: "collapse",
		placeholder: "No matching records found",
    	columns:[
	        {title:'번호', headerHozAlign:"center", field:"rnum", hozAlign:"center", width: 100},
	        {title:'이름', headerHozAlign:"center", field:"empName", hozAlign:"center", width: 100, visible: false},
	        {title:'직급', headerHozAlign:"center", field:"rankName", hozAlign:"center", width: 100, visible: false},
	        {title:'직책', headerHozAlign:"center", field:"positionName", hozAlign:"center", visible: false},
	        {title:'직무', headerHozAlign:"center", field:"jobName", hozAlign:"center", visible: false},
	        {title:'출근 시간', headerHozAlign:"center", field:"commuteStart", hozAlign:"center"},
	        {title:'퇴근 시간', headerHozAlign:"center", field:"commuteEnd", hozAlign:"center"},
	        {title:'근무 상태', headerHozAlign:"center", field:"commuteStatusValue", hozAlign:"center"},
    	],
	});

	//trigger download of data.csv file
	document.getElementById("myCommuteListTab-export-csv").addEventListener("click", function(){
	    table.download("csv", "data.csv");
	});

	//trigger download of data.json file
	document.getElementById("myCommuteListTab-export-json").addEventListener("click", function(){
	    table.download("json", "data.json");
	});

	//trigger download of data.xlsx file
	document.getElementById("myCommuteListTab-export-xlsx").addEventListener("click", function(){
	    table.download("xlsx", "data.xlsx", {sheetName:"My Data"});
	});

	//trigger download of data.pdf file
	document.getElementById("myCommuteListTab-print").addEventListener("click", function(){
	    table.download("pdf", "data.pdf", {
	    	style:true,
	    	autoTable: function(doc) {
	    	    doc.addFileToVFS('malgun.ttf', margun); // your font in binary format as second parameter
	    	    doc.addFont('malgun.ttf', 'malgun', 'normal'); 
	    	    doc.setFont('malgun');
	    	    return {  
	    	      styles: {
	    	        font: 'malgun',    
	    	        fontStyle: 'normal'
	    	      }
	    	   };
	    	}
	    });
	});

	//trigger download of data.html file
	document.getElementById("myCommuteListTab-export-html").addEventListener("click", function(){
	    table.download("html", "data.html", {style:true});
	});
});
	

</script>