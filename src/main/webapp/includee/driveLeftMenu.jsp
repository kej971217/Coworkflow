<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

					<%-- 인사정보 좌측 사이드 메뉴 --%>
                    <!-- BEGIN: File Manager Menu -->
                    <div class="intro-y box p-5 mt-6" style="margin-top: 1.85rem;">
                    	<div class="flex items-center dark:border-darkmode-400 text-2xl"> <i class="mr-2" icon-name="folder"></i> <a href="${cPath }/drive/main.do"> <spring:message code="level1Menu.drive"/> </a> </div>  
                        <div class="border-t border-slate-200 dark:border-darkmode-400 mt-4 pt-4">
                            <span onclick="leftMenuActive(this); openFolder('');" class="flex items-center px-3 py-2 rounded-md bg-primary text-white font-medium" data-filter-type="" style="cursor: pointer;"> <i class="w-4 h-4 mr-2" icon-name="users"></i> 전체 </span>
                            <span onclick="leftMenuActive(this); openFolder('');" class="flex items-center px-3 py-2 mt-2 rounded-md" data-filter-type="image" style="cursor: pointer;"> <i class="w-4 h-4 mr-2" icon-name="image"></i> 사진 </span>
                            <span onclick="leftMenuActive(this); openFolder('');" class="flex items-center px-3 py-2 mt-2 rounded-md" data-filter-type="video" style="cursor: pointer;"> <i class="w-4 h-4 mr-2" icon-name="video"></i> 동영상 </span>
                            <span onclick="leftMenuActive(this); openFolder('');" class="flex items-center px-3 py-2 mt-2 rounded-md" data-filter-type="document" style="cursor: pointer;"> <i class="w-4 h-4 mr-2" icon-name="file"></i> 문서 </span>
                            <span onclick="leftMenuActive(this);" class="flex items-center px-3 py-2 mt-2 rounded-md" style="cursor: pointer;"> <i class="w-4 h-4 mr-2" icon-name="trash"></i> 휴지통 </span>
                        </div>  
                        <div class="border-t border-slate-200 dark:border-darkmode-400 mt-4 pt-4">
                            <a href="" class="flex items-center px-3 py-2 rounded-md">
                                <div class="w-2 h-2 bg-pending rounded-full mr-3"></div>
                                Custom Work 
                            </a>
                            <a href="" class="flex items-center px-3 py-2 mt-2 rounded-md">
                                <div class="w-2 h-2 bg-success rounded-full mr-3"></div>
                                Important Meetings 
                            </a>
                            <a href="" class="flex items-center px-3 py-2 mt-2 rounded-md">
                                <div class="w-2 h-2 bg-warning rounded-full mr-3"></div>
                                Work 
                            </a>
                            <a href="" class="flex items-center px-3 py-2 mt-2 rounded-md">
                                <div class="w-2 h-2 bg-pending rounded-full mr-3"></div>
                                Design 
                            </a>
                            <a href="" class="flex items-center px-3 py-2 mt-2 rounded-md">
                                <div class="w-2 h-2 bg-danger rounded-full mr-3"></div>
                                Next Week 
                            </a>
                            <a href="" class="flex items-center px-3 py-2 mt-2 rounded-md"> <i class="w-4 h-4 mr-2" icon-name="plus"></i> Add New Label </a>
                        </div>
                    </div>
                    <!-- END: File Manager Menu -->