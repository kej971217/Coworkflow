<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="col-span-12 lg:col-span-6 mt-2">
	<style>
#pag {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.writer {
	text-align: center;
}

.head {
	text-align: center;
}

.body {
	text-align: center;
}

#title {
	width: 500px;
}
</style>

	<sec:authentication property="principal.realUser.empId" var="empId" />
	<!-- BEGIN: Content -->
	<div class="content">
		<div class="grid grid-cols-12 gap-6 mt-5">
			<div
				class="intro-y col-span-12 flex flex-wrap sm:flex-nowrap items-center mt-2">
				<c:if test="${empId eq 'a100005'}">
					<a href="${cPath}/board/inform/informBoardInsert.do"
						class="btn btn-primary shadow-md mr-2">등록</a>
				</c:if>
				<div class="hidden md:block mx-auto text-slate-500"></div>
				<div class="w-full sm:w-auto mt-3 sm:mt-0 sm:ml-auto md:ml-0">
					<div class="w-56 relative text-slate-500">
						<input type="text" class="form-control w-56 box pr-10"
							placeholder="통합 검색"> <i
							class="w-4 h-4 absolute my-auto inset-y-0 mr-3 right-0"
							data-lucide="search"></i>
					</div>
				</div>
				<button id="searchBtn" class="btn btn-primary">검색</button>
				<div>
					<select class="w-20 form-select box mt-3 sm:mt-0" id="opt">
						<!-- 오른쪽으로 옮기기 -->
						<option>10</option>
						<option>25</option>
						<option>35</option>
						<option>50</option>
					</select>
				</div>
			</div>
			<!-- BEGIN: Data List -->
			<div class="intro-y col-span-12 overflow-auto lg:overflow-visible">
				<table class="table table-report -mt-2">
					<thead class="head">
						<tr>
							<th class="whitespace-nowrap">번호</th>
							<th class="text-center whitespace-nowrap">제목</th>
							<th class="text-center whitespace-nowrap">조회수</th>
							<th class="text-center whitespace-nowrap">작성일</th>
							<th class="text-center whitespace-nowrap">작성자</th>
						</tr>
					</thead>
					<tbody class="body" chahyun>
						<c:if test="${not empty informBoard.postList }">
							<c:forEach var="post" items="${informBoard.postList}"
								varStatus="status">      
								<tr>
									<td>${post.postId}</td>
									<td class="font-medium text-left"><a
										href="${cPath }/board/inform/informBoardView.do?what=${post.postId }">[${post.postHeader }]
											+ ${post.postTitle} </a></td>
									<td>${post.postCnt}</td>
									<td>${post.postDate}</td>
									<td class="w-56">${post.empId}</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
			<!-- END: Data List -->
			<!-- BEGIN: Pagination -->  
			<div
				class="intro-y col-span-12 flex flex-wrap sm:flex-row sm:flex-nowrap items-center">
				<nav class="w-full sm:w-auto sm:mr-auto" id="pag">
					<ul class="pagination">
						<li class="page-item"><a class="page-link" href="#"> <i
								class="w-4 h-4" data-lucide="chevrons-left"></i>
						</a></li>
						<li class="page-item"><a class="page-link" href="#"> <i
								class="w-4 h-4" data-lucide="chevron-left"></i>
						</a></li>
						<li class="page-item"><a class="page-link" href="#">...</a></li>
						<li class="page-item active"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a>      
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
			<!-- END: Pagination -->
		</div>
		<!-- BEGIN: Delete Confirmation Modal -->
		<div id="delete-confirmation-modal" class="modal" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-body p-0">
						<div class="p-5 text-center">
							<i icon-name="x-circle"
								class="w-16 h-16 text-danger mx-auto mt-3"></i>
							<div class="text-3xl mt-5">삭제하시겠습니까?</div>
							<div class="text-slate-500 mt-2">삭제 후에는 되돌릴 수 없습니다.</div>
						</div>
						<div class="px-5 pb-8 text-center">
							<button type="button" data-tw-dismiss="modal"
								class="btn btn-outline-secondary w-24 mr-1">취소</button>
							<button type="button" class="btn btn-danger w-24">삭제</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- END: Delete Confirmation Modal -->
	</div>
	<!-- END: Content -->




	<script>
	const tBody = $("[chahyun]");
	
	const fn_makeTr2 = function(posts){
	  let retHtml="";
	  for(let i=0; i<posts.length; i++){
	        let post = posts[i];
	       retHtml+=  `
			<tr>
				<td>\${post.postId}</td>
				<td class="font-medium text-left"><a href="${cPath }/board/inform/informBoardView.do?what=\${post.postId }" >\${post.postHeader}\${post.postTitle} </a> </td>
				<td>\${post.postCnt}</td>
				<td>\${post.postDate}</td>
				<td class="w-56">\${post.empId}</td>
			</tr>
	        `
	    }
	    tBody.html(retHtml);
	} 
	
	console.log(post.postHeader);
	</script>