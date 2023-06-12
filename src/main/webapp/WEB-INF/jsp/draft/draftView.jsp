<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
.atrzLine {
	width: 62px;
	/* 	flex-direction: row; */
	flex-wrap: wrap;
}

#selectedList {
	display: block;
	height: 150px;
	overflow: auto;
	box-sizing: content-box;
}

.selectFormCheckBox {
	box-sizing: content-box;
	width: 23.6px;
}

.drftSetButton {
	height: 35px;
	margin: 5px;
	border-color: #FFFFFF;
}

#drftBtnArea {
	padding-top: 10px;
	display: flex;
	justify-content: flex-end;
}

#approvDoc {
	border: 1px solid black;
	border-collapse: collapse;
	outline: 1.5px solid black;
}

#aprvContent {
	width: 649px;
	height: 473px;
}

#drftSetArea {
	background-color: #3541A8;
	height: 50px;
}

#drftSetTableArea {
	margin: 50px;
}

#draftTitle {
	text-align: center;
}
/* #draftView{ */
/* 	width:780; */
/* 	height:750; */
/* } */

/* 모달 */
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
	border-radius: 5px;
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 400;
	overflow-y: auto;
	max-height: 500px;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

/*form*/
.atrzScrollable-table {
	display: block;
	height: 150px;
	overflow: auto;
	/*     width:360px; */
}

.empListTr {
	width: 360px;
}

.empSelectFormBtnBox {
	padding: 15px 0px;
}

.sign {
	width: 64.89px;
	height: 72.67px;
}

.status {
	font-size: 10px;
	text-align: center;
	border-top: hidden;
}

