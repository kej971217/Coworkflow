<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
        <!-- BEGIN: Content --><!-- 인사정보-내정보조회-내급여내역서조회 -->
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
                    <form id="mySalaryStatementTab-html-filter-form" class="xl:flex sm:mr-auto" >
                        <div class="sm:flex items-center sm:mr-4">
                            <label class="w-12 flex-none xl:w-auto xl:flex-initial mr-2">Field</label>
                            <select id="mySalaryStatementTab-html-filter-field" class="form-select w-full sm:w-32 2xl:w-full mt-2 sm:mt-0 sm:w-auto">
                                <option value="payrollRecordDate">지급일</option>
                            </select>
                        </div>
                        <div class="sm:flex items-center sm:mr-4 mt-2 xl:mt-0">
                            <label class="w-12 flex-none xl:w-auto xl:flex-initial mr-2">Type</label>
                            <select id="mySalaryStatementTab-html-filter-type" class="form-select w-full mt-2 sm:mt-0 sm:w-auto" >
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
                            <input id="mySalaryStatementTab-html-filter-value" type="text" class="form-control sm:w-40 2xl:w-full mt-2 sm:mt-0" placeholder="Search...">
                        </div>
                        <div class="mt-2 xl:mt-0">
                            <button id="mySalaryStatementTab-html-filter-go" class="btn btn-primary w-full sm:w-16" >Go</button>
                            <button id="mySalaryStatementTab-html-filter-reset" class="btn btn-secondary w-full sm:w-16 mt-2 sm:mt-0 sm:ml-1" >Reset</button>
                        </div>
                    </form>
                    <div class="flex mt-5 sm:mt-0">
                        <button id="mySalaryStatementTab-print" class="btn btn-outline-secondary w-1/2 sm:w-auto mr-2"> <i icon-name="printer" class="w-4 h-4 mr-2"></i> Print </button>
                        <div class="dropdown w-1/2 sm:w-auto">
                            <button  class="dropdown-toggle btn btn-outline-secondary w-full sm:w-auto" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> Export <i icon-name="chevron-down" class="w-4 h-4 ml-auto sm:ml-2"></i> </button>
                            <div class="dropdown-menu w-40">
                                <ul class="dropdown-content">
                                    <li>
                                        <a id="mySalaryStatementTab-export-csv" href="javascript:;" class="dropdown-item"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> Export CSV </a>
                                    </li>
                                    <li>
                                        <a id="mySalaryStatementTab-export-json" href="javascript:;" class="dropdown-item"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> Export JSON </a>
                                    </li>
                                    <li>
                                        <a id="mySalaryStatementTab-export-xlsx" href="javascript:;" class="dropdown-item"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> Export XLSX </a>
                                    </li>
                                    <li>
                                        <a id="mySalaryStatementTab-export-html" href="javascript:;" class="dropdown-item"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> Export HTML </a>
                                    </li> 
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="overflow-x-auto scrollbar-hidden">
                    <div id="mySalaryStatementTab" class="mt-5 table-report table-report--tabulator"></div>
                </div>
            </div>
            <!-- END: HTML Table Data -->





 
<!-- BEGIN: Modal Toggle -->
<!-- <div class="text-center">  -->
<!-- 	<a href="javascript:;" data-tw-toggle="modal" data-tw-target="#mySalaryModal" class="btn btn-primary">Show Modal</a>  -->
<!-- </div>  -->
<!-- END: Modal Toggle -->


