<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<body>
    <!-- 사내 소식 글 목록 -->
    <div class="content">
		<div class="grid grid-cols-12 gap-6 mt-3">
			<div class="intro-y col-span-12 flex flex-wrap sm:flex-nowrap items-center mt-2">
				<button class="btn btn-primary shadow-md mr-1" id="toggle_id" data-tw-toggle="modal" data-tw-target="#insert-modal-preview" onclick = "location.href = '${cPath}/board/inform/informBoardInsert.do' ">등록</button>
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
							<th class="whitespace-nowrap">제목</th>  
							<th class="whitespace-nowrap">조회수</th>
							<th class="whitespace-nowrap">작성일</th>
							<th class="whitespace-nowrap">작성자</th>
						</tr>
					</thead>
					<tbody class="body" chahyun>
					</tbody>
				</table>
			</div>
			<!-- END: Data List -->
			<!-- BEGIN: Pagination -->
			<div class="intro-y col-span-12 flex flex-wrap sm:flex-row sm:flex-nowrap items-center" style="margin: 0 auto;">  
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

    <!--  검색  -->
    <form name="searchForm" method="post">
    	<security:csrfInput/>
    <!-- 	<input type="hidden" name="page" placeholder="page"/> -->
    	<input type="hidden" name="searchWord" placeholder="searchWord"/>
    </form>
    
<script>
    // 오자 마자 리스트 데이터 가져오기
    const listTbody = document.querySelector("[chahyun]");
    const dispList = (data) =>{
        console.log("리스트 체킁:",data);
        let tbodyStr = "";
        for(let i=0; i<data.length; i++){
            let post = data[i];
            console.log("post",post);
            tbodyStr += `
                <tr>
				    <td>\${post.postId}</td>
					<td class="font-medium text-left"><a href="${cPath}/board/inform/informBoardView.do?what=\${post.postId }" >[\${post.postHeader }]\${post.postTitle} </a> </td>
					<td>\${post.postCnt}</td>
					<td>\${post.postDate}</td>
					<td class="w-56">\${post.empName}</td>
			    </tr>
            `
        }
        console.log("리스트 체킁킁:",tbodyStr);
        listTbody.innerHTML = tbodyStr;

    }
    const getList = () => {
        $.ajax({
            method:"get",
            url:"${cPath}/board/inform/informBoardList.do",
            dataType:"json",
            success:(rdata)=>{
                console.log(rdata);
                dispList(rdata);
            },
            error:(error)=>{
                console.log(error);
            }
        })

    }
    getList();
	
	
    
    // 검색 
	const tBody = $("[chahyun]");

	const fn_makeTr2 = function(posts){
	// 	console.log("체킁: ", posts);
	let retHtml="";
	for(let i=0; i<posts.length; i++){
			let post = posts[i];
		retHtml+=  `
			<tr>
				<td>\${post.postId}</td>
				<td class="font-medium text-left"><a href="${cPath }/board/inform/informBoardView.do?what=\${post.postId }" >\${post.postTitle} </a> </td>
				<td>\${post.postCnt}</td>
				<td>\${post.postDate}</td>
				<td class="w-56">\${post.empName}</td>  
			</tr>
			`
		}
		tBody.html(retHtml);   
	}

	
	// 검색
    function fsearch(){
    	var searchWord = $("[name=searchWord]").val();
    	$.ajax({
    		method:"get",
    		url:"${cPath}/board/inform/informBoardSearch.do",
    		data:`schWord=\${searchWord}`,
    		dataType: "json",
    		success: data=>{
    			tBody.empty();
    			fn_makeTr2(data);
    		}
    					
    	})
    }
    
</script>

