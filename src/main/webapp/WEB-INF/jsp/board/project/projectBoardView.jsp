<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<style>
/* 진행 중 */
	#ing{
		background-color: #9CFFEBCD;
/* 		background-color: #9CFC006A; */
		color: #708090;
/* 		color: #3CB371; */
	}
/* 완료 */
	#end{
		background-color: #9CFC006A;
		color: #708090;
	}


	
/* 	즉시 */
	#즉시{ 
		color: #FF0000;
	}
/* 	긴급 */
	#긴급{
		color: #FF8C00;
	}
/* 	높음 */
	#높음{
		color: #FFD700;
	}
/* 	보통 */
	#보통{
		color: #4169E1;
	}
/* 	낮음 */
	#낮음{
		color: #008B8B;
	}
	
	.progress{
		height: 20px;
		color: #4169E1;
		
	}
	::-webkit-progress-bar {
	  background-color: #B0C4DE;
	    border-radius: 4px;
	}
	
	::-webkit-progress-value {
	  background-color: #4169E1;
	    border-radius: 4px;
	}
	
</style>
<sec:authentication property="principal.realUser.empId" var="empId" />
<!-- BEGIN: 기간 Modal Content -->
	<!-- BEGIN: Modal Content -->
	<div id="header-footer-modal-preview" class="modal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- BEGIN: Modal Header -->
				<div class="modal-header">
					<h2 class="font-medium text-base mr-auto">기간 수정</h2>
				</div>
				<!-- END: Modal Header -->
				<!-- BEGIN: Modal Body -->
				<div class="modal-body grid grid-cols-12 gap-4 gap-y-3">
					<div class="col-span-12 sm:col-span-6">
						<label for="modal-form-1" class="form-label">시작 기간</label> <input
							id="modal-form-1" type="date" class="form-control" value=""
							placeholder="시작 기간">
					</div>
					<div class="col-span-12 sm:col-span-6">
						<label for="modal-form-2" class="form-label">종료 기간</label> <input
							id="modal-form-2" type="date" class="form-control"
							placeholder="종료 기간">
					</div>
				</div>
				<!-- END: Modal Body -->
				<!-- BEGIN: Modal Footer -->
				<div class="modal-footer">
					<button type="button" data-tw-dismiss="modal"
						class="btn btn-outline-secondary w-20 mr-1">취소</button>
					<button class="btn btn-primary w -20">저장</button>
				</div>
				<!-- END: Modal Footer -->
			</div>
		</div>
	</div>
	<!-- END: Modal Content -->
	<!-- END: 기간 Modal Content -->



	<!-- BEGIN: 참여자 Modal Toggle -->
	<div class="text-center">
	</div>
	<!-- END: Modal Toggle -->
	<!-- BEGIN: Modal Content -->
	<div id="header-footer-modal-personPreview" class="modal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- BEGIN: Modal Header -->
				<div class="modal-header">
					<h2 class="font-medium text-base mr-auto">참여자 수정</h2>
				</div>
				<!-- END: Modal Header -->
				<!-- BEGIN: Modal Body -->
				<div class="modal-body grid grid-cols-12 gap-4 gap-y-3">
					<div class="col-span-12 sm:col-span-2">
						<label for="modal-form-1" class="form-label">포지션</label> <input
							id="modal-form-1" type="text" class="form-control">
					</div>
					<div class="col-span-12 sm:col-span-10">
						<label for="modal-form-2" class="form-label">임직원(팀)</label> <input
							id="modal-form-2" type="text" class="form-control">
					</div>
				</div>
				<!-- END: Modal Body -->
				<!-- BEGIN: Modal Footer -->
				<div class="modal-footer">
					<button type="button" data-tw-dismiss="modal"
						class="btn btn-outline-secondary w-20 mr-1">취소</button>
					<button class="btn btn-primary w-20">저장</button>
				</div>
				<!-- END: Modal Footer -->
			</div>
		</div>
	</div>
	<!-- END: 참여자 Modal Content -->
	
	
	
	<!-- BEGIN: 프로젝트 Modal Toggle -->
	<div class="text-center">
	</div>
	<!-- END: Modal Toggle -->
	<!-- BEGIN: Modal Content -->
	<div id="header-footer-modal-projectPreview" class="modal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- BEGIN: Modal Header -->
				<div class="modal-header">
					<h2 class="font-medium text-base mr-auto">프로젝트 프로그램 수정</h2>
				</div>
				<!-- END: Modal Header -->
				<!-- BEGIN: Modal Body -->
				<div class="modal-body grid grid-cols-12 gap-4 gap-y-3">
					<div class="col-span-12 sm:col-span-6">
						<label for="modal-form-1" class="form-label">프로젝트명</label> <input
							id="modal-form-1" type="text" class="form-control" value="${projectBoard.projectName }">
					</div>
					<div class="col-span-12 sm:col-span-6">
						<label for="modal-form-2" class="form-label">프로젝트 목표</label> <input
							id="modal-form-2" type="text" class="form-control" value="${projectBoard.projectGoal }">
					</div>
				</div>
				<!-- END: Modal Body -->
				<!-- BEGIN: Modal Footer -->
				<div class="modal-footer">
					<button type="button" data-tw-dismiss="modal"
						class="btn btn-outline-secondary w-20 mr-1">취소</button>
					<button class="btn btn-primary w-20">저장</button>
				</div>
				<!-- END: Modal Footer -->
			</div>
		</div>
	</div>
	<!-- END: 프로젝트 Modal Content -->
	
	
