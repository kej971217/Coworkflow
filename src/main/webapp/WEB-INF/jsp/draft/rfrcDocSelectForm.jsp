<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>    
    <div>
    <div>첨부문서선택</div>
    <hr>
    <div>
	<table border="1">
	<thead>
	    <tr>
	        <th >
	            <input type="checkbox">
	        </th>
	        <th >문서정보</th>
	        <th >제목</th>
	        <th >작성자</th>
	        <th >작성일자</th>
	    </tr>
	</thead>
	<tbody>
		<c:if test="${not empty rfrrDocList }">
		    <c:forEach items="${rfrrDocList }" var="rfrrDoc">
		        <tr>
		            <td><input type="checkbox"></td>
		            <td>${rfrrDoc.aprvDocId}<br>${rfrrDoc.atrzFormName}</td>
		            <td class="formSelect">
		                <a onclick=draft(${rfrrDoc.aprvDocId})>${rfrrDoc.aprvDocTitle}</a>
		            </td>
		            <td>${rfrrDoc.empName}</td>
		            <td>${rfrrDoc.aprvDocDate}</td>
		        </tr>
		    </c:forEach>
		</c:if>
		<c:if test="${empty rfrrDocList }">
		    <tr>
		        <td colspan="7">결재양식없음</td>
		    </tr>
		</c:if>
        </tbody>
</table>
</div>
</div>