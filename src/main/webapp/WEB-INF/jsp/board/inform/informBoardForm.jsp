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
    <form id=insertform method="post" enctype="multipart/form-data">
    <security:csrfInput/>
        <div class="content" id="black_bg">
            <div class="intro-y flex flex-col sm:flex-row items-center mt-8">
                <h2 class="text-lg font-medium mr-auto">
                    사내 소식 등록
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
                    <button type="button" class="btn btn-primary-soft flex w-24 inline-block mr-1 mb-2" onclick="insertInform()"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> 저장 </button>
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
			              <select class="form-select w-full" name="postHeader">
			                <option value="" disabled selected>말머리</option>
			                <option value="경조사">[경조사]</option>
			                <option value="사내 행사">[사내 행사]</option>
			                <option value="업무 보고">[업무 보고]</option>
			                <option value="사내 간행물">[사내 간행물]</option>
			              </select>
			            </div>
                        <div class="border border-slate-200/60 dark:border-darkmode-400 rounded-md p-5 mt-5">
                             <div class="font-medium flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5"> <i icon-name="chevron-down" class="w-4 h-4 mr-2"></i>첨부파일</div>
                             <div class="mt-5">
                                 <div class="mt-3">
                                     <div class="border-2 border-dashed dark:border-darkmode-400 rounded-md pt-4">
                                         <div class="flex flex-wrap px-4" id="disp">
                                         </div>
                                         <div class="px-4 pb-4 flex items-center cursor-pointer relative">
                                             <i icon-name="image" class="w-4 h-4 mr-2"></i> <span class="text-primary mr-1">올리기</span>
                                             <input type="file" class="w-full h-full top-0 left-0 absolute opacity-0" id="addFiles" name="addFiles" multiple style="cursor:pointer;">
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

// 사내소식 등록 시 알람
const noticeAlarm = new StompJs.Client({
	brokerURL:`ws://\${document.location.host}${cPath}/ws/notice`,
	debug:function(str){
//				console.log(str);
	},
	onConnect:function(frame){
		
//			console.log("아 이거 안타나...?");
		
	}
});
noticeAlarm.activate();
//window.addEventListener("DOMContentLoaded", event=>{
//});

let editor;

const CKEDITOR=ClassicEditor
    .create( document.querySelector( '#editor' ),  {
		ckfinder: {
			uploadUrl : '/informBoardInsert.do'
		}
	})
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

    var postTitle = "[" + $("select[name=postHeader]").val() + "]" + $("input[name=postTitle]").val();
    var postContent = editor.getData();

    $('#previewTitle').html(postTitle);
    $('#previewContent').html(postContent);
    $('#previewEmpId').html('관리자');

    var currentDateTime = new Date(); // 현재 날짜와 시간을 가져옵니다.
    var options = { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit' };
    var formattedDateTime = currentDateTime.toLocaleString('ko-KR', options);


    $('#previewDate').html(formattedDateTime);
    var Modal = tailwind.Modal.getOrCreateInstance(document.querySelector("#modal-preview"));
    Modal.show();

}

function insertInform() {
	
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
	
	let formData = new FormData(document.querySelector("#insertform"));
	formData.delete("postContent");
	formData.append("postContent",editor.getData());
    
	$.ajax({
		url: "${cPath}/board/inform/informBoardInsert.do",
		type: "post",
		data: formData,
		contentType:false,
        processData: false,
        cache: false,
        dataType:"json",
		beforeSend: function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
		},
		/* 컨트롤러에서 return값이 data로(변수명이라서 다른 거 해도 상관없음) 넘어옴  */
		success : function(data){
            if(data=="1"){
				Swal.fire({
                    icon: 'success',
                    title: '성공',
                    text: "글을 등록했습니다.",
                }).then((result) => {
                    if (result.isConfirmed) {
                    	location.href = '${cPath}/board/inform/informBoard.do';
                    }
                })
            } else {
                Swal.fire({
                    icon: 'fail',
                    title: '제목을 입력해주세요.',
                    text: "잠시 후 다시 시도 해주세요.",
                });
            }
            
            
            // 알람용 json 데이터 생성.
       let alarmData = {
       			// 현재 알람을 보내는 사람 ID
       			empId : "a100005",
       			alarmContent : `님 새로운 사내소식이 등록되었습니다.`,
       			almType : `NOTICE`
       		};         
                           
//         console.log("이거는 타는지?")
       		// 알람을 띄우기 위한 publish
       		noticeAlarm.publish({
       			destination:"/topic/alarm/newNotice", 
       			body:JSON.stringify(alarmData),
       			headers:{
       				"content-type":"application/json"
       			}
       		});  
            
            
		}
		
	});
}

	//파일 서버 전송아니공, 그냥 사용자가 선택한 파일 미리보깅!
	const Disp = document.querySelector("#disp");
	const fileInput = document.querySelector("#addFiles");
	
	function oneFile(pFile){
		
		let fileReader = new FileReader();
	    fileReader.onload = function(){
	        let onImg = document.createElement("img");
	        onImg.src = fileReader.result;
	        onImg.width = 100; onImg.height = 100;
	        Disp.appendChild(onImg);
	    }
	    fileReader.readAsDataURL(pFile);
	}
	
	fileInput.onchange = () => {
	    //console.log("선택된 파일들:",fileInput.files);
	    let onFiles = fileInput.files;
	    Disp.innerHTML = "";
	    for(let i=0; i < onFiles.length; i++) {
	        //console.log("요거이 개별파일",chFiles[i]);
	        oneFile(onFiles[i]);
	    }
	}


</script>

</html>