.red {
	color: red;
}
</style>
<body id="draftView" style=" margin: 0; padding: 0;">  
	<div>
		<div id="drftSetArea">  
			<div id="drftBtnArea">
				<form:form modelAttribute="approval"
					action="${cPath }/approval/draftDelete.do" method="post">
					<c:if test="${approval.nextAprvCheck eq 0}">
						<button class="btn btn-sm btn-secondary mr-1 mb-2"
							onclick="atrzPop()">결재</button>
					</c:if>
					<security:csrfInput />
					<form:input type="hidden" path="aprvDocId"
						value="${approval.aprvDocId}" />
					<c:if test="${approval.deleteCheck eq 0}">
						<form:button class="btn btn-sm btn-secondary mr-1 mb-2"
							type="submit">삭제</form:button>
					</c:if>
				</form:form>
			</div>
		</div>
		<div id="drftSetTableArea">
			<h1 id="draftTitle">${approval.atrzFormName}</h1>
			<table id="approvDoc" border="1">
				<tr>
					<td>기안번호</td>
					<td>${approval.aprvDocId}</td>
					<td rowspan="6" style="text-align: center;">결재</td>
					<c:forEach var="idx" begin="0" end="3" step="1">
						<c:set value="${approval.atrzLineList[idx]}" var="atrzLine" />
						<c:if test="${not empty atrzLine}">
							<c:if test="${atrzLine.aprvTurn eq idx + 1}">
								<td class="atrzLine position" style="text-align: center;">${atrzLine.positionName}</td>
							</c:if>
						</c:if>
						<c:if test="${empty atrzLine}">
							<td class="atrzLine position"></td>
						</c:if>
					</c:forEach>
				</tr>
				<tr>
					<td>작성일자</td>
					<td>${approval.aprvDocDate}</td>
					<c:forEach var="idx" begin="0" end="3" step="1">
						<c:set value="${approval.atrzLineList[idx]}" var="atrzLine" />
						<c:if test="${not empty atrzLine}">
							<c:if test="${atrzLine.aprvTurn eq idx + 1}">
								<c:if test="${atrzLine.isapprovalStatus eq '1'}">
									<c:if test="${empty atrzLine.empDptId}">
										<td rowspan="3" class="atrzLine sign"><img class="sign"
											src="${cPath }/mypage/${atrzLine.empSign.empAtchSaveName}"
											alt="${atrzLine.empSign.empAtchOriginName}" /></td>
									</c:if>
									<c:if test="${not empty atrzLine.empDptId}">
										<td rowspan="3" class="atrzLine sign"><img class="sign"
											src="${cPath }/mypage/deputyImg.png" alt="deputyImg.png" /></td>
									</c:if>
								</c:if>
							</c:if>
							<c:if test="${atrzLine.isapprovalStatus eq '2'}">
								<td rowspan="3" class="atrzLine sign"><img class="sign"
									src="${cPath }/mypage/${atrzLine.empSign.empAtchSaveName}"
									alt="${atrzLine.empSign.empAtchOriginName}" /></td>
							</c:if>
							<c:if test="${atrzLine.isapprovalStatus eq '0'}">
								<td rowspan="3" class="atrzLine sign"></td>
							</c:if>
						</c:if>
						<c:if test="${empty atrzLine}">
							<td rowspan="3" class="atrzLine sign"></td>
						</c:if>
					</c:forEach>
				</tr>
				<tr>
					<td>기안부서</td>
					<td>${approval.teamName}</td>

				</tr>
				<tr>
					<td>기안자</td>
					<td>${approval.empName}</td>


				</tr>
				<tr>
					<td>응급여부</td>
					<td><c:if test="${approval.isurgent == '1'}">
				    응급
				</c:if> <c:if test="${approval.isurgent == '0'}">
				    보통
				</c:if></td>
					<c:forEach var="idx" begin="0" end="3" step="1">
						<c:set value="${approval.atrzLineList[idx]}" var="atrzLine" />
						<c:if test="${not empty atrzLine}">
							<c:if test="${atrzLine.aprvTurn eq idx + 1}">
								<c:if test="${atrzLine.isapprovalStatus eq '1'}">
									<td class="atrzLine status" style="text-align: center;">${atrzLine.isapprovalDate}
										승인</td>
								</c:if>
								<c:if test="${atrzLine.isapprovalStatus eq '2'}">
									<td class="atrzLine status red" style="text-align: center;">${atrzLine.isapprovalDate}
										반려</td>
								</c:if>
								<c:if test="${atrzLine.isapprovalStatus eq '0'}">
									<td class="atrzLine status" style="text-align: center;">결재
										전</td>
								</c:if>
							</c:if>
						</c:if>
						<c:if test="${empty atrzLine}">
							<td class="atrzLine status"></td>
						</c:if>
					</c:forEach>
				</tr>
				<tr>
					<td>수신자</td>
					<c:if test="${not empty approval.receiverName}">
						<td>${approval.receiverName}[${approval.receiverDpmt}]</td>
					</c:if>
					<c:if test="${empty approval.receiverName}">
						<td></td>
					</c:if>
					<c:forEach var="idx" begin="0" end="3" step="1">
						<c:set value="${approval.atrzLineList[idx]}" var="atrzLine" />
						<c:if test="${not empty atrzLine}">
							<c:if test="${atrzLine.aprvTurn eq idx + 1}">
								<td class="atrzLine empId" style="text-align: center;">${atrzLine.empName }</td>
							</c:if>
						</c:if>
						<c:if test="${empty atrzLine}">
							<td class="atrzLine empId"></td>
						</c:if>
					</c:forEach>
				</tr>
				<tr>
					<td>참조자</td>
					<c:set var="rfrrList" value="${approval.atrzRfrrList }" />
							<td colspan="6" style="border-right:hidden;">
					<c:forEach items="${rfrrList }" var="rfrr">
						<c:if test="${not empty rfrr }">
	<%-- 						<td>${rfrr }</td> --%>
								[${rfrr.atrzRfrrEmpDpmt }]${rfrr.atrzRfrrEmpName } 
						</c:if>	
					</c:forEach>
							</td>
