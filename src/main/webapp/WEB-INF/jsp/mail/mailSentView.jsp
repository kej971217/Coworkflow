<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div class="mailDetailSentBlock">
	<div class="grid grid-cols-12 gap-6 mt-8">
		<div class="col-span-12 lg:col-span-3 2xl:col-span-2">
			<h2 class="intro-y text-lg font-medium mr-auto mt-2">
				<spring:message code="level2Menu.mailView" />
			</h2>
			<%-- 메일 좌측 사이드 메뉴 include --%>
			<jsp:include page="/includee/mailLeftMenu.jsp"></jsp:include>
		</div>
		<%--  받은 편지함 본문 --%>

		<div class="col-span-12 lg:col-span-9 2xl:col-span-10 mt-10">
			<!-- BEGIN: Inbox Filter -->
			<div class="intro-y inbox box mt-5">
				<div
					class="p-5 flex flex-col-reverse sm:flex-row text-slate-500 border-b border-slate-200/60">
					<div
						class="flex items-center mt-3 sm:mt-0 border-t sm:border-0 border-slate-200/60 pt-5 sm:pt-0 mt-5 sm:mt-0 -mx-5 sm:mx-0 px-5 sm:px-0">
						<!--  ----------------   메일 새로 고침 --------------  -->
						<a href="javascript:history.back()"
							class="w-5 h-5 flex items-center justify-center"> <i
							class="w-4 h-4" icon-name="chevron-left"></i>
						</a>
					</div>
				</div>
				<%-- 메일 데이터 표시 영역 시작 --%>
				<div id="mailPagination">
					<%-- 데이터 항목 표시 --%>
					<div id="mailListIndex" class="intro-y" data-index="{status.index}">
						<div
							class="inline-block sm:block text-slate-600 dark:text-slate-500 bg-slate-100 dark:bg-darkmode-400/70 border-b border-slate-200/60 dark:border-darkmode-400"
							style="background: white">

							<div class="flex px-5 py-3">
								<div class="mr-5 font-semibold">보낸 사람</div>
								<div class="from"></div>
							</div>
							<hr>
							<div class="flex px-5 py-3">
								<div class="mr-5 font-semibold">받는 사람</div>
								<div class="to"></div>
							</div>
							<hr>
							<div class="flex px-5 py-3">
								<div class="mr-5 font-semibold">제목</div>
								<div style="width: 5x;"></div>
								<div class="sub"></div>
							</div>

							<hr>
							<div id="cont"
								class="flex items-center px-5 py-3 mt-8 mb-8 ml-4 mr-4 pt-5 pb-5 pl-5 pr-5"
								style="border: 1px solid #eef1f6; border-radius: 10px;"></div>
						</div>
					</div>
				</div>
				<div id="filesArea"></div>
			</div>
			<!-- END: Inbox Filter -->
			<!-- BEGIN: Inbox Content -->

			<%-- 메일 데이터 표시 영역 종료 --%>
		</div>
	</div>
</div>
<div id="dataPrintArea" style="display: none">
	<div id="allModel">${getEmailList}</div>
