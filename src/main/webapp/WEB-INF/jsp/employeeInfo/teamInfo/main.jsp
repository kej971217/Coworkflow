<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
        <!-- BEGIN: Content -->
        <div class="content">
            <div class="grid grid-cols-12 gap-6 mt-8">
                <div class="col-span-12 lg:col-span-3 2xl:col-span-2">
                    <h2 class="intro-y text-lg font-medium mr-auto mt-2">
                    &nbsp;
                    </h2>   
                    <%-- 인사정보 좌측 사이드 메뉴 include --%>
					<jsp:include page="/includee/employeeInfoLeftMenu.jsp"></jsp:include>
                </div>
                <div class="col-span-12 lg:col-span-9 2xl:col-span-10">
                    <!-- BEGIN: Inbox Filter -->
                    <div class="intro-y flex flex-col-reverse sm:flex-row items-center">
                        <div class="w-full sm:w-auto relative mr-auto mt-3 sm:mt-0">
                            <i class="w-4 h-4 absolute my-auto inset-y-0 ml-3 left-0 z-10 text-slate-500" icon-name="search"></i> 
                            <input type="text" class="form-control w-full sm:w-64 box px-10" placeholder="Search mail">
                            <div class="inbox-filter dropdown absolute inset-y-0 mr-3 right-0 flex items-center" data-tw-placement="bottom-start">
                                <i class="dropdown-toggle w-4 h-4 cursor-pointer text-slate-500" role="button" aria-expanded="false" data-tw-toggle="dropdown" icon-name="chevron-down"></i> 
                                <div class="inbox-filter__dropdown-menu dropdown-menu pt-2">
                                    <div class="dropdown-content">
                                        <div class="grid grid-cols-12 gap-4 gap-y-3 p-3">
                                            <div class="col-span-6">
                                                <label for="input-filter-1" class="form-label text-xs">From</label>
                                                <input id="input-filter-1" type="text" class="form-control flex-1" placeholder="example@gmail.com">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-2" class="form-label text-xs">To</label>
                                                <input id="input-filter-2" type="text" class="form-control flex-1" placeholder="example@gmail.com">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-3" class="form-label text-xs">Subject</label>
                                                <input id="input-filter-3" type="text" class="form-control flex-1" placeholder="Important Meeting">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-4" class="form-label text-xs">Has the Words</label>
                                                <input id="input-filter-4" type="text" class="form-control flex-1" placeholder="Job, Work, Documentation">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-5" class="form-label text-xs">Doesn't Have</label>
                                                <input id="input-filter-5" type="text" class="form-control flex-1" placeholder="Job, Work, Documentation">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-6" class="form-label text-xs">Size</label>
                                                <select id="input-filter-6" class="form-select flex-1">
                                                    <option>10</option>
                                                    <option>25</option>
                                                    <option>35</option>
                                                    <option>50</option>
                                                </select>
                                            </div>
                                            <div class="col-span-12 flex items-center mt-3">
                                                <button class="btn btn-secondary w-32 ml-auto">Create Filter</button>
                                                <button class="btn btn-primary w-32 ml-2">Search</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="w-full sm:w-auto flex">
                            <button class="btn btn-primary shadow-md mr-2">Start a Video Call</button>
                            <div class="dropdown">
                                <button class="dropdown-toggle btn px-2 box" aria-expanded="false" data-tw-toggle="dropdown">
                                    <span class="w-5 h-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="plus"></i> </span>
                                </button>
                                <div class="dropdown-menu w-40">
                                    <ul class="dropdown-content">
                                        <li>
                                            <a href="" class="dropdown-item"> <i icon-name="user" class="w-4 h-4 mr-2"></i> Contacts </a>
                                        </li>
                                        <li>
                                            <a href="" class="dropdown-item"> <i icon-name="settings" class="w-4 h-4 mr-2"></i> Settings </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END: Inbox Filter -->
                    <!-- BEGIN: Inbox Content -->
                    <div class="intro-y inbox box mt-5">
                        <div class="p-5 flex flex-col-reverse sm:flex-row border-b border-slate-200/60">
                            <div class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0">
                                <input class="form-check-input" type="checkbox">
                                <div class="dropdown ml-1" data-tw-placement="bottom-start">
                                    <a class="dropdown-toggle w-5 h-5 block" href="javascript:;" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="chevron-down" class="w-5 h-5"></i> </a>
                                    <div class="dropdown-menu w-32">
                                        <ul class="dropdown-content">
                                            <li> <a href="" class="dropdown-item">All</a> </li>
                                            <li> <a href="" class="dropdown-item">None</a> </li>
                                            <li> <a href="" class="dropdown-item">Read</a> </li>
                                            <li> <a href="" class="dropdown-item">Unread</a> </li>
                                            <li> <a href="" class="dropdown-item">Starred</a> </li>
                                            <li> <a href="" class="dropdown-item">Unstarred</a> </li>
                                        </ul>
                                    </div>
                                </div>
                                <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="refresh-cw"></i> </a>
                                <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="more-horizontal"></i> </a>
                            </div>
                            <div class="flex items-center sm:ml-auto">
                                <div class="">1 - 50 of 5,238</div>
                                <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="chevron-left"></i> </a>
                                <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="chevron-right"></i> </a>
                                <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="settings"></i> </a>
                            </div>
                        </div>
                        <div class="p-5 flex flex-col sm:flex-row items-center text-center sm:text-left"><!-- text-slate-500 글자 연하게 -->
                            <div>컨텐츠 좌측 하단</div>
                            <div class="sm:ml-auto mt-2 sm:mt-0">컨텐츠 우측 하단</div>
                        </div>
                        <div class="p-5 flex flex-col sm:flex-row items-center text-center sm:text-left" style="padding-bottom: 0;">
                            <div>2023년 5월 근무 현황</div>
                            <div class="sm:ml-auto mt-2 sm:mt-0">컨텐츠 우측 하단</div>
                        </div>
                        <div class="p-5 flex flex-col sm:flex-row items-center text-center sm:text-left">
                            <div class="overflow-x-auto" style="width: 100%;">
						    <table class="table table-bordered table-hover">
						        <thead>
						            <tr>
						                <th class="whitespace-nowrap"></th>
						                <th class="whitespace-nowrap">기준근무</th>
						                <th class="whitespace-nowrap">실근무</th>
						                <th class="whitespace-nowrap">휴가</th>
						            </tr>
						        </thead>
						        <tbody>
						            <tr>
						                <td>소정</td>
						                <td>Angelina</td>
						                <td>Jolie</td>
						                <td>@angelinajolie</td>
						            </tr>
						            <tr>
						                <td>연장 . 휴일</td>
						                <td>Brad</td>
						                <td>Pitt</td>
						                <td>@bradpitt</td>
						            </tr>
						            <tr>
						                <td>총 근무</td>
						                <td>Charlie</td>
						                <td>Hunnam</td>
						                <td>@charliehunnam</td>
						            </tr>
						        </tbody>
						    </table>
						</div>
                        </div>
                    </div>
                    <!-- END: Inbox Content -->
                    <!-- BEGIN: Inbox Content2 -->
                    <div class="intro-y inbox box mt-5">
                        <div class="p-5 flex flex-col-reverse sm:flex-row border-b border-slate-200/60">
                            <div class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0">
                                <input class="form-check-input" type="checkbox">
                                <div class="dropdown ml-1" data-tw-placement="bottom-start">
                                    <a class="dropdown-toggle w-5 h-5 block" href="javascript:;" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="chevron-down" class="w-5 h-5"></i> </a>
                                    <div class="dropdown-menu w-32">
                                        <ul class="dropdown-content">
                                            <li> <a href="" class="dropdown-item">All</a> </li>
                                            <li> <a href="" class="dropdown-item">None</a> </li>
                                            <li> <a href="" class="dropdown-item">Read</a> </li>
                                            <li> <a href="" class="dropdown-item">Unread</a> </li>
                                            <li> <a href="" class="dropdown-item">Starred</a> </li>
                                            <li> <a href="" class="dropdown-item">Unstarred</a> </li>
                                        </ul>
                                    </div>
                                </div>
                                <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="refresh-cw"></i> </a>
                                <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="more-horizontal"></i> </a>
                            </div>
                            <div class="flex items-center sm:ml-auto">
                                <div class="">1 - 50 of 5,238</div>
                                <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="chevron-left"></i> </a>
                                <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="chevron-right"></i> </a>
                                <a href="javascript:;" class="w-5 h-5 ml-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="settings"></i> </a>
                            </div>
                        </div>
                        <div class="p-5 flex flex-col sm:flex-row items-center text-center sm:text-left"><!-- text-slate-500 글자 연하게 -->
                            <div>컨텐츠 좌측 하단</div>
                            <div class="sm:ml-auto mt-2 sm:mt-0">컨텐츠 우측 하단</div>
                        </div>
                        <div class="p-5 flex flex-col sm:flex-row items-center text-center sm:text-left" style="padding-bottom: 0">
                            <div>2023년 5월 근무 현황</div>
                            <div class="sm:ml-auto mt-2 sm:mt-0">컨텐츠 우측 하단</div>
                        </div>
                        <div class="p-5 flex flex-col sm:flex-row items-center text-center sm:text-left">
                            <div class="overflow-x-auto" style="width: 100%;">
						    <table class="table table-bordered table-hover">
						        <thead>
						            <tr>
						                <th class="whitespace-nowrap"></th>
						                <th class="whitespace-nowrap">기준근무</th>
						                <th class="whitespace-nowrap">실근무</th>
						                <th class="whitespace-nowrap">휴가</th>
						            </tr>
						        </thead>
						        <tbody>
						            <tr>
						                <td>소정</td>
						                <td>Angelina</td>
						                <td>Jolie</td>
						                <td>@angelinajolie</td>
						            </tr>
						            <tr>
						                <td>연장 . 휴일</td>
						                <td>Brad</td>
						                <td>Pitt</td>
						                <td>@bradpitt</td>
						            </tr>
						            <tr>
						                <td>총 근무</td>
						                <td>Charlie</td>
						                <td>Hunnam</td>
						                <td>@charliehunnam</td>
						            </tr>
						        </tbody>
						    </table>
						</div>
                        </div>
                    </div>
                    <!-- END: Inbox Content2 -->