<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script src="${cPath}/resources/js/ckeditor/ckeditor.js"></script>
<%-- CK 에디터 --%>
<div class="grid grid-cols-12 gap-6 mt-8">
	<%-- 바디 전체 --%>
	<%-- 사이드 메뉴 시작 --%>
	<div class="col-span-12 lg:col-span-3 2xl:col-span-2">

		<h2 class="intro-y text-lg font-medium mr-auto mt-2">
			<spring:message code="level2Menu.mailDraft" />
		</h2>
		<%-- 메일 좌측 사이드 메뉴 include --%>
		<jsp:include page="/includee/mailLeftMenu.jsp"></jsp:include>
	</div>
	<%-- 사이드 메뉴 종료 --%>


	<%-- 임시보관 메일 본문 시작 --%>
	<div id="contentBody"
		class="col-span-12 lg:col-span-9 2xl:col-span-10 mt-10">

		<form id="emailForm" method="post" enctype="multipart/form-data">

			<security:csrfInput />
			<%-- 받는 사람 입력 시작 --%>
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
					class="intro-y flex flex-col-reverse sm:flex-row items-center pb-5 mt-5 ml-1">
					<%-- 받는 사람 입력 라인 --%>
					<div class="w-20">
						<label class="mailReceiver text-slate-500 font-semibold">받는
							사람</label>
					</div>

					<div class="relative w-auto mr-auto mt-5 sm:mt-0">
						<%-- 받는 사람 입력칸 종료 --%>
						<%--<div id="toAddr">--%>
						<input id="addrInput" name="mailSendToList" type="text"
							class="form-control w-full sm:w-72 box px-10 text-slate-500"
							style="min-width: 720px; min-height: 45px; border: solid 1px #ddd;"
							placeholder="메일 계정 입력">
						<%-- 계정 불러오기 시작 --%>
						<div id="selectedAddr"
							class="inbox-filter dropdown absolute inset-y-0 mr-3 right-0 flex items-center"
							data-tw-placement="bottom-start">
							<%-- 계정 선택 버튼 Block 시작 --%>
							<i id="addrIcon"
								class="dropdown-toggle w-4 h-4 mt-2 cursor-pointer text-slate-500"
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
						<%-- 계정 불러오기 종료 --%>
						<%--</div>--%>
						<%-- 받는 사람 입력칸 종료 --%>
					</div>
					<%-- 계정 선택 버튼 Block 종료 --%>
				</div>
				<%-- 임시보관함 식별자 시작 --%>
				<div id="temp">
					<input name="mailDraftId" style="display: none" />
				</div>
				<%-- 임시보관함 식별자 종료 --%>

				<%-- 받는 사람 입력 종료 --%>
				<hr>

				<%-- 제목 입력 시작 --%>
				<div
					class="p-5 flex flex-col-reverse sm:flex-row text-slate-500 border-b border-slate-200/60">
					<div class="flex items-center w-20 font-semibold">제목</div>
					<input type="text" id="subject"
						class="form-control w-full sm:w-72 box px-10 font-semibold"
						style="min-width: 720px; min-height: 45px; border: solid 1px #ddd;"
						name="mailSendSubject"> <input type="text" id="dqi"
						name="mailDraftId" style="display: none">
				</div>
				<%-- 제목 입력 종료 --%>

				<hr>


				<%-- 내용 입력 시작 --%>
				<div
					class="p-5 flex flex-col-reverse sm:flex-row text-slate-500 border-b border-slate-200/60">
					<%-- 컨텐트 부분 시작 --%>
					<div
						class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0">


						<textarea id="mailContent" class="w-full h-full"
							name="mailSendContent">

                                </textarea>


					</div>
				</div>
				<%-- 내용 입력 종료 --%>


				<hr>
				<%-- 첨부파일 입력 칸 시작 --%>
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
				<%-- 첨부파일 입력 칸 시작 --%>


				<hr>


				<%-- 버튼 Block 시작 --%>
				<div
					class="intro-y flex flex-col-reverse sm:flex-row items-center justify-end   mt-5 pb-5">
					<%-- 임시 보관 버튼 시작 --%>
					<div class="w-full sm:w-auto flex">
						<button id="sendingDraftBtn" class="btn btn-secondary mr-2">
							<spring:message code="level2Menu.mailDraftSave" />
						</button>
					</div>
					<%-- 임시 보관 버튼 끝 --%>

					<%-- 메일 보내기 버튼 시작 --%>
					<div class="w-full sm:w-auto flex">
						<button id="sendingMailBtn" class="btn btn-primary mr-2">
							<spring:message code="level2Menu.mailSendEmail" />
						</button>
					</div>
					<%-- 메일 보내기 버튼 끝--%>
				</div>
				<%-- 버튼 Block 종료 --%>
			</div>
		</form>
	</div>
	<%-- 임시보관 메일 본문 종료 --%>
