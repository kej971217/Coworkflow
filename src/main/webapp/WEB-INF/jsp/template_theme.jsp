<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<!DOCTYPE html>
<!--
Template Name: Midone - HTML Admin Dashboard Template
Author: Left4code
Website: http://www.left4code.com/
Contact: muhammadrizki@left4code.com
Purchase: https://themeforest.net/user/left4code/portfolio
Renew Support: https://themeforest.net/user/left4code/portfolio
License: You must have a valid license purchased only from themeforest(the above link) in order to legally use the theme for your project.
-->
<html lang="en" class="light">
<!-- BEGIN: Head -->
<head>
<meta charset="utf-8">
<link href="/resources/Rubic/dist/images/logo.svg" rel="shortcut icon">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Midone admin is su`per flexible, powerful, clean & modern responsive tailwind admin template with unlimited possibilities.">
<meta name="keywords"
	content="admin template, Midone Admin Template, dashboard template, flat admin template, responsive admin template, web app">
<meta name="author" content="LEFT4CODE">
<security:csrfMetaTags />
<title><tiles:getAsString name="title" /></title>

<tiles:insertAttribute name="preScript" />
<c:if test="${not empty message }">
	<script type="text/javascript">
		window.addEventListener("DOMContentLoaded", function() {
			Swal.fire({
				icon : 'success',
				title : '성공',
				text : '${message}'
			})
		});
	</script>
</c:if>
</head>
<!-- END: Head -->
<!-- BEGIN: Body -->
<body class="py-5">


	<!--  BEGIN: 기간 Modal Content 
	BEGIN: Modal Content
	<div id="header-footer-modal-preview" class="modal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				BEGIN: Modal Header
				<div class="modal-header">
					<h2 class="font-medium text-base mr-auto">기간 수정</h2>
				</div>
				END: Modal Header
				BEGIN: Modal Body
				<div class="modal-body grid grid-cols-12 gap-4 gap-y-3">
					<div class="col-span-12 sm:col-span-6">
						<label for="modal-form-1" class="form-label">시작 기간</label> <input
							id="modal-form-1" type="date" class="form-control" value=""
							placeholder="시작 기간">
					</div>
					<div class="col-span-12 sm:col-span-6">
						<label for="modal-form-2" class="form-label">종료 기간</label> <input
							id="modal-form-2" type="date" class="form-control"
							placeholder="종료 기간">
					</div>
				</div>
				END: Modal Body
				BEGIN: Modal Footer
				<div class="modal-footer">
					<button type="button" data-tw-dismiss="modal"
						class="btn btn-outline-secondary w-20 mr-1">취소</button>
					<button class="btn btn-primary w -20">저장</button>
				</div>
				END: Modal Footer
			</div>
		</div>
	</div>
	END: Modal Content
	END: 기간 Modal Content



	BEGIN: 참여자 Modal Toggle
	<div class="text-center">
	</div>
	END: Modal Toggle
	BEGIN: Modal Content
	<div id="header-footer-modal-personPreview" class="modal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				BEGIN: Modal Header
				<div class="modal-header">
					<h2 class="font-medium text-base mr-auto">참여자 수정</h2>
				</div>
				END: Modal Header
				BEGIN: Modal Body
				<div class="modal-body grid grid-cols-12 gap-4 gap-y-3">
					<div class="col-span-12 sm:col-span-2">
						<label for="modal-form-1" class="form-label">포지션</label> <input
							id="modal-form-1" type="text" class="form-control">
					</div>
					<div class="col-span-12 sm:col-span-10">
						<label for="modal-form-2" class="form-label">임직원(팀)</label> <input
							id="modal-form-2" type="text" class="form-control">
					</div>
				</div>
				END: Modal Body
				BEGIN: Modal Footer
				<div class="modal-footer">
					<button type="button" data-tw-dismiss="modal"
						class="btn btn-outline-secondary w-20 mr-1">취소</button>
					<button class="btn btn-primary w-20">저장</button>
				</div>
				END: Modal Footer
			</div>
		</div>
	</div>
	END: 참여자 Modal Content
	
	
	
	BEGIN: 프로젝트 Modal Toggle
	<div class="text-center">
	</div>
	END: Modal Toggle
	BEGIN: Modal Content
	<div id="header-footer-modal-projectPreview" class="modal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				BEGIN: Modal Header
				<div class="modal-header">
					<h2 class="font-medium text-base mr-auto">프로젝트 프로그램 수정</h2>
				</div>
				END: Modal Header
				BEGIN: Modal Body
				<div class="modal-body grid grid-cols-12 gap-4 gap-y-3">
					<div class="col-span-12 sm:col-span-6">
						<label for="modal-form-1" class="form-label">프로젝트명</label> <input
							id="modal-form-1" type="text" class="form-control">
					</div>
					<div class="col-span-12 sm:col-span-6">
						<label for="modal-form-2" class="form-label">시스템</label> <input
							id="modal-form-2" type="text" class="form-control">
					</div>
				</div>
				END: Modal Body
				BEGIN: Modal Footer
				<div class="modal-footer">
					<button type="button" data-tw-dismiss="modal"
						class="btn btn-outline-secondary w-20 mr-1">취소</button>
					<button class="btn btn-primary w-20">저장</button>
				</div>
				END: Modal Footer
			</div>
		</div>
	</div>
	END: 프로젝트 Modal Content -->




	<tiles:insertAttribute name="mobileMenu" />
	<tiles:insertAttribute name="topBar" />
	<%--     	${level1Menu } kjhkjhjk --%>
	<tiles:insertAttribute name="topMenu" />
	<!-- 		<ul class="top-menu"> -->
	<%-- 		  <li class="<%= currentPage.equals("main") ? "top-menu--active" : "" %>"><a href="main.jsp">메인</a></li> --%>
	<%-- 		  <li class="<%= currentPage.equals("about") ? "top-menu--active" : "" %>"><a href="about.jsp">소개</a></li> --%>
	<%-- 		  <li class="<%= currentPage.equals("contact") ? "top-menu--active" : "" %>"><a href="contact.jsp">문의</a></li> --%>
	<!-- 		</ul> -->


	<!-- BEGIN: Content -->
	<div class="content">




		<tiles:insertAttribute name="body" />



	</div>
	<!-- END: Content -->



	<tiles:insertAttribute name="footer" />
	<tiles:insertAttribute name="postScript" />
</body>
<!-- END: Body -->
</html>








