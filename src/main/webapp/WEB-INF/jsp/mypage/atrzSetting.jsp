<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
#deputySelectBox {
	height: 260px;
}

#deputySettingView {
	display: none;
}
#atchBtn{
	display: none;

}
#signSaveBtn{
	display: none;

}
</style>
<div class="content">
	<%-- 						<form id="atrzEditForm" method="post" > --%>
	<%-- 							<security:csrfInput /> --%>
	<div class="grid grid-cols-12 gap-6">
		<jsp:include page="/includee/mypageLeftMenu.jsp"></jsp:include>
		<div class="col-span-12 lg:col-span-8 2xl:col-span-9">
			<div class="intro-y box lg:mt-5">
				<div
					class="flex items-center p-5 border-b border-slate-200/60 dark:border-darkmode-400">
					<h2 class="font-medium text-base mr-auto">결재 설정</h2>
				</div>
				<div class="p-5" id="deputyInfoView">
					<div class="flex flex-col-reverse xl:flex-row flex-col">
						<div id="deputyListDiv" class="flex-1 mt-6 xl:mt-0">
							<div class="grid grid-cols-12 gap-x-5">
								<div style="text-align: right;">
									<button onclick="toggleDiv()"
										class="btn btn-sm btn-secondary w-20 mr-1 mb-2">대결 등록</button>
								</div>
								<div
									class="aprvList intro-y col-span-12 overflow-auto 2xl:overflow-visible">
									<table class="table table-report -mt-2">
										<tr>  
											<td align="center">부재자</td>
											<td align="center">대결자</td>
											<td align="center">부서</td>
											<td align="center">직책</td>
											<td align="center">시작일시</td>
											<td align="center">종료일시</td>
										</tr>
										<c:if test="${not empty approver }">
											<c:forEach items="${approver }" var="deputy">
												<tr>
													<td align="center">${deputy.empName }</td>
													<td align="center">${deputy.deputyEmpName }</td>
													<td align="center">${deputy.deputyTeamName }</td>
													<td align="center">${deputy.deputyPositionName }</td>
													<td align="center">${deputy.deputyApproverBgn }</td>
													<td align="center">${deputy.deputyApproverEnd }</td>
												</tr>
											</c:forEach>
										</c:if>
										<c:if test="${empty approver }">
											<tr>
												<td colspan="7" align="center">데이터가 존재하지
													않습니다.</td>
											</tr>
										</c:if>
									</table>
								</div>
							</div>
						</div>
						<div>
							<div class="w-60 mx-auto xl:mr-0 xl:ml-6 box">
								<div
									class="border-2 border-dashed shadow-sm border-slate-200/60 dark:border-darkmode-400 rounded-md p-5">
									<h2 class="font-medium text-base mr-auto">서명</h2>
									<div id="previewImg" class="h-40 relative image-fit cursor-pointer mx-auto">
										<c:if test="${not empty mypage.signImage }" >
											<img id="faciImg" class="rounded-full" src="${cPath }/mypage/${mypage.signImage.empAtchSaveName}" alt="${mypage.signImage.empAtchOriginName}" />
										</c:if>
										<c:if test="${empty mypage.signImage }" >
											<img alt="Coworkflow" class="rounded-full" src="/Coworkflow/resources/Rubick/dist/images/profile-8.jpg">
										</c:if>
										<div
											class="w-5 h-5 flex items-center justify-center absolute rounded-full tright-0 top-0 -mr-2 -mt-2"></div>
									</div>
									<div class="mx-auto cursor-pointer relative mt-5">
										<input id="atchBtn" type="file" name="empFiles"
											class="btn btn-sm btn-secondary w-full mr-1 mb-2"
											 />
										<input id="signUpdateBtn" type="button" name="empFiles"
										class="btn btn-sm btn-secondary w-full mr-1 mb-2"
										onclick="signUpdate()"
										value="결재 이미지 등록 / 변경" />
										<input id="signSaveBtn" type="button" name="empFiles"
										class="btn btn-sm btn-secondary w-full mr-1 mb-2"
										onclick="signSave()"
										value="저장" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="p-5" id="deputySettingView">
					<div class="flex flex-col-reverse xl:flex-row flex-col">
						<div class="flex-1 mt-6 xl:mt-0">
							<div class="grid grid-cols-12 gap-x-5">
								<div class="col-span-12 2xl:col-span-6">
									<div>
										<div>대결자 선택</div>
										<br>
										<hr>
										<br>
										<div>
											<div>
												<label for="update-profile-form-1" class="form-label">부서명
												</label> <select name="team" class="form-select">
													<option value="">전체</option>
													<c:forEach items="${teamInfo }" var="team">
														<option class="${team.belongTeam }"
															value="${team.teamId }">${team.teamName }</option>
													</c:forEach>
												</select> <br> <br>
												<div style="height: 260px; display: block; overflow: auto;">
													<table border="1" id="deputySelectBox">
														<tbody id="teamEmpListBody" class="atrzScrollable-table">
															<c:forEach items="${teamEmpList }" var="teamEmp">
																<tr onclick="deputyEnter(this)"
																	class="${teamEmp.teamId } empListTr">
																	<td><input class="deputySelect form-control"
																		type="hidden" name="atrzEmp"
																		data-empid="${teamEmp.empId }"
																		data-empname="${teamEmp.empName}"
																		data-teamname="${teamEmp.teamName }"
																		data-positionname="${teamEmp.positionName }" /></td>
																	<td><a>[${teamEmp.teamName }]
																			${teamEmp.positionName } ${teamEmp.empName }</a></td>
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
										<button onclick="deputySettingSave()"
											class="btn btn-primary w-20 mr-auto">저장</button>
									</div>
								</div>
								<div class="col-span-12 2xl:col-span-6">
									<div>
										<label for="update-profile-form-1" class="form-label">부재자</label>
										<input id="update-profile-form-1" type="text" disabled="disabled"
											class="form-control" value="${mypage.empName }">
									</div>
									<br>
									<div id="deputyDiv">
										<label for="update-profile-form-1" class="form-label">대결자</label>
										<input id="deputyEmpName" type="text" class="form-control">
									</div>
									<br>
									<div>
										<label for="update-profile-form-1" class="form-label">사유</label>
										<input id="update-profile-form-1" type="text"
											name="deputyApproverReason" class="form-control">
									</div>
									<br>
									<div>
										<label for="update-profile-form-1" class="form-label">시작일시</label>
										<input id="update-profile-form-1" type="date"
											name="deputyApproverBgn" class="form-control">
									</div>
									<br>
									<div>
										<label for="update-profile-form-1" class="form-label">종료일시</label>
										<input id="update-profile-form-1" type="date"
											name="deputyApproverEnd" class="form-control">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%-- 	</form> --%>
