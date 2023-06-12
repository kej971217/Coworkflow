<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<style>
.swal2-container {
	z-index: 10000;
}
</style>
<!-- BEGIN: Content -->
<div class="content">
	<div class="grid grid-cols-12 gap-6 mt-8">
		<div class="col-span-12 lg:col-span-3 2xl:col-span-2">
			<h2 class="intro-y text-lg font-medium mr-auto mt-2">&nbsp;</h2>
			<%-- 드라이브 좌측 사이드 메뉴 include --%>
			<jsp:include page="/includee/driveLeftMenu.jsp"></jsp:include>
		</div>
		<div class="col-span-12 lg:col-span-9 2xl:col-span-10">



			<!-- BEGIN: File Manager Filter -->
			<div class="intro-y flex flex-col-reverse sm:flex-row items-center">
				<div class="w-full sm:w-auto relative mr-auto mt-3 sm:mt-0">
					<i
						class="w-4 h-4 absolute my-auto inset-y-0 ml-3 left-0 z-10 text-slate-500"
						icon-name="search"></i> <input type="text"
						class="form-control w-full sm:w-64 box px-10"
						placeholder="Search files">
					<div
						class="inbox-filter dropdown absolute inset-y-0 mr-3 right-0 flex items-center"
						data-tw-placement="bottom-start">
						<i class="dropdown-toggle w-4 h-4 cursor-pointer text-slate-500"
							role="button" aria-expanded="false" data-tw-toggle="dropdown"
							icon-name="chevron-down"></i>
						<div class="inbox-filter__dropdown-menu dropdown-menu pt-2">
							<div class="dropdown-content">
								<div class="grid grid-cols-12 gap-4 gap-y-3 p-3">
									<div class="col-span-6">
										<label for="input-filter-1" class="form-label text-xs">File
											Name</label> <input id="input-filter-1" type="text"
											class="form-control flex-1" placeholder="Type the file name">
									</div>
									<div class="col-span-6">
										<label for="input-filter-2" class="form-label text-xs">Shared
											With</label> <input id="input-filter-2" type="text"
											class="form-control flex-1" placeholder="example@gmail.com">
									</div>
									<div class="col-span-6">
										<label for="input-filter-3" class="form-label text-xs">Created
											At</label> <input id="input-filter-3" type="text"
											class="form-control flex-1" placeholder="Important Meeting">
									</div>
									<div class="col-span-6">
										<label for="input-filter-4" class="form-label text-xs">Size</label>
										<select id="input-filter-4" class="form-select flex-1">
											<option>10</option>
											<option>25</option>
											<option>35</option>
											<option>50</option>
										</select>
									</div>
									<div class="col-span-12 flex items-center mt-3">
										<button class="btn btn-secondary w-32 ml-auto">Create
											Filter</button>
										<button class="btn btn-primary w-32 ml-2">Search</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="w-full sm:w-auto flex">
					<!--                         	<button class="btn btn-primary mr-1 mb-2"> 저장중 <i data-loading-icon="oval" data-color="white" class="w-4 h-4 ml-2"></i> </button> -->
					<!-- 							<button class="btn btn-success mr-1 mb-2"> 추가중 <i data-loading-icon="spinning-circles" data-color="white" class="w-4 h-4 ml-2"></i> </button> -->
					<!-- 							<button class="btn btn-warning mr-1 mb-2"> 로딩중 <i data-loading-icon="three-dots" data-color="1a202c" class="w-4 h-4 ml-2"></i> </button> -->
					<!-- 							<button class="btn btn-danger mr-1 mb-2"> 삭제중 <i data-loading-icon="puff" data-color="white" class="w-4 h-4 ml-2"></i> </button> -->
					<button data-tw-toggle="modal" data-tw-target="#fileUploadModal"
						class="btn btn-primary shadow-md mr-1 mb-2">
						<i class="w-4 h-4 mr-1" icon-name="file-plus"></i> 새 파일
					</button>
					<button data-tw-toggle="modal" data-tw-target="#newFolderModal"
						class="btn btn-primary shadow-md mr-1 mb-2">
						<i class="w-4 h-4 mr-1" icon-name="folder-plus"></i> 새 폴더
					</button>
					<div class="dropdown">
						<button class="dropdown-toggle btn px-2 box" aria-expanded="false"
							data-tw-toggle="dropdown">
							<span class="w-5 h-5 flex items-center justify-center"> <i
								class="w-4 h-4" icon-name="plus"></i>
							</span>
						</button>
						<div class="dropdown-menu w-40">
							<ul class="dropdown-content">
								<li><a href="javascript:;" class="dropdown-item" onclick="checkAll();"> <i
										class="fa-solid fa-square-check w-4 h-4 mr-2"></i> 전체 선택
								</a></li>
								<li><a href="javascript:;" class="dropdown-item" onclick="checkAllCancel();"> <i
										class="fa-solid fa-square-minus w-4 h-4 mr-2"></i> 선택 해제
								</a></li>
								<li><a href="javascript:;"
									onclick="event.preventDefault(); deleteSelectedItems();"
									class="dropdown-item"> <i
										class="fa-solid fa-trash w-4 h-4 mr-2"></i> 선택 삭제
								</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- END: File Manager Filter -->



			<!-- BEGIN: Directory & Files -->
			<div id="driveListDiv"
				class="intro-y grid grid-cols-12 gap-3 sm:gap-6 mt-5">
				<div class="text-slate-500 p-3 text-center">Loading...</div>
			</div>
			<!-- END: Directory & Files -->



		</div>
	</div>
