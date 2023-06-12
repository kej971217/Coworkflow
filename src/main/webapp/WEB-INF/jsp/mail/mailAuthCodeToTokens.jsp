<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<script>
    document.querySelector(".reqTokens").style.display = "none";

    /*함수 목록*/
    /*1. goToControllerWithJSON(문자열 jsonData) :  [콜백함수]토큰 가지고, 토큰을 처리할 컨트롤러로 이동*/
    /*2. requestTokens() : 컨트롤러에서 보낸 인가 코드를 비롯한 필요 정보를 가지고, 토큰 요청하기 */

    /*[콜백함수]토큰 가지고, 토큰을 처리할 컨트롤러로 이동*/
    goToControllerWithJSON = (jsonData) => {
        console.log("<2> 토큰을 가지고, 토큰을 처리할 컨트롤러로 이동");
        var tokenToController = document.querySelector(".tokenToController").value;
        console.log("토큰 처리 컨트롤러 URL: %s", tokenToController);
        console.log("넘길 json 데이터(문자열 상태) : %s", jsonData);
        console.log("응답 시간 : (단위: 밀리초)", jsonData.search('responseDateTime'));


        console.log("스프링 시큐리티 headerName : %s", headerName);
        console.log("스프링 시큐리티 headerValue : %s", headerValue);


        let xhrToController = new XMLHttpRequest();
        xhrToController.open("POST", tokenToController, false);
        /* -----------------------------------------------------------------------*/
        xhrToController.setRequestHeader(headerName, headerValue);
        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');

        /* -----------------------------------------------------------------------*/
        xhrToController.onreadystatechange = () => {
            if (xhrToController.readyState == 4 && xhrToController.status == 200) {

                console.log("토큰 컨트롤러 찾아가기");
                xhrToController.send(jsonData);
                //return tokenToController;
                window.location.href = tokenToController;

            } else if (xhrToController.status == 400) {
                console.log("오류 : %s", 400);
                console.log("서버가 응답을 받았으나, 클라이언트 측에서 잘못된 요청을 보내서 처리 불가")
                console.log("응답 데이터 : %s", xhrToController.responseText);

                return;
            } else if (xhrToController.status == 403) {
                console.log("오류 : %s", 403);
                console.log("서버가 요청을 이해했으나, 인가를 거부");
                console.log("스프링 프레임워크를 사용하는 경우, 스프링 시큐리티 메타 태그 확인 바람");
                console.log("응답 데이터 : %s", xhrToController.responseText);
                console.log(xhrToController.statusText);

                return;

            } else if (xhrToController.status == 404) {
                console.log("오류 : %s", 404);
                console.log("요청 페이지 없음");
                console.log("응답 데이터 : %s", xhrToController.responseText);

                return;
            } else if (xhrToController.status == 415) {
                console.log("오류 : %s", 415);
                console.log("클라이언트가 요청한 미디어 타입(데이터 형식)이 지원하지 않음");
                console.log("응답 데이터 : %s", xhrToController.responseText);

                return;
            } else {
                console.log("토큰 요청하기 비동기 접근 실패");
                console.log("응답 데이터 : %s", xhrToController.responseText);

                return;
            }
        }
        xhrToController.send(jsonData);
        //return tokenToController;

    }

    /*컨트롤러에서 보낸 인가 코드를 비롯한 필요 정보를 가지고, 토큰 요청하기*/
    requestTokens = () => {
        var reqTokenWithAuthorizationCode = document.querySelector(".code").value;
        var reqTokenWithClientId = document.querySelector(".client_id").value;
        var reqTokenWithClientSecret = document.querySelector(".client_secret").value;
        var reqTokenWithRedirectURI = document.querySelector(".redirect_uri").value;
        var reqTokenWithGrantType = document.querySelector(".grant_type").value;
        var reqTokenWithTokenURI = document.querySelector(".tokenUri").value;

        console.log("<1> 인가 코드 + 필요 정보를 갖고, 토큰 요청하기");
        console.log("토큰 요청 URI : %s", reqTokenWithTokenURI);
        console.log("1. 인가 코드 : %s", reqTokenWithAuthorizationCode);
        console.log("2. 클라이언트 ID : %s", reqTokenWithClientId);
        console.log("3. 클라이언트 시크릿 : %s", reqTokenWithClientSecret);
        console.log("4. 웹 어플리케이션으로 리다이렉트 URI : %s", reqTokenWithRedirectURI);
        console.log("5. 승인 유형 : %s = authorization_code", reqTokenWithGrantType);


        /* -----------------------------------------------------------------------*/

        let xhr = new XMLHttpRequest();
        xhr.open("POST", reqTokenWithTokenURI, true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        /* -----------------------------------------------------------------------*/
        var data = new URLSearchParams();// URLSearchParams :  URL의 쿼리 문자열을 다루기 위한 인터페이스
        // set : 하나의 키, 하나의 값
        // append : 하나의 키, 여러 값
        data.append("code", reqTokenWithAuthorizationCode);
        data.append("client_id", reqTokenWithClientId);
        data.append("client_secret", reqTokenWithClientSecret);
        data.append("redirect_uri", reqTokenWithRedirectURI);
        data.append("grant_type", reqTokenWithGrantType);


        console.log("data : %s", data)
        /* -----------------------------------------------------------------------*/

        var responseForTokenRequest;

        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("함수 requestTokens : 토큰 요청하기 비동기 접근 성공");
                console.log("응답 데이터 : %s", xhr.responseText);
                /*----------------------------------------------------*/
                /*현재 시각*/
                var currentDateTime = new Date();
                console.log("현재 시간 (단위: 밀리초) : %s", currentDateTime);
                console.log("현재 시간 : %s년 %s월 %s일 %s시 %s분 %s초", currentDateTime.getFullYear(), currentDateTime.getMonth(), currentDateTime.getDay(), currentDateTime.getHours(), currentDateTime.getMinutes(), currentDateTime.getSeconds());

                /*----------------------------------------------------*/
                responseForTokenRequest = JSON.parse(xhr.responseText);
                /*JSON 문자열 -> 자바스크립트 객체*/
                /*{
                    "access_token": "ya29.a0AWY7CklR4jkg1SIl7zXCVyOYyKeuSBl9UGmDmqf5w1ftqENROm40Wv28NldfJCrTU2czWcWpdbQQmSNwG5g38iDFya8v5rqrGgabK4W91_jjD4s2SCetoemdurCV0BDbUBwJ-n1IESvw7GqH-qYdp0TF2-0EaCgYKAQkSARASFQG1tDrpU5fjAZS1Q5qx4ea9TmZ-XA0163",
                        "expires_in": 3599,
                        "refresh_token": "1//0eDqZT2p1K9byCgYIARAAGA4SNwF-L9Ir6GyoDqgb_anELcGPbCRHygkB3OPiygXRExCnPrOKKatQ8fx5BaLHepskfk4-pSj7mWU",
                        "scope": "https://mail.google.com/",
                        "token_type": "Bearer"
                }*/
                /*JSON의 키값(문자열)과 속성명이 일치해야 함(언더바까지)*/
                var accessToken = responseForTokenRequest.access_token;
                var expiresIn = responseForTokenRequest.expires_in;
                var refreshToken = responseForTokenRequest.refresh_token;
                var scope = responseForTokenRequest.scope;
                var tokenType = responseForTokenRequest.token_type;


                /* 컨트롤러로 JSON 데이터 보내는 콜백함수에 넣어줄 JSON 문자열 */
                var jsonData = JSON.stringify({ /*자바스크립트 객체 -> JSON 문자열*/
                    accessToken: accessToken,
                    expiresIn: expiresIn,
                    refreshToken: refreshToken,
                    scope: scope,
                    tokenType: tokenType,
                    responseDateTime: currentDateTime,
                });

                console.log("json 문자열 변화 : %s", jsonData);


                document.querySelector("#jsonData").value = jsonData;



                document.querySelector("#jsonForm").submit();




                //goToControllerWithJSON(jsonData);

            } else if (xhrToController.status == 400) {
                console.log("오류 : %s", 400);
                console.log("서버가 응답을 받았으나, 클라이언트 측에서 잘못된 요청을 보내서 처리 불가")
                console.log("응답 데이터 : %s", xhrToController.responseText);

                return;
            } else if (xhrToController.status == 403) {
                console.log("오류 : %s", 403);
                console.log("서버가 요청을 이해했으나, 인가를 거부");
                console.log("스프링 프레임워크를 사용하는 경우, 스프링 시큐리티 메타 태그 확인 바람");
                console.log("응답 데이터 : %s", xhrToController.responseText);
                console.log(xhrToController.statusText);

                return;

            } else if (xhrToController.status == 404) {
                console.log("오류 : %s", 404);
                console.log("요청 페이지 없음");
                console.log("응답 데이터 : %s", xhrToController.responseText);

                return;
            } else if (xhrToController.status == 415) {
                console.log("오류 : %s", 415);
                console.log("클라이언트가 요청한 미디어 타입(데이터 형식)이 지원하지 않음");
                console.log("응답 데이터 : %s", xhrToController.responseText);

                return;
            } else {
                console.log("토큰 요청하기 비동기 접근 실패");
                console.log("응답 데이터 : %s", xhrToController.responseText);

                return;
            }


        }
        xhr.send(data);

    }

    requestTokens();

</script>
