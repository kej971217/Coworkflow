<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>    
    <style>
    	.ck-editor__editable{
    		height: 750px;
    	}
    </style>
    
    
    <script>
    	var message='${message}';
    	if(message!="")
    		alert(message);
    </script>
    
    
        <!-- BEGIN: Content -->
    <form id="insertForm"   method="post" >
    <security:csrfInput/>
        <div class="content" id="black_bg">
            <div class="intro-y flex flex-col sm:flex-row items-center mt-8">
                <h2 class="text-lg font-medium mr-auto">
                    게시글 등록
                </h2>
                <div class="w-full sm:w-auto flex mt-4 sm:mt-0">
                    <button type="button" class="btn btn flex w-54 inline-block mr-1 mb-2" id="modal_btn_eye" onclick="preView()"> <i class="w-4 h-4 mr-2" icon-name="eye"></i> 미리보기 </button>
                    <button type="button" class="btn btn-warning-soft flex w-24 inline-block mr-1 mb-2" id="modal_btn"> <i class="w-4 h-4 mr-2" icon-name="corner-up-left"></i> 취소 </button>
                    
                    <!-- 글 등록 취소 모달 시작 -->
						<div id="delete-modal-preview" class="modal" tabindex="-1" aria-hidden="true">
						    <div class="modal-dialog">
						        <div class="modal-content">
						            <div class="modal-body p-0">
						                <div class="p-5 text-center"> <i data-lucide="x-circle" class="w-16 h-16 text-danger mx-auto mt-3"></i>
						                    <div class="text-3xl mt-5">등록을 취소하시겠습니까?</div>
						                    <div class="text-slate-500 mt-2">아직 저장되지 않은 내용이 있습니다.
						                    </div>
						                </div>
						                <div class="px-5 pb-8 text-center">
						                	<button data-tw-dismiss="modal" class="btn btn-secondary w-24 mr-1">취소</button> 
						                	<a href="javascript:history.back();" class="btn btn-primary w-24 inline-block mr-1 mb-2">확인</a>
<%-- 						                	<a href="${cPath }/board/project/projectBoardView.do?what=${project.projectId }" class="btn btn-primary w-24 inline-block mr-1 mb-2">확인</a> --%>
						                </div>
						            </div>
						        </div>
						    </div>
						</div>
					<!-- 글 등록 취소 모달 끝 -->
                    <!-- BEGIN: Modal Content -->
					<div id="modal-preview" class="modal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog" style="width: 80%">
                            <div class="modal-content">
                                <div class="modal-body p-0">
                                    <div class="p-5 text-center"> <i data-lucide="x-circle" class="w-16 h-16 text-danger mx-auto mt-3"></i>
                                        <div class="border-b border-slate-200/60 dark:border-darkmode-400 text-center sm:text-left">
                                            <div class="px-5 py-10 sm:px-20 sm:py-20">
                                                <div id="previewTitle" class="text-primary font-semibold text-3xl"></div>
                                                <div class="border-b-2 dark:border-darkmode-400 whitespace-nowrap"></div>
                                                <div id="previewEmpId" class="mt-2" style="text-align:right;"><span class="font-medium"></span> </div>
                                                <div id="previewDate" class="mt-1" style="text-align:right;"></div>
                                                <div id="previewContent"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="px-5 pb-8 text-center">
                                        <button data-tw-dismiss="modal" class="btn btn-secondary w-24 mr-1">닫기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
					<!-- END: Modal Content -->
					
					<!-- Form 태그안에 button 넣으면 디폴트가 submit 주의 해야 함-->
                    <button type="button" class="btn btn-primary-soft flex w-24 inline-block mr-1 mb-2" onclick="insertForm()"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> 저장 </button>
                </div>
            </div>
            <div class="pos intro-y grid grid-cols-12 gap-5 mt-5">
                <!-- BEGIN: Post Content -->
                <div class="intro-y col-span-12 lg:col-span-8">
                    <input type="text" class="intro-y form-control py-3 px-4 box pr-10" placeholder="제목" name="postTitle" maxlength="130" >
                    <div class="post intro-y overflow-hidden box mt-5" style="height:1000px;">
                        <ul class="post__tabs nav nav-tabs flex-col sm:flex-row bg-slate-200 dark:bg-darkmode-800" role="tablist">
                            <li class="nav-item">
                                <button title="Fill in the article content" data-tw-toggle="tab" data-tw-target="#content" class="nav-link tooltip w-full sm:w-40 py-4 active" id="content-tab" role="tab" aria-controls="content" aria-selected="true"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> 내용 </button>
                            </li>
                        </ul>
                        <div class="post__content tab-content">
                            <div id="content" class="tab-pane p-5 active" role="tabpanel" aria-labelledby="content-tab">
                                <div class="border border-slate-200/60 dark:border-darkmode-400 rounded-md p-5" style="height:900px;">
                                    <div class="font-medium flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5" > <i icon-name="chevron-down" class="w-4 h-4 mr-2"></i> 작성 </div>
                                    <div class="mt-5">
                                        <div >
                                            <textarea id="editor" placeholder="작성" name="postContent"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: Post Content -->
 				<!-- BEGIN: Post Info -->
                <div class="col-span-12 lg:col-span-4">
                    <div class="intro-y box p-5">
                       <div class="mt-2">
			              <select class="form-select w-full" name="postAsap">
			                <option value="" disabled selected>우선순위</option>
			                <option value="즉시">즉시</option>
			                <option value="긴급">긴급</option>
			                <option value="높음">높음</option>
			                <option value="보통">보통</option>
			                <option value="낮음">낮음</option>
			              </select>
			            </div>
                        
                        
                        <div class="border border-slate-200/60 dark:border-darkmode-400 rounded-md p-5 mt-5">
                             <div class="font-medium flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5"> <i icon-name="chevron-down" class="w-4 h-4 mr-2"></i>기간</div>
                             <div class="mt-5">
                                     <label class="form-label">시작 기간</label>
                                         <div class="px-4 pb-4 flex items-center cursor-pointer relative">
                                             <input type="date" name="postSday">
                                         </div>
                                         
                                     <label class="form-label">마감 기간</label>
                                         <div class="px-4 pb-4 flex items-center cursor-pointer relative">
                                             <input type="date" name="postFday">
                                         </div>
                             </div>
                         </div>
                         
                         <div class="mt-7">
			              <select class="form-select w-full" name="postProgress">
			                <option value="" disabled selected>진척도</option>
			                <option value="10">10</option>
			                <option value="20">20</option>
			                <option value="30">30</option>
			                <option value="40">40</option>
			                <option value="50">50</option>
			                <option value="60">60</option>
			                <option value="70">70</option>
			                <option value="80">80</option>
			                <option value="90">90</option>
			                <option value="100">100</option>
			              </select>
			            </div>
                         
                        <div class="border border-slate-200/60 dark:border-darkmode-400 rounded-md p-5 mt-7">
                             <div class="font-medium flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5"> <i icon-name="chevron-down" class="w-4 h-4 mr-2"></i>사진 및 파일</div>
                             <div class="mt-5">
                                 <div class="mt-3">
                                     <div class="border-2 border-dashed dark:border-darkmode-400 rounded-md pt-4">
                                         <div class="px-4 pb-4 flex items-center cursor-pointer relative">
                                             <i icon-name="image" class="w-4 h-4 mr-2"></i> <span class="text-primary mr-1">올리기</span>
                                             <input type="file" class="w-full h-full top-0 left-0 absolute opacity-0" name="atchId" multiple>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                    </div>
                </div>
                <!-- END: Post Info -->
            </div>
        </div>
    </form>
        <!-- END: Content -->
