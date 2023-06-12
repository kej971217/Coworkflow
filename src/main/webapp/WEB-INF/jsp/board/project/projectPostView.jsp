<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<!-- BEGIN: Content -->
            <div class="content">
                <div class="intro-y flex flex-col sm:flex-row items-center mt-8">
                    <div class="w-full sm:w-auto flex mt-4 sm:mt-0">
                        <button onclick="location.href='${cPath }/board/project/projectBoardView.do?projectId=${projectId }&boardId=${projectBoard.boardId}'" class="btn btn-primary shadow-md mr-2">목록</button>
                    </div>
                    <c:if test="${empId eq empId}">
                    	<button class="btn btn-danger-soft eddit" style="float:right;" onclick="deletePost(${projectBoard.postId})">삭제</button>
                    	<a href="${cPath }/board/project/projectPostUpdate.do?postId=${projectBoard.postId }&boardId=${projectBoard.boardId}&projectId=${projectId}" class="btn btn-pending-soft eddit" style="float:right;" onclick="updateProjectPost()">수정</a>
                    </c:if>
                </div>
                <!-- BEGIN: Invoice -->
                <div class="intro-y box overflow-hidden mt-5">
                    <div class="text-center sm:text-left">
                        <div class="px-5 py-10 sm:px-20 sm:py-20">
                            <div class="text-primary font-semibold text-3xl border-b pb-3 mb-3">${projectBoard.postTitle }</div>
                            <p class="mt-1 text-right">${projectBoard.postDate }</p>
                            <p>${projectBoard.postContent }</p>
                        </div>
                    </div>
                    <div class="px-5 sm:px-16 py-10 sm:py-20">
                        <div class="overflow-x-auto">
                            <table class="table">
                                    <tr>
                                    	<th></th>
                                    	<td></td>
                                    	<th></th>
                                    	<td></td>
                                    </tr>
                                    <tr>
                                        <th>담당자</th>
                                        <td>${projectBoard.empId }</td>
                                        <th>우선순위</th>
                                        <td>${projectBoard.postAsap }</td>
                                    </tr>
                                    <tr>
                                        <th>시작 기간</th>
                                        <td>${projectBoard.postSday }</td>
                                        <th>완료 기한</th>
                                        <td>${projectBoard.postFday }</td>
                                    </tr>
                                    <tr>
                                    	<th>진척도</th>
                                    	<td colspan="3">${projectBoard.postProgress }%</td>
                                    </tr>
                            </table>
                        </div>
                    </div>
                <!-- END: Invoice -->
            </div>
            <!-- END: Content -->
            
<script>
function deletePost(postId) {
    Swal.fire({
        icon: 'warning',
        title: '확인',
        text: '정말 삭제 하시겠습니까?',
        showCancelButton: true,
        confirmButtonText: '확인',
        cancelButtonText: '취소'
    }).then((result) => {
        if (result.isConfirmed) {
            // 콜백 함수 내에서 필요한 동작 수행
            $.ajax({
                url: "${cPath}/board/project/projectPostEdit.do",
                type: 'get',
                contentType : "application/json",
                beforeSend : function(xhrToController){
                    xhrToController.setRequestHeader(headerName, headerValue);
                    xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
                },
                success : function (data) {
                    if (data['result']) {
                        Swal.fire({
                            icon: 'success',
                            title: '성공',
                            text: data['message'],
                        }).then((result) => {
                            // 사용자가 확인 버튼을 클릭한 경우 실행될 콜백 함수
                            if (result.isConfirmed) {
                                // 콜백 함수 내에서 필요한 동작 수행
                                location.href = 'projectPostView.do';
                            }
                        })
                    } else {
                        Swal.fire({
                            icon: 'fail',
                            title: '실패',
                            text: data['message'],
                        });
                    }
                }
            });
        }
    })
}
</script>