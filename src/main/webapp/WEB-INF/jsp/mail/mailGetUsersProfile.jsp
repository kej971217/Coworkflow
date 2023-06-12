<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<script>
    console.log("사용자 프로필 정보 페이지 뷰 진입");
    var loading = document.querySelector(".mailSomeonesInfos");
    var it = document.querySelector("#reqWithInfo");
    // var last = document.querySelector(".messagesTotal").value;
    // var first = document.querySelector(".userId").value;

    /* 로딩 중 정보 가리기 */
    {
        it.style.display="none"
        loading.style.display="none";
    }

    var userId = document.querySelector(".userId").value;
    var accessToken = document.querySelector(".accessToken").value;
    console.log("userId : %s", userId);
    console.log("accessToken : %s", accessToken);


    getUserProfile = (userId, accessToken) => {
        console.log("사용자 프로필 요청 함수 실행");

        var url = `https://gmail.googleapis.com/gmail/v1/users/${userId}/profile`;

        console.log("url", url);
        var authHearValue = `Bearer ${accessToken}`;
        let xhr = new XMLHttpRequest();
        xhr.open("GET", url, false);
        xhr.setRequestHeader("Accept", "application/json;charset=UTF-8");
        xhr.setRequestHeader("Authorization", authHearValue);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("getUserProfile 비동기 요청 성공");
                console.log("응답 : %s", xhr.responseText);
                var responseUserProfile = JSON.parse(xhr.responseText);
                var emailAddress = responseUserProfile["emailAddress"];
                var messagesTotal = responseUserProfile["messagesTotal"];
                var threadsTotal = responseUserProfile["threadsTotal"];
                var historyId = responseUserProfile["historyId"];
                console.log(" --- < 받은 사용자 프로필 정보 확인 > --- ");
                console.log("1. 이메일 주소 (emailAddress) : %s", emailAddress);
                console.log("2. 전체 메일 개수 (messagesTotal) : %s", messagesTotal);
                console.log("3. 그룹단위 메일 개수 (threadsTotal) : %s", threadsTotal);
                console.log("4. 메일 변경 이력 횟수 (historyId) : %s", historyId);

                document.querySelector(".emailAddress").textContent = emailAddress;
                document.querySelector(".messagesTotal").textContent = messagesTotal;
                document.querySelector(".threadsTotal").textContent = threadsTotal;
                document.querySelector(".historyId").textContent = historyId;

                loading.style.display="block";
                it.style.display="none"


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
                console.log("토큰 요청하기 비동기 접근 실패");
                console.log("응답 데이터 : %s", xhr.responseText);

                return;
            }
        }
        xhr.send();
    }


    getUserProfile(userId, accessToken);



</script>