<!--         <script src="dist/js/ckeditor-classic.js"></script> 이거 왜 필요하더라??? -->
        <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script>
let editor;

const CKEDITOR=ClassicEditor
    .create( document.querySelector( '#editor' ) )
    .then( newEditor => {
        editor = newEditor;
    } )
    .catch( error => {
        console.error( error );
    } );


window.onload = function() {

	function onClick() {
		 var Modal = tailwind.Modal.getOrCreateInstance(document.querySelector("#delete-modal-preview"));
		 
		 Modal.show();
		 
	}

document.getElementById('modal_btn').addEventListener('click', onClick);
 
 
};


// 미리 보기
function preView() {

    var postTitle = $("input[name=postTitle]").val();
    var postContent = editor.getData();

    $('#previewTitle').html(postTitle);
    $('#previewContent').html(postContent);
    $('#previewEmpId').html('a100001');

    var currentDateTime = new Date(); // 현재 날짜와 시간을 가져옵니다.
    var options = { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit' };
    var formattedDateTime = currentDateTime.toLocaleString('ko-KR', options);


    $('#previewDate').html(formattedDateTime);
    var Modal = tailwind.Modal.getOrCreateInstance(document.querySelector("#modal-preview"));
    Modal.show();

}

function insertForm() {
	
	if(!$("[name=postTitle]").val().trim()){
        Swal.fire({
            icon: 'fail',
            title: '제목을 입력해주세요.',
        });
		return;
	}
	
	if(!editor.getData().trim()){
        Swal.fire({
            icon: 'fail',
            title: '내용을 입력해주세요.',
        });
		return;
	}
	
	
    let data = {
        postTitle: $("[name=postTitle]").val(),
        postContent : editor.getData(),
        postSday: $("[name=postSday]").val(),
        postFday: $("[name=postFday]").val(),
        postAsap: $("[name=postAsap]").val(),
        postProgress: $("[name=postProgress]").val(),
        boardId: location.href.split("?")[1].split("=")[1].split("&")[0]
    }
    
    console.log(data);
    
	$.ajax({
		url: "${cPath}/board/project/projectPostInsert.do",
		type: "post",
		data: JSON.stringify(data),
		contentType: "application/json;charset=utf-8",
        dataType:"json",
		beforeSend: function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
		},
		/* 컨트롤러에서 return값이 data로(변수명이라서 다른 거 해도 상관없음) 넘어옴  */
		success : function(data){
			
			console.log("체킁:",data);
			
            if(data=="1"){
				Swal.fire({
                    icon: 'success',
                    title: '성공',
                    text: "글을 등록했습니다.",
                }).then((result) => {
                    if (result.isConfirmed) {
                        
                    	location.href = '${cPath}/board/project/projectBoardView.do?what=${projectId}&how=${boardId}';
                    }
                })
            } else {
                Swal.fire({
                    icon: 'fail',
                    title: '등록 실패',
                    text: "잠시 후 다시 시도 해주세요.",
                });
            }
		}
		
	});
}

</script>

</html>