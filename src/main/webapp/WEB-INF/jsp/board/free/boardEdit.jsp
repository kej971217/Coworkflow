<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<form:form id="editForm" modelAttribute="freeboard" method="post" enctype="multipart/form-data">
	<form:hidden path="boNo"/>
	<table class="table table-boardered">
		<tr>
			<th><spring:message code="freeboard.boTitle" /></th>
			<td>
				<form:input path="boTitle"  maxlength="200" class="form-control" />
				<form:errors path="boTitle" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th><spring:message code="freeboard.boWriter" /></th>
			<td>
				<form:input path="boWriter"  maxlength="80" class="form-control" />
				<form:errors path="boWriter" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th><spring:message code="freeboard.boPass" /></th>
			<td>
				<form:input path="boPass"  maxlength="200" class="form-control" />
				<form:errors path="boPass" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th><spring:message code="freeboard.boIp" /></th>
			<td>
				${pageContext.request.remoteAddr }
				<form:hidden path="boIp"  value="${pageContext.request.remoteAddr }"/>
				<form:errors path="boIp" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th><spring:message code="freeboard.boMail" /></th>
			<td>
				<form:input path="boMail" type="email" maxlength="200" class="form-control" />
				<form:errors path="boMail" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th>기존파일</th>
			<td>
				<c:forEach items="${freeboard.atchFileGroup.atchFileList }" var="attatch" varStatus="vs">
					<span>
						${attatch.atchOrginName }<span class="btn btn-danger delFileBtn" data-atch-seq="${attatch.atchSeq }">삭제</span>				
						<c:if test="${not vs.last }">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:if>
					</span>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<input type="file" name="addFiles" />
				<input type="file" name="addFiles" />
				<input type="file" name="addFiles" />
			</td>
		</tr>
		<tr>
			<th><spring:message code="freeboard.boContent" /></th>
			<td>
				<form:textarea path="boContent" class="form-control" />
				<form:errors path="boContent" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" class="btn btn-success" value="<spring:message code='save'/>" />
				<input type="reset" class="btn btn-danger" value="<spring:message code='reset'/>" />
			</td>
		</tr>
	</table>
</form:form>
<script>
	let editForm = $("#editForm");
	$(".delFileBtn").on("click", function(event){
		let atchSeq = $(this).data("atchSeq");
		$(this).parent("span").hide();
		let newInput = $("<input>").attr("name", "delFileGroup.delSeqs").val(atchSeq);
		editForm.append(newInput);
	});
</script>






















