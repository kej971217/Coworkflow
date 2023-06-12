<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<div class="border-b border-slate-200/60 dark:border-darkmode-400 text-center sm:text-left">
  <div class="px-5 py-10 sm:px-20 sm:py-20">
    <div class="text-primary font-semibold text-3xl">${noticeBoard.postTitle }</div>
    <div class="border-b-2 dark:border-darkmode-400 whitespace-nowrap"></div>
    <div class="mt-2" style="text-align:right;"><span class="font-medium">${noticeBoard.empId }</span> </div>
    <div class="mt-1" style="text-align:right;">${noticeBoard.postDate }</div>
    <div id="content">${noticeBoard.postContent }</div>
  </div>
</div>