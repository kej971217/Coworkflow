<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<!--
Template Name: Midone - HTML Admin Dashboard Template
Author: Left4code
Website: http://www.left4code.com/
Contact: muhammadrizki@left4code.com
Purchase: https://themeforest.net/user/left4code/portfolio
Renew Support: https://themeforest.net/user/left4code/portfolio
License: You must have a valid license purchased only from themeforest(the above link) in order to legally use the theme for your project.
-->
<html lang="en" class="light">
    <!-- BEGIN: Head -->
    <head>
        <meta charset="utf-8">
        <link href="dist/images/logo.svg" rel="shortcut icon">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Midone admin is super flexible, powerful, clean & modern responsive tailwind admin template with unlimited possibilities.">
        <meta name="keywords" content="admin template, Midone Admin Template, dashboard template, flat admin template, responsive admin template, web app">
        <meta name="author" content="LEFT4CODE">
        <title>Error Page - Midone - Tailwind HTML Admin Template</title>
        <!-- BEGIN: CSS Assets-->
        <link rel="stylesheet" href="${cPath}/resources/Rubick/dist/css/app.css" />
        <!-- END: CSS Assets-->
    </head>
    <!-- END: Head -->
    <body class="py-5">
        <div class="container">
            <!-- BEGIN: Error Page -->
            <div class="error-page flex flex-col lg:flex-row items-center justify-center h-screen text-center lg:text-left">
                <div class="-intro-x lg:mr-20">
                    <img alt="Coworkflow" class="h-48 lg:h-auto" src="${cPath}/resources/Rubick/dist/images/error-illustration.svg">
                </div>
                <div class="text-white mt-10 lg:mt-0">
                    <div class="intro-x text-8xl font-medium">400</div>
                    <div class="intro-x text-xl lg:text-3xl font-medium mt-5">Bad Request</div>
                    <div class="intro-x text-lg mt-3">잘못된 요청입니다.</div>
                    <button class="intro-x btn py-3 px-4 text-white border-white dark:border-darkmode-400 dark:text-slate-200 mt-10" onclick="location.href='${cPath}/index.do'">홈으로</button>
                </div>
            </div>
            <!-- END: Error Page -->
        </div>
    </body>
</html>