<!-- BEGIN: Modal Content -->
<div id="mySalaryModal" class="modal" data-tw-backdrop="static" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
             <!-- BEGIN: Modal Header -->
             <div class="modal-header">
             	<h2 class="font-medium text-base text-lg mr-auto">급여 상세 내역</h2>
             </div> <!-- END: Modal Header -->
             <!-- BEGIN: Modal Body -->
             <div class="modal-body px-5 py-10">
                <div class="text-center">
					<div class="overflow-x-auto">
                    	<!-- 테이블 시작 -->
					    <table class="table table-bordered">
					        <thead class="table-light">
					            <tr>
					                <th class="whitespace-nowrap text-center" colspan="6" style="letter-spacing: 1.5em;">세부내역</th>
					            </tr>
					        </thead>
					        <tbody>
					            <tr>
					                <td rowspan="3" bgcolor="#eef1f6">기본정보</td>  
					                <td>번호</td>
					                <td id="rnum" colspan="4"></td>
					            </tr>  
					            <tr>
					                <td>지급일</td>
					                <td id="payrollRecordDate" colspan="4"></td>
					            </tr>
					            <tr>
					                <td>호봉</td>
					                <td id="seniorityBasedWage" colspan="4"></td>  
					            </tr>
					            <tr>
					                <td rowspan="7" bgcolor="#eef1f6">지급내역</td>
					                <td>기본급</td>
					                <td id="baseSalary"></td>
					                <td rowspan="7" bgcolor="#eef1f6">공제내역</td>
					                <td>소득세</td>
					                <td id="incomeTax"></td>
					            </tr>
					            <tr>
					                <td>직책수당</td>
					                <td id="positionAllowance"></td>
					                <td>주민세</td>
					                <td id="residenceTax"></td>
					            </tr>
					            <tr>
					                <td>시간외근무수당</td>
					                <td id="overtimePay"></td>
					                <td>국민연금</td>
					                <td id="nationalPension"></td>
					            </tr>
					            <tr>
					                <td>상여금</td>
					                <td id="bonus"></td>
					                <td>장기요양</td>
					                <td id="longTermCareInsurance"></td>
					            </tr>
					            <tr>
					                <td>식대</td>
					                <td id="meals"></td>
					                <td>건강보험</td>
					                <td id="healthInsurance"></td>
					            </tr>
					            <tr>
					                <td>교통비</td>
					                <td id="transAllowance"></td>
					                <td>공제액 합계</td>  
					                <td id="totalDeduction"></td>
					            </tr>
					            <tr>
					                <td>지급액 합계</td>
					                <td id="totalPayment"></td>
					                <td colspan="2"></td> 
					            </tr>  
					            <tr>
					                <td rowspan="4" bgcolor="#eef1f6">실수령액</td>  
					                <td id="netSalary" colspan="5"></td>
					            </tr>
					        </tbody>  
					    </table>
					    <!-- 테이블 끝 -->
					</div>
                </div>
             </div> <!-- END: Modal Body -->
             <!-- BEGIN: Modal Footer -->
             <div class="modal-footer"> 
             	<button data-tw-dismiss="modal" class="btn btn-primary w-20">닫기</button> 
             </div> <!-- END: Modal Footer -->
        </div>
    </div>
</div> <!-- END: Modal Content -->

<script type="text/javascript" src="${cPath }/resources/js/margun.js"></script>
<script>
var mySalaryModal;