<%-- 						<c:if test="${empty rfrr }"> --%>
<!-- 							<td></td> -->
<%-- 						</c:if> --%>
				</tr>
				<tr>
					<td>참조자</td>
					<td colspan="6" id="rfrrLine">${approval.aprvDocList.aprvDocTitle}</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="6">${approval.aprvDocTitle}</td>
				</tr>
				<tr>
					<td colspan="7"><div name="aprvContent" id="aprvContent" style="padding-left:40px; padding-top:20px;">${approval.aprvContent}</div></td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td colspan="6">
					<c:forEach items="${approval.atchFileGroup.atchFileList }" var="attatch"
							varStatus="vs">
							<c:url value="/approval/attatch/download.do" var="downloadURL">
								<c:param name="atchId" value="${attatch.atchId }" />
								<c:param name="atchSeq" value="${attatch.atchSeq }" />
							</c:url>
							<a href="${downloadURL }">${attatch.atchOriginName }</a>
							<c:if test="${not vs.last }">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
						</c:forEach></td>
				</tr>

			</table>
		</div>
		<div style="width: 100%; padding: 35px 50px; background-color: #f1f5f9; box-sizing: border-box;">
			<div id="replyBody" style="font-size: larger; font-weight: 600;">
				댓글
				<table>  
					<c:set var="ReplyList" value="${approval.aprvReplyList }" />
						<c:if test="${not empty ReplyList }">
						
						<c:forEach items="${ReplyList }" var="reply">
							<tr>
								<td rowspan=3; style="font-size: 14px; padding-bottom: 5px;  vertical-align: bottom;">
								<img src="${cPath }/mypage/${reply.empAtchSaveName }" alt="${reply.empAtchSaveName }" style=" border-radius: 50%; margin-right: 10px; height: 30px; width: 30px; background-color: gray;"/></td>
							</tr>
							<tr style="padding:0px; margin:0px;">
								<td style="font-size: 14px; font-family:'Pretendard', Roboto; vertical-align: bottom;">${reply.empName }</td>
								<td >
									<form id="replyDelete" style ="margin:0px;"
										action="${cPath }/approval/aprvReplyDelete.do" method="post">
										<security:csrfInput />
										<input type="hidden" name="atrzReplyId" value="${reply.atrzReplyId }" />
										<input type="hidden" name="aprvDocId"
											value="${reply.aprvDocId }" />
											<c:if test="${reply.empId eq myId}">
										<button type="submit" style="border: 0.2px solid gray; font-family:'Pretendard', Roboto; background-color: #ffffff; border-radius: 20px; margin-top:20px;">삭제</button>
										<input type="button" style="border: 0.2px solid gray; font-family:'Pretendard', Roboto; background-color: #ffffff; border-radius: 20px; margin-top:20px;"
											onclick="updateReply(${reply.atrzReplyId })" value="수정">
											</c:if>
									</form>
								</td>
							</tr>
							<tr style="padding:0px; margin:0px;">
								<td style="font-size: 14px; font-family:'Pretendard', Roboto;" class="replycontent" id="replyId+'${reply.atrzReplyId }'">${reply.atrzReplyContent }</td>
							</tr>
							<tr>
								<td></td>
								<td style="font-size: 12px; font-family:'Pretendard', Roboto;">${reply.atrzReplyDate }</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>
			<br>
			<div>
				<form:form id="replyForm" modelAttribute="aprvReply"
					action="${cPath }/approval/aprvReplyInsert.do" method="post">
					<security:csrfInput />
					<form:input type="hidden" path="aprvDocId"
						value="${approval.aprvDocId}" />
					<form:textarea path="atrzReplyContent"
						style=" width: 100%; min-width: 100%; max-width: 100%; min-height:75px; border-radius: 2px; border: solid 1px #8b8b8b;" />  
					<form:button style="appearance: none; width: 100%; height: 45px; background: #1e40af; color: #fff; border-radius: 5px; margin-top: 5px; border: none; font-weight: 700; font-size: 15px;">등록</form:button>
				</form:form>    
			</div>
		</div>
	</div>



	<script>

/*
 * 댓글 수정 div 폼으로 변경 ! 
 */
function updateReply(replyId){
	var replyContent = $('[id="replyId${replyId}"]');
	
	console.log('replyContent',replyContent)
}


CKEDITOR.instances.aprvContent.getData();
CKEDITOR.instances["aprvContent"].getData();
function atrzPop(){
	event.preventDefault();
                window.open(`signup.do?what=${approval.aprvDocId}`, "결재", "width=400, height=200")  
            }
</script>
</body>