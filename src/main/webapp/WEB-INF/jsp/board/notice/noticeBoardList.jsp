<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<div class="col-span-12 lg:col-span-6">
	<style>
	#pag{
		  position: absolute;
		  top: 50%;
		  left: 50%;
		  transform: translate(-50%, -50%);
		}
		
		.writer{
			text-align: center;
		}
		
		.head{
			text-align: center;
		}
		.body{
			text-align: center;
		}
		
		#title{
			width: 500px;
		}

	/* 너비 비율 설정 */
	colgroup {width: 100%;}
	colgroup col:nth-child(1) {width: 20%;}
	colgroup col:nth-child(2) {width: 40%;}
	colgroup col:nth-child(3) {width: 10%;}
	colgroup col:nth-child(4) {width: 20%;}
	colgroup col:nth-child(5) {width: 10%;}
		
	</style>
		
<%--  <p>principal : <sec:authentication property="principal" /></p>
 <p>사용자 ID : <sec:authentication property="principal.realUser.empId"/></p>
 --%>
 	<sec:authentication property="principal.realUser.empId" var="empId" />
	<!-- BEGIN: Content -->
	<div class="content">
		<div class="grid grid-cols-12 gap-6 mt-3">
			<div class="intro-y col-span-12 flex flex-wrap sm:flex-nowrap items-center mt-2">
			<c:if test="${empId eq 'a100005'}">
				<a href="${cPath}/board/notice/noticeBoardInsert.do" class="btn btn-primary shadow-md mr-1" id="toggle_id">공지 등록</a>
			</c:if>
				<div>
					<select class="w-20 form-select box mt-3 sm:mt-0" id="opt" style="margin-left: 5px;"> <!-- 오른쪽으로 옮기기 -->
						<option>10</option>
						<option>25</option>
						<option>35</option>
						<option>50</option>
					</select>
				</div>
                <div class="overflow-x-auto scrollbar-hidden">
                	<div id="tabulator" class="mt-5 table-report table-report--tabulator"></div>
            	</div>
				<div class="hidden md:block mx-auto text-slate-500"></div>
				<div class="w-full sm:w-auto mt-3 sm:mt-0 sm:ml-auto md:ml-0 py-5">
					<div class="w-56 relative text-slate-500">
						<input type="text" class="form-control w-56 box pr-10" placeholder="통합 검색" name="searchWord" id="searchWord"> 
						<i class="w-4 h-4 absolute my-auto inset-y-0 mr-3 right-0" data-lucide="search"></i>
					</div>
				</div>
					<button id="searchBtn" class="btn btn-primary" onclick="fsearch()" style="margin-left: 4px;">검색</button>
			</div>
			<!-- BEGIN: Data List -->
			<div class="intro-y col-span-12 overflow-auto lg:overflow-visible">
				<table class="table table-report -mt-2">
					<thead class="head">
						<tr>
							<th class="whitespace-nowrap">번호</th> 
							<th class="text-left whitespace-nowrap">제목</th>    
							<th class="whitespace-nowrap">조회수</th>  
							<th class="whitespace-nowrap">작성일</th>  
							<th class="text-center whitespace-nowrap">작성자</th>
						</tr>
					</thead>
					<tbody class="body" chahyun>
						<c:if test="${not empty noticeBoard.postList }">	
							<c:forEach var="post" items="${noticeBoard.postList}" varStatus="status">
							<tr>
								<td>${post.postId}</td>
								<td class="font-medium text-left"><a href="${cPath }/board/notice/noticeBoardView.do?what=${post.postId }" >${post.postTitle} </a> </td>
								<td>${post.postCnt}</td>
								<td>${post.postDate}</td>
								<td class="w-56">${post.empName}</td>
							</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
			<!-- END: Data List -->
			<!-- BEGIN: Pagination -->
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
	</div>
	<!-- END: Content -->
	
	
	<!--  검색  -->
<form name="searchForm" method="post">
	<security:csrfInput/>
<!-- 	<input type="hidden" name="page" placeholder="page"/> -->
	<input type="hidden" name="searchWord" placeholder="searchWord"/>
</form>
<script src="${cPath }/resources/js/board/boardList.js"></script>

<script>
const tBody = $("[chahyun]");

const fn_makeTr2 = function(posts){
// 	console.log("체킁: ", posts);
  let retHtml="";
  for(let i=0; i<posts.length; i++){
        let post = posts[i];
       retHtml+=  `
		<tr>
			<td>\${post.postId}</td>
			<td class="font-medium text-left"><a href="${cPath }/board/notice/noticeBoardView.do?what=\${post.postId }" >\${post.postTitle} </a> </td>
			<td>\${post.postCnt}</td>
			<td>\${post.postDate}</td>
			<td class="w-56">\${post.empId}</td>
		</tr>
        `
    }
    tBody.html(retHtml);
}

function fsearch(){
	var searchWord = $("[name=searchWord]").val();
// 	alert(searchWord);
	$.ajax({
		method:"get",
// 		url:"${cPath}/board/notice/noticeBoardSearch.do/\${searchWord}",
		url:"${cPath}/board/notice/noticeBoardSearch.do",
		data:`schWord=\${searchWord}`,
		dataType: "json",
		success: data=>{
// 			console.log("서버의 컨트롤러로부터 받은 값",data);
// 			console.log("안녕?",data[0].postContent);
			tBody.empty();
			fn_makeTr2(data);
		}
					
	})
}


// 엔터키 눌렀을 때 검색
	$("#searchWord").keydown(function(key) {
		if( key.keyCode == 13 ){
		}
	});
 
</script>