</div>


<script>
	var header = '${_csrf.headerName}';
	var token = '${_csrf.token}'
	
	$("[name=team]").on("change", function(event) {
		$("#teamEmpListBody > tr").css("display", "none");
		$("#teamEmpListBody > tr." + this.value).css("display", "block");
	})
	
	function deputyEnter(pthis) {
		// 	event.preventDefault();
		var calledTr = pthis;
		console.log(calledTr)

		deputyEmpName = document.querySelector("#deputyEmpName")
		deputyDiv = document.querySelector("#deputyDiv")

		selectedteamname = calledTr.children[0].children[0]
				.getAttribute("data-teamname");
		selectedpositionname = calledTr.children[0].children[0]
				.getAttribute("data-positionname");
		selectedEmpName = calledTr.children[0].children[0]
				.getAttribute("data-empname");
		selectedEmpId = calledTr.children[0].children[0]
				.getAttribute("data-empid");
		deputyDiv.empty
		deputyDiv.innerHTML = `<label for="update-profile-form-1" class="form-label">대결자</label><br>`
		deputyDiv.innerHTML += 
			`<input class="form-control" type="text" value=[\${selectedteamname}]&nbsp;\${selectedpositionname}&nbsp;\${selectedEmpName}>`
		deputyDiv.innerHTML += `<input type="hidden" name="deputyApproverEmp" value=\${selectedEmpId}>`;
	}
	
	function signUpdate(){
		event.preventDefault();
		
		var deputyListDiv = document.querySelector("#deputyListDiv");
		var atchBtn = document.querySelector("#atchBtn");
		var signUpdateBtn = document.querySelector("#signUpdateBtn");
		var signSaveBtn = document.querySelector("#signSaveBtn");

		if (signUpdateBtn.style.display === "block") {
			signSaveBtn.style.display = "none";
			deputyListDiv.style.display = "block";
			atchBtn.style.display = "none"
		} else {
			atchBtn.style.display = "block"
			signSaveBtn.style.display = "block";
			deputyListDiv.style.display = "none";
			signUpdateBtn.style.display = "none";
		}
	}

	function toggleDiv() {
		event.preventDefault();

		var infoView = document.querySelector("#deputyInfoView");
		var settingView = document.querySelector("#deputySettingView");

		if (infoView.style.display === "none") {
			infoView.style.display = "block";
			settingView.style.display = "none";
		} else {
			infoView.style.display = "none";
			settingView.style.display = "block";
		}
	}

	function deputySettingSave() {
		event.preventDefault();
		let deputy = {
			deputyApproverEmp : $("[name=deputyApproverEmp]").val(),
			deputyApproverReason : $("[name=deputyApproverReason]").val(),
			deputyApproverEnd : $("[name=deputyApproverEnd]").val(),
			deputyApproverBgn : $("[name=deputyApproverBgn]").val()
		};
		console.log(deputy)

		$.ajax({
			method : "post",
			url : "${cPath}/mypage/insertDeputyApprover.do",
			data : JSON.stringify(deputy),
			contentType : "application/json;charset=utf-8",
			dataType : "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(rslt) {
				Swal.fire({
                    icon: 'success',
                    title: '성공',
                    text: "대결자를 등록했습니다.",
                }).then((result) => {
                    if (result.isConfirmed) {
                    	location.href = '${cPath}/mypage/atrzSetting.do';
                    }
                })
				
			}
		})
	}
	
	function signSave(){
		event.preventDefault();
		let signIMG = $("[name=empFiles]")[0];
		let formData = new FormData();
	    formData.append("name","sendImgForm")
	    formData.append("signIMG",signIMG.files[0])
	    
		$.ajax({
			method : "post",
			url : "${cPath}/mypage/updateSignImg.do",
			data : formData,
			dataType : "json",
			contentType : false,
			processData : false,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
				
			},
			success : function(rslt) {
				if(rslt=="success"){
					Swal.fire({
	                    icon: 'success',
	                    title: '성공',
	                    text: "결재 이미지를 등록했습니다.",
					}).then((result) => {
                            location.href = '${cPath}/mypage/atrzSetting.do';
                    })
				}
			}
		})
	}
	const signImg = document.querySelector("#atchBtn");
    const previewImg = document.querySelector("#previewImg");

    signImg.onchange = ()=>{
        let vfile = signImg.files[0];
        let vfileReader = new FileReader(); // 파일 읽어주는 아저씨
        
        vfileReader.onload = () =>{
            let vimg = document.createElement("img");
            vimg.src = vfileReader.result; 
            previewImg.appendChild(vimg);
        }
        
        vfileReader.readAsDataURL(vfile);
    }
	
</script>