<!-- BEGIN: Conent -->
            <div class="content">
<%--             <p>그저 헷깔릴뿐!${projectBoard}</p> --%>
                <!-- BEGIN: Transaction Details -->
                <a class="btn btn-primary w-24 mr-1 mb-2 mt-6" href="${cPath}/board/project/projectBoardList.do">목록</a>
                <div class="intro-y grid grid-cols-11 gap-5 mt-2">
                    <div class="col-span-12 lg:col-span-4 2xl:col-span-3">
                        <div class="box p-5 rounded-md">
                            <div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5 mb-5">
                                <div class="font-medium text-base truncate">프로젝트</div>
                                <a href="#" class="flex items-center ml-auto text-primary" data-tw-toggle="modal"
			data-tw-target="#header-footer-modal-projectPreview"> <i icon-name="edit" class="w-4 h-4 mr-2"></i> 수정 </a>
                            </div>
                            <div class="flex items-center"> <i icon-name="link-2" class="w-4 h-4 text-slate-500 mr-2"></i> 프로젝트명: ${projectBoard.projectName }</div>
                            <div class="flex items-center mt-3"> <i icon-name="linkedin" class="w-4 h-4 text-slate-500 mr-2"></i> 프로젝트 목표 </div>
                            <div class="flex items-center mt-3">　　${projectBoard.projectGoal }</div>
                        </div>
                        
                        <div class="box p-5 rounded-md mt-5">
                            <div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5 mb-5">
                                <div class="font-medium text-base truncate">기간</div>
                                <a href="#" class="flex items-center ml-auto text-primary" data-tw-toggle="modal" data-tw-target="#header-footer-modal-preview"> <i icon-name="edit" class="w-4 h-4 mr-2"></i> 수정 </a>
                            </div>
                            <div class="flex items-center"> <i icon-name="clipboard" class="w-4 h-4 text-slate-500 mr-2"></i> 시작 기간 : ${projectBoard.projectStartDate } </div>
                            <div class="flex items-center mt-3"> <i icon-name="calendar" class="w-4 h-4 text-slate-500 mr-2"></i> 종료 기간 : ${projectBoard.projectGoalDate } </div>
                            <div class="flex items-center mt-3"> <i icon-name="disc" class="w-4 h-4 text-slate-500 mr-2"></i> 진행 상황 
                            <c:if test="${projectBoard.projectProgress < 100}">
                            	<span class="bg-success/20 text-success rounded px-2 ml-1" id="ing">진행 중</span>
                            </c:if>
                            <c:if test="${projectBoard.projectProgress == 100 }">
                            	<span class="bg-success/20 text-success rounded px-2 ml-1" id="end">완료</span>
                            </c:if>
                            </div>
                        </div>
                        
                        <div class="box p-5 rounded-md mt-5">
                            <div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5 mb-5">
                                <div class="font-medium text-base truncate">진행률</div>
                            </div>
							<div style="text-align:center;"><progress class="progress" id="progress" value="${projectBoard.projectProgress }" min="0" max="100"></progress>${projectBoard.projectProgress }%</div>
                        </div>
                        <div class="box p-5 rounded-md mt-5">
                            <div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5 mb-5">
                                <div class="font-medium text-base truncate">참여자</div>
                                <a href="#" class="flex items-center ml-auto text-primary" data-tw-toggle="modal"
			data-tw-target="#header-footer-modal-personPreview"> <i icon-name="edit" class="w-4 h-4 mr-2"></i> 수정 </a>
                            </div>
                            <div class="flex items-center">
                                <i icon-name="clipboard" class="w-4 h-4 text-slate-500 mr-2"></i> PM: 
                                <div class="ml-auto">박봉팔(전략기획팀)</div>
                            </div>
                            <div class="flex items-center mt-3">
                                <i icon-name="credit-card" class="w-4 h-4 text-slate-500 mr-2"></i> TA: 
                                <div class="ml-auto">최태식(IT팀), 염계정(마케팅팀)</div>
                            </div>
                            <div class="flex items-center mt-3">
                                <i icon-name="credit-card" class="w-4 h-4 text-slate-500 mr-2"></i> DA: 
                                <div class="ml-auto">김채현(IT팀)</div>
                            </div>
                            <div class="flex items-center border-t border-slate-200/60 dark:border-darkmode-400 pt-5 mt-5 font-medium">
                                <i icon-name="users" class="w-4 h-4 text-slate-500 mr-2"></i> 총 인원: 
                                <div class="ml-auto">4</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-span-12 lg:col-span-7 2xl:col-span-8">
                        <div class="box p-5 rounded-md">
                            <div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 pb-5 mb-5">
                                <div class="font-medium text-base truncate">게시글</div>
                                <a href="${cPath }/board/project/projectPostInsert.do?boardId=${projectBoard.boardId}&projectId=${projectBoard.projectId}" class="flex items-center ml-auto text-primary"> <i icon-name="plus" class="w-4 h-4 mr-2"></i> 새 글 등록 </a>
                            </div>
                            <div class="overflow-auto lg:overflow-visible -mt-3">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th class="whitespace-nowrap !py-5">작성자</th>
                                            <th class="whitespace-nowrap text-right">제목</th>
                                            <th class="whitespace-nowrap text-right">우선순위</th>
                                            <th class="whitespace-nowrap text-right">시작 기간</th>
                                            <th class="whitespace-nowrap text-right">마감 기간</th>
                                        </tr>
                                    </thead>
                                    <tbody class="body" tForm>
                                    </tbody>
                                </table>
                            </div>
                            <div class="w-full sm:w-auto mt-3 sm:mt-0 sm:ml-auto md:ml-0 py-5">
								<div class="w-100 relative text-slate-500">
									<input type="text" class="form-control w-56 box pr-10" placeholder="통합 검색" name="searchWord" id="searchWord"> 
									<i class="w-4 h-4 absolute my-auto inset-y-0 mr-3 right-0" data-lucide="search"></i>
									<button id="searchBtn" class="btn btn-primary" onclick="fsearch()" style="margin-left: 4px;">검색</button>
								</div>
							</div>
                        </div>
                    </div>
                </div>
                <!-- END: Transaction Details -->
            </div>
            <!-- END: Content -->
            
