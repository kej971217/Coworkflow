<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<div class="mailDraftBlock">
    <div class="grid grid-cols-12 gap-6 mt-8">
        <div class="col-span-12 lg:col-span-3 2xl:col-span-2">
            <h2 class="intro-y text-lg font-medium mr-auto mt-2 mb-5">
                <spring:message code="level2Menu.mailDraft"/>
            </h2>
            <%-- 메일 좌측 사이드 메뉴 include --%>
            <jsp:include page="/includee/mailLeftMenu.jsp"></jsp:include>
        </div>
        <%--  임시보관함 본문 시작 --%>
        <div class="col-span-12 lg:col-span-9 2xl:col-span-10 pt-5">
            <div class="intro-y inbox box mt-10 ">
                <%-- 본문 상단 부분 시작 --%>
                <div
                        class="p-5 flex flex-col-reverse sm:flex-row text-slate-500 border-b border-slate-200/60">
                    <div
                            class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0">
                        <input class="form-check-input" type="checkbox">
                        <!--  ----------------   메일 새로 고침 --------------  -->
                        <a href="${cPath}/mail/mailDraft/draftListOpen.do"
                           class="w-5 h-5 ml-5 flex items-center justify-center"> <i
                                class="w-4 h-4" icon-name="refresh-cw"></i>
                        </a>
                    </div>
                    <div class="flex items-center sm:ml-auto">
                        <div id="numberOfPages">${rendererPagination}</div>
                    </div>
                </div>
                <%-- 본문 상단 부분 종료 --%>
                <%-- 메일 데이터 표시 영역 시작 --%>
                <div id="mailPagination">
                    <%-- 데이터 항목 표시 --%>

                </div>
                <%-- 메일 데이터 표시 영역 종료 --%>
            </div>
        </div>
        <%-- 임시보관함 본문 종료 --%>
    </div>
</div>
<div id="dataPrintArea" style="display: none">
    <div id="allModel">${mailList}</div>