</div>
<script>
	/* console.log("보낸 메일 열람"); */

	/* --------------------- 메일 쓰기 버튼 이벤트 시작 ---------------------- */
	function fn_writing(event) {
		location.href = `${cPath}/mail/mailForm/mailWriteForm.do`;
	}

	var compose = document.querySelector("#compose");
	compose.addEventListener("click", function(event) {
		console.log("메일 쓰기 버튼 클릭")
		fn_writing(event);
	});
	/* --------------------- 메일 쓰기 버튼 이벤트 종료 ---------------------- */
	/* --------------------- 모델 객체 확인 시작(JSON으로 변환) ---------------------- */
	var fromServer = document.querySelector("#dataPrintArea #allModel");
	var serverValue = fromServer.innerHTML;
	serverValue = serverValue.toString();
	var serverJSON = JSON.parse(serverValue);
	/* --------------------- 모델 객체 확인 종료(JSON으로 변환) ---------------------- */
	/* --------------------- 받은 메일 입력 시작 ---------------------- */
	var mailPrint = document.querySelector("#mailPagination");
	if (serverJSON.length > 0) {
		{
			var me = document.createTextNode("나");
			var from = document.querySelector(".from");
			from.appendChild(me);

			var mailC = serverJSON[0];

			var to = document.querySelector(".to");
			var receive = mailC['mailSendReceiver'];
			var tANode = document.createTextNode(receive);
			to.appendChild(tANode);

			var subject = mailC['mailSendTitle'];
			var sub = document.querySelector(".sub");
			sub.setAttribute("class", "ml-7");
			var sb = document.createTextNode(subject);
			sub.appendChild(sb);

			var content = mailC['mailSendContent'];
			var contP = document.querySelector("#cont");
			contP.innerHTML = content;/*text/plain 및 text/html 어떤 게 들어올지 모름*/
		}

		/* ------------------------ 첨부파일 출력 ---------------------- */
		var filesArea = document.querySelector("#filesArea");
		var mailItem = serverJSON[0];
		if (mailItem.hasOwnProperty("mailAttachmentId") > 0) {
			var fblock = document.createElement("div");
			fblock.setAttribute("id", "fblock");
			fblock.style.padding = 5;
			filesArea.appendChild(fblock);
			var fblockP = document.querySelector("#fblock");

			var eachf = document.createElement("div");
			eachf.setAttribute("class", "ml-5 mr-5 pt-5 pb-5 font-semibold");
			eachf.setAttribute("id", "attArea");
			eachf.style.color = "#768498";
			fblockP.appendChild(eachf);
			var str = "첨부파일";
			var strN = document.createTextNode(str);
			var attArea = document.querySelector("#fblock #attArea");
			attArea.appendChild(strN);

			/* var hr = document.createElement("hr");
			attArea.appendChild(hr); */

			var mid = document.createElement("div");
			mid.setAttribute("id", "middle");
			mid.setAttribute("class", "pb-3");
			fblockP.appendChild(mid);
			var midP = document.querySelector("#fblock #middle")

			/*  mr-4 pt-5 pb-5 pl-5 pr-5" style="border: 1px solid black; border-radius: 10px;" */
			var eachrf = document.createElement("div");
			eachrf.setAttribute("id", "herefs");
			eachrf.setAttribute("class", "ml-4 mr-4 mb-10 pt-1 pb-1 pl-1 pr-1");
			eachrf.style.display = "center";
			eachrf.style.border = "1px solid #eef1f6";
			eachrf.style.borderRadius = "10px";
			midP.appendChild(eachrf);
			var eachrfP = document.querySelector("#fblock #middle #herefs");

			for (let i = 0; i < serverJSON.length; i++) {
				var click = document.createElement("a");
				click.setAttribute("id", "attachS" + i);
				click.setAttribute("class", "ml-4 mt-5 mb-5");
				click.setAttribute("data-index", i);
				click.style.display = "inline-block";
				var mid = mailItem['mailMessageId'];
				var aid = mailItem['mailAttachmentId'];
				click.href = "${cPath}/mail/mailSent/attachDown.do?what=" + mid
						+ "&for=" + aid;
				var aname = mailItem['mailAttachmentName'];
				click.download = aname;
				eachrfP.appendChild(click);
				var clickP = document.querySelector("#attachS" + i);

				/*        var aTag = document.getElementsByName("a");*/
				var asize = mailItem['mailAttachmentName'];
				var fsize = document.createTextNode(asize);
				clickP.appendChild(fsize);

				var asize = mailItem['mailAttachmentSize'];
				var area = document.createElement("div");
				area.setAttribute("id", "fileSizeArea" + i);
				area.setAttribute("class", "here");
				area.style.display = "inline-block";
				eachrfP.appendChild(area);

				/* --------------------- 첨부파일 사이즈 이벤트 시작 ---------------------- */
				var attachSByte = asize
				console.log("attachSByte : %s", attachSByte);
				var attachSizeKB;
				var attachSizeMB;
				var fileSizeArea = document.querySelector("#fileSizeArea" + i);
				if (Math.floor(attachSByte / 1024) > 0) {
					attachSizeKB = Math.floor(attachSByte / 1024) + " KB";
					fileSizeArea.innerHTML = " (" + attachSizeKB + ")";
					if (Math.floor(attachSizeKB / 1024) > 0) {
						attachSizeMB = Math.floor(attachSizeKB / 1024) + " MB";
						fileSizeArea.innerHTML = " (" + attachSizeMB + ")";
					}
				}
				/* --------------------- 첨부파일 사이즈 이벤트 종료 ---------------------- */
				var br = document.createElement("br");
				eachrfP.appendChild(br);
			}
		}
	}
</script>