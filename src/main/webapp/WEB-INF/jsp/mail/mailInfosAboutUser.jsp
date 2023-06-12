<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="mailSomeonesInfos">
    <div class="grid grid-cols-12 gap-6 mt-8">
        <div class="col-span-12 lg:col-span-3 2xl:col-span-2">
            <h2 class="intro-y text-lg font-medium mr-auto mt-2">
                <spring:message code="level2Menu.mailUser"/>
            </h2>
            <!-- BEGIN: Side Menu -->
            <div id="sideMenu">
                <div class="intro-y box bg-primary p-5 mt-6">
                    <div>
                        <button id="compose" onclick="return fn_writingMail();" type="button"
                                class="btn text-slate-600 dark:text-slate-300 w-full bg-white dark:bg-darkmode-300 dark:border-darkmode-300 mt-1">
                            <i class="w-4 h-4 mr-2" icon-name="edit"></i>
                            <spring:message code="level2Menu.mailCompose"/>
                        </button>
                    </div>
                    <div
                            class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
                        <a id="inbox" href="${cPath}/mail/mailInbox/mailInboxOpen.do"
                           class="flex items-center px-3 py-2 rounded-md font-medium ${level2Menu='mailInbox' ? 'top-menu--active' : ''}">
                            <i class="w-4 h-4 mr-2" icon-name="inbox"></i> <spring:message
                                code="level2Menu.mailInbox"/>
                        </a>
                    </div>
                    <div
                            class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
                        <a id="sent" href="${cPath}/mail/mailSent/sentOpenDB.do"
                           class="flex items-center px-3 py-2 rounded-md font-medium ${level2Menu='mailSent' ? 'top-menu--active' : ''}">
                            <i class="w-4 h-4 mr-2" icon-name="send"></i> <spring:message
                                code="level2Menu.mailSent"/>
                        </a>
                        <a id="draft" href="${cPath}/mail/mailDraft/draftViewOpen.do"
                           class="flex items-center px-3 py-2 rounded-md font-medium ${level2Menu='mailSent' ? 'top-menu--active' : ''}">
                            <i class="w-4 h-4 mr-2" icon-name="files"></i> <spring:message
                                code="level2Menu.mailDraft"/>
                        </a>
                    </div>
<%--                     <div
                            class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
                        <a id="trash" href="${cPath}/mail/mailTrash/mailTrashOpen.do"
                           class="flex items-center px-3 py-2 rounded-md font-medium ${level2Menu='mailInbox' ? 'top-menu--active' : ''}">
                            <i class="w-4 h-4 mr-2" icon-name="trash-2"></i> <spring:message
                                code="level2Menu.mailTrash"/>
                        </a>
                    </div> --%>
                </div>
            </div>
            <!-- END: Side Menu -->
        </div>
        <%-- 본문 표시 --%>
        <div class="col-span-12 lg:col-span-9 2xl:col-span-10">
            <%-- 사용자 프로필 정보 표시 --%>
            <div class="intro-y box col-span-12 2xl:col-span-6 mt-20 mr-1">
                <div class="flex items-center p-5 border-b border-slate-200/60 dark:border-darkmode-400">
                    <h2 class="font-medium text-base mr-auto">
                        ${empName} <spring:message code="level2Menu.mailProfile"/>
                    </h2>
                </div>
                <div class="p-5">
                    <div class="flex items-center" id="emailAddress"><i data-lucide="user-circle" class="w-4 h-4 text-slate-500 mr-2"></i><div class="emailAddress">${emailAddress}</div></div>
                    <div class="flex items-center mt-3"> <i data-lucide="mails" class="w-4 h-4 text-slate-500 mr-2"></i><spring:message code="level2Menu.mailMessagesTotal"/>&nbsp;&nbsp; : &nbsp;&nbsp;<div class="messagesTotal">${messagesTotal}</div> </div>
                    <div class="flex items-center mt-3"> <i data-lucide="rows" class="w-4 h-4 text-slate-500 mr-2"></i><spring:message code="level2Menu.mailThreadsTotal"/>&nbsp;&nbsp; : &nbsp;&nbsp;<div class="threadsTotal">${threadsTotal}</div> </div>
                    <div class="flex items-center mt-3"> <i data-lucide="scroll-text" class="w-4 h-4 text-slate-500 mr-2"></i><spring:message code="level2Menu.mailHistory"/>&nbsp;&nbsp; : &nbsp;&nbsp;<div class="historyId">${historyId}</div> </div>
                </div>
            </div>

        </div>
    </div>

</div>
<!-- END: Inbox Content -->
<script>
    console.log("메일 쓰기 진입");
    /* --------------------- 메일 쓰기 버튼 이벤트 시작 ---------------------- */
    function fn_writing(event) {
        location.href = `${cPath}/mail/mailForm/mailWriteForm.do`;
    }

    var compose = document.querySelector("#compose");
    compose.addEventListener("click", function (event) {
        console.log("메일 쓰기 버튼 클릭")
        fn_writing(event);
    });

    /* --------------------- 메일 쓰기 버튼 이벤트 종료 ---------------------- */
    /* ------------------------- CK 에디터 설정 시작 ------------------------ */
    CKEDITOR.replace(`mailContent`, {
        resize_enabled: false,
        uiColor: '#CCEAEE',
        width: 800,
        height: 400

    });
    /* ------------------------- CK 에디터 설정 종료 ------------------------ */
    /* ------------------------- <select> change 이벤트 시작 ------------------------ */
    var selectedEmails = [];

    /* <select><option> 선택 시 작동*/
    function handleOptionTagClick(e) {
        console.log("메일 계정 클릭 함수 진입");
        var selectedValue = e.target.value;// 클릭하여 선택한 값 변수에 담기
        // e.target.selectedIndex = 0; // 기본 selected 설정해놓은 option으로 돌아가기

        // 선택한 option 값 input에 입력하기
        var mailsAddrInput = document.querySelector("#addrInput");
        mailsAddrInput.value = selectedValue;


        selectedEmails.push(selectedValue);/* 이메일 모으기*/


        /* 새로운 input 생성 */
        var createNewInput = document.createElement("input");
        createNewInput.type = "text";
        createNewInput.id = "addrInput";
        createNewInput.name = "mailSendTo";
        createNewInput.className = "form-control w-full sm:w-72 box px-10";
        createNewInput.placeholder = "<spring:message code="level2Menu.mailSearch"/>";
        createNewInput.oninput = "fn_filterDropDownAddr(e)";

        mailsAddrInput.append(createNewInput);// 기존 input에 추가하기
    }

    var selectBoxElement = document.querySelector("#selectBox");
    selectBoxElement.addEventListener("change", function (e) {
        console.log("메일 쓰기 : 계정 클릭 이벤트 감지");
        handleOptionTagClick(e);
    });
    /* ------------------------- <select> change 이벤트 종료 ------------------------ */

</script>