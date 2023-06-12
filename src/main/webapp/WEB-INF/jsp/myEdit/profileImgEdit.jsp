<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %> 

<div>
    <div>
        <div>
             <div class="w-60 mx-auto xl:mr-0 xl:ml-6 box">
	             <div class="border-2 border-dashed shadow-sm border-slate-200/60 dark:border-darkmode-400 rounded-md p-5">
	                 <div class="h-40 relative image-fit cursor-pointer mx-auto">
	                     <img class="rounded-md" alt="Coworkflow" src="">
	                     <div class="w-5 h-5 flex items-center justify-center absolute rounded-full tright-0 top-0 -mr-2 -mt-2"></div>
	                 </div>
	                 <div class="mx-auto cursor-pointer relative mt-5">
	                     <button class="btn btn-sm btn-secondary w-full mr-1 mb-2">기본이미지</button>
	                     <button class="btn btn-sm btn-secondary w-full mr-1 mb-2">변경</button>
	                 </div>
	             </div>
	         </div>
        </div>
    <div>
        <input type="button" value="저장"/>
        <input type="button" value="취소"/></div>
    </div>
</div>

