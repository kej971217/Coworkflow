<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<script src="${cPath}/resources/js/ckeditor/ckeditor.js"></script>
<%-- CK 에디터 --%>


<div class="grid grid-cols-12 gap-6 mt-8">
	<%-- 바디 전체 --%>
	<div class="col-span-12 lg:col-span-3 2xl:col-span-2">
		<%-- 좌측 Bar --%>
		<h2 class="intro-y text-lg font-medium mr-auto mt-2">
			<spring:message code="level2Menu.mailCompose" />
		</h2>
		<%-- 메일 좌측 사이드 메뉴 include --%>
		<jsp:include page="/includee/mailLeftMenu.jsp"></jsp:include>
	</div>
	<%-- 좌측 Bar 종료 --%>


	<div id="contentBody"
		class="col-span-12 lg:col-span-9 2xl:col-span-10 mt-10">

		<div class="intro-y flex flex-col-reverse sm:flex-row items-center">

		</div>

		<form id="emailForm" method="post" enctype="multipart/form-data">
			<security:csrfInput />
			<!-- BEGIN: Inbox Filter -->
			<div class="intro-y inbox box mt-5 pt-3 pl-5 pr-5">
				<div
					class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0">
					<!--  ----------------   메일 새로 고침 --------------  -->
					<a href="javascript:history.back()"
						class="w-5 h-5 flex items-center justify-center"> <i
						class="w-4 h-4" icon-name="chevron-left"></i>
					</a>
				</div>
				<hr>
				<div
					class="intro-y flex flex-col-reverse sm:flex-row items-center p-5">
					<%-- 받는 사람 입력 라인 --%>
					<div class="w-20">
						<label class="mailReceiver text-slate-500 font-semibold"><spring:message
								code="level2Menu.mailTo" /></label>
						<%-- 받는 사람 문자 표시 --%>
					</div>

					<div class="relative w-auto mr-auto mt-5 sm:mt-0">
						<%-- 메일 받는 사람 입력 --%>
						<input id="addrInput" name="mailSendToList" type="text"
							class="form-control w-full sm:w-72 box px-10 text-slate-500"
							style="min-width: 720px; min-height: 45px; border: solid 1px #ddd;"
							placeholder="<spring:message code="level2Menu.mailSearch"/>">


						<div
							class="inbox-filter dropdown absolute inset-y-0 mr-3 right-0 flex items-center"
							data-tw-placement="bottom-start">
							<%-- 계정 선택 버튼 Block 시작 --%>
							<i id="addrIcon"
								class="dropdown-toggle w-4 h-4 cursor-pointer text-slate-500"
								role="button" aria-expanded="false" data-tw-toggle="dropdown"
								icon-name="text"></i>
							<div class="inbox-filter__dropdown-menu dropdown-menu pt-2">
								<div class="dropdown-content"
									style="width: 400px; display: flex;">
									<div class="grid grid-cols-12 gap-4 gap-y-3 p-3"
										style="width: 100%;">
										<%--                                        1. 이메일을 가진 직원 목록 : savedEmp--%>
										<%--  참고 1. 전체 직원 목록 : empList : empId, empName, infoEmail--%>
										<div class="col-span-12">
											<div
												class="sm:grid grid-cols-6 gap-2 flex-1 pt-1 col-span-12">
												<select id="selectBox" name="selectBox"
													class="form-select col-span-12" style="width: 100%;">
													<%-- 1. 이메일을 가진 직원 목록 : totalEmpEmailList List<MailSendVO> --%>
													<%-- 참고 1. 전체 직원 목록 : empList : empId, empName, infoEmail--%>
													<option selected>이메일 계정을 선택하십시오.</option>
													<c:forEach items="${totalEmpEmailList}" var="mailSendVO"
														varStatus="status">
														<option value="${mailSendVO.infoEmail}">
															${mailSendVO.empName}&nbsp│&nbsp${mailSendVO.infoEmail}</option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<%-- 계정 선택 버튼 Block 종료 --%>


				</div>
				<hr class="border-0">
				<div id="mailsAddrInput">
					<%-- 계정 입력 Input Block 시작--%>
				</div>
				<%-- 계정 입력 Input Block 종료 --%>

				<hr>

				<div
					class="p-5 flex flex-col-reverse sm:flex-row text-slate-500 border-b border-slate-200/60">
					<div class="flex items-center w-20 font-semibold">제목</div>
					<input type="text" class="form-control w-full sm:w-72 box px-10"
						style="min-width: 720px; min-height: 45px; border: solid 1px #ddd;"
						name="mailSendSubject">
				</div>

				<hr class="border-0">


				<div
					class="p-5 flex flex-col-reverse sm:flex-row text-slate-500 border-b border-slate-200/60">
					<%-- 컨텐트 부분 시작 --%>
					<div
						class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0">


						<textarea id="mailContent" class="w-full h-full"
							name="mailSendContent"></textarea>


					</div>
				</div>

				<hr class="border-0">

				<div
					class="p-5 flex flex-col-reverse sm:flex-row text-slate-500 border-b border-slate-200/60">
					<%-- 첨부파일 부분 시작 --%>
					<div
						class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0">

						<div id="filesContainer">
							<div id="filesInputWrapper" class="flex">
								<!--                                 <div class="inline-block mr-4 flex items-center">        -->
								<!--                                     <label for="files">첨부 파일</label> -->
								<!--                                 </div> -->
								<div id="filesBlock" class="inline-block flex">
									<label for="files" class="flex items-center align-center"><i
										id="filesIcon" class="w-4 h-4 mr-2 " icon-name="plus-square"></i>
										파일첨부 </label> <input type="file" class="flex" multiple id="files"
										name="fileList"
										onchange=" $('#fakeFileName').val(this.value.replace('C:\\fakepath\\','') ); ">
									<input type="text" id="fakeFileName">
								</div>
							</div>
						</div>

					</div>
				</div>
				<%-- 컨텐트 부분 종료 --%>

				<hr class="border-0">


				<div
					class="intro-y flex flex-col-reverse sm:flex-row items-center justify-end   mt-5 pb-5">
					<%-- 버튼 Block 종료 --%>
					<div class="w-full sm:w-auto flex">
						<%-- 임시 보관 버튼 --%>
						<button id="sendingDraftBtn" class="btn btn-secondary mr-2">
							<spring:message code="level2Menu.mailDraftSave" />
						</button>
					</div>
					<%-- 임시 보관 버튼 끝 --%>

					<div class="w-full sm:w-auto flex">
						<%-- 메일 보내기 버튼 --%>
						<button id="sendingMailBtn" class="btn btn-primary mr-2">
							<spring:message code="level2Menu.mailSendEmail" />
						</button>
					</div>
					<%-- 메일 보내기 버튼 끝--%>
				</div>
				<%-- 버튼 Block 종료 --%>


			</div>

		</form>
		<!-- END: Content -->
	</div>
