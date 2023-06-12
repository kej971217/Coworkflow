<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %> 
                <div class="col------span-12 lg:col-span-4 2xl:col-span-3 flex lg:block flex-col-reverse">
                    <div class="intro-y box mt-6">
                        <div class="relative flex items-center p-5">
                            <div class="w-12 h-12 image-fit">
                                <security:authentication property="principal" var="authMember" />
	                    	<img alt="Coworkflow" class="rounded-full"  src="${cPath }/mypage/<security:authentication property="principal.realUser.mypage.profileImage.empAtchSaveName" />"/>
                            </div>
                            <div class="ml-4 mr-auto">
                                <div class="font-medium text-base">${mypage.empName }</div>
                                <div class="text-slate-500">${mypage.teamName }_${mypage.positionName }</div>
                            </div>
                        </div>
                        <div class="p-5 border-t border-slate-200/60 dark:border-darkmode-400">
                            <a class="flex items-center mt-5 font-medium" href="${cPath}/mypage/mypageEditView.do"> <i icon-name="user" class="w-4 h-4 mr-2"></i> 개인정보 변경 </a>
                            <a class="flex items-center mt-5 font-medium" href="${cPath}/mypage/passChange.do"> <i icon-name="lock" class="w-4 h-4 mr-2"></i> 비밀번호 변경</a>
                            <a class="flex items-center mt-5 font-medium"  href="${cPath}/mypage/atrzSetting.do"> <i icon-name="settings" class="w-4 h-4 mr-2"></i> 결재 설정 </a>
                        </div>
                    </div>
                </div>  