</div>


<div id="dataPrintArea" style="display: none">
	<div id="allModel">${getEmailList}</div>
</div>
<script>
    /* console.log("임시보관 다시 작성하기 진입"); */

    /* --------------------- 메일 쓰기 버튼 이벤트 시작 ---------------------- */
    function fn_writing(event) {
        location.href = `${cPath}/mail/mailForm/mailWriteForm.do`;
    }

    var compose = document.querySelector("#compose");
    compose.addEventListener("click", function (event) {
        /* console.log("메일 쓰기 버튼 클릭") */
        fn_writing(event);
    });

    /* --------------------- 메일 쓰기 버튼 이벤트 종료 ---------------------- */

    /* ------------------------- <select> change 이벤트 시작 ------------------------ */

    /* <select><option> 선택 시 작동*/
    function handleOptionTagClick(e) {
        /* console.log("메일 계정 클릭 함수 진입"); */
        var selectedValue = e.target.value;// 클릭하여 선택한 값 변수에 담기
        /* console.log("선택 값 확인 : ", selectedValue); */

        // 선택한 option 값 input에 입력하기
        var mailsAddrInput = document.querySelector("#addrInput");
        mailsAddrInput.value = selectedValue;
        mailsAddrInput.innerHTML = selectedValue;

        e.target.selectedIndex = 0; // 기본 selected 설정해놓은 option으로 돌아가기
    }

    var selectBoxElement = document.querySelector("#selectBox");
    selectBoxElement.addEventListener("change", function (e) {
        /* console.log("메일 쓰기 : 계정 클릭 이벤트 감지"); */
        handleOptionTagClick(e);
    });
    /* ------------------------- <select> change 이벤트 종료 ------------------------ */

    /* ------------------------- CK 에디터 설정 시작 ------------------------ */
    var editor = CKEDITOR.replace(`mailContent`, {
        resize_enabled: false,
        uiColor: '#CCEAEE',
        width: 800,
        height: 400
    });
    /* ------------------------- CK 에디터 설정 종료 ------------------------ */

    /* --------------------- 모델 객체 확인 시작(JSON으로 변환) ---------------------- */
    var fromServer = document.querySelector("#dataPrintArea #allModel");
    var serverValue = fromServer.innerHTML;
    serverValue = serverValue.toString();
    var serverJSON = JSON.parse(serverValue);
    /* --------------------- 모델 객체 확인 종료(JSON으로 변환) ---------------------- */
    /* --------------------- 임시보관 메일 열람 시작 ---------------------- */
    if (serverJSON.length > 0) {
        var addrInput = document.querySelector("#addrInput");
        var receive = serverJSON[0]['mailSendReceiver'];
        if (receive != null || receive) {
            addrInput.value = serverJSON[0]['mailSendReceiver'];
        }


        var subject = document.querySelector("#subject");
        var title = serverJSON[0]['mailSendTitle'];
        if (title != null || title) {
            subject.value = title;
        }


        var dqi = document.querySelector("#dqi");
        var dq = serverJSON[0]['mailDraftId'];
        if (dq != null || dq) {
            dqi.value = dq;
            /* alert("임시보관 식별자 : "+dqi.value) */
        }

        var content = document.querySelector("#mailContent");
        var cont = serverJSON[0]['mailSendContent'];
        if (cont != null || cont) {
            content.innerHTML = cont;
        }


        /*var filesArea = document.querySelector("#filesArea");
        var mailItem = serverJSON[0];
        if (mailItem.hasOwnProperty("mailAttachmentId") > 0) {
            for (let i = 0; i < serverJSON.length; i++) {
                var fdiv = document.createElement("div");
                fdiv.setAttribute("id", "fnum"+i);
                filesArea.appendChild(fdiv);

                var click = document.createElement("a");
                click.setAttribute("id", "attachS" + i);
                click.setAttribute("class", "ml-4 mt-2 mb-2");
                click.setAttribute("data-index", i);
                click.style.display = "inline-block";
                var mid = mailItem['mailMessageId'];
                var did = mailItem['mailDraftId']
                var aid = mailItem['mailAttachmentId'];
                click.href = "



        ${cPath}/mail/mailDraft/attachDown.do?what=" + did + "&for=" + aid;
                var aname = mailItem['mailAttachmentName'];
                click.download = aname;
                fdiv.appendChild(click);
                var clickP = document.querySelector("#attachS" + i);

                /!*        var aTag = document.getElementsByName("a");*!/
                var asize = mailItem['mailAttachmentName'];
                var fsize = document.createTextNode(asize);
                clickP.appendChild(fsize);

                var asize = mailItem['mailAttachmentSize'];
                var area = document.createElement("div");
                area.setAttribute("id", "fileSizeArea" + i);
                area.setAttribute("class", "here");
                area.style.display = "inline-block";
                fdiv.appendChild(area);


                /!* --------------------- 첨부파일 사이즈 이벤트 시작 ---------------------- *!/
                var attachSByte = asize
                console.log("attachSByte : %s", attachSByte);
                var attachSizeKB;
                var attachSizeMB;
                var fileSizeArea = document.querySelector("#fileSizeArea" + i);
                if (Math.floor(attachSByte / 1024) > 0) {
                    attachSizeKB = Math.floor(attachSByte / 1024) + " KB";
                    fileSizeArea.innerHTML = " (" + attachSizeKB + ")";
                    if (Math.floor(attachSizeKB / 1024) > 0) {
                        attachSizeMB = Math.floor(attachSizeKB / 1024) + " MB";
                        fileSizeArea.innerHTML = " (" + attachSizeMB + ")";
                    }
                }
                /!* --------------------- 첨부파일 사이즈 이벤트 종료 ---------------------- *!/

                /!* -------------------- 첨부파일 전송 포함 여부 정보 블록 시작 -------------------- *!/
                var finput = document.createElement("input");
                finput.setAttribute("id", "finfo"+i);
                finput.setAttribute("name", "fileList");
                /!*finput.type = "hidden";*!/
                finput.value = aid;
                fdiv.appendChild(finput);

                /!* -------------------- 첨부파일 전송 포함 여부 정보 블록 종료 -------------------- *!/

                /!* -------------------- 첨부파일 삭제 버튼 시작 -------------------- *!/
                var dbtn = document.createElement("button");
                dbtn.setAttribute("id", "del" + i);
                dbtn.setAttribute("class", "ml-2 mb-0");
                dbtn.style.display = "inline-block";
                fdiv.appendChild(dbtn);

                var minus = document.createElement("i");
                minus.setAttribute("icon-name", "x-octagon");
                dbtn.appendChild(minus);

                document.querySelector("#del" + i).addEventListener("click", function(e) {
                    e.preventDefault();
                    var fElements = document.querySelector("#fnum"+i);
                    fElements.remove();
                    var fbeing = document.querySelector("#finfo"+i);
                    fbeing.value = "";
                    return false;
                });
                /!* -------------------- 첨부파일 삭제 버튼 종료 -------------------- *!/


                var br = document.createElement("br");
                fdiv.appendChild(br);
            }
        }*/

    }


    /* --------------------- 임시보관 메일 열람 종료 ---------------------- */

    formSend = document.querySelector("#emailForm");
    sendingMailBtn = document.querySelector("#sendingMailBtn");
    /* console.log("sendingMailBtn : "+ sendingMailBtn); */
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
        sendingTo("${cPath}/mail/mailForm/draftUpdate.do", formDraft);
        return false;
    });
    /* --------------------- 메일 임시보관 버튼 이벤트 종료 ---------------------- */
    /* --------------------- 메일 전송 버튼 이벤트 시작 ---------------------- */

    var alarmAddr = document.querySelector("#addrInput");/* 주소 */
    var regex = /^[a-zA-Z0-9._%+-]{6,30}@gmail\.com$/;


    var title = document.querySelector("#subject");
    var text = document.querySelector("#mailContent");

    sendingMailBtn.addEventListener("click", function (e) {
        e.preventDefault();
        /* console.log("메일 보내기 클릭 이벤트"); */

        var inputA = alarmAddr.value;
        var titleV = title.value;
        /* var textV = text.textContent; */
        var textV = editor.getData();


        function validateFields() {
            var missingFields = [];

            if (!regex.test(inputA)) {
                missingFields.push("메일 계정");
                /* alert("계정 입력 확인 : "+inputA) */
            }

            if (titleV.length === 0) {
                missingFields.push("제목");
                /* alert("제목 입력 확인 : "+titleV) */
            }

            if (textV.length === 0) {
                missingFields.push("내용");
                /* alert("내용 입력 확인 : "+textV) */
            }

            if (missingFields.length > 0) {
                let missingFieldsText = missingFields.join(", ");
                /*  alert(missingFieldsText); */
                Swal.fire({
                    icon: 'error',
                    title: 'Alert',
                    text: missingFieldsText + '을(를) 입력하세요.'
                });
            } else {
                // 모든 조건이 만족됨 (계정, 제목, 내용 모두 유효)
                /* alert("주소, 제목, 내용 조건 유효 : " + inputA); */
                sendingTo("${cPath}/mail/mailForm/mailDraftFinalSend.do", formSend);
            }

        }


        // 함수를 호출하여 유효성 검사 실행
        validateFields();


        return false;
    });

    /* --------------------- 메일 전송 버튼 이벤트 종료 ---------------------- */
</script>