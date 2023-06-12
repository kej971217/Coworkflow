<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>    
    
            <!-- BEGIN: Inbox Menu -->
            <div id="sideMenu">
                <div class="intro-y box bg-primary p-5 mt-6">
                    <div>
                        <button id="compose" onclick="return fn_writingMail();" type="button" class="btn text-slate-600 dark:text-slate-300 w-full bg-white dark:bg-darkmode-300 dark:border-darkmode-300 mt-1">
                            <i class="w-4 h-4 mr-2" icon-name="edit"></i>
                            <spring:message code="level2Menu.mailCompose"/>
                        </button>
                    </div>
                    <div class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
                        <a id="inbox" href="${cPath}/mail/mailInbox/mailInboxOpen.do" class="flex items-center px-3 py-2 ${level2Menu == 'mailInbox' ? 'rounded-md bg-white/10 dark:bg-darkmode-700 font-medium' : 'mt-2 rounded-md'}">
                            <i class="w-4 h-4 mr-2" icon-name="inbox"></i> <spring:message code="level2Menu.mailInbox"/>      
                        </a>
                    </div>
                    <div class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-2 text-white">    
                        <a id="sent" href="${cPath}/mail/mailSent/sentOpenDB.do" class="flex items-center px-3 py-2 ${level2Menu == 'mailSent' ? 'rounded-md bg-white/10 dark:bg-darkmode-700 font-medium' : 'mt-2 rounded-md'}">
                            <i class="w-4 h-4 mr-2" icon-name="send"></i> <spring:message code="level2Menu.mailSent"/>
                        </a> 
                        <a id="draft" href="${cPath}/mail/mailDraft/drafts.do" class="flex items-center px-3 py-2 ${level2Menu == 'mailDraft' ? 'rounded-md bg-white/10 dark:bg-darkmode-700 font-medium' : 'mt-2 rounded-md'}">
                        	<i class="w-4 h-4 mr-2" icon-name="files"></i> <spring:message code="level2Menu.mailDraft"/>          
                    	</a>
                    </div>
                    <div
                            class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
                        <a id="trash" href="javascript:;"
                           class="flex items-center px-3 py-2 rounded-md font-medium ${level2Menu='mailInbox' ? 'top-menu--active' : ''}">
                            <i class="w-4 h-4 mr-2" icon-name="trash-2"></i> <spring:message
                                code="level2Menu.mailTrash"/>
                        </a>
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
            </div>
            <!-- END: Inbox Menu -->