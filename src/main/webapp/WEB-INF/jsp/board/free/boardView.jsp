<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<table class="table table-bordered">
	<tr>
		<th>제목</th>
		<td>${freeboard.boTitle}</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>${freeboard.boWriter}</td>
	</tr>
	<tr>
		<th>아이피</th>
		<td>${freeboard.boIp}</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td>${freeboard.boMail}</td>
	</tr>
	<tr>
		<th>작성일</th>
		<td>${freeboard.boDate}</td>
	</tr>
	<tr>
		<th>조회수</th>
		<td>${freeboard.boHit}</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td>
			<c:forEach items="${freeboard.atchFileGroup.atchFileList }" var="attatch" varStatus="vs">
				<c:url value="/board/attatch/download.do" var="downloadURL">
					<c:param name="atchId" value="${attatch.atchId }" />
					<c:param name="atchSeq" value="${attatch.atchSeq }"/>
				</c:url>
				<a href="${downloadURL }">${attatch.atchOrginName }</a>
				
				<c:if test="${not vs.last }">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
			</c:forEach>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>${freeboard.boContent}</td>
	</tr>
	<tr>
		<td colspan="2">
			<c:url value="/board/free/boardUpdate.do" var="updateURL">
				<c:param name="what" value="${freeboard.boNo }"/>
			</c:url>
			<a class="btn btn-primary" href="${updateURL }">수정</a>
			<a class="btn btn-danger" href=":;" id="delBtn">삭제</a>
		</td>
	</tr>
</table>
<form:form modelAttribute="freeboard" action="${cPath }/board/free/boardDelete.do" method="post">
	<form:input path="boNo"/>
	<input type="submit" value="삭제" />
</form:form>
<script src="${cPath }/resources/js/board/boardView.js"></script>