<form name="searchForm" method="post">
	<security:csrfInput/>
<!-- 	<input type="hidden" name="page" placeholder="page"/> -->
	<input type="hidden" name="searchWord" placeholder="searchWord"/>
</form>

<script>

	// 게시글 목록 반복문
	const listTbody = document.querySelector("[tForm]");
	
	const dispList = (data) =>{ /* 여기서 data는 밑에 함수 getList에서 success시 넘어오는 postList */
	    console.log("프로젝트 게시글 목록 체킁:",data);
	    let tbodyStr = "";
	    for(let i=0; i<data.length; i++){
	        let post = data[i];
	        console.log("프로젝트 post",post);
	        tbodyStr += `
	        	<tr>
	            <td class="text-left">\${post.empId }</td>
	            <td class="text-right">
	            	<a href="${cPath }/board/project/projectPostView.do?postId=\${post.postId }&boardId=${projectBoard.boardId}&projectId=${projectBoard.projectId}" >\${post.postTitle} </a> 
	            </td>
	            <td class="text-right" id="\${post.postAsap }">\${post.postAsap }</td>
	            <td class="text-right">\${post.postSday }</td>
	            <td class="text-right">\${post.postFday }</td>
	        </tr>
	        `
	    }
	    console.log("리스트 체킁킁:",tbodyStr);
	    listTbody.innerHTML = tbodyStr;
	}
	
	
	// 목록 데이터 가져오기
	const getList = () => {
		$.ajax({
			method:"get",
			url:"${cPath}/board/project/projectPostListJSON",
			data:"boardId=${projectBoard.boardId}", 
			datatType:"json",
			success:(postList)=>{
				console.log("프로젝트 게시글 목록 ajax:",postList);
				dispList(postList);
			}, error:(err)=>{
				console.log(err);
			}
		})
	}
	getList();
	
	
	
	
	// 검색
	const tBody = $("[tForm]");
	
	const fn_makeTr2 = function(posts){
	// 	console.log("체킁: ", posts);
	let retHtml="";
	for(let i=0; i<posts.length; i++){
			let post = posts[i];
		retHtml+=  `
        	<tr>
            <td class="text-right">\${project.empId }</td>
            <td class="!py-4">
            	<a href="${cPath }/board/project/projectPostView.do?what=\${project.postId }" >\${project.postTitle} </a>  
            </td>
            <td class="text-right" id="${project.postAsap }">\${project.postAsap }</td>
            <td class="text-right">\${project.postSday }</td>
            <td class="text-right">\${project.postFday }</td>
        </tr>
        `
		}
		tBody.html(retHtml);
	}
	
	// 검색
	function fsearch(){
		var searchWord = $("[name=searchWord]").val();
	// 	alert(searchWord);
		$.ajax({
			method:"get",
			url:"${cPath}/board/project/projectPostSearch.do",
			data:`schWord=\${searchWord}`,
			dataType: "json",
			success: data=>{
				tBody.empty();
				fn_makeTr2(data);
			}
						
		})
	}
	
	
	function updateProgressPercent(){
		if( ${projectBoard.projectProgress} == 100 ){
			$.ajax({
				url : "${cPath}/board/project/projectFinal?projectId=${projectBoard.projectId}",
				method : "get",
				data : { },          
				dataType : "json"
			}).done(function(resp, textStatus, jqXHR) {
				console.log(resp);
			}).fail(function(jqXHR, status, error) {
				console.log(`상태코드: \${status}, 에러메시지: \${error}`);
			});
		}else{
			
		}
	}
	
	$(function(){
		updateProgressPercent();  
	});
</script>