</div>

<script>
    /* ------------------------- CK 에디터 설정 시작 ------------------------ */
    CKEDITOR.replace(`mailContent`, {
        resize_enabled: false,
        uiColor: '#CCEAEE',
        width: 800,
        height: 400

    });
    /* ------------------------- CK 에디터 설정 종료 ------------------------ */

    /* --------------------- 메일 쓰기 버튼 이벤트 시작 ---------------------- */
    function fn_writingMail(event) {
        location.href = `${cPath}/mail/mailForm/mailWriteForm.do`;
    }

    var compose = document.querySelector("#compose");
    compose.addEventListener("click", function (event) {
        /* console.log("메일 쓰기 버튼 클릭") */
        fn_writingMail(event);
    });

    /* --------------------- 메일 쓰기 버튼 이벤트 종료 ---------------------- */

    /* ------------------------- <select> change 이벤트 시작 ------------------------ */

    /* <select><option> 선택 시 작동*/
    function handleOptionTagClick(e) {
        /* console.log("메일 계정 클릭 함수 진입"); */
        var selectedValue = e.target.value;// 클릭하여 선택한 값 변수에 담기
        /* console.log("선택 값 확인 : %s", selectedValue); */

        // 선택한 option 값 input에 입력하기
        var mailsAddrInput = document.querySelector("#addrInput");
        mailsAddrInput.value = selectedValue;
        mailsAddrInput.innerHTML = selectedValue;

        /*selectedEmails.push(selectedValue);/!* 이메일 모으기*!/*/

        /* 새로운 input 생성 */
        /*        var createNewInput = document.createElement("input");
                createNewInput.type = "text";
                createNewInput.id = "mailsAddrInput";
                createNewInput.name = "mailsAddrInput";
                createNewInput.className = "form-control w-full sm:w-72 box px-10";
                createNewInput.placeholder = "
        <spring:message code="level2Menu.mailSearch"/>";
        createNewInput.oninput = "fn_filterDropDownAddr(e)";

        mailsAddrInput.append(createNewInput);// 기존 input에 추가하기*/

        e.target.selectedIndex = 0; // 기본 selected 설정해놓은 option으로 돌아가기
    }
    var selectBoxElement = document.querySelector("#selectBox");
    selectBoxElement.addEventListener("change", function (e) {
        /* console.log("메일 쓰기 : 계정 클릭 이벤트 감지"); */
        handleOptionTagClick(e);
    });
    /* ------------------------- <select> change 이벤트 종료 ------------------------ */
    /* --------------------- 메일 전송 버튼 함수 시작 ---------------------- */
    sendingTo = (url, form) => {
        form.action = url;//폼 전송 url 설정
        form.submit();//폼 전송
    }
    /* --------------------- 메일 전송 버튼 함수 종료 ---------------------- */
    /* --------------------- 메일 임시보관 버튼 이벤트 시작 ---------------------- */
    var formDraft = document.querySelector("#emailForm");
    var savingDraftBtn = document.querySelector("#sendingDraftBtn");
    savingDraftBtn.addEventListener("click", function (e) {
        e.preventDefault();
        /* alert("임시보관") */
        sendingTo("${cPath}/mail/mailForm/draftSend.do", formDraft);
        return false;
    });
    /* --------------------- 메일 임시보관 버튼 이벤트 종료 ---------------------- */
    /* --------------------- 메일 전송 버튼 이벤트 시작 ---------------------- */
    var formSend = document.querySelector("#emailForm");
    var sendingMailBtn = document.querySelector("#sendingMailBtn");

    sendingMailBtn.addEventListener("click", function (e) {
        e.preventDefault();
        /* alert("전송") */
        sendingTo("${cPath}/mail/mailForm/mailSend.do", formSend);
        return false;
    });

    /* --------------------- 메일 전송 버튼 이벤트 종료 ---------------------- */


</script>