</div>
<!-- END: Content -->




<%-- Large 모달 시작 --%>
<div id="fileUploadModal" class="modal" data-tw-backdrop="static" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<%-- 모달 헤더 시작 --%>
			<div class="modal-header">
				<h2 class="font-medium text-xl mr-auto">새 파일</h2>
			</div>
			<%-- 모달 헤더 끝 --%>
			<%-- 모달 바디 시작 --%>
			<div class="modal-body p-10 text-center">
				<%-- 파일 여러개 업로드 박스 시작 --%>
				<form id="fileUploadBoxForm" action="${cPath }/drive/upload.do"
					method="post" class="dropzone2" enctype="multipart/form-data">
					<!-- class"dropzone" && action=".." 있으면 자동으로 dropzone 됨 -->
					<security:csrfInput />
					<input type="hidden" id="driveId" name="driveId" value="1" />
					<%-- 아래 input name은 컨트롤러로 보내주는 MultipartFile 이름 --%>
					<div class="fallback">
						<input name="file" type="file" />
					</div>
					<div class="dz-message" data-dz-message>
						<div class="text-lg font-medium">파일을 이곳에 드래그 앤 드롭하거나 클릭하여 업로드하세요.</div>
						<div class="text-slate-500">
						한 개의 파일 용량은 10 MB 까지 업로드 할 수 있습니다.  
						</div>
					</div>
				</form>
				<%-- 파일 여러개 업로드 박스 끝 --%>
			</div>
			<%-- 모달 바디 끝 --%>
			<%-- 모달 풋터 시작 --%>
			<div class="modal-footer">
				<button data-tw-dismiss="modal"
					onclick="myDropzone.removeAllFiles(true); openFolder( $('#fileUploadBoxForm #driveId').val() );"
					class="btn btn-outline-primary w-24 mr-1 mb-2">닫기</button>
				<!-- 				<br> -->
				<!-- 				<button class="btn btn-primary mr-1 mb-2"> 저장중 <i data-loading-icon="oval" data-color="white" class="w-4 h-4 ml-2"></i> </button> -->
				<!-- 				<button class="btn btn-success mr-1 mb-2"> 추가중 <i data-loading-icon="spinning-circles" data-color="white" class="w-4 h-4 ml-2"></i> </button> -->
				<!-- 				<button class="btn btn-warning mr-1 mb-2"> 로딩중 <i data-loading-icon="three-dots" data-color="1a202c" class="w-4 h-4 ml-2"></i> </button> -->
				<!-- 				<button class="btn btn-danger mr-1 mb-2"> 삭제중 <i data-loading-icon="puff" data-color="white" class="w-4 h-4 ml-2"></i> </button> -->
			</div>
			<%-- 모달 풋터 시작 --%>
		</div>
	</div>
</div>
<%-- Large 모달 끝 --%>





