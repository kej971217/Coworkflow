<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<script>
    var compose = document.querySelector("#compose");
    var aTagInbox = document.querySelector("#inbox");
    var aTagStar = document.querySelector("#star");
    var aTagDraft = document.querySelector("#draft");
    var aTagAll = document.querySelector("#alle");
    var aTagSent = document.querySelector("#sent");
    var aTagSpam = document.querySelector("#spam");
    var aTagTrash = document.querySelector("#trash");
    var aTagArchive = document.querySelector("#archive");


    //--------------------------화면 교체 시작--------------------------
    var divTagStart = `<div class="content">`;
    var divTagEnd = `<div data-url="top-menu-dark-dashboard-overview-1.html" class="dark-mode-switcher cursor-pointer shadow-md fixed bottom-0 right-0 box border rounded-full w-40 h-12 flex items-center justify-center z-50 mb-10 mr-10">`;

    //------------------------------   메일 쓰기 버튼 클릭 ------------------------    -->

    var composeUrl = "${cPath}/mail/mailForm.do";
    composeClickHandler = (event) => {
        event.preventDefault();
        console.log("메일 쓰기 클릭 이벤트 발생 !!!")
        compose.removeEventListener(event.type.toString(), composeClickHandler);

        let xhr = new XMLHttpRequest();
        xhr.open("GET", composeUrl, true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {

                console.log("메일 쓰기 비동기 접근 성공")
                //console.log("문자열 수 1 : %d, 문자열 수 2 : %d", divTagStart.length, divTagEnd.length);

                //console.log(xhr.responseText)

                let startIndex = xhr.responseText.indexOf(divTagStart);
                let endIndex = xhr.responseText.lastIndexOf(divTagEnd);

                console.log("시작 : %d, 끝 : %d", startIndex, endIndex);
                let nestedContent = xhr.responseText.substring(startIndex+divTagStart.length, endIndex);
                //let nestedContent = xhr.responseText.querySelector("div.content").innerHTML;

                console.log(nestedContent);
                let parser = new DOMParser();
                // DOMParser 객체
                // 문자열 형태의 XML 또는 HTML 데이터를 파싱하고,
                // 이를 DOM(Document Object Model) 객체의 트리 형태로 변환하는 JavaScript 내장 객체


                let selectHtml = parser.parseFromString(nestedContent, "text/html");

                document.querySelector(".content").innerHTML = selectHtml.documentElement.innerHTML;

                // document.querySelector(".content").innerHTML = nestedContent;

            } else if (xhr.readyState == 404) {
                console.log("호출한 자료 없음")
            }
        }
        xhr.send();
        return false;
    }


    <!--   ------------------------------   그외 사이드 메뉴 <a> 태그 클릭 ------------------------------    -->
    <!--   ------------------------------   받은 편지함   ------------------------------    -->

    inboxClickHandler = (event) => {
        event.preventDefault();
        console.log("메일 사이드 버튼 클릭 이벤트 발생 !!!")
        aTagInbox.removeEventListener(event.type.toString(), inboxClickHandler);


        let aTagUrl= event.target.dataset.url;
        let xhr = new XMLHttpRequest();
        xhr.open("GET", aTagUrl, true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {

                console.log("메일 사이드 버튼 비동기 접근 성공")
                //console.log("문자열 수 1 : %d, 문자열 수 2 : %d", divTagStart.length, divTagEnd.length);

                //console.log(xhr.responseText)

                let startIndex = xhr.responseText.indexOf(divTagStart);
                let endIndex = xhr.responseText.lastIndexOf(divTagEnd);

                console.log("시작 : %d, 끝 : %d", startIndex, endIndex);
                let nestedContent = xhr.responseText.substring(startIndex+divTagStart.length, endIndex);
                //let nestedContent = xhr.responseText.querySelector("div.content").innerHTML;

                console.log(nestedContent);
                let parser = new DOMParser();
                // DOMParser 객체
                // 문자열 형태의 XML 또는 HTML 데이터를 파싱하고,
                // 이를 DOM(Document Object Model) 객체의 트리 형태로 변환하는 JavaScript 내장 객체


                let selectHtml = parser.parseFromString(nestedContent, "text/html");

                document.querySelector(".content").innerHTML = selectHtml.documentElement.innerHTML;
                // document.querySelector(".content").innerHTML = nestedContent;

            } else if (xhr.readyState == 404) {
                console.log("호출한 자료 없음")
            }
        }
        xhr.send();
        return false;
    };


    <!--   ------------------------------   중요 메일함 ------------------------------    -->

    starMailClickHandler = (event) => {
        event.preventDefault();
        console.log("메일 사이드 버튼 클릭 이벤트 발생 !!!")

        aTagStar.removeEventListener(event.type.toString(), starMailClickHandler);


        let aTagUrl= event.target.dataset.url;

        let xhr = new XMLHttpRequest();
        xhr.open("GET", aTagUrl, true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("메일 사이드 버튼 비동기 접근 성공")
                //console.log("문자열 수 1 : %d, 문자열 수 2 : %d", divTagStart.length, divTagEnd.length);

                //console.log(xhr.responseText)

                let startIndex = xhr.responseText.indexOf(divTagStart);
                let endIndex = xhr.responseText.lastIndexOf(divTagEnd);

                console.log("시작 : %d, 끝 : %d", startIndex, endIndex);
                let nestedContent = xhr.responseText.substring(startIndex+divTagStart.length, endIndex);
                //let nestedContent = xhr.responseText.querySelector("div.content").innerHTML;

                console.log(nestedContent);
                let parser = new DOMParser();
                // DOMParser 객체
                // 문자열 형태의 XML 또는 HTML 데이터를 파싱하고,
                // 이를 DOM(Document Object Model) 객체의 트리 형태로 변환하는 JavaScript 내장 객체


                let selectHtml = parser.parseFromString(nestedContent, "text/html");

                document.querySelector(".content").innerHTML = selectHtml.documentElement.innerHTML;
                // document.querySelector(".content").innerHTML = nestedContent;

            } else if (xhr.readyState == 404) {
                console.log("호출한 자료 없음")
            }
        }
        xhr.send();
        return false;
    };


    <!--   ------------------------------   임시 메일함 ------------------------------    -->

    draftClickHandler = (event) => {
        event.preventDefault();
        console.log("메일 사이드 버튼 클릭 이벤트 발생 !!!")

        aTagDraft.removeEventListener(event.type.toString(), draftClickHandler);

        let aTagUrl= event.target.dataset.url;

        let xhr = new XMLHttpRequest();
        xhr.open("GET", aTagUrl, true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("메일 사이드 버튼 비동기 접근 성공")
                //console.log("문자열 수 1 : %d, 문자열 수 2 : %d", divTagStart.length, divTagEnd.length);

                //console.log(xhr.responseText)

                let startIndex = xhr.responseText.indexOf(divTagStart);
                let endIndex = xhr.responseText.lastIndexOf(divTagEnd);

                console.log("시작 : %d, 끝 : %d", startIndex, endIndex);
                let nestedContent = xhr.responseText.substring(startIndex+divTagStart.length, endIndex);
                //let nestedContent = xhr.responseText.querySelector("div.content").innerHTML;

                console.log(nestedContent);
                let parser = new DOMParser();
                // DOMParser 객체
                // 문자열 형태의 XML 또는 HTML 데이터를 파싱하고,
                // 이를 DOM(Document Object Model) 객체의 트리 형태로 변환하는 JavaScript 내장 객체


                let selectHtml = parser.parseFromString(nestedContent, "text/html");

                document.querySelector(".content").innerHTML = selectHtml.documentElement.innerHTML;
                // document.querySelector(".content").innerHTML = nestedContent;


            } else if (xhr.readyState == 404) {
                console.log("호출한 자료 없음")
            }
        }
        xhr.send();
        return false;
    }


    <!--   ------------------------------   전체 메일함 ------------------------------    -->

    allMailClickHandler = (event) => {
        event.preventDefault();
        console.log("메일 사이드 버튼 클릭 이벤트 발생 !!!")

        aTagAll.removeEventListener(event.type.toString(), allMailClickHandler);

        let aTagUrl= event.target.dataset.url;

        let xhr = new XMLHttpRequest();
        xhr.open("GET", aTagUrl, true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("메일 사이드 버튼 비동기 접근 성공")
                //console.log("문자열 수 1 : %d, 문자열 수 2 : %d", divTagStart.length, divTagEnd.length);

                //console.log(xhr.responseText)

                let startIndex = xhr.responseText.indexOf(divTagStart);
                let endIndex = xhr.responseText.lastIndexOf(divTagEnd);

                console.log("시작 : %d, 끝 : %d", startIndex, endIndex);
                let nestedContent = xhr.responseText.substring(startIndex+divTagStart.length, endIndex);
                //let nestedContent = xhr.responseText.querySelector("div.content").innerHTML;

                console.log(nestedContent);
                let parser = new DOMParser();
                // DOMParser 객체
                // 문자열 형태의 XML 또는 HTML 데이터를 파싱하고,
                // 이를 DOM(Document Object Model) 객체의 트리 형태로 변환하는 JavaScript 내장 객체


                let selectHtml = parser.parseFromString(nestedContent, "text/html");

                document.querySelector(".content").innerHTML = selectHtml.documentElement.innerHTML;
                // document.querySelector(".content").innerHTML = nestedContent;

            } else if (xhr.readyState == 404) {
                console.log("호출한 자료 없음")
            }
        }
        xhr.send();
        return false;
    }


    <!--   ------------------------------   보낸 메일함 ------------------------------    -->

    sentClickHandler = (event) => {
        event.preventDefault();
        console.log("메일 사이드 버튼 클릭 이벤트 발생 !!!")

        aTagSent.removeEventListener(event.type.toString(), sentClickHandler);

        let aTagUrl= event.target.dataset.url;

        let xhr = new XMLHttpRequest();
        xhr.open("GET", aTagUrl, true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("메일 사이드 버튼 비동기 접근 성공")
                //console.log("문자열 수 1 : %d, 문자열 수 2 : %d", divTagStart.length, divTagEnd.length);

                //console.log(xhr.responseText)

                let startIndex = xhr.responseText.indexOf(divTagStart);
                let endIndex = xhr.responseText.lastIndexOf(divTagEnd);

                console.log("시작 : %d, 끝 : %d", startIndex, endIndex);
                let nestedContent = xhr.responseText.substring(startIndex+divTagStart.length, endIndex);
                //let nestedContent = xhr.responseText.querySelector("div.content").innerHTML;

                console.log(nestedContent);
                let parser = new DOMParser();
                // DOMParser 객체
                // 문자열 형태의 XML 또는 HTML 데이터를 파싱하고,
                // 이를 DOM(Document Object Model) 객체의 트리 형태로 변환하는 JavaScript 내장 객체


                let selectHtml = parser.parseFromString(nestedContent, "text/html");

                document.querySelector(".content").innerHTML = selectHtml.documentElement.innerHTML;
                // document.querySelector(".content").innerHTML = nestedContent;

            } else if (xhr.readyState == 404) {
                console.log("호출한 자료 없음")
            }
        }
        xhr.send();
        return false;
    }


    <!--   ------------------------------   스팸 메일함 ------------------------------    -->

    spamClickHandler = (event) => {
        event.preventDefault();
        console.log("메일 사이드 버튼 클릭 이벤트 발생 !!!")

        aTagSpam.removeEventListener(event.type.toString(), spamClickHandler);

        let aTagUrl= event.target.dataset.url;

        let xhr = new XMLHttpRequest();
        xhr.open("GET", aTagUrl, true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("메일 사이드 버튼 비동기 접근 성공")
                //console.log("문자열 수 1 : %d, 문자열 수 2 : %d", divTagStart.length, divTagEnd.length);

                //console.log(xhr.responseText)

                let startIndex = xhr.responseText.indexOf(divTagStart);
                let endIndex = xhr.responseText.lastIndexOf(divTagEnd);

                console.log("시작 : %d, 끝 : %d", startIndex, endIndex);
                let nestedContent = xhr.responseText.substring(startIndex+divTagStart.length, endIndex);
                //let nestedContent = xhr.responseText.querySelector("div.content").innerHTML;

                console.log(nestedContent);
                let parser = new DOMParser();
                // DOMParser 객체
                // 문자열 형태의 XML 또는 HTML 데이터를 파싱하고,
                // 이를 DOM(Document Object Model) 객체의 트리 형태로 변환하는 JavaScript 내장 객체


                let selectHtml = parser.parseFromString(nestedContent, "text/html");

                document.querySelector(".content").innerHTML = selectHtml.documentElement.innerHTML;
                document.querySelector(".content").innerHTML = nestedContent;

            } else if (xhr.readyState == 404) {
                console.log("호출한 자료 없음")
            }
        }
        xhr.send();
        return false;
    };

    <!--   ------------------------------  휴지통  ------------------------------    -->

    trashClickHandler = (event) => {
        event.preventDefault();
        console.log("메일 사이드 버튼 클릭 이벤트 발생 !!!")

        aTagTrash.removeEventListener(event.type.toString(), trashClickHandler);

        let aTagUrl= event.target.dataset.url;

        let xhr = new XMLHttpRequest();
        xhr.open("GET", aTagUrl, true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("메일 사이드 버튼 비동기 접근 성공")
                //console.log("문자열 수 1 : %d, 문자열 수 2 : %d", divTagStart.length, divTagEnd.length);

                //console.log(xhr.responseText)

                let startIndex = xhr.responseText.indexOf(divTagStart);
                let endIndex = xhr.responseText.lastIndexOf(divTagEnd);

                console.log("시작 : %d, 끝 : %d", startIndex, endIndex);
                let nestedContent = xhr.responseText.substring(startIndex+divTagStart.length, endIndex);
                //let nestedContent = xhr.responseText.querySelector("div.content").innerHTML;

                console.log(nestedContent);
                let parser = new DOMParser();
                // DOMParser 객체
                // 문자열 형태의 XML 또는 HTML 데이터를 파싱하고,
                // 이를 DOM(Document Object Model) 객체의 트리 형태로 변환하는 JavaScript 내장 객체


                let selectHtml = parser.parseFromString(nestedContent, "text/html");

                document.querySelector(".content").innerHTML = selectHtml.documentElement.innerHTML;
                // document.querySelector(".content").innerHTML = nestedContent;

            } else if (xhr.readyState == 404) {
                console.log("호출한 자료 없음")
            }
        }
        xhr.send();
        return false;
    }

    <!--   ------------------------------  메일 아카이브  ------------------------------    -->

    archiveClickHandler =  (event) => {
        event.preventDefault();
        console.log("메일 사이드 버튼 클릭 이벤트 발생 !!!")

        aTagArchive.removeEventListener(event.type.toString(), archiveClickHandler);
        let aTagUrl= event.target.dataset.url;

        let xhr = new XMLHttpRequest();
        xhr.open("GET", aTagUrl, true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("메일 사이드 버튼 비동기 접근 성공")
                //console.log("문자열 수 1 : %d, 문자열 수 2 : %d", divTagStart.length, divTagEnd.length);

                //console.log(xhr.responseText)

                let startIndex = xhr.responseText.indexOf(divTagStart);
                let endIndex = xhr.responseText.lastIndexOf(divTagEnd);

                console.log("시작 : %d, 끝 : %d", startIndex, endIndex);
                let nestedContent = xhr.responseText.substring(startIndex+divTagStart.length, endIndex);
                //let nestedContent = xhr.responseText.querySelector("div.content").innerHTML;

                console.log(nestedContent);
                let parser = new DOMParser();
                // DOMParser 객체
                // 문자열 형태의 XML 또는 HTML 데이터를 파싱하고,
                // 이를 DOM(Document Object Model) 객체의 트리 형태로 변환하는 JavaScript 내장 객체


                let selectHtml = parser.parseFromString(nestedContent, "text/html");

                document.querySelector(".content").innerHTML = selectHtml.documentElement.innerHTML;
                // document.querySelector(".content").innerHTML = nestedContent;


            } else if (xhr.readyState == 404) {
                console.log("호출한 자료 없음")
            }
        }
        xhr.send();
        return false;
    }

    <!--    -->
    // compose.addEventListener("click", composeClickHandler);
    // aTagInbox.addEventListener("click", inboxClickHandler);
    // aTagStar.addEventListener("click", starMailClickHandler);
    // aTagDraft.addEventListener("click", draftClickHandler);
    // aTagAll.addEventListener("click", allMailClickHandler);
    // aTagSent.addEventListener("click", sentClickHandler);
    // aTagSpam.addEventListener("click", spamClickHandler);
    // aTagTrash.addEventListener("click", trashClickHandler);
    // aTagArchive.addEventListener("click", archiveClickHandler);

    // var compose = document.querySelector("#compose");
    // var aTagInbox = document.querySelector("#inbox");
    // var aTagStar = document.querySelector("#star");
    // var aTagDraft = document.querySelector("#draft");
    // var aTagAll = document.querySelector("#alle");
    // var aTagSent = document.querySelector("#sent");
    // var aTagSpam = document.querySelector("#spam");
    // var aTagTrash = document.querySelector("#trash");
    // var aTagArchive = document.querySelector("#archive");

    var sideMenu = document.querySelector("#sideMenu");
    sideMenu.addEventListener("click", function(event) {
        console.log("사이드 메뉴 클릭 이벤트 감지");
        if(event.target.tagName === 'A') {
            console.log(event.target.id.toString());
            switch (event.target.id.toString()) {
                case "inbox" : inboxClickHandler(event); break;
                case "star" : starMailClickHandler(event); break;
                case "draft" : draftClickHandler(event); break;
                case "alle" : allMailClickHandler(event); break;
                case "sent" : sentClickHandler(event); break;
                case "spam" : spamClickHandler(event); break;
                case "trash" : trashClickHandler(event); break;
                case "archive" : archiveClickHandler(event); break;
            }
        } else if(event.target.tagName === 'BUTTON') {
            console.log(event.target.id.toString());
            switch (event.target.id.toString()) {
                case "compose": composeClickHandler(event); break;
                default: break;
            }
        }

    })

</script>
<!-- 스크립트 종료 -->