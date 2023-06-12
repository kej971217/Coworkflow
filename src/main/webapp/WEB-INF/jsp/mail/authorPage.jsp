<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="security"%>

<div class="reqTokens">
    <h1>3. 토큰 신청하기</h1>
    <table>
        <tr>
            <td>인가 코드</td>
            <td><input class="code" readonly type="text" name="code" value="${code}"></td>
        </tr>
        <tr>
            <td>클라이언트(웹 어플리케이션) ID</td>
            <td><input class="client_id" readonly type="text" name="client_id" value="${clientId}"></td>
        </tr>
        <tr>
            <td>클라이언트 시크릿</td>
            <td><input class="client_secret" readonly type="text" name="client_secret" value="${clientSecret}"></td>
        </tr>

        <tr>
            <td>리다이렉트 URI</td>
            <td><input class="redirect_uri" readonly type="text" name="redirect_uri" value="${redirectUri}"></td>
        </tr>
        <tr>
            <td>승인 타입(authorization_code 이어야 함)</td>
            <td><input class="grant_type" readonly type="text" name="grant_type" value="${grantType}"></td>
        </tr>
    </table>
    <table>
        <tr>
            <td>토큰 요청</td>
            <td><input class="tokenUri" readonly type="text" name="tokenUri" value="${tokenUri}"></td>
        </tr>
        <tr>
            <td>리다이렉트 컨트롤러</td>
            <td><input class="tokenToController" readonly type="text" name="tokenUri" value="${cPath}/mail/authorization/tokenCallback.do"></td>
        </tr>
    </table>

    <form:form id="jsonForm" method="post" action="${cPath }/mail/authorization/tokenCallback.do">
        <security:csrfInput/>
        <div>
            <h6>토큰json</h6><input type="text" id="jsonData" name="jsonData">
        </div>

        <%--        accessToken: accessToken,--%>
        <%--        expiresIn: expiresIn,--%>
        <%--        refreshToken: refreshToken,--%>
        <%--        scope: scope,--%>
        <%--        tokenType: tokenType,--%>
        <%--        responseDateTime: currentDateTime,--%>
    </form:form>
</div>
<jsp:include page="mailAuthCodeToTokens.jsp"/>