<%-- Large 모달 시작 --%>
<div id="newFolderModal" class="modal" data-tw-backdrop="static" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<%-- 모달 헤더 시작 --%>
			<div class="modal-header">
				<h2 class="font-medium text-xl mr-auto">새 폴더</h2>
			</div>
			<%-- 모달 헤더 끝 --%>
			<%-- 모달 바디 시작 --%>
			<div class="modal-body p-10">
				<form id="newFolderForm">
					<security:csrfInput />
					<input type="hidden" id="driveId2" name="driveId2" value="1" />
					<input type="text" id="driveRoot" name="driveRoot" class="form-control" placeholder="새 폴더명을 입력하세요." autocomplete="off">
				</form>
			</div>
			<%-- 모달 바디 끝 --%>
			<%-- 모달 풋터 시작 --%>
			<div class="modal-footer">
				<button class="btn btn-primary w-24 mr-1 mb-2"
					onclick="makeFolder();">만들기</button>
				<button data-tw-dismiss="modal"
					class="btn btn-outline-primary w-24 mr-1 mb-2">닫기</button>
			</div>
			<%-- 모달 풋터 시작 --%>
		</div>
	</div>
</div>
<%-- Large 모달 끝 --%>





<%-- Large 모달 시작 --%>
<div id="updateFileNameModal" class="modal" data-tw-backdrop="static" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<%-- 모달 헤더 시작 --%>
			<div class="modal-header">
				<h2 class="font-medium text-xl mr-auto">이름 바꾸기</h2>
			</div>
			<%-- 모달 헤더 끝 --%>
			<%-- 모달 바디 시작 --%>
			<div class="modal-body p-10">
				<form id="updateFileNameForm">
					<security:csrfInput />
					<input type="hidden" id="driveAtchNo" name="driveAtchNo" value="" />
					<input type="text" id="driveAtchOriginName"
						name="driveAtchOriginName" value="" class="form-control"
						placeholder="수정할 파일명을 입력하세요." autocomplete="off">
				</form>
			</div>
			<%-- 모달 바디 끝 --%>
			<%-- 모달 풋터 시작 --%>
			<div class="modal-footer">
				<button class="btn btn-primary w-24 mr-1 mb-2"
					onclick="updateFileName();">확인</button>
				<button data-tw-dismiss="modal"
					class="btn btn-outline-primary w-24 mr-1 mb-2">닫기</button>
			</div>
			<%-- 모달 풋터 시작 --%>
		</div>
	</div>
</div>
<%-- Large 모달 끝 --%>





<%-- Large 모달 시작 --%>
<div id="updateFolderNameModal" class="modal" data-tw-backdrop="static" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg">   
		<div class="modal-content">    
			<%-- 모달 헤더 시작 --%>
			<div class="modal-header">
				<h2 class="font-medium text-xl mr-auto">이름 바꾸기</h2>  
			</div>
			<%-- 모달 헤더 끝 --%>
			<%-- 모달 바디 시작 --%>
			<div class="modal-body p-10">
				<form id="updateFolderNameForm">
					<security:csrfInput />
					<input type="hidden" id="driveId" name="driveId" value="" /> 
					<input type="hidden" id="driveId2" name="driveId2" value="" /> 
					<input type="text" id="driveRoot" name="driveRoot" value="" class="form-control" placeholder="수정할 폴더명을 입력하세요." autocomplete="off">
				</form>
			</div>
			<%-- 모달 바디 끝 --%>
			<%-- 모달 풋터 시작 --%>
			<div class="modal-footer">
				<button class="btn btn-primary w-24 mr-1 mb-2" 
					onclick="updateFolderName();">확인</button>
				<button data-tw-dismiss="modal"
					class="btn btn-outline-primary w-24 mr-1 mb-2">닫기</button>
			</div>
			<%-- 모달 풋터 시작 --%>
		</div>
	</div>
</div>
<%-- Large 모달 끝 --%>



<script>



<%--
//--------------------------------------------------------------------------------
// 버튼 있을 적 파일 업로드 --> Dropzone 사용하는 지금은 필요 없음
//--------------------------------------------------------------------------------
// function uploadFile(){
    
