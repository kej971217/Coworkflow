<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>    
    <style>
    	.ck-editor__editable{
    		height: 750px;
    	}
    </style>
    
        <!-- BEGIN: Content -->
    <form id="insertForm"   method="post" >
    <security:csrfInput/>
        <div class="content" id="black_bg">
            <div class="intro-y flex flex-col sm:flex-row items-center mt-8">
                <h2 class="text-lg font-medium mr-auto">
                    사내 소식 수정
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
						                    <div class="text-3xl mt-5">수정을 취소하시겠습니까?</div>
						                    <div class="text-slate-500 mt-2">아직 저장되지 않은 내용이 있습니다.
						                    </div>
						                </div>
						                <div class="px-5 pb-8 text-center">
						                	<button data-tw-dismiss="modal" class="btn btn-secondary w-24 mr-1">취소</button> 
						                	<a href="${cPath }/board/inform/informBoard.do" class="btn btn-primary w-24 inline-block mr-1 mb-2">확인</a>
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
                    <button type="button" class="btn btn-primary-soft flex w-24 inline-block mr-1 mb-2" onclick="updateNotice()"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> 저장 </button>
                </div>
            </div>
            <div class="pos intro-y grid grid-cols-12 gap-5 mt-5">
                <!-- BEGIN: Post Content -->
                <div class="intro-y col-span-12 lg:col-span-8">
                    <input type="text" class="intro-y form-control py-3 px-4 box pr-10" placeholder="제목" name="postTitle" maxlength="130" value="${informVO.postTitle }" >
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
                                            <textarea id="editor" placeholder="작성" name="postContent">${informVO.postContent }</textarea>
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
			              <select class="form-select w-full" name="postHeader" id="postHeader">
			                <option value="" disabled selected>말머리</option>
			                <option value="경조사">[경조사]</option>
			                <option value="사내 행사">[사내 행사]</option>
			                <option value="업무 보고">[업무 보고]</option>
			                <option value="사내 간행물">[사내 간행물]</option>
			              </select>
			            </div>
                        <div class="border border-slate-200/60 dark:border-darkmode-400 rounded-md p-5 mt-5">
                             <div class="font-medium flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5"> <i icon-name="chevron-down" class="w-4 h-4 mr-2"></i>사진 및 파일</div>
                             <div class="mt-5">
                                 <div class="mt-3">
                                     <div class="border-2 border-dashed dark:border-darkmode-400 rounded-md pt-4">
                                         <div class="px-4 pb-4 flex items-center cursor-pointer relative">
                                             <i icon-name="image" class="w-4 h-4 mr-2"></i> <span class="text-primary mr-1">올리기</span>
                                             <input type="file" class="w-full h-full top-0 left-0 absolute opacity-0" name="atchId" multiple style="cursor:pointer;">
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

    var postTitle = "[" + $("select[name=postHeader]").val()+"]"+ $("input[name=postTitle]").val();
    var postContent = editor.getData();

    $('#previewTitle').html(postTitle);
    $('#previewContent').html(postContent);
    $('#previewEmpId').html('a100005');

    var currentDateTime = new Date(); // 현재 날짜와 시간을 가져옵니다.
    var options = { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit' };
    var formattedDateTime = currentDateTime.toLocaleString('ko-KR', options);


    $('#previewDate').html(formattedDateTime);
    var Modal = tailwind.Modal.getOrCreateInstance(document.querySelector("#modal-preview"));
    Modal.show();

}

$(document).ready(function(){
	$("#postHeader").val('${informVO.postHeader}').prop("selected", true); 
});


function updateNotice() {
	var postHeader = $("select[name=postHeader]").val();
    var postTitle = $("input[name=postTitle]").val();
    var postContent = editor.getData();
    var postId = location.href.split("?")[1].split("=")[1];
    
    // // FormData 객체 생성
    // var formData = new FormData();
    // formData.append('postTitle', postTitle);
    // formData.append('postContent', postContent);
    let postVO = {
    	postHeader:postHeader,
    	postTitle:postTitle, 
    	postContent:postContent,
    	postId:postId
    }
    
    console.log("포스트 브이오",postVO);

    $.ajax({
        url: "${cPath}/board/inform/informBoardUpdate.do",
        type: 'post',
        data: JSON.stringify(postVO),
        contentType : "application/json",
        beforeSend : function(xhrToController){
            xhrToController.setRequestHeader(headerName, headerValue);
        },
        success : function (data) {
            if (data > 0 ) {
                Swal.fire({
                    icon: 'success',
                    title: '성공',
                    text: "등록되었습니다.",
                }).then((result) => {
					// 사용자가 확인 버튼을 클릭한 경우 실행될 콜백 함수
                    if (result.isConfirmed) {
                        // 콜백 함수 내에서 필요한 동작 수행
                        location.href = `${cPath}/board/inform/informBoardView.do?what=\${postId}`;
                    }
                })
            } else {
                Swal.fire({
                    icon: 'fail',
                    title: '실패',
                    text: "잠시 후 다시 시도해주세요.",
                });
            }
        }
    });

}

</script>

</html>