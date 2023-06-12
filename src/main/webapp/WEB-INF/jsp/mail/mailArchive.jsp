<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div class="grid grid-cols-12 gap-6 mt-8">
    <div class="col-span-12 lg:col-span-3 2xl:col-span-2">
        <h2 class="intro-y text-lg font-medium mr-auto mt-2">
            <spring:message code="level2Menu.mailArchive"/>
        </h2>
        <!-- BEGIN: Inbox Menu -->
        <div id="sideMenu">
            <div class="intro-y box bg-primary p-5 mt-6">
                <div>
                    <button id="compose" type="button"
                            class="btn text-slate-600 dark:text-slate-300 w-full bg-white dark:bg-darkmode-300 dark:border-darkmode-300 mt-1">
                        <i class="w-4 h-4 mr-2" icon-name="edit"></i> <spring:message
                            code="level2Menu.mailCompose"/>
                    </button>
                </div>
                <div class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
                    <a id="inbox" href="#" data-url="${cPath}/mail/mailInbox.do"
                       class="flex items-center px-3 py-2 rounded-md bg-white/10 dark:bg-darkmode-700 font-medium">
                        <i
                                class="w-4 h-4 mr-2" icon-name="inbox"></i><spring:message
                            code="level2Menu.mailInbox"/></a>
                    <a id="star" href="#" data-url="${cPath}/mail/mailStar.do"  class="flex items-center px-3 py-2 rounded-md bg-white/10 dark:bg-darkmode-700 font-medium">
                        <i
                                class="w-4 h-4 mr-2"
                                icon-name="star"></i><spring:message
                            code="level2Menu.mailStar"/> </a>
                    <a id="draft" href="#" data-url="${cPath}/mail/mailDraft.do" class="flex items-center px-3 py-2 rounded-md bg-white/10 dark:bg-darkmode-700 font-medium">
                        <i
                                class="w-4 h-4 mr-2"
                                icon-name="files"></i><spring:message
                            code="level2Menu.mailDraft"/> </a>
                    <a id="alle" href="#" data-url="${cPath}/mail/mailAll.do"
                       class="flex items-center px-3 py-2 rounded-md bg-white/10 dark:bg-darkmode-700 font-medium">
                        <i
                                class="w-4 h-4 mr-2" icon-name="mails"></i><spring:message
                            code="level2Menu.mailAll"/></a>
                </div>
                <div class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
                    <a id="sent" href="#" data-url="${cPath}/mail/mailSent.do" class="flex items-center px-3 py-2 rounded-md bg-white/10 dark:bg-darkmode-700 font-medium">
                        <i class="w-4 h-4 mr-2"
                           icon-name="send"></i><spring:message
                            code="level2Menu.mailSent"/> </a>
                    <a id="spam" href="#" data-url="${cPath}/mail/mailSpam.do" class="flex items-center px-3 py-2 mt-2 rounded-md">
                        <i class="w-4 h-4 mr-2"
                           icon-name="alert-triangle"></i><spring:message
                            code="level2Menu.mailSpam"/> </a>
                    <a id="trash" href="#" data-url="${cPath}/mail/mailTrash.do" class="flex items-center px-3 py-2 mt-2 rounded-md">
                        <i class="w-4 h-4 mr-2"
                           icon-name="trash-2"></i><spring:message
                            code="level2Menu.mailTrash"/> </a>
                </div>
                <div class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
                    <a id="archive" href="#" data-url="${cPath}/mail/mailArchive.do"
                       class="flex items-center px-3 py-2 mt-2 rounded-md"> <i class="w-4 h-4 mr-2"
                                                                               icon-name="archive"></i><spring:message
                            code="level2Menu.mailArchive"/> </a>
                </div>
            </div>
        </div>
        <!-- END: Inbox Menu -->
    </div>
    <div class="col-span-12 lg:col-span-9 2xl:col-span-10">
        <!-- BEGIN: Inbox Filter -->
        <div class="intro-y flex flex-col-reverse sm:flex-row items-center">
            <div class="col-span-12 lg:col-span-9 2xl:col-span-10">
                <!-- BEGIN: Inbox Filter -->
                <div class="intro-y flex flex-col-reverse sm:flex-row items-center">
                    <label class="mailReceiver"><spring:message code="level2Menu.mailTo"/> </label>
                    <div class="w-full sm:w-auto relative mr-auto mt-3 sm:mt-0">
                        <button type="button" class="" title="<spring:message code="level2Menu.mailSearch"/>">
                            <i class="w-4 h-4 absolute my-auto inset-y-0 ml-3 left-0 z-10 text-slate-500"
                               icon-name="search"></i>
                        </button>
                        <input type="text" class="form-control w-full sm:w-72 box px-10"
                               placeholder="<spring:message code="level2Menu.mailSearch"/>">
                        <div class="inbox-filter dropdown absolute inset-y-0 mr-3 right-0 flex items-center"
                             data-tw-placement="bottom-start">
                            <i class="dropdown-toggle w-4 h-4 cursor-pointer text-slate-500" role="button"
                               aria-expanded="false" data-tw-toggle="dropdown" icon-name="network"></i>
                            <div class="inbox-filter__dropdown-menu dropdown-menu pt-2">
                                <div class="dropdown-content" style="width: 400px; display: flex;">
                                    <div class="grid grid-cols-12 gap-4 gap-y-3 p-3" style="width: 100%;">
                                        <!-- 버튼 수정중 --------------------------------------------------------------------------------->
                                        <div class="col-span-12">
                                            <label for="input-filter-1" class="form-label text-xs"><spring:message
                                                    code="level2Menu.mailSearchEmployee"/></label>
                                            <div id="input-filter-1"
                                                 class="sm:grid grid-cols-6 gap-2 flex-1 pt-1 col-span-12">
                                                <select id="selectEmployee" class="form-select col-span-12"
                                                        style="width: 100%;">
                                                    <%--                                                    <c:forEach items="${emloyeeList}" var="employee">--%>
                                                    <option selected>직원 동적 호출</option>
                                                    <option>example@gmail.com</option>
                                                    <%--                                                        <option value="${employee.email}">${employee.name}&nbsp;│&nbsp;${employee.email}</option>--%>
                                                    <%--                                                    </c:forEach>--%>
                                                </select>
                                            </div>
                                        </div>
                                        <hr class="col-span-12" style="width: 100%;">
                                        <div class="col-span-12">
                                            <label for="input-filter-2" class="form-label text-xs"><spring:message
                                                    code="level2Menu.mailSearchTeam"/></label>
                                            <div id="input-filter-2"
                                                 class="sm:grid grid-cols-6 gap-2 flex-1 pt-1 col-span-12">
                                                <select id="selectTeam" class="form-select col-span-12"
                                                        style="width: 100%;">
                                                    <%--                                                    <c:forEach items="${emloyeeList}" var="employee">--%>
                                                    <option selected>팀 동적 호출</option>
                                                    <option>예시 : 총무팀</option>
                                                    <%--                                                        <option value="${employee.email}">${employee.name}&nbsp;│&nbsp;${employee.email}</option>--%>
                                                    <%--                                                    </c:forEach>--%>
                                                </select>
                                            </div>
                                        </div>
                                        <hr class="col-span-12" style="width: 100%;">
                                        <div class="col-span-12">
                                            <label for="input-filter-3" class="form-label text-xs"><spring:message
                                                    code="level2Menu.mailSearchDepartment"/></label>
                                            <div id="input-filter-3"
                                                 class="sm:grid grid-cols-6 gap-2 flex-1 pt-1 col-span-12">
                                                <select id="selectDepartment" class="form-select col-span-12"
                                                        style="width: 100%;">
                                                    <%--                                                    <c:forEach items="${emloyeeList}" var="employee">--%>
                                                    <option selected>본부 동적 호출</option>
                                                    <option>예시 : 경영지원 본부</option>
                                                    <%--                                                        <option value="${employee.email}">${employee.name}&nbsp;│&nbsp;${employee.email}</option>--%>
                                                    <%--                                                    </c:forEach>--%>
                                                </select>
                                            </div>
                                        </div>
                                        <hr class="col-span-12" style="width: 100%;">
                                        <div class="col-span-12">
                                            <label for="input-filter-4" class="form-label text-xs"><spring:message
                                                    code="level2Menu.mailSearchAll"/></label>
                                            <div id="input-filter-4"
                                                 class="sm:grid grid-cols-6 gap-2 flex-1 pt-1 col-span-12">
                                                <select id="selectAll" class="form-select col-span-12"
                                                        style="width: 100%;">
                                                    <%--                                                    <c:forEach items="${emloyeeList}" var="employee">--%>
                                                    <option selected>전체 동적 호출</option>
                                                    <option>전체 메일 주소를 호출하지만 보여주지 않음</option>
                                                    <%--                                                        <option value="${employee.email}">${employee.name}&nbsp;│&nbsp;${employee.email}</option>--%>
                                                    <%--                                                    </c:forEach>--%>
                                                </select>
                                            </div>
                                        </div>
                                        <hr class="col-span-12" style="width: 100%;">
                                        <div class="col-span-12">
                                            <label for="input-filter-5" class="form-label text-xs"><spring:message
                                                    code="level2Menu.mailSearchProject"/></label>
                                            <div id="input-filter-5"
                                                 class="sm:grid grid-cols-6 gap-2 flex-1 pt-1 col-span-12">
                                                <select id="selectProject" class="form-select col-span-12"
                                                        style="width: 100%;">
                                                    <%--                                                    <c:forEach items="${emloyeeList}" var="employee">--%>
                                                    <option selected>프로젝트 팀 동적 호출</option>
                                                    <option>예시 : 봄 특화 프로젝트 팀</option>
                                                    <%--                                                        <option value="${employee.email}">${employee.name}&nbsp;│&nbsp;${employee.email}</option>--%>
                                                    <%--                                                    </c:forEach>--%>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-span-12 flex items-center mt-3 justify-end"
                                             style="margin-top: 2rem">
                                            <button id="selectButton" class="btn btn-primary w-32 ml-2"><spring:message
                                                    code="level2Menu.mailSearch"/></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="w-full sm:w-auto flex">
                        <button class="btn btn-primary shadow-md mr-2"><spring:message
                                code="level2Menu.mailDraftSave"/></button>
                    </div>
                    <div class="w-full sm:w-auto flex">
                        <button class="btn btn-primary shadow-md mr-2"><spring:message
                                code="level2Menu.mailSendEmail"/></button>
                    </div>
                </div>
                <!-- END: Inbox Filter -->
                <!-- BEGIN: Inbox Content -->
                <div class="intro-y inbox box mt-5">
                    <div class="p-5 flex flex-col-reverse sm:flex-row text-slate-500 border-b border-slate-200/60">
                        <div class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0">
                            <textarea></textarea>
                        </div>
                    </div>

                </div>
            </div>
        </div>


        <!-- END: Content -->
        <div class="intro-y inbox box mt-5">
            <div class="p-5 flex flex-col-reverse sm:flex-row text-slate-500 border-b border-slate-200/60">
                <div class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0">
                    <input class="form-check-input" type="checkbox">
                    <!--  ----------------   메일 새로 고침 --------------  -->
                    <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4"
                                                                                                     icon-name="refresh-cw"></i>
                    </a>

                </div>
                <div class="flex items-center sm:ml-auto">
                    <div class="">1 - 50 of 5,238 페이징 처리 표시</div>
                    <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4"
                                                                                                     icon-name="chevron-left"></i>
                    </a>
                    <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4"
                                                                                                     icon-name="chevron-right"></i>
                    </a>
                    <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4"
                                                                                                     icon-name="settings"></i>
                    </a>
                </div>
            </div>
            <!--    -------------------  메일  라인  ---------------------    -->
            <div class="overflow-x-auto sm:overflow-x-visible">

                <!-- 메일 한개 당 반복 -->
                <%--<c:forEach items="${emloyeeList}" var="employee">--%>
                <div class="intro-y">
                    <div class="inbox__item inbox__item--active inline-block sm:block text-slate-600 dark:text-slate-500 bg-slate-100 dark:bg-darkmode-400/70 border-b border-slate-200/60 dark:border-darkmode-400">
                        <div class="flex px-5 py-3">
                            <div class="w-72 flex-none flex items-center mr-5">
                                <spring:message code="level2Menu.mailArchiveMails"/>

                                <div class="inbox__item--sender truncate ml-3"> 보낸 사람 이름
                                    <%--<c:forEach items="${emloyeeList}" var="employee">--%>
                                    <%--                                    <div value="${employee.id}">${employee.name}</div>--%>
                                    <%--                             </c:forEach>--%>
                                </div>
                            </div>
                            <div class="w-64 sm:w-auto truncate"><span class="inbox__item--highlight"> 메일 제목</span>
                                <%--<c:forEach items="${emloyeeList}" var="employee">--%>
                                <%--                                    <div value="${employee.id}">${employee.email.title}</div>--%>
                                <%--                             </c:forEach>--%>
                            </div>
                            <div class="inbox__item--time whitespace-nowrap ml-auto pl-10">수신 시간 05:09 AM</div>
                        </div>
                    </div>
                </div>
                <%--                             </c:forEach>--%>
            </div>
        </div>
        <%--                </form:form>--%>
    </div>
</div>
</div>
</div>
<!-- END: Inbox Content -->
<jsp:include page="mailSideMenuClick.jsp"></jsp:include>