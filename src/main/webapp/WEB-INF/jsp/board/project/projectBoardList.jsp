<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>


<div class="grid grid-cols-12 gap-6 mt-8">
	<div class="col-span-12 lg:col-span-3 2xl:col-span-2">
		<!-- BEGIN: approval Menu -->
		<div id="sideMenu">
			<div class="intro-y box bg-primary p-5 mt-6">
				<div>
					<button type="button" onclick="location.href='${cPath }/board/project/projectBoardInsert.do'"
						class="btn text-slate-600 dark:text-slate-950 w-full bg-white dark:bg-darkmode-300 dark:border-darkmode-300 mt-1">
						<i class="w-4 h-4 mr-2" icon-name="edit-3"></i>프로젝트 생성
					</button>
				</div>
				<div
					class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
					<a style="cursor:pointer;" onclick="f_project(0)" class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="cloud-rain"></i> 진행 중 </a>
					<a style="cursor:pointer;" onclick="f_project(1)" class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="coffee"></i> 완료 </a>
				</div>
			</div>
		</div>
		<!-- END: approval Menu -->
	</div>
	<div class="col-span-12 lg:col-span-9 2xl:col-span-10">
		<!-- BEGIN: Inbox Content -->
            <div class="grid grid-cols-10 gap-6 mt-5">
                <div  class="intro-y col-span-12 flex justify-end flex-wrap xl:flex-nowrap items-right mt-2">
<!-- 				 <div class="relative w-56 mx-auto"> -->
<!-- 				     <div class="absolute rounded-l w-10 h-full flex items-center justify-center bg-slate-100 border text-slate-500 dark:bg-darkmode-700 dark:border-darkmode-800 dark:text-slate-400"> <i data-lucide="calendar" class="w-4 h-4"></i> </div> <input type="text" class="datepicker form-control pl-12" data-single-mode="true"> -->
<!-- 				 </div> -->
                    <div class="flex w-full sm:w-auto">
                        
                    </div>
                    <div class="hidden xl:block mx-auto text-slate-500"></div>
                </div>
                <!-- BEGIN: Data List -->
                <div id="listTableBody" class="aprvList intro-y col-span-12 overflow-auto 2xl:overflow-visible">
	                <div class="font-3xl font-extrabold text-start truncate pb-3 flex">프로젝트 목록</div>        
                    <div id="listBody" class="flex" prjList>  
						<!-- 프로젝트 목록 -->
						<div class="content">
			                <div class="intro-y grid grid-cols-12 gap-5 mt-5">
			                    <!-- BEGIN: Item List -->
			                    <div class="intro-y col-span-12 lg:col-span-8">
			                    </div>
		                	</div>
	            		</div>
            			<!-- 프로젝트 목록 끝 -->
                	</div>
                </div>
                <!-- END: Data List -->
                <!-- BEGIN: Pagination -->
                <div class="pagingArea intro-y col-span-12 flex flex-wrap sm:flex-row sm:flex-nowrap items-center">
                    </div>
                </div>
                <!-- END: Pagination -->
            </div>
        </div>
        

        
<script>
	const projectList = document.querySelector("[prjList]");
	
	const dispList = (data) => {
		let tbodyStr = "";
		console.log("data{}:",data);
		for(let i=0; i<data.length; i++){
			let project = data[i];
			tbodyStr += `
			<div class="grid grid-cols-10 gap-5 mt-3 pt-3 flex flex-1">    
                <a href="${cPath }/board/project/projectBoardView.do?projectId=\${project.projectId }&boardId=\${project.boardId}" data-tw-toggle="modal" data-tw-target="#add-item-modal" class="intro-y block col-span-12 sm:col-span-5 2xl:col-span-5">  
                    <div class="box rounded-md p-3 relative zoom-in">  
                        <div class="flex-none relative block before:block before:w-full before:pt-[100%]">
                            <div class="absolute top-0 left-0 w-full h-full image-fit">
                                <img alt="Coworkflow" class="rounded-md" style="object-fit: scale-down;   background-color: #1e40af;    " src="${cPath}/resources/commonImages/logo_en.png"> 
                            </div>
                        </div>  
                        <div class="block font-medium text-center truncate mt-3">\${project.projectName }</div>
                    </div>
                </a>
            </div>
			`
		}
// 		console.log("확인", tbodyStr);
// 		console.log("프로젝트 리스트", projectList);
		projectList.innerHTML = tbodyStr;
		
	}
	
	
	const getList =() =>{
		$.ajax({
			method:'get',
			url: "${cPath}/board/project/projectBoardListJSON",
			dataType: 'json',
			success:(prjList) => {
				console.log("전체 목록",prjList);
// 				$("#projectName").html(prjList[0].projectName);

				dispList(prjList);
			},
			error:(err) => {
				console.log(err);
			}
		})
	}
	getList();
                                                                  	
	
	
	// 진행 중, 진행 완료 목록	
	const f_project = (isuse) => {
		$.ajax({
			method:"get",
			url:"${cPath}/board/project/projectBoardListJSON",
			data: isuse,
			dataType:"json",
			success:(prj)=>{
				console.log(prj);
				let selProjList = []; // 선택한 것만 담을 임시 배열
				for(let i=0; i<prj.length; i++){
					if(prj[i].isuse == isuse){
						console.log("진행중", prj[i]);
						selProjList.push(prj[i]);
					}
				}
				projectList.innerHTML=""; // 비우기
				dispList(selProjList);    // 임시배열에 담은 것 출력
			},
			error:(err)=>{
				console.log(err);
			}
		})
	}
	
</script>