//     var form = $('#fileUploadBoxForm')[0];
//     var formData = new FormData(form);
 
//     $.ajax({
//         url : '${cPath }/drive/upload.do',
//         type : 'POST',
//         enctype: 'multipart/form-data',
//         data : formData,
//         contentType : false,
//         processData : false,
//         beforeSend : function(xhrToController){
// 			xhrToController.setRequestHeader(headerName, headerValue);
// 		}
//     }).done(function(data){
//        	callback(data);
//     });
// }
//--------------------------------------------------------------------------------
// 체크한 요소 선택해서 한번에 삭제하는 함수 (삭제확인 : sweetalert2)
//--------------------------------------------------------------------------------
// async function removeFile(elem){    
// 	var driveAtchNo = $(elem).data("driveAtchNo");
// 	var driveId = $(elem).data("driveId");

// 	const userConfirmation = await Swal.fire({
// 		title: 'Are you sure?',
// 		text: "You won't be able to revert this!",
// 		icon: 'warning',
// 		showCancelButton: true,
// 		confirmButtonColor: '#3085d6',
// 		cancelButtonColor: '#d33',
// 		confirmButtonText: 'Yes, delete it!'
// 	})

// 	if(userConfirmation.isConfirmed){
// 		$.ajax({
// 			url : "${cPath }/drive/removeFile.do",
// 			method : "post",
// 			data : {"driveAtchNo": driveAtchNo},
// 			dataType : "json",
// 			beforeSend : function(xhrToController){
// 				xhrToController.setRequestHeader(headerName, headerValue);
// 			}
// 		}).done(function(resp, textStatus, jqXHR) {
// 			if(resp.result){
// 				openFolder(driveId);
// 				$(elem).parents(".dropdown-menu").remove();
// 			}
// 		}).fail(function(jqXHR, status, error) {
// 			console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
// 		});
// 	}
// }
// async function removeFolder(elem){
// 	const userConfirmation = await Swal.fire({
// 		title: 'Are you sure?',
// 		text: "You won't be able to revert this! All files and folders inside this will also be deleted.",
// 		icon: 'warning',
// 		showCancelButton: true,
// 		confirmButtonColor: '#3085d6',
// 		cancelButtonColor: '#d33',
// 		confirmButtonText: 'Yes, delete it!'
// 	})

// 	if(userConfirmation.isConfirmed){
// 		$.ajax({
// 			url : "${cPath }/drive/deleteFolder.do",
// 			method : "post",
// 			data : {"driveId": $(elem).data("driveId")},
// 			dataType : "json",
// 			beforeSend : function(xhrToController){
// 				xhrToController.setRequestHeader(headerName, headerValue);
// 			}
// 		}).done(function(resp, textStatus, jqXHR) {
// 			if(resp.result){
// 				openFolder(1);
// 				$(elem).parents(".dropdown-menu").remove();
// 			}
// 		}).fail(function(jqXHR, status, error) {
// 			console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
// 		});
// 	}
// }
//--------------------------------------------------------------------------------
--%>




function deleteSelectedItems(){
// 	console.log("들어온나");
	
	let folderIds = Array.from(document.querySelectorAll('#driveListDiv input[type=checkbox][data-type=folder]:checked')).map(data => ({type: 'folder', id: data.dataset.driveId}));
	let fileIds = Array.from(document.querySelectorAll('#driveListDiv input[type=checkbox][data-type=file]:checked')).map(data => ({type: 'file', id: data.dataset.driveAtchNo}));
	let itemsToDelete = [...folderIds, ...fileIds];
	console.log(itemsToDelete);

	$.ajax({
		url : "${cPath }/drive/deleteMultipleItems.do",    
		method : "POST",
		data : JSON.stringify(itemsToDelete),
		dataType: "json",
		contentType: "application/json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
			xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		}   
	}).done(function(resp, textStatus, jqXHR) {
		if(resp.result) {
			openFolder( $("#fileUploadBoxForm #driveId").val() );
            Swal.fire(
                '삭제 성공',
                '선택한 파일이 삭제되었습니다',
                'success'
            );
        } else {
            Swal.fire({
                icon: '삭제 실패',
                title: '파일을 삭제하지 못했습니다.',
                text: resp.message
            });
        }
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});

}