$(function(){
	mySalaryModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#mySalaryModal"));
	
	
	//Define variables for input elements
	var fieldEl = document.getElementById("mySalaryStatementTab-html-filter-field");
	var typeEl = document.getElementById("mySalaryStatementTab-html-filter-type");
	var valueEl = document.getElementById("mySalaryStatementTab-html-filter-value");

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
	document.getElementById("mySalaryStatementTab-html-filter-field").addEventListener("change", updateFilter);
	document.getElementById("mySalaryStatementTab-html-filter-type").addEventListener("change", updateFilter);
	document.getElementById("mySalaryStatementTab-html-filter-value").addEventListener("keyup", updateFilter);



	//Clear filters on "Clear Filters" button click
	document.getElementById("mySalaryStatementTab-html-filter-reset").addEventListener("click", function(){
		fieldEl.value = "";
		typeEl.value = "like";
		valueEl.value = "";
		
		table.clearFilter();
	});
	
	//Build Tabulator
	var table = new Tabulator("#mySalaryStatementTab", {
		ajaxURL: "${cPath}/employeeInfo/myInfo/selectMyPayrollRecordsList.do",
		// ajaxParams:{key1:"value1", key2:"value2"}, //ajax parameters
		ajaxResponse: function(url, params, response) {
// 			console.log(url);
 			console.log(params);
 			console.log(response);   
	        return response;
		},
		ajaxFiltering: true,
		ajaxSorting: true,
		printAsHtml: true,
		printStyled: true,
		rowClickPopup:"Im a Popup", 
		pagination: "remote",
		paginationSize: 10,
		paginationSizeSelector: [10, 20, 30, 40],
		layout: "fitColumns",
// 		columnDefaults: {
// 			resizable:true,
// 		},
		responsiveLayout: "collapse",
// 		responsiveLayoutCollapseStartOpen: false,
		placeholder: "No matching records found",

    	columns:[  //, print: false, download: false
    		{formatter:"responsiveCollapse", width: 40, minWidth: 30, hozAlign:"center", resizable: false, headerSort: false},  
	        {title:'번호', headerHozAlign:"center", field:"rnum", hozAlign:"center" },    
	        {title:'지급일', headerHozAlign:"center", field:"payrollRecordDate", hozAlign:"center",
	        	formatter:"datetime",
	        	formatterParams: {
	        	    inputFormat:"yyyy-MM-dd HH:mm:ss",
	        	    outputFormat:"yyyy-MM-dd",
	        	    invalidPlaceholder:"(invalid date)",
	        	    timezone:"Asia/Seoul",
	        	}
	        },
	        {title:'호봉', headerHozAlign:"center", field:"seniorityBasedWage", hozAlign:"center", visible: false},
	        {title:'기본급', headerHozAlign:"center", field:"baseSalary", hozAlign:"center", 
	        	formatter: "money", 
	        	formatterParams: {
	        		decimal:".",
	        	    thousand:",",
	        	    symbol:" 원",
	        	    symbolAfter:"p",
	        	    negativeSign:true,
	        	    precision:false,
	        	}
	        },
	        {title:'직책수당', headerHozAlign:"center", field:"positionAllowance", hozAlign:"center", visible: false, print: true, download: true,},
	        {title:'시간외근무수당', headerHozAlign:"center", field:"overtimePay", hozAlign:"center", visible: false, print: true, download: true,},
	        {title:'상여금', headerHozAlign:"center", field:"bonus", hozAlign:"center", visible: false},
	        {title:'식대', headerHozAlign:"center", field:"meals", hozAlign:"center", visible: false},  
	        {title:'교통비', headerHozAlign:"center", field:"transAllowance", hozAlign:"center", visible: false},
	        {title:'지급 합계', headerHozAlign:"center", field:"totalPayment", hozAlign:"center", visible: false},
	        {title:'소득세', headerHozAlign:"center", field:"incomeTax", hozAlign:"center", visible: false},
	        {title:'주민세', headerHozAlign:"center", field:"residenceTax", hozAlign:"center", visible: false},
	        {title:'국민연금', headerHozAlign:"center", field:"nationalPension", hozAlign:"center", visible: false},
	        {title:'장기요양', headerHozAlign:"center", field:"longTermCareInsurance", hozAlign:"center", visible: false},
	        {title:'건강보험', headerHozAlign:"center", field:"healthInsurance", hozAlign:"center", visible: false},
	        {title:'공제 합계', headerHozAlign:"center", field:"totalDeduction", hozAlign:"center", visible: false},
	        {title:'실수령액', headerHozAlign:"center", field:"netSalary", hozAlign:"center",  
	        	formatter: "money", 
	        	formatterParams: {
	        		decimal:".",
	        	    thousand:",",
	        	    symbol:" 원",
	        	    symbolAfter:"p",
	        	    negativeSign:true,
	        	    precision:false,
	        	}
	        },	
    	],
	}).on("rowClick", function(e, row){
// 	    console.log(e);
// 		console.log(row);
// 		console.log(row._row.data.empId);
// 		console.log(row._row.data.netSalary.toLocaleString("ko-KR"));
// 		console.log("체킁!!");
		$("#rnum").html(row._row.data.rnum);
		$("#payrollRecordDate").html(row._row.data.payrollRecordDate.split(' ', 1));
		$("#seniorityBasedWage").html(row._row.data.seniorityBasedWage);
		$("#baseSalary").html(row._row.data.baseSalary.toLocaleString("ko-KR") + " 원");
		$("#positionAllowance").html(row._row.data.positionAllowance.toLocaleString("ko-KR") + " 원");
		$("#overtimePay").html(row._row.data.overtimePay.toLocaleString("ko-KR") + " 원");
		$("#bonus").html(row._row.data.bonus.toLocaleString("ko-KR") + " 원");
		$("#meals").html(row._row.data.meals.toLocaleString("ko-KR") + " 원");
		$("#transAllowance").html(row._row.data.transAllowance.toLocaleString("ko-KR") + " 원");
		$("#totalPayment").html(row._row.data.totalPayment.toLocaleString("ko-KR") + " 원");
		$("#incomeTax").html(row._row.data.incomeTax.toLocaleString("ko-KR") + " 원");
		$("#residenceTax").html(row._row.data.residenceTax.toLocaleString("ko-KR") + " 원");
		$("#nationalPension").html(row._row.data.nationalPension.toLocaleString("ko-KR") + " 원");
		$("#longTermCareInsurance").html(row._row.data.longTermCareInsurance.toLocaleString("ko-KR") + " 원");
		$("#healthInsurance").html(row._row.data.healthInsurance.toLocaleString("ko-KR") + " 원");
		$("#totalDeduction").html(row._row.data.totalDeduction.toLocaleString("ko-KR") + " 원");
		$("#netSalary").html(row._row.data.netSalary.toLocaleString("ko-KR") + " 원");
		mySalaryModal.show();
	});       

	
	
	//trigger download of data.csv file
	document.getElementById("mySalaryStatementTab-export-csv").addEventListener("click", function(){
	    table.download("csv", "data.csv");
	});

	//trigger download of data.json file
	document.getElementById("mySalaryStatementTab-export-json").addEventListener("click", function(){
	    table.download("json", "data.json");
	});

	//trigger download of data.xlsx file
	document.getElementById("mySalaryStatementTab-export-xlsx").addEventListener("click", function(){
	    table.download("xlsx", "data.xlsx", {sheetName:"My Data"});
	});

	//trigger download of data.pdf file
	document.getElementById("mySalaryStatementTab-print").addEventListener("click", function(){
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
	document.getElementById("mySalaryStatementTab-export-html").addEventListener("click", function(){
	    table.download("html", "data.html", {style:true});

	});
});
	

</script>