</div>
<script>
    /* --------------------- 메일 쓰기 버튼 이벤트 시작 ---------------------- */
    function fn_writingMail(event) {
        location.href = `${cPath}/mail/mailForm/mailWriteForm.do`;
    }

    var compose = document.querySelector("#compose");
    compose.addEventListener("click", function (event) {
        console.log("메일 쓰기 버튼 클릭")
        fn_writingMail(event);
    });

    /* --------------------- 메일 쓰기 버튼 이벤트 종료 ---------------------- */

    /* --------------------- 모델 객체 확인 시작(JSON으로 변환) ---------------------- */
    var fromServer = document.querySelector("#dataPrintArea #allModel");
    var serverValue = fromServer.innerHTML;
    serverValue = serverValue.toString();
    /* --------------------- 모델 객체 확인 종료(JSON으로 변환) ---------------------- */

    var mailPagination = document.querySelector("#mailPagination");
    if (serverValue != null && serverValue != "") {
        /* --------------------- 모델 객체 확인 시작(JSON으로 변환) ---------------------- */
        var serverJSON = JSON.parse(serverValue);
        /* --------------------- 모델 객체 확인 종료(JSON으로 변환) ---------------------- */
        /* --------------------- 받은 메일 목록 입력 시작 ---------------------- */
        var startRow = serverJSON['startRow'];
        var endRow = serverJSON['endRow'];
        startRow -= 1;
        endRow -= 1;

        var dataList = serverJSON['dataList'];
        if (dataList != null && dataList.length > 0) {
            for (let i = startRow; i <= endRow; i++) {
                if (dataList.hasOwnProperty(i)) {

                    var mailListIndex = document.createElement("div");
                    mailListIndex.setAttribute("id", "mailListIndex" + i);
                    mailListIndex.setAttribute("class", "intro-y");
                    mailListIndex.style.cursor = "pointer";
                    mailListIndex.setAttribute("data-index", i);
                    mailPagination.appendChild(mailListIndex);
                    var mailListIndexP = document.querySelector("#mailListIndex" + i);

                    var raw1num = document.createElement("div");
                    raw1num.setAttribute("class", "inline-block sm:block text-slate-600 dark:text-slate-500 bg-slate-100 dark:bg-darkmode-400/70 border-b border-slate-200/60 dark:border-darkmode-400");
                    raw1num.setAttribute("id", "raw1num" + i);
                    raw1num.style.background = "white";
                    mailListIndexP.appendChild(raw1num);
                    var raw1numP = document.querySelector("#raw1num" + i);

                    var raw2num = document.createElement("div");
                    raw2num.setAttribute("class", "flex px-5 py-3");
                    raw2num.setAttribute("id", "raw2num" + i);
                    raw1numP.appendChild(raw2num);
                    var raw2numP = document.querySelector("#raw2num" + i);

                    var raw3num = document.createElement("div");
                    raw3num.setAttribute("class", "w-72 flex-none flex items-center mr-5");
                    raw3num.setAttribute("id", "raw3num" + i);
                    raw2numP.appendChild(raw3num);
                    var raw3numP = document.querySelector("#raw3num" + i); /*4*/

                    var raw3num1 = document.createElement("input");/*1*/
                    raw3num1.setAttribute("id", "mailId" + i);
                    raw3num1.style.display = "none";
                    var mailDraftId = dataList[i]['mailDraftId'];
                    raw3num1.value = mailDraftId;
                    raw3numP.appendChild(raw3num1);

                    var raw3num2 = document.createElement("input");/*2*/
                    raw3num2.setAttribute("class", "form-check-input flex-none");
                    raw3num2.type = "checkbox";
                    raw3numP.appendChild(raw3num2);

                    var raw3num3 = document.createElement("a");/*2*/
                    raw3num3.setAttribute("href", "javascript:;");
                    raw3num3.setAttribute("class", "w-5 h-5 flex-none ml-4 flex items-center justify-center text-slate-400");
                    raw3numP.appendChild(raw3num3);

                    var raw3num4 = document.createElement("div");/*3*/
                    raw3num4.setAttribute("class", "inbox__item--sender truncate ml-3");
                    raw3num4.setAttribute("id", "from" + i);
                    raw3numP.appendChild(raw3num4);

                    var raw3num4P = document.querySelector("#from" + i);
                    var mailSendSender = dataList[i]['mailSendSender'];
                    if (mailSendSender != null && mailSendSender) {
                        var fANode = document.createTextNode("나");
                        raw3num4P.appendChild(fANode);
                    }


                    var tArea = document.createElement("div");
                    tArea.setAttribute("id", "clickAMail" + i);
                    tArea.setAttribute("class", "w-64 sm:w-auto truncate");
                    raw2numP.appendChild(tArea);
                    var tAreaP = document.querySelector("#clickAMail" + i);

                    var title = document.createElement("span");
                    title.setAttribute("class", "inbox__item--highlight");
                    tAreaP.appendChild(title);

                    var mailSendTitle = dataList[i]['mailSendTitle'];
                    var mailSnippet = dataList[i]['mailSnippet'];
                    var middle = " - ";
                    var titleNode = document.createTextNode(mailSendTitle);
                    var middleNode = document.createTextNode(middle);
                    var snippNode = document.createTextNode(mailSnippet);
                    title.appendChild(titleNode);
                    title.appendChild(middleNode);
                    title.appendChild(snippNode);


                    var timeArea = document.createElement("div");
                    timeArea.setAttribute("class", "inbox__item--time whitespace-nowrap ml-auto pl-10");
                    timeArea.setAttribute("id", "tick" + i);
                    raw2numP.appendChild(timeArea);
                    var timeAreaP = document.querySelector("#tick" + i);

                    var currentDate = new Date(); /* 값 : Sun Jun 04 2023 17:36:00 GMT+0900 (한국 표준시) */
                    var mailInboxDate = dataList[i]['mailSendDate'];
                    var dataDate = mailInboxDate['date'];
                    var dataTime = mailInboxDate['time'];
                    var dDateTime = new Date(dataDate['year'], dataDate['month']-1, dataDate['day'], dataTime['hour'], dataTime['minute'], dataTime['second']);
                    /* var day = (1000 * 60 * 60 * 24);*//* 밀리초 => 일(day) */
                    /*var differDays = Math.ceil((currentDate - dDateTime) / day);
                    var tick = document.querySelector("#tick" + i); */
                    var year = dDateTime.getFullYear();
                    var month = (dDateTime.getMonth()+1).toString().padStart(2, '0');
                    var day = (dDateTime.getDate()).toString().padStart(2, '0');
                    /* var hour = (dDateTime.getHours()).toString().padStart(2, '0');
                    var min = (dDateTime.getMinutes()).toString().padStart(2, '0'); */
                    var resultdate = year + "-" + month + "-" + day;
                    /* var resulttime = hour + ":" + min; */
                    var dTNode = document.createTextNode(resultdate);
                    /* var tTNode = document.createTextNode(resulttime);
                    if (differDays < 1) { */
                        /* 메일 받은 날 = 열람 날 */
                        timeAreaP.appendChild(dTNode);
                   /*  } else { */
                        /* 메일 받은 날 -시간 흐름-> 열람 날 */
                       /*  timeAreaP.appendChild(tTNode);
                    } */
                }
            }

        } else {
            var mailListIndex = document.createElement("div");
            mailListIndex.setAttribute("id", "mailListIndex");
            mailListIndex.setAttribute("class", "intro-y");
            mailListIndex.style.cursor = "pointer";
            mailPagination.appendChild(mailListIndex);
            var mailListIndexP = document.querySelector("#mailListIndex");

            var raw1num = document.createElement("div");
            raw1num.setAttribute("class", "inline-block sm:block text-slate-600 dark:text-slate-500 bg-slate-100 dark:bg-darkmode-400/70 border-b border-slate-200/60 dark:border-darkmode-400");
            raw1num.setAttribute("id", "raw1num");
            raw1num.style.background = "white";
            mailListIndexP.appendChild(raw1num);
            var raw1numP = document.querySelector("#raw1num");

            var raw2num = document.createElement("div");
            raw2num.setAttribute("class", "flex px-5 py-3");
            raw2num.setAttribute("id", "raw2num");
            raw1numP.appendChild(raw2num);
            var raw2numP = document.querySelector("#raw2num");


            var noNode = document.createTextNode("임시보관 메일이 없습니다.");
            raw2numP.appendChild(noNode);
        }
    } else {
        var mailListIndex = document.createElement("div");
        mailListIndex.setAttribute("id", "mailListIndex");
        mailListIndex.setAttribute("class", "intro-y");
        mailListIndex.style.cursor = "pointer";
        mailPagination.appendChild(mailListIndex);
        var mailListIndexP = document.querySelector("#mailListIndex");

        var raw1num = document.createElement("div");
        raw1num.setAttribute("class", "inline-block sm:block text-slate-600 dark:text-slate-500 bg-slate-100 dark:bg-darkmode-400/70 border-b border-slate-200/60 dark:border-darkmode-400");
        raw1num.setAttribute("id", "raw1num");
        raw1num.style.background = "white";
        mailListIndexP.appendChild(raw1num);
        var raw1numP = document.querySelector("#raw1num");

        var raw2num = document.createElement("div");
        raw2num.setAttribute("class", "flex px-5 py-3");
        raw2num.setAttribute("id", "raw2num");
        raw1numP.appendChild(raw2num);
        var raw2numP = document.querySelector("#raw2num");


        var noNode = document.createTextNode("임시보관 메일이 없습니다.");
        raw2numP.appendChild(noNode);
    }
        /* --------------------- 받은 메일 목록 입력 종료 ---------------------- */
        /* --------------------- 페이지 버튼 이벤트 시작 ---------------------- */
        var mailPagination = document.querySelector("#mailPagination");
        /* --------------------- 페이지 버튼 이벤트 시작 ---------------------- */

        /* --------------------- 페이지 열기 이벤트 시작 ---------------------- */
        function fn_paging(pageNumber, event) {
            console.log("fn_paging 진입");
            location.href = `${cPath}/mail/mailDraft/choicePage.do?page=` + pageNumber;
        }

        fn_viewMail = (e) => {
            var clickedRow = e.target.closest(".intro-y"); // 클래스 선택자를 사용
            if (clickedRow) {
                var dataIndex = clickedRow.getAttribute('data-index'); // data-index 속성값 가져오기
                console.log(dataIndex); // 확인용 로그
            }
            var index = clickedRow.dataset.index;

            var mailId = document.querySelector("#mailId" + index).value;

            location.href = "${cPath}/mail/mailDraft/choiceMail.do?what=" + mailId;
        }

        mailPagination.addEventListener("click", function (e) {
            console.log("메일 행 클릭 이벤트 감지");
            fn_viewMail(e);
        });
    /* --------------------- 페이지 열기 이벤트 시작 ---------------------- */


</script>