<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			<div class="intro-y box bg-primary p-5 mt-6">
				<div>
<!-- 					<button type="button" onclick="draftFormList()" -->
<%-- 					<button type="button" onclick="location.href='${cPath }/approval/draftFormList.do'" --%>
					<button type="button" onclick="draftFormList()"
						class="btn text-slate-600 dark:text-slate-300 w-full bg-white dark:bg-darkmode-300 dark:border-darkmode-300 mt-1">
						<i class="w-4 h-4 mr-2" icon-name="edit-3"></i>결재작성
					</button>
				</div>
				<div class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
					<a onclick="approvalListJson()" style="cursor: pointer;"    
						class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="user-check"></i> 상신함
					</a><a onclick="runApprovalList()" style="cursor: pointer;"
						class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="settings"></i> 진행중
					</a> <a onclick="aprvAtrzEndList()" style="cursor: pointer;"
						class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="settings"></i> 완료함
					</a> <a onclick="rejectApprovalList()" style="cursor: pointer;"
						class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="settings"></i> 반려함
					</a>
					</div>
					<div class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
					 <a onclick="unsetApprovalList()" style="cursor: pointer;"
						class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="user"></i> 미결함
					</a> <a onclick="preApprovalList()" style="cursor: pointer;"
						class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="users"></i> 예결함
					</a> <a onclick="deputyApprovalList()" style="cursor: pointer;"
						class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="settings"></i> 대결함
					</a> <a onclick="atrzApprovalList()" style="cursor: pointer;"
						class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="settings"></i> 기결함
					</a> 
					</div>
					<div class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
					<a onclick="approvalReciveList()" style="cursor: pointer;"
						class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="git-pull-request"></i> 수신함
					</a> 
					<a onclick="rfrrApprovalList()" style="cursor: pointer;"
						class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="settings"></i> 참조함
					</a> 
					</div>
					<div class="border-t border-white/10 dark:border-darkmode-400 mt-6 pt-6 text-white">
					<a onclick="tempApprovalList()" style="cursor: pointer;"
						class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="user-check"></i> 임시보관문서 </a>
					<a href="${cPath}/mypage/atrzSetting.do" style="cursor: pointer;"  
						class="flex items-center px-3 py-2"> <i class="w-4 h-4 mr-2"
						icon-name="settings"></i> 결재설정
					</a>
				</div>
			</div>