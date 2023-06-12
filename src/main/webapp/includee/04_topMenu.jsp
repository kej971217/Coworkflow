<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>



<!-- BEGIN: Top Menu -->
<nav class="top-nav">
    <ul>
        <li>
            <!-- 홈 -->
            <a href="${cPath}/" class="top-menu ${level1Menu == 'home' ? 'top-menu--active' : ''}">
                <div class="top-menu__icon"> <i icon-name="home"></i> </div>
                <div class="top-menu__title"> <spring:message code="level1Menu.home"/> </div>
            </a>
        </li>
        <li>
            <!-- 메일 -->
            <a href="${cPath}/mail/mailInbox/mailInboxOpen.do" class="top-menu ${level1Menu == 'mail' ? 'top-menu--active' : ''}">
                <div class="top-menu__icon"> <i icon-name="mail"></i> </div>
                <div class="top-menu__title"> <spring:message code="level1Menu.mail"/> <i icon-name="chevron-down" class="top-menu__sub-icon"></i> </div>
            </a>  
            <ul class="">
                <li>
                    <a href="${cPath}/mail/mailInbox/mailInboxOpen.do" class="top-menu">
                        <div class="top-menu__icon"> <i icon-name="inbox"></i> </div>
                        <div class="top-menu__title"> <spring:message code="level2Menu.mailInbox"/> </div>
                    </a>
                </li>
                <li>
                    <a href="${cPath}/mail/mailSent/sentOpenDB.do" class="top-menu">
                        <div class="top-menu__icon"> <i icon-name="send"></i> </div>
                        <div class="top-menu__title"> <spring:message code="level2Menu.mailSent"/> </div>
                    </a>
                </li>
                <li>
                    <a href="${cPath}/mail/mailDraft/drafts.do" class="top-menu">
                        <div class="top-menu__icon"> <i icon-name="files"></i> </div>
                        <div class="top-menu__title"> <spring:message code="level2Menu.mailDraft"/> </div>
                    </a>
                </li>
                <li>
                    <a href="javascript:;" class="top-menu">
                        <div class="top-menu__icon"> <i icon-name="trash-2"></i> </div>
                        <div class="top-menu__title"> <spring:message code="level2Menu.mailTrash"/> </div>
                    </a>
                </li>
            </ul>
        </li>
        <li>
            <!-- 결재 -->
            <a href="${cPath}/approval/approvalList.do" class="top-menu ${level1Menu == 'approval' ? 'top-menu--active' : ''}">
                <div class="top-menu__icon"> <i icon-name="file-text"></i> </div>
                <div class="top-menu__title"> <spring:message code="level1Menu.approval"/> </div>
            </a>
        </li>
        <!-- 조직도 -->
        <li>
            <a href="${cPath }/organizationChart/main.do" class="top-menu">
                <div class="top-menu__icon"> <i icon-name="git-pull-request"></i> </div>
                <div class="top-menu__title"> <spring:message code="level1Menu.organizationChart"/> </div>
            </a>
        </li>
        <li>
            <!-- 캘린더 -->
            <a href="${cPath}/calendar/calendarList.do" class="top-menu ${level1Menu == 'calendar' ? 'top-menu--active' : ''}">
                <div class="top-menu__icon"> <i icon-name="calendar"></i> </div>
                <div class="top-menu__title"> <spring:message code="level1Menu.calendar"/> </div>
            </a>
        </li>
        <li>
            <!-- 게시판 -->
            <a href="${cPath}/board/notice/noticeBoardList.do" class="top-menu ${level1Menu == 'board' ? 'top-menu--active' : ''}">  
                <div class="top-menu__icon"> <i icon-name="edit-2"></i> </div>
                <div class="top-menu__title"> <spring:message code="level1Menu.board"/> <i icon-name="chevron-down" class="top-menu__sub-icon"></i> </div>
            </a>
            <ul class="">
                <li>
                    <a href="${cPath}/board/notice/noticeBoardList.do" class="top-menu">
                        <div class="top-menu__icon"> <i icon-name="user-check"></i> </div>
                        <div class="top-menu__title"> <spring:message code="level2Menu.noticeBoard"/> </div>
                    </a>
                </li>
                <li>
                    <a href="${cPath}/board/inform/informBoard.do" class="top-menu">
                        <div class="top-menu__icon"> <i icon-name="volume-2"></i> </div>
                        <div class="top-menu__title"> <spring:message code="level2Menu.informBoard"/> </div>
                    </a>
                </li>


                <!-- if 시작 -->


                <li>
                    <a href="${cPath}/board/project/projectBoardList.do" class="top-menu">
                        <div class="top-menu__icon"> <i icon-name="zap"></i> </div>
                        <div class="top-menu__title"> <spring:message code="level2Menu.projectBoard"/> </div>
                    </a>
                </li>


                <!-- if 끝 -->


                <li>
                    <a href="${cPath}/board/club/clubBoardList.do" class="top-menu">
                        <div class="top-menu__icon"> <i icon-name="smile"></i> </div>
                        <div class="top-menu__title"> <spring:message code="level2Menu.clubBoard"/> </div>
                    </a>
                </li>
            </ul>
        </li>
        <li>
            <!-- 인사정보 -->
            <a href="${cPath }/employeeInfo/dutyManagement/main.do" class="top-menu ${level1Menu == 'employeeInfo' ? 'top-menu--active' : ''}">  
                <div class="top-menu__icon"> <i icon-name="clipboard"></i> </div>
                <div class="top-menu__title"> <spring:message code="level1Menu.employeeInfo"/> <i icon-name="chevron-down" class="top-menu__sub-icon"></i> </div>
            </a>
            <ul class="">
                <li>
                    <a href="${cPath }/employeeInfo/dutyManagement/main.do" class="top-menu">
                        <div class="top-menu__icon"> <i icon-name="user-check"></i> </div>
                        <div class="top-menu__title"> <spring:message code="level2Menu.dutyManagement"/> </div>
                    </a>
                </li>
                <li>  
                    <a href="${cPath }/employeeInfo/myInfo/workStatus.do" class="top-menu">
                        <div class="top-menu__icon"> <i icon-name="user"></i> </div>
                        <div class="top-menu__title"> <spring:message code="level2Menu.myInfo"/> <i icon-name="chevron-down" class="top-menu__sub-icon"></i> </div>
                    </a>
                    <ul class="">
                        <li>
                            <a href="${cPath }/employeeInfo/myInfo/workStatus.do" class="top-menu">
                                <div class="top-menu__icon"> <i icon-name="more-horizontal"></i> </div>
                                <div class="top-menu__title"> <spring:message code="level3Menu.workStatus"/> </div>
                            </a>
                        </li>
                        <li>
                            <a href="${cPath }/employeeInfo/myInfo/vacationStatus.do" class="top-menu">
                                <div class="top-menu__icon"> <i icon-name="more-horizontal"></i> </div>
                                <div class="top-menu__title"> <spring:message code="level3Menu.vacationStatus"/> </div>
                            </a>
                        </li>
                        <li>
                            <a href="${cPath }/employeeInfo/myInfo/workingCodition.do" class="top-menu">
                                <div class="top-menu__icon"> <i icon-name="more-horizontal"></i> </div>
                                <div class="top-menu__title"> <spring:message code="level3Menu.workingCodition"/> </div>
                            </a>
                        </li>
                        <li>
                            <a href="${cPath }/employeeInfo/myInfo/salaryStatement.do" class="top-menu">
                                <div class="top-menu__icon"> <i icon-name="more-horizontal"></i> </div>
                                <div class="top-menu__title"> <spring:message code="level3Menu.salaryStatement"/> </div>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="${cPath }/employeeInfo/teamInfo/workStatus.do" class="top-menu">
                        <div class="top-menu__icon"> <i icon-name="users"></i> </div>
                        <div class="top-menu__title"> <spring:message code="level2Menu.teamInfo"/> <i icon-name="chevron-down" class="top-menu__sub-icon"></i> </div>
                    </a>
                    <ul class="">
                        <li>
                            <a href="${cPath }/employeeInfo/teamInfo/workStatus.do" class="top-menu">
                                <div class="top-menu__icon"> <i icon-name="more-horizontal"></i> </div>
                                <div class="top-menu__title"> <spring:message code="level3Menu.teamWorkStatus"/> </div>
                            </a>
                        </li>
                        <li>
                            <a href="${cPath }/employeeInfo/teamInfo/vacationStatus.do" class="top-menu">
                                <div class="top-menu__icon"> <i icon-name="more-horizontal"></i> </div>
                                <div class="top-menu__title"> <spring:message code="level3Menu.teamVacationStatus"/> </div>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="${cPath }/employeeInfo/reports/main.do" class="top-menu">
                        <div class="top-menu__icon"> <i icon-name="book-open"></i> </div>
                        <div class="top-menu__title"> <spring:message code="level2Menu.reports"/> </div>
                    </a>
                </li>
            </ul>
        </li>
        <li>
            <!-- 드라이브 -->
            <a href="${cPath }/drive/main.do" class="top-menu ${level1Menu == 'drive' ? 'top-menu--active' : ''}">
                <div class="top-menu__icon"> <i icon-name="folder"></i> </div>
                <div class="top-menu__title"> <spring:message code="level1Menu.drive"/> </div>
            </a>
        </li>
        <li>
            <!-- 메신저 -->
            <a href="${cPath }/msg/messageList.do" class="top-menu ${level1Menu == 'msg' ? 'top-menu--active' : ''}">
                <div class="top-menu__icon"> <i icon-name="message-circle"></i> </div>
                <div class="top-menu__title"> <spring:message code="level1Menu.msg"/> </div>
            </a>
        </li>
    </ul>
</nav>
<!-- END: Top Menu -->