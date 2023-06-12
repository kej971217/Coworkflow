<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<div class="col-span-12 lg:col-span-6 mt-8">
    <div class="intro-y block sm:flex items-center h-10">
		<h1 class="text-lg font-medium truncate mr-5">프로젝트 등록</h1>
	</div>
</div>
<style>
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
<!-- BEGIN: Content -->
<form id="insertProjectForm" method="post">
	<security:csrfInput />
	<div class="content">
		<div class="grid grid-cols-12 gap-6">
			<div class="col-span-12 lg:col-span-12 2xl:col-span-12">
				<!-- BEGIN: Display Information -->
				<div class="intro-y box lg:mt-5">
					<div
						class="flex items-center p-5 border-b border-slate-200/60 dark:border-darkmode-400">
						<h2 class="font-medium text-base mr-auto">
							<input type="text" class="form-control" name="projectName" placeholder="프로젝트명" style="width: 870px;">
					</div>
					<div class="p-5">
						<div class="flex flex-col-reverse xl:flex-row flex-col">
							<div class="flex-1 mt-6 xl:mt-0">
								<div class="grid grid-cols-12 gap-x-5">
									<div class="col-span-12 2xl:col-span-6">
										<div class="mt-3">
											<label for="update-profile-form-4" class="form-label">프로젝트 목표</label>
											<input id="update-profile-form-4" type="text" name="projectGoal" class="form-control" placeholder="프로젝트 목표">
											<form:errors path="projectGoal" element="span" class="text-danger" />
										</div>
									</div>

									<div class="mt-3">
										<label for="update-profile-form-4" class="form-label">시작일</label>
										<input id="update-profile-form-4" type="date" name="projectStartDate" class="form-control" style="width: 870px;">
									</div>
									<div class="col-span-12 2xl:col-span-6">
										<div class="mt-3">
											<label for="update-profile-form-4" class="form-label">종료일</label>
											<input id="update-profile-form-4" type="date" name="projectGoalDate" class="form-control" style="width: 870px;">
										</div>
									</div>

									<div class="col-span-12 2xl:col-span-6">
										<div class="mt-3">
											<label for="update-profile-form-4" class="form-label">프로젝트장</label>
											<input id="prgBoss" type="text" name="empId" class="form-control" value="${empId }">
											<div id="prgBoss"></div>
										</div>
									</div>
									
									<!-- <div class="col-span-12 2xl:col-span-6">
										<div class="mt-3">
											<label for="update-profile-form-4" class="form-label">프로젝트원</label>
                                               <select id="departList" name="departList" id="departList" class="form-select">
													<c:forEach items="${departList}" var="departList" varStatus="status">
															<option value="${departList.teamName}">${departList.teamName }</option>
													</c:forEach>
												</select>
										</div>
									</div> -->



								</div>
							</div>
						</div>
						<div class="flex justify-end mt-4">
							<button type="button" class="btn btn-primary w-20 mr-auto" onclick="insertProject()">등록</button>
							<button type="reset" class="text-danger flex items-center">
								<i icon-name="trash-2" class="w-4 h-4 mr-1"></i>초기화
							</button>
							</a>
						</div>
					</div>
				</div>
				<!-- END: Display Information -->
			</div>
		</div>
	</div>
	<!-- END: Content -->
</form>

<script>
	function insertProject(){
		console.log("Header:",headerName);
		console.log("Value:",headerValue);
		
	let data = {
		projectName: $("[name=projectName]").val(),
		projectGoal: $("[name=projectGoal]").val(),
		projectStartDate: $("[name=projectStartDate]").val(),
		projectGoalDate: $("[name=projectGoalDate]").val(),
		empId: $("[name=empId]").val()
		       
	}
		
		$.ajax({
			url: "${cPath}/board/project/projectBoardInsert.do",
			type: "post",
			data: JSON.stringify(data),
			contentType: "application/json;charset=utf-8",
	        dataType:"json",
	        beforeSend: function(xhrToController){
				xhrToController.setRequestHeader(headerName, headerValue);
			},
			success :(data)=>{
				console.log(data);
				window.location.href = 'projectBoardList.do';
			},
			error:(err)=>{
				console.log(err);
			}
			
		});
	}

</script>