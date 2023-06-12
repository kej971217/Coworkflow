<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>    

 <div class="grid grid-cols-12 gap-6 mt-8">
	<div class="col-span-12 lg:col-span-3 2xl:col-span-2">
		  <%-- 결재 좌측 사이드 메뉴 include --%>
		<jsp:include page="/includee/aprvLeftMenu.jsp"></jsp:include>
	</div>
	
    <div class="col-span-12 lg:col-span-9 2xl:col-span-10">
        <div class="grid grid-cols-12 gap-6 mt-5">
			<div  class="intro-y col-span-12 flex flex-wrap xl:flex-nowrap items-center mt-2">
                <div class="flex w-full sm:w-auto">
                	<input type="date" class="form-control box pr-10" style="margin-right:8px;">
                    <input type="date" class="form-control box pr-10" style="margin-right:8px;">
                    <div class="w-48 relative text-slate-500">
                        <input name="searchWord" type="text" class="form-control w-48 box pr-10" placeholder="검색 내용">
                        <i class="w-4 h-4 absolute my-auto inset-y-0 mr-3 right-0" icon-name="search"></i> 
                    </div>
                    <select name="searchType" class="form-select box ml-2">
                        <option value>전제</option>
                        <option value="searchWord">제목</option>
                        <option value="empName">작성자</option>
                    </select>
                </div>
                <div class="hidden xl:block mx-auto text-slate-500"></div>
	                <div class="w-full xl:w-auto flex items-center mt-3 xl:mt-0">
	                    <div class="dropdown">
	                    </div>
	                </div>
				</div>
               		<div id="listTableBody" class="aprvList intro-y col-span-12 overflow-auto 2xl:overflow-visible" data-view-url="${cPath}/approval/draftView.do">
                       <table class="table table-report -mt-2">
                       <c:set var="draftList" value="${draftVO }" />
                       <c:if test="${not empty draftList }">
                           <c:forEach items="${draftList }" var="draft">
                               <tr>
                                   <td>${draft.atrzFormId }</td>
                                   <td class="formSelect">
                                       <c:url value="/approval/draft.do" var="viewURL">
                                       </c:url>
                                       <a onclick="draftInsert(${draft.atrzFormId })">${draft.atrzFormName }</a>
                                   </td>
                               </tr>
                           </c:forEach>
                       </c:if>
                       <c:if test="${empty draftList }">
                           <tr>
                               <td colspan="7">결재양식없음</td>
                           </tr>
                       </c:if>
                       </table>
                   </div>
                  </div>
               </div>
            </div>
        <script src="${cPath }/resources/js/approval/approvalList.js"></script>
        <script type="text/javascript">

              function draftInsert(atrzFormId){
                window.open(`draft.do?what=\${atrzFormId}`, "결재문서", "width=780, height=760")  
            }
          </script>
    </body>