function updateFolderNameVal(driveId, driveId2, driveRoot){
	$("#updateFolderNameForm #driveId").val(driveId);
	$("#updateFolderNameForm #driveId2").val(driveId2);
	$("#updateFolderNameForm #driveRoot").val(driveRoot);
	updateFolderNameModal.show();
}

function updateFolderName(){
	$.ajax({
		url : "${cPath }/drive/updateFolderName.do",
		method : "post",
		data : {"driveId" : $("#updateFolderNameForm #driveId").val(), "driveId2": $("#updateFolderNameForm #driveId2").val(), "driveRoot" : $("#updateFolderNameForm #driveRoot").val()},     
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
		}      
	}).done(function(resp, textStatus, jqXHR) {
		if(resp.result){
			updateFolderNameModal.hide();
			updateFolderNameForm[0].reset();
			openFolder( $("#fileUploadBoxForm #driveId").val() );
		}
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}





function updateFileNameVal(driveAtchNo, driveAtchOriginName){
	$("#updateFileNameForm #driveAtchNo").val(driveAtchNo);
	$("#updateFileNameForm #driveAtchOriginName").val(driveAtchOriginName);
	updateFileNameModal.show();
}

function updateFileName(){
	$.ajax({
		url : "${cPath }/drive/updateFileName.do",
		method : "post",
		data : {"driveAtchNo": $("#updateFileNameForm #driveAtchNo").val(), "driveAtchOriginName": $("#updateFileNameForm #driveAtchOriginName").val()},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
		}
	}).done(function(resp, textStatus, jqXHR) {
		if(resp.result){
			updateFileNameModal.hide();
			updateFileNameForm[0].reset();
			openFolder( $("#fileUploadBoxForm #driveId").val() );
		}
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}




function removeFile(elem){    
// 	console.log(elem);
// 	console.log(DOMStringMap);
// 	console.log($(elem).data("driveAtchNo"));
	console.log( elem.dataset.driveAtchNo );
// 	console.log($(elem).data("driveId"));
	var driveAtchNo = $(elem).data("driveAtchNo");
	var driveId = $(elem).data("driveId");
	
	$.ajax({
		url : "${cPath }/drive/removeFile.do",
		method : "post",
		data : {"driveAtchNo": driveAtchNo},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
		if(resp.result){
			openFolder(driveId);
// 			myFileDropdown.hide(); //드롭다운 DOM 엘리먼트 선택해서 닫으면 Dropzone.js 파일업로드 폼 깨짐
			$(elem).parents(".dropdown-menu").remove(); //드롭다운(이름바꾸기, 삭제하기) 없애줌
		}
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}




function removeFolder(elem){
	$.ajax({
		url : "${cPath }/drive/deleteFolder.do",
		method : "post",
		data : {"driveId": $(elem).data("driveId")},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
		}
	}).done(function(resp, textStatus, jqXHR) {
		if(resp.result){
			openFolder(1);
			$(elem).parents(".dropdown-menu").remove();
		}
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}



function makeFolder(){
// 	console.log(newFolderForm.serialize());
// 	console.log(newFolderForm.serializeObject());
// 	console.log(newFolderForm.serializeArray());
	
	$.ajax({
		url : "${cPath }/drive/makeFolder.do",
		method : "post",
		data : newFolderForm.serializeObject(),
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
		if(resp.result){
			//input 지우고
			$("#newFolderForm #driveRoot").val("");
			//모달 감추고
			newFolderModal.hide();    
			openFolder( $("#newFolderForm #driveId2").val() );
		}else{
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: resp.message
			});
		}
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}


var filterType = "";
function leftMenuActive(elem){
	$(elem).siblings().attr('class','flex items-center px-3 py-2 mt-2 rounded-md');
	$(elem).attr('class','flex items-center px-3 py-2 rounded-md bg-primary text-white font-medium');
	filterType = $(elem).data('filterType');
}

function openFolder(driveId){
	
	// 1. ACTIVE된 a태그에서 data 값을 가져오기
	// 2. a태그에서 클릭할때  input hidden에 저장하기
	
	if(driveId==null || driveId=="") driveId = $("#fileUploadBoxForm #driveId").val();
	console.log(filterType);
	$.ajax({
		url : "${cPath }/drive/openFolder.do",
		method : "post",
		data : {"driveId" : ( driveId ? driveId : 1 ), "filterType" : filterType },
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
		}
	}).done(function(resp, textStatus, jqXHR) {
		console.log(resp);
		if(resp.result){
			// driveId
			$("#fileUploadBoxForm #driveId").val(driveId);
			// driveId2
			$("#driveId2").val(driveId);
			//폴더 불러오기
			$("#driveListDiv").html("");
			// 최상위 폴더가 아니면...
			if( $("#fileUploadBoxForm #driveId").val() != 1){
				<%-- 폴더 하나 시작 --%>
				var content = 
						`<div class="intro-y col-span-6 sm:col-span-4 md:col-span-3 2xl:col-span-2">
                            <div class="file box rounded-md px-5 pt-8 pb-5 px-3 sm:px-5 relative zoom-in">
                                <div class="absolute left-0 top-0 mt-3 ml-3">
                                </div>
                                <a href="javascript:getParentDriveId2();" class="w-3/5 file__icon file__icon--empty-directory mx-auto" style="opacity: 0.5;"></a> 
                                <a href="javascript:;" class="block font-medium mt-4 text-center truncate">상위 폴더로 이동</a> 
                                <div class="text-slate-500 text-xs text-center mt-0.5">&nbsp;</div>
                            </div>
                        </div>`;
					<%-- 폴더 하나 끝 --%>
				$("#driveListDiv").append(content);
				
			}
			for(var i=0; i<resp.data.folderList.length; i++){
				<%-- 폴더 하나 시작 --%>
				var content = 
						`<div class="intro-y col-span-6 sm:col-span-4 md:col-span-3 2xl:col-span-2">
                            <div class="file box rounded-md px-5 pt-8 pb-5 px-3 sm:px-5 relative zoom-in">
                                <div class="absolute left-0 top-0 mt-3 ml-3">
                                    <input class="form-check-input border border-slate-500" type="checkbox" data-type="folder" data-drive-id="\${resp.data.folderList[i].driveId}" data-drive-id2="\${resp.data.folderList[i].driveId2}">
                                </div>
                                <a href="javascript:openFolder(\${resp.data.folderList[i].driveId});" class="w-3/5 file__icon file__icon--empty-directory mx-auto"></a> 
                                <a href="javascript:;" class="block font-medium mt-4 text-center truncate">\${resp.data.folderList[i].driveRoot}</a> 
                                <div class="text-slate-500 text-xs text-center mt-0.5">&nbsp;</div>
                                <div class="absolute top-0 right-0 mr-2 mt-3 dropdown ml-auto">
                                    <a href="javascript:;" class="dropdown-toggle w-5 h-5 block" aria-expanded="false" data-tw-toggle="dropdown"> <i class="fa-solid fa-ellipsis-vertical w-5 h-5 text-slate-500"></i> </a>
                                    <div class="dropdown-menu w-40">
                                        <ul class="dropdown-content">
                                            <li>
                                                <a href="javascript:;" onclick="event.preventDefault(); updateFolderNameVal('\${resp.data.folderList[i].driveId}', '\${resp.data.folderList[i].driveId2}', '\${resp.data.folderList[i].driveRoot}')" class="dropdown-item"  data-drive-id="\${resp.data.folderList[i].driveId}" data-drive-id2="\${resp.data.folderList[i].driveId2}"> <i class="fa-solid fa-pen-to-square w-4 h-4 mr-2"></i> 이름 바꾸기 </a>
                                            </li>
                                            <li>
                                                <a href="javascript:;" onclick="event.preventDefault(); removeFolder(this)" class="dropdown-item" data-drive-id="\${resp.data.folderList[i].driveId}" data-drive-id2="\${resp.data.folderList[i].driveId2}"> <i class="fa-solid fa-trash w-4 h-4 mr-2"></i> 삭제하기 </a>  
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>`;
					<%-- 폴더 하나 끝 --%>
				$("#driveListDiv").append(content);
			}
			
			//파일 불러오기
			for(var i=0; i<resp.data.fileList.length; i++){
				<%-- 파일 하나 시작 --%>
				var content = 
						`<div class="intro-y col-span-6 sm:col-span-4 md:col-span-3 2xl:col-span-2">
                            <div class="file box rounded-md px-5 pt-8 pb-5 px-3 sm:px-5 relative zoom-in">
                                <div class="absolute left-0 top-0 mt-3 ml-3">
                                    <input class="form-check-input border border-slate-500" type="checkbox" data-type="file" data-drive-atch-no="\${resp.data.fileList[i].driveAtchNo}" data-drive-id="\${resp.data.fileList[i].driveId}">   
                                </div>`;
                                
                if(resp.data.fileList[i].driveAtchType.includes('image')){
                    content += 
                                `<a href="${cPath}/drive/download.do?driveAtchNo=\${resp.data.fileList[i].driveAtchNo}" class="w-3/5 file__icon file__icon--image mx-auto">
                                    <div class="file__icon--image__preview image-fit">
                                        <img alt="\${resp.data.fileList[i].driveAtchSaveName}" src="${cPath}/drive\${resp.data.fileList[i].driveFileRoot}\${resp.data.fileList[i].driveAtchSaveName}">  
                                    </div>
                                </a>`;
                }else{
                    content += 
			                    `<a href="${cPath}/drive/download.do?driveAtchNo=\${resp.data.fileList[i].driveAtchNo}" class="w-3/5 file__icon file__icon--file mx-auto">
			                    	<div id="mimeType\${i}" class="mimeType file__icon__file-name">TYPE</div>
			                	</a>`;
                	
                }    
//                 var fileKB = Math.round( ( (resp.data.fileList[i].driveAtchSize) / 1024) *10 ) / 10;
//                 var fileMB = Math.round( ( (fileKB) / 1024) *10 ) / 10;
//                 var fileSize = (fileKB < 100) ? fileKB + " KB" : fileMB + " MB";
                var fileSizeFormat = formatBytes(resp.data.fileList[i].driveAtchSize, 2);
                    content += 
                                `<a href="javascript:;" class="block font-medium mt-4 text-center truncate">\${resp.data.fileList[i].driveAtchOriginName}</a> 
                                <div class="text-slate-500 text-xs text-center mt-0.5">\${fileSizeFormat}</div>
                                <div id="myFileDropdown" class="myFileDropdown absolute top-0 right-0 mr-2 mt-3 dropdown ml-auto">
                                    <a class="dropdown-toggle w-5 h-5 block" href="javascript:;" aria-expanded="false" data-tw-toggle="dropdown"> <i class="fa-solid fa-ellipsis-vertical w-5 h-5 text-slate-500"></i> </a>
                                    <div class="dropdown-menu w-40">
                                        <ul class="dropdown-content">  
                                            <li>
                                                <a href="javascript:updateFileNameVal(\${resp.data.fileList[i].driveAtchNo}, '\${resp.data.fileList[i].driveAtchOriginName}');" data-drive-atch-no="\${resp.data.fileList[i].driveAtchNo}" data-drive-id="\${resp.data.fileList[i].driveId}" class="dropdown-item"> <i class="fa-solid fa-pen-to-square w-4 h-4 mr-2"></i> 이름 바꾸기 </a>
                                            </li>
                                            <li>
                                                <a href="javascript:;" onclick="event.preventDefault(); removeFile(this);" data-drive-atch-no="\${resp.data.fileList[i].driveAtchNo}" data-drive-id="\${resp.data.fileList[i].driveId}" class="dropdown-item"> <i class="fa-solid fa-trash w-4 h-4 mr-2"></i> 삭제하기 </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>`;
					<%-- 파일 하나 끝 --%>
				$("#driveListDiv").append(content);
				<%-- 콘텐츠 붙여넣기 끝 --%>
				
				var myFileName = resp.data.fileList[i].driveAtchOriginName;
				var splitArray = myFileName.split('.');  
				$("#mimeType" + i).html(splitArray[splitArray.length-1].toUpperCase());
// 				$(".mimeType").eq(i).html(splitArray[splitArray.length-1].toUpperCase()); //이건 왜 안되냥...?
// 				console.log("***************************");
// 				console.log(myFileName);
// 				console.log(splitArray);
// 				console.log(splitArray.length);
// 				console.log(splitArray[splitArray.length-1]);
// 				console.log(splitArray[splitArray.length-1].toUpperCase());
			}   

		}
// 		resp.data.folderList
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}




function formatBytes(bytes, decimals = 2){
	if(bytes === 0){
		return '0 Bytes';
	}else{
		const k = 1024;
		const dm = decimals < 0 ? 0 : decimals;
		const size = ['Bytes','KB','MB','GB','TB','PB','EB','ZB','YB'];
		const i = Math.floor(Math.log(bytes) / Math.log(k));
		return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + size[i];
	} 
}

function checkAll(){
	$('#driveListDiv input[type=checkbox]').attr('checked', true);
}

function checkAllCancel(){
	$('#driveListDiv input[type=checkbox]').attr('checked', false);
}

function getParentDriveId2(){
	$.ajax({
		url : "${cPath}/drive/getParentDriveId2.do",
		method : "post",
		data : {"driveId" : Number($("#driveId").val()) },
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
		if(resp.result){
			openFolder(resp.data.driveId2);
		}
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}




var fileUploadModal;
var newFolderModal;
var updateFileNameModal;
var updateFolderNameModal;

var newFolderForm;
var updateFileNameForm;
var updateFolderNameForm;
var myDropzone ;

// var myFileDropdown;

$(function(){
	
	openFolder(1);
	
	
	fileUploadModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#fileUploadModal"));
	newFolderModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#newFolderModal"));
	updateFileNameModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#updateFileNameModal"));
	updateFolderNameModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#updateFolderNameModal"));
	 
	newFolderForm = $("#newFolderForm");
	updateFileNameForm = $("#updateFileNameForm");
	updateFolderNameForm = $("#updateFolderNameForm");

	
	
	
// 	myFileDropdown = tailwind.Dropdown.getOrCreateInstance(document.querySelector(".myFileDropdown")); //드롭다운 DOM 엘리먼트 선택해서 닫으면 Dropzone.js 파일업로드 폼 깨짐 --> 고유 드롭다운 요소 선택해서 remove()
	
	
	 Dropzone.autoDiscover= false;
          
	 myDropzone = new Dropzone('#fileUploadBoxForm', {
		    url: '${cPath}/drive/upload.do' ,    // 드롭다운 시 업로드 되는 URL
		    addRemoveLinks: true,
		    paramName: "uploads",
// 		    uploadMultiple: true,
		  //  maxFilesize: 300, // 드롭다운 시 파일 크기            
		    init: function () {
		        this.on('success', function (file, json) {
// 		        	console.log("file");
// 		        	console.log(file);
// 		        	console.log("json");
// 		        	console.log(json);
		        	
		            // 파일이 서버에 업로드가 완료 되었을 때
// 		            if (res.msg == 'OK') {
// 		                //만약에 response message 가 OK 라면
// 		                alert("업로드가 완료 되었습니다.");
// 		            } else {
// 		                // 만약에 OK 가 아니라면???
// 		                alert("업로드가 실패하였습니다.");
// 		            }
		            
		        });

		        this.on('addedfile', function (file) {
		            $("#file-dropzone").hide();
		            $(".upload-progress").show();
		        });

		        this.on('drop', function (file) {
		            // 파일이 드롭되면Upload Progress 나와줘야 된다.
		            $("#file-dropzone").hide();
		            $(".upload-progress").show();
		        });

		        // 2개 이상의 파일을 올릴 시 이전에 올린 이미지 삭제.
		        this.on("maxfilesexceeded", function (file) {
		            this.removeAllFiles();
		            this.addFile(file);
		        });
		        
		        
// 		        this.on("complete", function (file) {
// 		            this.removeAllFiles(file);  
// 		        });
		    },
		    removefile: function(file) {
// 		    	file.previewElement.remove();
		    	console.log(file);
		    }
		    
		});
		
// 	 myDropzone.on("sending", function(file, formData) {
// 		 console.log("PLZ..."); 
// 		 console.log(file);
// 		 console.log(formData);
		 
// 		  // do something
// 	});  


});
</script>