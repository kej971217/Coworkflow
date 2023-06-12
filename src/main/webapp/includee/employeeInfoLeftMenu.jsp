<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

					<%-- 인사정보 좌측 사이드 메뉴 --%>
                    <!-- BEGIN: Inbox Menu -->
                    <div class="intro-y box bg-primary p-5 mt-6">
                    	<div class="flex items-center dark:border-darkmode-400 text-white text-2xl"> <i class="mr-2" icon-name="clipboard"></i> <a href="${cPath }/employeeInfo/main.do"> 인사정보 </a> </div><!-- text-2xl 글자크기 바꾸기 -->
                        <div class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-4 text-white">  
                            <a href="${cPath }/employeeInfo/dutyManagement/main.do" class="flex items-center px-3 py-2 ${level2Menu == 'dutyManagement' ? 'rounded-md bg-white/10 dark:bg-darkmode-700 font-medium' : 'mt-2 rounded-md'}"> <i class="w-4 h-4 mr-2" icon-name="user-check"></i> <spring:message code="level2Menu.dutyManagement"/> </a>
                            <div class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2" icon-name="user"></i> <spring:message code="level2Menu.myInfo"/> </div>    
	                            <a href="${cPath }/employeeInfo/myInfo/workStatus.do" class="flex items-center px-3 py-2 pl-6 ${level3Menu == 'workStatus' ? 'rounded-md bg-white/10 dark:bg-darkmode-700 font-medium' : 'mt-2 rounded-md'}"> <div class="w-1 h-1 rounded-full mr-3" style="background:white;"></div> <spring:message code="level3Menu.workStatus"/> </a>
	                            <a href="${cPath }/employeeInfo/myInfo/vacationStatus.do" class="flex items-center px-3 py-2 pl-6 ${level3Menu == 'vacationStatus' ? 'rounded-md bg-white/10 dark:bg-darkmode-700 font-medium' : 'mt-2 rounded-md'}"> <div class="w-1 h-1 rounded-full mr-3" style="background:white;"></div> <spring:message code="level3Menu.vacationStatus"/> </a>
	                            <a href="${cPath }/employeeInfo/myInfo/workingCodition.do" class="flex items-center px-3 py-2 pl-6 ${level3Menu == 'workingCodition' ? 'rounded-md bg-white/10 dark:bg-darkmode-700 font-medium' : 'mt-2 rounded-md'}"> <div class="w-1 h-1 rounded-full mr-3" style="background:white;"></div> <spring:message code="level3Menu.workingCodition"/> </a>
	                            <a href="${cPath }/employeeInfo/myInfo/salaryStatement.do" class="flex items-center px-3 py-2 pl-6 ${level3Menu == 'salaryStatement' ? 'rounded-md bg-white/10 dark:bg-darkmode-700 font-medium' : 'mt-2 rounded-md'}"> <div class="w-1 h-1 rounded-full mr-3" style="background:white;"></div> <spring:message code="level3Menu.salaryStatement"/> </a>
                            <div class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2" icon-name="users"></i> <spring:message code="level2Menu.teamInfo"/> </div>
	                            <a href="${cPath }/employeeInfo/teamInfo/workStatus.do" class="flex items-center px-3 py-2 pl-6 ${level3Menu == 'teamWorkStatus' ? 'rounded-md bg-white/10 dark:bg-darkmode-700 font-medium' : 'mt-2 rounded-md'}"> <div class="w-1 h-1 rounded-full mr-3" style="background:white;"></div> <spring:message code="level3Menu.teamWorkStatus"/> </a>
	                            <a href="${cPath }/employeeInfo/teamInfo/vacationStatus.do" class="flex items-center px-3 py-2 pl-6 ${level3Menu == 'teamVacationStatus' ? 'rounded-md bg-white/10 dark:bg-darkmode-700 font-medium' : 'mt-2 rounded-md'}"> <div class="w-1 h-1 rounded-full mr-3" style="background:white;"></div> <spring:message code="level3Menu.teamVacationStatus"/> </a>
                            <a href="${cPath }/employeeInfo/reports/main.do" class="flex items-center px-3 py-2 ${level2Menu == 'reports' ? 'rounded-md bg-white/10 dark:bg-darkmode-700 font-medium' : 'mt-2 rounded-md'}"> <i class="w-4 h-4 mr-2" icon-name="book-open"></i> <spring:message code="level2Menu.reports"/> </a>
                        </div>
                        <div class="border-t border-white/10 dark:border-darkmode-400 mt-4 pt-4 text-white">
                            <a href="" class="flex items-center px-3 py-2 truncate">
                                <div class="w-2 h-2 bg-pending rounded-full mr-3"></div>
                                Custom Work 
                            </a>
                            <a href="" class="flex items-center px-3 py-2 mt-2 rounded-md truncate">
                                <div class="w-2 h-2 bg-success rounded-full mr-3"></div>
                                Important Meetings 
                            </a>
                            <a href="" class="flex items-center px-3 py-2 mt-2 rounded-md truncate">
                                <div class="w-2 h-2 bg-warning rounded-full mr-3"></div>
                                Work 
                            </a>
                            <a href="" class="flex items-center px-3 py-2 mt-2 rounded-md truncate">
                                <div class="w-2 h-2 bg-pending rounded-full mr-3"></div>
                                Design 
                            </a>
                            <a href="" class="flex items-center px-3 py-2 mt-2 rounded-md truncate">
                                <div class="w-2 h-2 bg-danger rounded-full mr-3"></div>
                                Next Week 
                            </a>
                            <a href="" class="flex items-center px-3 py-2 mt-2 rounded-md truncate"> <i class="w-4 h-4 mr-2" icon-name="plus"></i> Add New Label </a>
                        </div>
                    </div>
                    <!-- END: Inbox Menu -->