<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="loading">
    <div class="mailInboxBlock">
        <div class="grid grid-cols-12 gap-6 mt-8">
            <div class="col-span-12 lg:col-span-3 2xl:col-span-2">
                <h2 class="intro-y text-lg font-medium mr-auto mt-2">
                    <spring:message code="level2Menu.mailUser"/>
                </h2>
                <!-- BEGIN: Inbox Menu -->
                <div id="sideMenu">
                    <div class="intro-y box bg-primary p-5 mt-6">
                        <div>
                            <button id="compose" type="button"
                                    class="btn text-slate-600 dark:text-slate-300 w-full bg-white dark:bg-darkmode-300 dark:border-darkmode-300 mt-1">
                                <i class="w-4 h-4 mr-2" icon-name="edit"></i>
                                <spring:message code="level2Menu.mailCompose"/>
                            </button>
                        </div>
                        <div
                                class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
                            <a id="inbox" href="${cPath}/mail/mailInbox/inboxOpen.do"
                               class="flex items-center px-3 py-2 rounded-md font-medium ${level2Menu='mailInbox' ? 'top-menu--active' : ''}">
                                <i class="w-4 h-4 mr-2" icon-name="inbox"></i> <spring:message
                                    code="level2Menu.mailInbox"/>
                            </a> <a id="star" href="" data-url="${cPath}/mail/mailStar.do"
                                    class="flex items-center px-3 py-2 rounded-md font-medium ${level2Menu='mailStar' ? 'top-menu--active' : ''}">
                            <i class="w-4 h-4 mr-2" icon-name="star"></i> <spring:message
                                code="level2Menu.mailStar"/>
                        </a> <a id="draft" href="#" data-url="${cPath}/mail/mailDraft.do"
                                class="flex items-center px-3 py-2 rounded-md font-medium ${level2Menu='mailDraft' ? 'top-menu--active' : ''}">
                            <i class="w-4 h-4 mr-2" icon-name="files"></i> <spring:message
                                code="level2Menu.mailDraft"/>
                        </a> <a id="alle" href="#" data-url="${cPath}/mail/mailAll.do"
                                class="flex items-center px-3 py-2 rounded-md font-medium ${level2Menu='mailAll' ? 'top-menu--active' : ''}">
                            <i class="w-4 h-4 mr-2" icon-name="mails"></i> <spring:message
                                code="level2Menu.mailAll"/>
                        </a>
                        </div>
                        <div
                                class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
                            <a id="sent" href="#" data-url="${cPath}/mail/mailSent.do"
                               class="flex items-center px-3 py-2 rounded-md font-medium ${level2Menu='mailSent' ? 'top-menu--active' : ''}">
                                <i class="w-4 h-4 mr-2" icon-name="send"></i> <spring:message
                                    code="level2Menu.mailSent"/>
                            </a> <a id="spam" href="#" data-url="${cPath}/mail/mailSpam.do"
                                    class="flex items-center px-3 py-2 mt-2 rounded-md ${level2Menu='mailSpam' ? 'top-menu--active' : ''}">
                            <i
                                    class="w-4 h-4 mr-2" icon-name="alert-triangle"></i> <spring:message
                                code="level2Menu.mailSpam"/>
                        </a> <a id="trash" href="#" data-url="${cPath}/mail/mailTrash.do"
                                class="flex items-center px-3 py-2 mt-2 rounded-md ${level2Menu='mailTrash' ? 'top-menu--active' : ''}">
                            <i
                                    class="w-4 h-4 mr-2" icon-name="trash-2"></i> <spring:message
                                code="level2Menu.mailTrash"/>
                        </a>
                        </div>
                        <div
                                class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
                            <a id="archive" href="#" data-url="${cPath}/mail/mailArchive.do"
                               class="flex items-center px-3 py-2 mt-2 rounded-md ${level2Menu='mailArchive' ? 'top-menu--active' : ''}">
                                <i
                                        class="w-4 h-4 mr-2" icon-name="archive"></i> <spring:message
                                    code="level2Menu.mailArchive"/>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- END: Inbox Menu -->
            </div>
            <%--  받은 편지함 본문 --%>
            <div class="col-span-12 lg:col-span-9 2xl:col-span-10">
                <div class="intro-y inbox box mt-5">

                </div>
                <!-- END: Inbox Content -->
            </div>
        </div>
    </div>
</div>