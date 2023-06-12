<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<script>
    console.log("사용자 프로필 정보 페이지 뷰 진입");
    var loading = document.querySelector(".mailSomeonesInfos");
    var it = document.querySelector(".from");
    while (false) {
        /* 화면 보여주기 조정 : 로딩 중에 안보이게 */
        it.style.display = "none";/*이건 계속 안 보여야 함*/
        loading.style.display = "none";
    }

    /* 구글 리소스 요청 기본 정보 */
    var empId = document.querySelector(".empId").value;
    var userId = document.querySelector(".userId").value;
    var accessToken = document.querySelector(".accessToken").value;
    console.log("사용자 아이디 : %s", empId);
    console.log("userId(이메일 주소) : %s", userId);
    console.log("accessToken : %s", accessToken);

    var idForMessage;
    var pagingResultSize;
    var ids = [];/* 배열 */
    var threadIds = [];
    var messageURLs = [];
    let idForUrl = [];


    getInboxMessage = (userId, accessToken, ids, threadIds) => {
        console.log("───────────────────────────────────────────────")
        console.log("메세지의 세부정보 가져오기 getInboxMessage 함수 실행");

        console.log(" id 들 : %s", ids);

        /* GET https://gmail.googleapis.com/gmail/v1/users/{지메일계정}/messages/{메세지목록에서 받은 id}  */
        /* 메시지 반복 요청 */
        for (var i = 0; i < ids.length; i++) {
            console.log(" --- < 요청 반복문 > ---")
            console.log(" 이메일 주소 : %s", userId);
            console.log(" id 값 : %s", ids[i]);
            // let idForUrl = ids[0]
            /* 요청 URL */
            <%--var url = `https://gmail.googleapis.com/gmail/v1/users/${userId}/messages/${ids[i]}`;--%>
            var url = "https://gmail.googleapis.com/gmail/v1/users/" + userId + "messages/" + ids[i] +"?key=AIzaSyCOwPq-pOFcNjofxYGWcnKPAa5TrOWw-0M";
            console.log(" 요청 url : https://gmail.googleapis.com/gmail/v1/users/" + userId + "messages/" + ids[i]);
            messageURLs[i] = url;
        }

        for (var i = 0; i < messageURLs.length; i++) {
            console.log("messageURLs", messageURLs[i]);/* 이메일 주소 제대로 담았는지 확인 */
        }
        var authHearValue = `Bearer ${accessToken}`;/* 요청 헤더 필수 정보 1 */
        var AccessControlAllowOrigin = "https://gmail.googleapis.com";
        let xhr = new XMLHttpRequest();
        for (var i = 0; i < messageURLs.length; i++) {
            xhr.open("GET", messageURLs[i], true);
            xhr.setRequestHeader("Accept", "application/json; charset=utf-8");
            xhr.setRequestHeader("Authorization", authHearValue);
            xhr.setRequestHeader("Origin", AccessControlAllowOrigin);
            xhr.onreadystatechange = () => {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    console.log("메세지 세부정보 비동기 요청 성공");
                    console.log("메세지 세부정보 응답 : %s", JSON.stringify(xhr.responseText));
                } else if (xhr.status == 401) {
                    console.log("오류 : %s", 401);
                    console.log("요청한 리소스에 대한 인증 실패");
                    console.log("Gmail API : 액세스 토큰 확인 필요");

                } else if (xhr.status == 400) {
                    console.log("오류 : %s", 400);
                    console.log("서버가 응답을 받았으나, 클라이언트 측에서 잘못된 요청을 보내서 처리 불가")
                    console.log("응답 데이터 : %s", xhr.responseText);

                    return;
                } else if (xhr.status == 403) {
                    console.log("오류 : %s", 403);
                    console.log("서버가 요청을 이해했으나, 인가를 거부");
                    console.log("스프링 프레임워크를 사용하는 경우, 스프링 시큐리티 메타 태그 확인 바람");
                    console.log("응답 데이터 : %s", xhr.responseText);
                    console.log(xhr.statusText);

                    return;

                } else if (xhr.status == 404) {
                    console.log("오류 : %s", 404);
                    console.log("요청 페이지 없음");
                    console.log("응답 데이터 : %s", xhr.responseText);

                    return;
                } else if (xhr.status == 415) {
                    console.log("오류 : %s", 415);
                    console.log("클라이언트가 요청한 미디어 타입(데이터 형식)이 지원하지 않음");
                    console.log("응답 데이터 : %s", xhr.responseText);

                    return;
                } else {
                    console.log("메세지 세부 정보 비동기 접근 실패");
                    console.log("응답 데이터 : %s", xhr.responseText);

                    return;
                }
            };
            xhr.send();
        }


    };

    /* 메세지 목록 가져오기 : 메세지의 id 와 threadId 필요할 떄 사용 */
    getInboxMessageList = (userId, accessToken) => {
        console.log("편지함에 있는 메시지 목록 나열 함수 실행");

        /* 요청 URL */
        var url = `https://gmail.googleapis.com/gmail/v1/users/${userId}/messages`;

        console.log("url", url);/* 이메일 주소 제대로 담았는지 확인 */
        var authHearValue = `Bearer ${accessToken}`;/* 요청 헤더 필수 정보 1 */

        let xhr = new XMLHttpRequest();
        xhr.open("GET", url, true);/* 동기 요청 */
        xhr.setRequestHeader("Accept", "text/html;charset=UTF-8");/* 요청 헤더 필수 정보 2 */
        xhr.setRequestHeader("Authorization", authHearValue);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("getInboxMessage 비동기 요청 성공");
                console.log("메세지 목록 응답 : %s", xhr.responseText);
                /*
                * 응답 형식
                * {
                *    "messages": [ 객체, 메시지 목록
                *                    {
                *                        "id": "1880eab9cbb4a242",메시지의 id
                *                        "threadId": "1880eab9cbb4a242"
                *                    },
                *                    {
                *                        "id": "188084741c5e4ff0",
                *                        "threadId": "188084741c5e4ff0"
                *                    }
                *                ],
                *    "resultSizeEstimate": 2 예상 총 결과 개수
                *}
                * */
                var responseMessage = JSON.parse(xhr.responseText);
                idForMessage = responseMessage.messages;
                console.log("message : %s", JSON.stringify(idForMessage));
                pagingResultSize = responseMessage.resultSizeEstimate;
                console.log(" 페이징을 위한 정보 : 전체 메일 개수 : %s", JSON.stringify(pagingResultSize));

                idForMessage.forEach(function (data, idx) {
                    console.log("데이터 : %s", JSON.stringify(data));
                    /* data : 하나의 객체 = 자바의 Map과 비슷 */
                    var id = data.id;
                    var threadId = data.threadId;
                    console.log(id);
                    console.log(threadId);
                    /* 배열에 id 값 담기 */
                    ids[idx] = id;
                    threadIds[idx] = threadId;
                });

                console.log(" 메일 id 들 : %s", ids);
                console.log(" 메일 스레드 id 들 : %s", threadIds);


                getInboxMessage(userId, accessToken, ids, threadIds);


                /* 정보*/
                // loading.style.display = "block";
                // it.style.display = "none"


                /*응답 성공 확인 했음. 캐시에 저장하기*/
            } else if (xhr.status == 401) {
                console.log("오류 : %s", 401);
                console.log("요청한 리소스에 대한 인증 실패");
                console.log("Gmail API : 액세스 토큰 확인 필요");

            } else if (xhr.status == 400) {
                console.log("오류 : %s", 400);
                console.log("서버가 응답을 받았으나, 클라이언트 측에서 잘못된 요청을 보내서 처리 불가")
                console.log("응답 데이터 : %s", xhr.responseText);

                return;
            } else if (xhr.status == 403) {
                console.log("오류 : %s", 403);
                console.log("서버가 요청을 이해했으나, 인가를 거부");
                console.log("스프링 프레임워크를 사용하는 경우, 스프링 시큐리티 메타 태그 확인 바람");
                console.log("응답 데이터 : %s", xhr.responseText);
                console.log(xhr.statusText);

                return;

            } else if (xhr.status == 404) {
                console.log("오류 : %s", 404);
                console.log("요청 페이지 없음");
                console.log("응답 데이터 : %s", xhr.responseText);

                return;
            } else if (xhr.status == 415) {
                console.log("오류 : %s", 415);
                console.log("클라이언트가 요청한 미디어 타입(데이터 형식)이 지원하지 않음");
                console.log("응답 데이터 : %s", xhr.responseText);

                return;
            } else {
                console.log("메세지 목록 비동기 접근 실패");
                console.log("응답 데이터 : %s", xhr.responseText);

                return;
            }
        }
        xhr.send();
    }


    getInboxMessageList(userId, accessToken);


</script>