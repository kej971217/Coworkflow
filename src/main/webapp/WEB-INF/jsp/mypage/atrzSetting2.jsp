<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.modal {
  display: none; 
  position: fixed; 
  z-index: 1; 
  left: 0;
  top: 0;
  width: 100%; 
  height: 100%; 
  overflow: auto; 
  background-color: rgba(0,0,0,0.5); 
}

.modal-content {
  border-radius: 5px;
  background-color: #fefefe;
  margin: 15% auto; 
  padding: 20px;
  border: 1px solid #888;
  width: 400;
  overflow-y: auto;
  max-height: 500px;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

#deputySelectBox{
	height: 260px;
	
}

</style>
<form id="mypageEditForm" method="post">
	<security:csrfInput />
	<div class="content">
		<div class="grid grid-cols-12 gap-6">
			<jsp:include page="/includee/mypageLeftMenu.jsp"></jsp:include>
			<div class="col-span-12 lg:col-span-8 2xl:col-span-9">
				<div class="intro-y box lg:mt-5">
					<div
						class="flex items-center p-5 border-b border-slate-200/60 dark:border-darkmode-400">
						<h2 class="font-medium text-base mr-auto">결재 설정</h2>
					</div>
					<div class="p-5">
						<div class="flex flex-col-reverse xl:flex-row flex-col">
							<div class="flex-1 mt-6 xl:mt-0">
								<div class="grid grid-cols-12 gap-x-5">
									<div class="col-span-12 2xl:col-span-6">
										<div>
									    <div>대결자 선택</div>
									    <br>
									    <div>
											<label for="update-profile-form-1" class="form-label">부재자</label>
											<input id="update-profile-form-1" type="text"
												class="form-control" value="${mypage.empName }">
										</div>
										<br>
									    	<div>
									    	<div><label for="update-profile-form-1" class="form-label">부서명 </label>
														<select name="team" class="form-select">
															<option value="">전체</option>
															<c:forEach  items="${teamInfo }" var="team">
																<option class="${team.belongTeam }" value="${team.teamId }">${team.teamName }</option>
															</c:forEach>
														</select>
														<br>
														<br>
													<div style="height: 200px; display: block; overflow: auto;">
														<table border="1" id="deputySelectBox">
														<tbody id="teamEmpListBody" class="atrzScrollable-table" >
															<c:forEach items="${teamEmpList }" var="teamEmp">
																<tr class="${teamEmp.teamId } empListTr">
																	<td><input class="deputySelect form-control" type="hidden" name="atrzEmp" data-empid="${teamEmp.empId }" data-empname="${teamEmp.empName}"  data-teamname="${teamEmp.teamName }" data-positionname="${teamEmp.positionName }"/></td>
																	<td>[${teamEmp.teamName }] ${teamEmp.positionName } ${teamEmp.empName }</td>
																</tr>
															</c:forEach>
														</tbody>
														</table>
													</div>  
													</div>
													<div>
														<br>
												</div>
												</div>
										</div>
										<div>
											<button onclick="deputySettingSave()" type="submit"
												class="btn btn-primary w-20 mr-auto">저장</button>
										</div>
									</div>
									<div class="col-span-12 2xl:col-span-6">
										<div>
											<label for="update-profile-form-1" class="form-label">부재자</label>
											<input id="update-profile-form-1" type="text"
												class="form-control" value="${mypage.empName }">
										</div>
										<br>
										<div>
											<label for="update-profile-form-1" class="form-label">대결자</label>
											<input id="update-profile-form-1" type="text"
												class="form-control" value="${approver.deputyEmpName }">
										</div>
										<br>
										<div>
											<label for="update-profile-form-1" class="form-label">사유</label>
											<input id="update-profile-form-1" type="text"
												name="deputyApproverReason" class="form-control"
												value="${approver.deputyApproverReason }">
										</div>
										<br>
										<div>
											<label for="update-profile-form-1" class="form-label">직책</label>
											<input id="update-profile-form-1" type="text"
												class="form-control" value="${approver.deputyPositionName }">
										</div>
										<br>
										<div>
											<label for="update-profile-form-1" class="form-label">시작일시</label>
											<input id="update-profile-form-1" type="date"
												name="deputyApproverBgn" class="form-control"
												value="${approver.deputyApproverBgn }">
										</div>
										<br>
										<div>
											<label for="update-profile-form-1" class="form-label">종료일시</label>
											<input id="update-profile-form-1" type="date"
												name="deputyApproverEnd" class="form-control"
												value="${approver.deputyApproverEnd }">
										</div>
									</div>
								</div>
							</div>
							<div>
								<div class="w-60 mx-auto xl:mr-0 xl:ml-6 box">
									<div
										class="border-2 border-dashed shadow-sm border-slate-200/60 dark:border-darkmode-400 rounded-md p-5">
										<h2 class="font-medium text-base mr-auto">결재 이미지</h2>
										<div class="h-40 relative image-fit cursor-pointer mx-auto">
											<c:if test="${ mypage.empAtchFileList.empAtchClasfct eq 0 }">
												<img id="faciImg"
													src="${cPath }/mypage/${mypage.empAtchFileList.empAtchSaveName}"
													alt="${mypage.empAtchFileList.empAtchSaveName}" />
											</c:if>
											<div
												class="w-5 h-5 flex items-center justify-center absolute rounded-full tright-0 top-0 -mr-2 -mt-2"></div>
										</div>
										<div class="mx-auto cursor-pointer relative mt-5">
											<input type="file" name="empFiles"
												class="btn btn-sm btn-secondary w-full mr-1 mb-2"
												value="프로필 이미지 등록 / 변경" />
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>


<script>
	function deputySettingSave() {
		let deputy = {};
		var tds = document.querySelectorAll(".position");
		for (let i = 0; i < tds.length; i++) {
			deputy.deputyApproverReason = deputyApproverReason.value;
			deputy.deputyApproverEnd = deputyApproverEnd.value;
			deputy.deputyApproverBgn = deputyApproverBgn.value;
		}

		$.ajax({
			method : "post",
			url : "${cPath}/mypage/insertDeputyApprover.do",
			data : JSON.stringify(deputy),
			contentType : "application/json;charset=utf-8", // json형태의 문자열을 보내겠다는 이야기
			dataType : "text",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(rslt) {
				console.log(rslt);
			}
		})
	}
	

	$("[name=team]").on("change", function(event){
		$("#teamEmpListBody > tr").css("display","none");
		$("#teamEmpListBody > tr." +this.value).css("display","block");
	})

	
</script>