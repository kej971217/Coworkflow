/**
 * 
 */

// 사내 소식 게시글 목록
let InformListTableBody = $("#informList");

let informListTable = function(){
	let informHtml = `
<div class="content">
		<div class="grid grid-cols-12 gap-6 mt-5">
			<div class="intro-y col-span-12 flex flex-wrap sm:flex-nowrap items-center mt-2">
			    <c:if test="\${empId eq 'a100005'}">
					<a href="\${cPath}/board/inform/informBoardInsert.do" class="btn btn-primary shadow-md mr-2">등록</a>
				</c:if>
				<div class="hidden md:block mx-auto text-slate-500"></div>
				<div class="w-full sm:w-auto mt-3 sm:mt-0 sm:ml-auto md:ml-0">
					<div class="w-56 relative text-slate-500">
						<input type="text" class="form-control w-56 box pr-10"
							placeholder="통합 검색"> <i class="w-4 h-4 absolute my-auto inset-y-0 mr-3 right-0" data-lucide="search"></i>
					</div>
				</div>
					<button id="searchBtn" class="btn btn-primary">검색</button>
				<div>
					<select class="w-20 form-select box mt-3 sm:mt-0" id="opt"> <!-- 오른쪽으로 옮기기 -->
						<option>10</option>
						<option>25</option>
						<option>35</option>
						<option>50</option>
					</select>
				</div>
			</div>
			<div class="intro-y col-span-12 flex flex-wrap sm:flex-row sm:flex-nowrap items-center">
				<nav class="w-full sm:w-auto sm:mr-auto" id="pag">
					<ul class="pagination">
						<li class="page-item"><a class="page-link" href="#"> <i
								class="w-4 h-4" data-lucide="chevrons-left"></i>
						</a></li>
						<li class="page-item"><a class="page-link" href="#"> <i
								class="w-4 h-4" data-lucide="chevron-left"></i>
						</a></li>
						<li class="page-item"><a class="page-link" href="#">...</a></li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item active"><a class="page-link" href="#">2</a>
						</li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item"><a class="page-link" href="#">...</a></li>
						<li class="page-item"><a class="page-link" href="#"> <i
								class="w-4 h-4" data-lucide="chevron-right"></i>
						</a></li>
						<li class="page-item"><a class="page-link" href="#"> <i
								class="w-4 h-4" data-lucide="chevrons-right"></i>
						</a></li>
					</ul>
				</nav>
			</div>
		</div>
		<div id="delete-confirmation-modal" class="modal" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-body p-0">
						<div class="p-5 text-center">
							<i icon-name="x-circle"
								class="w-16 h-16 text-danger mx-auto mt-3"></i>
							<div class="text-3xl mt-5">Are you sure?</div>
							<div class="text-slate-500 mt-2">
								Do you really want to delete these records? <br> This
								process cannot be undone.
							</div>
						</div>
						<div class="px-5 pb-8 text-center">
							<button type="button" data-tw-dismiss="modal"
								class="btn btn-outline-secondary w-24 mr-1">Cancel</button>
							<button type="button" class="btn btn-danger w-24">Delete</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	`
	InformListTableBody.html(informHtml);
}






//사내 소식 등록
let insertInformBody = $("#insertInformBody");

let informBody = `
	<form id="insertForm"   method="post" >
    <security:csrfInput/>
        <div class="content" id="black_bg">
            <div class="intro-y flex flex-col sm:flex-row items-center mt-8">
                <h2 class="text-lg font-medium mr-auto">
                    공지 등록
                </h2>
                <div class="w-full sm:w-auto flex mt-4 sm:mt-0">
                    <button type="button" class="btn btn flex w-54 inline-block mr-1 mb-2" id="modal_btn_eye" onclick="preView()"> <i class="w-4 h-4 mr-2" icon-name="eye"></i> 미리보기 </button>
                    <button type="button" class="btn btn-warning-soft flex w-24 inline-block mr-1 mb-2" id="modal_btn"> <i class="w-4 h-4 mr-2" icon-name="corner-up-left"></i> 취소 </button>
                    
                    <!-- BEGIN: Modal Content -->
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
						                	<a href="\${cPath }/board/notice/noticeBoardList.do" class="btn btn-primary w-24 inline-block mr-1 mb-2">확인</a>
						                </div>
						            </div>
						        </div>
						    </div>
						</div>
					<!-- END: Modal Content -->
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
                    <button type="button" class="btn btn-primary-soft flex w-24 inline-block mr-1 mb-2" onclick="insertNotice()"> <i icon-name="file-text" class="w-4 h-4 mr-2"></i> 저장 </button>
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
                        <div class="border border-slate-200/60 dark:border-darkmode-400 rounded-md p-5 mt-5">
                             <div class="font-medium flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5"> <i icon-name="chevron-down" class="w-4 h-4 mr-2"></i>사진 및 파일</div>
                             <div class="mt-5">
                                 <div class="mt-3">
                                     <label class="form-label">사진 올리기</label>
                                     <div class="border-2 border-dashed dark:border-darkmode-400 rounded-md pt-4">
                                         <div class="flex flex-wrap px-4">
                                             <div class="w-24 h-24 relative image-fit mb-5 mr-5 cursor-pointer zoom-in">
                                                 <img src="https://dwprottr7376.cdn-nhncommerce.com/data/goods/20/07/30//1000101218/1000101218_detail_387.jpg">
                                                 <div title="Remove this image?" class="tooltip w-5 h-5 flex items-center justify-center absolute rounded-full text-white bg-danger right-0 top-0 -mr-2 -mt-2"> <i icon-name="x" class="w-4 h-4"></i> </div>
                                             </div>
                                             <div class="w-24 h-24 relative image-fit mb-5 mr-5 cursor-pointer zoom-in">
                                                 <img src="https://dwprottr7376.cdn-nhncommerce.com/data/goods/20/07/30//1000101218/1000101218_detail_387.jpg">
                                                 <div title="Remove this image?" class="tooltip w-5 h-5 flex items-center justify-center absolute rounded-full text-white bg-danger right-0 top-0 -mr-2 -mt-2"> <i icon-name="x" class="w-4 h-4"></i> </div>
                                             </div>
                                         </div>
                                         <div class="px-4 pb-4 flex items-center cursor-pointer relative">
                                             <i icon-name="image" class="w-4 h-4 mr-2"></i> <span class="text-primary mr-1">파일 올리기</span> (드래그를 이용해 파일 올리기 가능)
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

`