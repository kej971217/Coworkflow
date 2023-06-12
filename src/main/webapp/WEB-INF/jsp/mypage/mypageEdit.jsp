<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>    
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<form:form id="mypageEditForm" modelAttribute="mypage" method="post"  enctype="multipart/form-data">
<div class="content">
            <div class="grid grid-cols-12 gap-6 mt-8">
                <!-- BEGIN: Profile Menu -->
                <jsp:include page="/includee/mypageLeftMenu.jsp"></jsp:include>
                <!-- END: Profile Menu -->
                <div class="col-span-12 lg:col-span-8 2xl:col-span-9">
                    <!-- BEGIN: Display Information -->
                    <div class="intro-y box mt-6 ">
                        <div class="flex text-2xl font-bold items-center p-5 border-b border-slate-200/60 dark:border-darkmode-400">
                            <h2 class="font-medium text-base mr-auto">    
                                기본정보
                            </h2>
                        </div>
                        <div class="p-5">
                            <div class="flex flex-col-reverse xl:flex-row flex-col">
                                <div class="flex-1 mt-6 xl:mt-0">
                                    <div class="grid grid-cols-12 gap-x-5 mt-3">      
                            <security:csrfInput/>
                                        <div class="col-span-12 2xl:col-span-6">
										   <div class="mb-3">  
										       <label for="update-profile-form-1" class="form-label pl-3">이름</label>            
										       <input id="update-profile-form-1" type="text" class="form-control" placeholder="Input text" value="${mypage.empName }" disabled>
										   </div>
										   <div class="mb-3">
										       <label for="update-profile-form-1" class="form-label pl-3">사번</label>
										       <input id="update-profile-form-1" type="text" class="form-control" placeholder="Input text" value="${mypage.empNum }" disabled>
										   </div>
										   <div class="mb-3">
										       <label for="update-profile-form-1" class="form-label pl-3">부서</label>
										       <input id="update-profile-form-1" type="text" class="form-control" placeholder="Input text" value="${mypage.teamName }" disabled>
										   </div>
										   <div>  
										       <label for="update-profile-form-1" class="form-label pl-3">아이디</label>
										       <input id="update-profile-form-1" type="text" class="form-control" placeholder="Input text" value="${mypage.empId }" disabled>
										   </div>
                                        </div>    
                                        <div class="col-span-12 2xl:col-span-6">
                                        	<div class="mb-3">
										       <label for="update-profile-form-1" class="form-label pl-3">성별</label>
										       <input id="update-profile-form-1" type="text" class="form-control" placeholder="Input text" value="${mypage.empGend }" disabled>
										   </div>
										   <div class="mb-3">
										       <label for="update-profile-form-1" class="form-label pl-3">입사일</label>
										       <input id="update-profile-form-1" type="text" class="form-control" placeholder="Input text" value="${mypage.empDate }" disabled>
										   </div>
										   <div class="mb-3">
										       <label for="update-profile-form-1" class="form-label pl-3">직급</label>
										       <input id="update-profile-form-1" type="text" class="form-control" placeholder="Input text" value="${mypage.rankName }" disabled>
										   </div>
										   <div>
										       <label for="update-profile-form-1" class="form-label pl-3">메일주소</label>
										       <input id="update-profile-form-1" type="text" class="form-control" placeholder="Input text" value="${mypage.infoEmail }" disabled>
										   </div>  
                                        </div>
                                    </div>
                                </div>
                                <div>
									<div class="w-60 mx-auto xl:mr-0 xl:ml-6 box">
										<div
											class="border-2 border-dashed shadow-sm border-slate-200/60 dark:border-darkmode-400 rounded-md p-5">
											<div id="previewImg" class="h-60 relative  image-fit cursor-pointer mx-auto">    
												<c:if test="${not empty mypage.profileImage}" >    
													<img id="faciImg" class="rounded-md" src="${cPath }/mypage/${mypage.profileImage.empAtchSaveName}" alt="${mypage.profileImage.empAtchOriginName}" />  
												</c:if>
												<c:if test="${empty mypage.profileImage }" >
													<img alt="Coworkflow" class="rounded-md" src="/Coworkflow/resources/Rubick/dist/images/profile-8.jpg">  
												</c:if>
												<div
													class="w-5 h-5 flex items-center justify-center absolute rounded-full tright-0 top-0 -mr-2 -mt-2"></div>
											</div>
											<div class="mx-auto cursor-pointer relative mt-5">
												<input id="mypageImg" type="file" name="empFiles" class="btn btn-sm btn-secondary w-full mr-1 mb-2"
													onclick="profileEdit()" value="프로필 이미지 등록 / 변경"/>
											</div>
										</div>
									</div>
								</div>
                            </div>
                        </div>
                    </div>
                    <!-- END: Display Information -->
                    <!-- BEGIN: Personal Information -->
                    <div class="intro-y box mt-6">    
                        <div class="flex items-center p-5 border-b border-slate-200/60 dark:border-darkmode-400">
                            <h2 class="font-medium text-base mr-auto">
                                개인정보
                            </h2>
                        </div>
                        <div class="p-5">
	                            <div class="grid grid-cols-12 gap-x-5 mt-3">  
	                                <div class="col-span-12 xl:col-span-6">
	                                    <div class="mb-3">
	                                        <label for="update-profile-form-6" class="form-label pl-3">내선번호</label>
	                                        <form:input path="comTel"  id="update-profile-form-6" type="text" class="form-control"/>
	                                    </div>
	                                    <div class="mt-3">
	                                        <label for="update-profile-form-7" class="form-label pl-3">주소</label>
	                                        <form:input  path="infoAddr" id="update-profile-form-7" type="text" class="form-control" />
	                                    </div>
	                                </div>
	                                <div class="col-span-12 xl:col-span-6">
	                                    <div class="mb-3">  
	                                        <label for="update-profile-form-10" class="form-label pl-3">휴대전화</label>
	                                        <form:input path="infoHp" id="update-profile-form-10" type="text" class="form-control" placeholder="Input text" />
	                                    </div>
	                                    <div class="mt-3">
	                                        <label for="update-profile-form-11" class="form-label pl-3">상세주소</label>
	                                        <form:input path="infoAddrdetail" id="update-profile-form-11" type="text" class="form-control" placeholder="Input text" />
	                                    </div>
	                                </div>
	                            </div>
                         </div>
                         <div class="flex flex-1 justify-end mt-4 border-t p-5">  
                             <button class="btn btn-primary mr-auto w-20">저장</button>   
                         </div>
                        
                    </div>
                    <!-- END: Personal Information -->
                </div>
            </div>
        </div>
                            </form:form>
<script>
	function changePass(){
		window.open(`changePass.do`, "비밀번호변경", "width=400, height=300")  
    }
	
	const mypageImg = document.querySelector("#mypageImg");
    const previewImg = document.querySelector("#previewImg");

    mypageImg.onchange = ()=>{
        let vfile = mypageImg.files[0];
        let vfileReader = new FileReader(); // 파일 읽어주는 아저씨
        
        vfileReader.onload = () =>{
            let vimg = document.createElement("img");
            vimg.src = vfileReader.result; 
            previewImg.appendChild(vimg);
        }
        
        vfileReader.readAsDataURL(vfile);
    }
	
</script>