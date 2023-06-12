<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>
	#content{
		height: auto;
		text-align: center;
	}
	
	.eddit{
		margin: 2px;
	}
	
</style>
 	<sec:authentication property="principal.realUser.empId" var="empId" />
<!-- BEGIN: Content -->
        <div id="content" class="content">
            <div class="intro-y flex flex-col mt-8">
                <div>
                    <a href="${cPath }/board/notice/noticeBoardList.do" class="btn btn-primary eddit" style="float:right;">목록</a>
                    <c:if test="${empId eq 'a100005'}">
                    	<button class="btn btn-danger-soft eddit" style="float:right;" onclick="deletePost(${noticeBoard.postId})">삭제</button>
                    	<a href="${cPath }/board/notice/noticeBoardUpdate.do?what=${noticeBoard.postId}" class="btn btn-pending-soft eddit" style="float:right;" onclick="updateNotice()">수정</a>
                    </c:if>
                </div>
            </div>
            
            <!-- BEGIN: Invoice -->
            <div class="intro-y box overflow-hidden mt-5">
                <div class="border-slate-200/60 dark:border-darkmode-400 text-center sm:text-left">  
                    <div class="px-5 py-10 sm:px-20 sm:py-20">
                        <div class="text-primary font-semibold text-3xl">${noticeBoard.postTitle }</div>
                        <div class="border-b-2 dark:border-darkmode-400 whitespace-nowrap"></div>
                        <div class="mt-2" style="text-align:right;"><span class="font-medium">${noticeBoard.empName }</span> </div>    
                        <div class="mt-1" style="text-align:right;">${noticeBoard.postDate }</div>
                        <div id="content">${noticeBoard.postContent }</div>
                    </div>
                </div>
                <div class="px-5 sm:px-16 py-10 sm:py-20">
                    <div class="overflow-x-auto">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th class="border-b-2 dark:border-darkmode-400 whitespace-nowrap"></th>
                                    <th class="border-b-2 dark:border-darkmode-400 text-right whitespace-nowrap" colspan="3"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="border-b dark:border-darkmode-400" colspan="2" style="text-align:left;">
                                        <p class="font-medium whitespace-nowrap" style="font-weight:bold; display:inline;" >다음 글 │</p> <c:choose>
                                        	<c:when test="${empty noticeBoard.nextPost.postTitle }"><p style="display:inline;" >다음 글이 없습니다.</p></c:when>
                                        	<c:otherwise><a id="movePage" href="${cPath }/board/notice/noticeBoardView.do?what=${noticeBoard.nextPost.postId }">${noticeBoard.nextPost.postTitle }</a></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="border-b dark:border-darkmode-400" colspan="2" style="text-align:left;">
                                        <p class="font-medium whitespace-nowrap" style="font-weight:bold; display:inline;" >이전 글 │</p> <c:choose>
                                        	<c:when test="${empty noticeBoard.prePost.postTitle }"><p style="display:inline;" >이전 글이 없습니다.</p></c:when>
                                        	<c:otherwise><a id="movePage" href="${cPath }/board/notice/noticeBoardView.do?what=${noticeBoard.prePost.postId }" >${noticeBoard.prePost.postTitle }</a></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
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
                    url: postId,
                    type: 'delete',
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
                                    window.location.href = 'noticeBoardList.do';
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
    
    
    function updateNotice(postId){
    	$.ajax({
    		url: postId,
    		type:"post",
    		contentType : "application/json",
    		success:function(data){
    			
    		}
    	})
    }
    
</script>