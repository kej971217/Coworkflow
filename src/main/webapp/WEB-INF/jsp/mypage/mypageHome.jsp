<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="content">
            <!-- BEGIN: Profile Info -->
            <div class="intro-y box px-5 pt-5 mt-5">
                <div class="flex flex-col lg:flex-row border-b border-slate-200/60 dark:border-darkmode-400 pb-5 -mx-5">
                    <div class="flex flex-1 px-5 items-center justify-center lg:justify-start">
                        <div class="w-20 h-20 sm:w-24 sm:h-24 flex-none lg:w-32 lg:h-32 image-fit relative">
                            <img alt="Coworkflow" class="rounded-full" src="${cPath}/resources/Rubick/dist/images/profile-5.jpg">
                        </div>
                        <div class="ml-5">
                            <div class="w-24 sm:w-40 truncate sm:whitespace-normal font-medium text-lg">Tom Cruise</div>
                            <div class="text-slate-500">Frontend Engineer</div>
                        </div>
                    </div>
                    <div class="mt-6 lg:mt-0 flex-1 px-5 border-l border-r border-slate-200/60 dark:border-darkmode-400 border-t lg:border-t-0 pt-5 lg:pt-0">
                        <div class="font-medium text-center lg:text-left lg:mt-3">Contact Details</div>
                        <div class="flex flex-col justify-center items-center lg:items-start mt-4">
                            <div class="truncate sm:whitespace-normal flex items-center"> <i icon-name="mail" class="w-4 h-4 mr-2"></i> tomcruise@left4code.com </div>
                            <div class="truncate sm:whitespace-normal flex items-center mt-3"> <i icon-name="instagram" class="w-4 h-4 mr-2"></i> Instagram Tom Cruise </div>
                            <div class="truncate sm:whitespace-normal flex items-center mt-3"> <i icon-name="twitter" class="w-4 h-4 mr-2"></i> Twitter Tom Cruise </div>
                        </div>
                    </div>
                    <div class="mt-6 lg:mt-0 flex-1 flex items-center justify-center px-5 border-t lg:border-0 border-slate-200/60 dark:border-darkmode-400 pt-5 lg:pt-0">
                        <div class="text-center rounded-md w-20 py-3">
                            <div class="font-medium text-primary text-xl">201</div>
                            <div class="text-slate-500">Orders</div>
                        </div>
                        <div class="text-center rounded-md w-20 py-3">
                            <div class="font-medium text-primary text-xl">1k</div>
                            <div class="text-slate-500">Purchases</div>
                        </div>
                        <div class="text-center rounded-md w-20 py-3">
                            <div class="font-medium text-primary text-xl">492</div>
                            <div class="text-slate-500">Reviews</div>
                        </div>
                    </div>
                </div>
                <ul class="nav nav-link-tabs flex-col sm:flex-row justify-center lg:justify-start text-center" role="tablist" >
                    <li id="profile-tab" class="nav-item" role="presentation">
                        <a href="javascript:;" class="nav-link py-4 flex items-center active" data-tw-target="#profile" aria-controls="profile" aria-selected="true" role="tab" > <i class="w-4 h-4 mr-2" icon-name="user"></i> Profile </a>
                    </li>
                    <li id="account-tab" class="nav-item" role="presentation">
                        <a href="javascript:;" class="nav-link py-4 flex items-center" data-tw-target="#account" aria-selected="false" role="tab" > <i class="w-4 h-4 mr-2" icon-name="shield"></i> Account </a>
                    </li>
                    <li id="change-password-tab" class="nav-item" role="presentation">
                        <a href="javascript:;" class="nav-link py-4 flex items-center" data-tw-target="#change-password" aria-selected="false" role="tab" > <i class="w-4 h-4 mr-2" icon-name="lock"></i> Change Password </a>
                    </li>
                    <li id="settings-tab" class="nav-item" role="presentation">
                        <a href="javascript:;" class="nav-link py-4 flex items-center" data-tw-target="#settings" aria-selected="false" role="tab" > <i class="w-4 h-4 mr-2" icon-name="settings"></i> Settings </a>
                    </li>
                </ul>
            </div>
            <!-- END: Profile Info -->
            <div class="tab-content mt-5">
                <div id="profile" class="tab-pane active" role="tabpanel" aria-labelledby="profile-tab">
                    <div class="grid grid-cols-12 gap-6">
                        <!-- BEGIN: Latest Uploads -->
                        <div class="intro-y box col-span-12 lg:col-span-6">
                            <div class="flex items-center px-5 py-5 sm:py-3 border-b border-slate-200/60 dark:border-darkmode-400">
                                <h2 class="font-medium text-base mr-auto">
                                    Latest Uploads
                                </h2>
                                <div class="dropdown ml-auto sm:hidden">
                                    <a class="dropdown-toggle w-5 h-5 block" href="javascript:;" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="more-horizontal" class="w-5 h-5 text-slate-500"></i> </a>
                                    <div class="dropdown-menu w-40">
                                        <ul class="dropdown-content">
                                            <li> <a href="javascript:;" class="dropdown-item">All Files</a> </li>
                                        </ul>
                                    </div>
                                </div>
                                <button class="btn btn-outline-secondary hidden sm:flex">All Files</button>
                            </div>
                            <div class="p-5">
                                <div class="flex items-center">
                                    <div class="file"> <a href="" class="w-12 file__icon file__icon--directory"></a> </div>
                                    <div class="ml-4">
                                        <a class="font-medium" href="">Documentation</a> 
                                        <div class="text-slate-500 text-xs mt-0.5">40 KB</div>
                                    </div>
                                    <div class="dropdown ml-auto">
                                        <a class="dropdown-toggle w-5 h-5 block" href="javascript:;" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="more-horizontal" class="w-5 h-5 text-slate-500"></i> </a>
                                        <div class="dropdown-menu w-40">
                                            <ul class="dropdown-content">
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="users" class="w-4 h-4 mr-2"></i> Share File </a>
                                                </li>
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="trash" class="w-4 h-4 mr-2"></i> Delete </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="flex items-center mt-5">
                                    <div class="file">
                                        <a href="" class="w-12 file__icon file__icon--file">
                                            <div class="file__icon__file-name text-xs">MP3</div>
                                        </a>
                                    </div>
                                    <div class="ml-4">
                                        <a class="font-medium" href="">Celine Dion - Ashes</a> 
                                        <div class="text-slate-500 text-xs mt-0.5">40 KB</div>
                                    </div>
                                    <div class="dropdown ml-auto">
                                        <a class="dropdown-toggle w-5 h-5 block" href="javascript:;" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="more-horizontal" class="w-5 h-5 text-slate-500"></i> </a>
                                        <div class="dropdown-menu w-40">
                                            <ul class="dropdown-content">
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="users" class="w-4 h-4 mr-2"></i> Share File </a>
                                                </li>
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="trash" class="w-4 h-4 mr-2"></i> Delete </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="flex items-center mt-5">
                                    <div class="file"> <a href="" class="w-12 file__icon file__icon--empty-directory"></a> </div>
                                    <div class="ml-4">
                                        <a class="font-medium" href="">Resources</a> 
                                        <div class="text-slate-500 text-xs mt-0.5">0 KB</div>
                                    </div>
                                    <div class="dropdown ml-auto">
                                        <a class="dropdown-toggle w-5 h-5 block" href="javascript:;" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="more-horizontal" class="w-5 h-5 text-slate-500"></i> </a>
                                        <div class="dropdown-menu w-40">
                                            <ul class="dropdown-content">
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="users" class="w-4 h-4 mr-2"></i> Share File </a>
                                                </li>
                                                <li>
                                                    <a href="" class="dropdown-item"> <i icon-name="trash" class="w-4 h-4 mr-2"></i> Delete </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- END: Latest Uploads -->
                        <!-- BEGIN: Work In Progress -->
                        <div class="intro-y box col-span-12 lg:col-span-6">
                            <div class="flex items-center px-5 py-5 sm:py-0 border-b border-slate-200/60 dark:border-darkmode-400">
                                <h2 class="font-medium text-base mr-auto">
                                    Work In Progress
                                </h2>
                                <div class="dropdown ml-auto sm:hidden">
                                    <a class="dropdown-toggle w-5 h-5 block" href="javascript:;" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="more-horizontal" class="w-5 h-5 text-slate-500"></i> </a>
                                    <div class="nav nav-tabs dropdown-menu w-40" role="tablist">
                                        <ul class="dropdown-content">
                                            <li> <a id="work-in-progress-mobile-new-tab" href="javascript:;" data-tw-toggle="tab" data-tw-target="#work-in-progress-new" class="dropdown-item" role="tab" aria-controls="work-in-progress-new" aria-selected="true">New</a> </li>
                                            <li> <a id="work-in-progress-mobile-last-week-tab" href="javascript:;" data-tw-toggle="tab" data-tw-target="#work-in-progress-last-week" class="dropdown-item" role="tab" aria-selected="false">Last Week</a> </li>
                                        </ul>
                                    </div>
                                </div>
                                <ul class="nav nav-link-tabs w-auto ml-auto hidden sm:flex" role="tablist" >
                                    <li id="work-in-progress-new-tab" class="nav-item" role="presentation"> <a href="javascript:;" class="nav-link py-5 active" data-tw-target="#work-in-progress-new" aria-controls="work-in-progress-new" aria-selected="true" role="tab" > New </a> </li>
                                    <li id="work-in-progress-last-week-tab" class="nav-item" role="presentation"> <a href="javascript:;" class="nav-link py-5" data-tw-target="#work-in-progress-last-week" aria-selected="false" role="tab" > Last Week </a> </li>
                                </ul>
                            </div>
                            <div class="p-5">
                                <div class="tab-content">
                                    <div id="work-in-progress-new" class="tab-pane active" role="tabpanel" aria-labelledby="work-in-progress-new-tab">
                                        <div>
                                            <div class="flex">
                                                <div class="mr-auto">Pending Tasks</div>
                                                <div>20%</div>
                                            </div>
                                            <div class="progress h-1 mt-2">
                                                <div class="progress-bar w-1/2 bg-primary" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                        <div class="mt-5">
                                            <div class="flex">
                                                <div class="mr-auto">Completed Tasks</div>
                                                <div>2 / 20</div>
                                            </div>
                                            <div class="progress h-1 mt-2">
                                                <div class="progress-bar w-1/4 bg-primary" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                        <div class="mt-5">
                                            <div class="flex">
                                                <div class="mr-auto">Tasks In Progress</div>
                                                <div>42</div>
                                            </div>
                                            <div class="progress h-1 mt-2">
                                                <div class="progress-bar w-3/4 bg-primary" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                        <a href="" class="btn btn-secondary block w-40 mx-auto mt-5">View More Details</a> 
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- END: Work In Progress -->
                        
                    </div>
                </div>
            </div>
        </div>
        <!-- END: Content -->