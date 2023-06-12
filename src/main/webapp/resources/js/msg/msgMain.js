/**
 * 
 */
// 여러 함수에서 사용될 것을 생각해 미리 가져온 정보들.
var modalSubmit = $('#modalSubmit');
const addChatBtn = $('#addChat');
const searchEmpBtn = $('#searchEmpBtn');
var searchEmp = $('#searchEmp');
var msgRoomList = $("#msgRoomList");
var msgEmpList = $("#msgEmpList");
const empModal = $("#empModal");
const loginId = $("#loginId").val();
const messageArea = $("#messageArea");
const msgInput = $("#msgInput");
const sendBtn = $("#sendBtn");
let yourProfile = $("#yourProfile");
let opponent = $("#opponent");
let empDate = $("#empDate");
let lastDate = $("#lastDate");

const client = new StompJs.Client({
		
		brokerURL:`ws://${document.location.host}${$.CPATH}/ws/chatting`,  
		debug:function(str){
//			console.log(str);
		},
		// 받는쪽 설정.
		onConnect:function(frame){
			// 알림용.  
			const subscription = this.subscribe("/user/msg/roomList", function(msgFrame){
				loadChatroomList();
			});
		}
	});

// 같은방 2번 클릭하면 Destination 1번만 설정되게= 들어가지 않게 하기위해.
let roomIdCheck = null;

//0. 직원 데이터 받아오는거.
function empData(){
	$.ajax({
		url : $.CPATH+"/msg/empData",
		method : "post",
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
	         xhrToController.setRequestHeader(headerName, headerValue);
	    },
	    contentType : "application/json",
	}).done(function(resp, textStatus, jqXHR) {
		
		let content = resp.empData.empDate;
	empDate.text(content);	
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : ${status}, 에러메시지 : ${error}`);
	});
}


//1. 채팅방 추가 버튼을 눌렀을 때, 채팅방이벤트
function allSave() {
	chatModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#chatModal"));

	let msgRoomName = $('#chatTitle').val();
	let empInfoId = $('#empInfoId').val();
	let empId = $('#empId').val();
	
	let empListID = empInfoId.split(",");
	
	if(empId.length==1){
		empId = empId[0];
	}
	
	// JSON 데이터 생성
	let sendData = {
			msgRoomName : msgRoomName,
			empInfoId : empInfoId,
	};

	// AJAX 요청
	$.ajax({
		url : $.CPATH+"/chatting/makeRoom",
		type : "post",
		data : JSON.stringify(sendData),
		beforeSend : function(xhrToController){
	         xhrToController.setRequestHeader(headerName, headerValue);
	         xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	    },
		contentType : "application/json",
		success : function(res) {
			
				loadChatroomList();
				chatModal.hide();
				// 모달 숨기기.
				// 모달 내용 비우기
				$('#chatTitle').val('');
				$('#empInfoId').val('');
				$('#empInfoName').val('');

//			for(let i = 0; i<empListID.length; i++){
				
//				let msgEmpId = empListID[i];

//			console.log(msgEmpId);

				client.publish({
					destination:`/user/${empId}/msg/roomList` 
				});
	

				// 알람용 json 데이터 생성.
				let alarmData = {
					// 현재 알람을 보내는 사람 ID
					empId : loginId,
					// 알람을 받아야하는 사람 ID
					apponent : empId,
					alarmContent : `님 새로운 채팅방에 초대 되셨습니다.`,
					almType : `CHAT`
				};
				
//				console.log(alarmData);
				// 알람을 띄우기 위한 publish
				client.publish({
					destination:`/user/${empId}/alarm/newAlarm`, 
					body:JSON.stringify(alarmData),
					headers:{
						"content-type":"application/json"
					}
				});
//		}		
				
		},
		error : function(request, status, error) {
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: 'Something went wrong!'
			});
		}
	});
}
//2. 모달 닫기를 눌렀을때 이벤트.	
function modalClose() {
	$("#chatModal #empId").val("");
}
//3. 직원 선택 모달 취소를 눌렀을때 이벤트.
function modalEmpClose(){
	$("#chatEmp #empInfoName").val("");
// 	$("#empParticipants").close();
}	

//4. 팀명 선택시 해당 팀원 이름만 나오게 만드는 온 체인지
$('#departList').on('change', function(){
		//선택한 요소의 value값을 얻어온다
		depart = $('option:selected', this).val();
		
		$.ajax({
			url : $.CPATH+"/calendar/empList",
			type : 'post',
			data : {  "depart" : depart  },  //==>json 객체타입 방식
			beforeSend : function(xhrToController){
		         xhrToController.setRequestHeader(headerName, headerValue);
		      },
			success : function(res){
				//데이타가 있는지 없는지 비교
				code = "";
				if(res.result){
					$.each(res.empList, function(i,v){
						code += `<option id="empId" value="${v.empId}">${v.empName}</option>`
					})
					$('#empId').html(code);
					$('#empId').trigger('change');
				}else{
					code += `<option value="0">데이터없음</option>`;
				}
			},
			error : function(xhr){
				Swal.fire({
					  icon: 'error',
					  title: 'Oops...',
					  text: 'Something went wrong!'
				});
			},
		})
	})
//5. empId를 넣을때에 이벤트.	
function insertEmpId(){
	$("#empInfoId").val("");
	$("#empInfoName").val("");
	 
	var selectEmpId = $("#empId").val();
	$("#empInfoId").val($("#empInfoId").val()+""+selectEmpId);
	
	var empNameList = $("#empId option:selected");
	empNameList.each(function(){
	    var empName = $(this).text();
		$("#empInfoName").val($("#empInfoName").val()+empName+",");
	});
	$("#empInfoName").val(  ($("#empInfoName").val()).slice(0, ($("#empInfoName").val()).length-1)  );
}

//6.리스트를 다시 받아오는 비동기 요청	
function loadChatroomList(){
	$.ajax({
		url : $.CPATH+"/msg/messageResetList.do",
		method : "post",
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
	         xhrToController.setRequestHeader(headerName, headerValue);
	    },
	    contentType : "application/json",
	}).done(function(resp, textStatus, jqXHR) {
		if(resp.msgInfoList!=null || resp.msgInfoList.length()>0 ){
	msgRoomList.empty();
	//console.log(resp.msgInfoList);     
	
	  
	
	for(var i=0; i<resp.msgInfoList.length; i++){
		if(resp.msgInfoList[i].msgRoom.msgRoomName == null){
			resp.msgInfoList[i].msgRoom.msgRoomName = "";
		}
//	console.log(resp.msgInfoList[i].msgRoom.msgRoomName);
	var content = 		`<div class="intro-x cursor-pointer box relative flex flex-1 items-center p-5 mt-5">  
		                    <div class="w-12 h-12 flex-none image-fit mr-1">`;
		                    

			 if( resp.msgInfoList[i].mypage!=null  ) { 
               content += `<img alt="Coworkflow" class="rounded-full" src="${$.CPATH}/mypage/${resp.msgInfoList[i].mypage.profileImage.empAtchSaveName}">`;
		     } else {
		       content += `<img alt="Coworkflow" class="rounded-full" src="${$.CPATH}/mypage/profile-13.jpg">`;
		     }      
		                        
		                        
		     content+=`            <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
		                    </div>
		                    <div class="ml-2 overflow-hidden flex flex-1 flex-col">
								${resp.msgInfoList[i].msgRoom.msgRoomName}  
		                        <div class="flex items-center" > 
		                            <a href="javascript:;" class="flex flex-1 font-medium" style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;display: block;padding-right: 5px;" data-room-id="${resp.msgInfoList[i].msgRoomId }"> ${resp.msgInfoList[i].apponentName } </a> 
		                            <div class="flex text-xs text-slate-400 text-right">     
									  ${resp.msgInfoList[i].lastMsgDate } 
								</div>
									
		                        </div>
		                        <div class="w-full truncate text-slate-500 mt-0.5"> ${resp.msgInfoList[i].lastMsgContent } </div>
		                    </div>
		                </div>`;
	msgRoomList.append(content);	
			}
		}
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : ${status}, 에러메시지 : ${error}`);
	});
}
	//								&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	//								&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;

// 7. 채팅 리스트 항목 클릭 이벤트 처리
msgRoomList.on('click', function(event) {
	
//	let empName = event.target.querySelector('a').val().trim();

// 클릭된 요소가 채팅 리스트의 항목인지 확인
  if (event.target.classList.contains('intro-x')) {
    // 클릭된 채팅 리스트 항목의 데이터 가져오기
//	console.log(event.target);
	let roomTag = event.target;
   	roomId = event.target.querySelector('a').dataset.roomId; // 채팅방 ID
    let apponontName = event.target.querySelector('a').innerText; // 상대방 이름
	let imgSaveName = event.target.querySelector('img').src; // 상대방 이미지
	let selectedLastDate = event.target.querySelector('.flex.text-xs.text-slate-400.text-right').innerText; // 마지막 메시지 전송시간
//	alert(`${$.CPATH}/chatting/enter/${roomId}`);
    // 채팅방으로 이동하는 코드 작성  
if(roomId!=null){
// 채팅 디폴트 페이지에서 채팅방 포맷으로 변경.	
$(".chat__box").children("div:nth-child(2)").fadeOut(300, function () {
		// 첫번째 div를 나타나게 한다.		
   $(".chat__box").children("div:nth-child(1)").fadeIn(300, function (el) {
       $(el).removeClass("hidden").removeAttr("style");
    });
});
}


// 채팅방 리스트 가져오기 위해 방으로 들어가는것.
    $.ajax({
		url : `${$.CPATH}/chatting/enter/${roomId}`,
		type : "get",
		beforeSend : function(xhrToController){
	         xhrToController.setRequestHeader(headerName, headerValue);
	         xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	    },
		contentType : "application/json",
// 성공하면!	
		success : function(res) {
		findedRoom = res.findedRoom
		yourProfile.attr('src', imgSaveName);  
		opponent.empty();
		opponent.append(apponontName);
		lastDate.empty();
		lastDate.append(selectedLastDate + ' 에 전송됨');  
		
		if(res.messageList.length==0 || res.messageList==null ){
		messageArea.empty();	
			
//			let content = "대화를 시작해보세요!";
//			messageArea.append(content);
		}else{
		
		
	messageArea.empty();	
//	console.log(res);  		
	for(var i=0; i<res.messageList.length; i++){		
			
			if(res.messageList[i].empId==loginId){
				let myMsgClone = myMsgTemplate.content.cloneNode(true);
				const myUlDiv = $(myMsgClone).find("div").eq(2);
				const myMsgSpan = $(myMsgClone).find(".msgarea");
				const myTimeDiv = $(myMsgClone).find("div").eq(4);
				const myImgDiv = $(myMsgClone).find("div").eq(5);
				
				myTimeDiv.html(res.messageList[i].msgDate)
				myMsgSpan.html(res.messageList[i].msgContent)
				myImgDiv.html(`<img alt="Coworkflow" class="rounded-full" src="${$.CPATH}/mypage/${res.messageList[i].empAtchSaveName}">`);
			messageArea.append(myMsgClone);
				
			}else{
				let msgClone = nonMyMsgTemplate.content.cloneNode(true);
				const imgDiv = $(msgClone).find("div").eq(1);
				const msgSpan = $(msgClone).find(".msgarea");
				const timeDiv = $(msgClone).find("div").eq(3);
				const ulDiv = $(msgClone).find("div").eq(5);
				
				imgDiv.html(`<img alt="Coworkflow" class="rounded-full" src="${$.CPATH}/mypage/${res.messageList[i].empAtchSaveName}">`);    
				timeDiv.html(res.messageList[i].msgDate)	
				msgSpan.html(res.messageList[i].msgContent)
			messageArea.append(msgClone);
				}                     
			messageArea.append($("<div>").addClass("clear-both"))
			}
			setTimeout(function(){
			$('#messageArea').scrollTop(999999); // 채팅 치면 마지막 메시지 보이게!!!  
			}, 800);    
	}	
	
//	console.log(roomIdCheck);
//	console.log(findedRoom.destination);
		// 기존 방인지 확인하기 위해 추가.
	if(roomIdCheck==findedRoom.destination){
	
	}else{
// 구독 설정!	
const subscription1 = client.subscribe(`${findedRoom.destination}`, function(msgFrame){
				let messageVO = JSON.parse(msgFrame.body);
				
				console.log(messageVO);
			if(messageVO.empId==loginId){
				let myMsgClone = myMsgTemplate.content.cloneNode(true);
				const myUlDiv = $(myMsgClone).find("div").eq(2);
				const myMsgSpan = $(myMsgClone).find(".msgarea");
				const myTimeDiv = $(myMsgClone).find("div").eq(4);
//				const myTimeDiv = $(myMsgClone).find(".mt-1").eq(4);
				const myImgDiv = $(myMsgClone).find("div").eq(5);
				myTimeDiv.html(messageVO.msgDate)
				myMsgSpan.html(messageVO.msgContent)
				myImgDiv.html(`<img alt="Coworkflow" class="rounded-full" src="${messageVO.empAtchSaveName}">`);  
			messageArea.append(myMsgClone);
			}else{
				let msgClone = nonMyMsgTemplate.content.cloneNode(true);
				const imgDiv = $(msgClone).find("div").eq(1);
				const msgSpan = $(msgClone).find(".msgarea");
//				const timeDiv = $(msgClone).find(".mt-1").eq(3);
				const timeDiv = $(msgClone).find("div").eq(3);
				const ulDiv = $(msgClone).find("div").eq(5);
				timeDiv.html(messageVO.msgDate)	
				msgSpan.html(messageVO.msgContent) 
				myImgDiv.html(`<img alt="Coworkflow" class="rounded-full" src="${messageVO.empAtchSaveName}">`);
			messageArea.append(msgClone);
				
				}                     
			messageArea.append($("<div>").addClass("clear-both"))
				
			});
		// 기존 방 주소 roomIdCheck에 넣어주기.	
		roomIdCheck = findedRoom.destination
		
		}
				
		},
		error : function(request, status, error) {
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: 'Something went wrong!'
			});
		}
	});
	
    
  }
});


// 8. 직원들의 프로필을 가져오는 리스트 
function loadEmpList(){
$.ajax({
		url : $.CPATH+"/msg/excludedMeEmpList",
		method : "post",
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
	         xhrToController.setRequestHeader(headerName, headerValue);
	    },
	    contentType : "application/json",
	}).done(function(resp, textStatus, jqXHR) {
		if(resp.msgEmpList!=null || resp.msgEmpList.length()>0 ){
	msgEmpList.empty();
//	console.log(resp.msgEmpList);
	for(var i=0; i<resp.msgEmpList.length; i++){
	var content = `<div class="cursor-pointer box relative flex items-center p-5 mt-5">
                            <div class="w-12 h-12 flex-none image-fit mr-1">
                                <img alt="Coworkflow" class="rounded-full" src="${$.CPATH}/mypage/${resp.msgEmpList[i].empAtchSaveName }">    
                                <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
                            </div>
                            <div class="ml-2 overflow-hidden">
                                <div class="flex items-center"> <a id="empName" href="" class="font-medium">${resp.msgEmpList[i].empName }</a> </div>
                                <div class="w-full truncate text-slate-500 mt-0.5"> ${resp.msgEmpList[i].teamName } ${resp.msgEmpList[i].positionName },  ${resp.msgEmpList[i].rankName } </div>
                            </div>
                            <div class="dropdown ml-auto">
                                <a class="dropdown-toggle w-5 h-5 block" href="javascript:;" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="more-horizontal" class="w-5 h-5 text-slate-500"></i> </a>
                                <div class="dropdown-menu w-40">
                                    <ul class="dropdown-content">
                                        <li>
                                            <a href="" class="dropdown-item"> <i icon-name="share-2" class="w-4 h-4 mr-2"></i> Share Contact </a>
                                        </li>
                                        <li>
                                            <a href="" class="dropdown-item"> <i icon-name="copy" class="w-4 h-4 mr-2"></i> Copy Contact </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>`;
	msgEmpList.append(content);	
			}
		}
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : ${status}, 에러메시지 : ${error}`);
	});


};

var myDropdownSelect;

window.addEventListener("DOMContentLoaded", ()=>{
	
	loadChatroomList();
	empData();
	loadEmpList();
	
//템플릿을 위해서 사용해야하는것.	
//모달 선택하기
var chatModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#chatModal"));
//모달 등록버튼 선택하기
modalSubmit = $('#modalSubmit');

// 새로운 채팅 추가 버튼 눌렀을떄
addChatBtn.on("click", function() {

	//모달 비우기
	$('#chatTitle').val('');
	$('#empInfoId').val('');
	$('#empInfoName').val('');
	
	// 모달 보여주기
	chatModal.show();
});

// stopm 활성화!
	client.activate();

// 직원 검색 버튼 누르면
	searchEmpBtn.on("click", event=>{
//	searchEmp.on("keyup", event=>{
	
	let empName = searchEmp.val();
	searchEmp.val('');
	if(empName==""){
		
		loadEmpList();
	}else{
		
		let empData = {
			empName : empName 
		}
//	console.log("입력했을떄,",empName);
		$.ajax({
		url : $.CPATH+"/msg/includedName",
		method : "post",
		data : JSON.stringify(empData),
		dataType : "json",
		beforeSend : function(xhrToController){
	         xhrToController.setRequestHeader(headerName, headerValue);
	    },
	    contentType : "application/json",
	}).done(function(resp, textStatus, jqXHR) {
		if(resp.msgEmpList!=null || resp.msgEmpList.length()>0 ){
	msgEmpList.empty();
	
	for(var i=0; i<resp.msgEmpList.length; i++){
	var content = `<div class="cursor-pointer box relative flex items-center p-5 mt-5">
                            <div class="w-12 h-12 flex-none image-fit mr-1">
                                <img alt="Coworkflow" class="rounded-full" src="${$.CPATH}/mypage/${resp.msgEmpList[i].empAtchSaveName }">
                                <div class="w-3 h-3 bg-success absolute right-0 bottom-0 rounded-full border-2 border-white dark:border-darkmode-600"></div>
                            </div>
                            <div class="ml-2 overflow-hidden">
                                <div class="flex items-center" > <a id="empName" href="" class="font-medium">${resp.msgEmpList[i].empName }</a> </div>
                                <div class="w-full truncate text-slate-500 mt-0.5">${resp.msgEmpList[i].teamName } ${resp.msgEmpList[i].positionName },  ${resp.msgEmpList[i].rankName }</div>
                            </div>
                            <div class="dropdown ml-auto">
                                <a class="dropdown-toggle w-5 h-5 block" href="javascript:;" aria-expanded="false" data-tw-toggle="dropdown"> <i icon-name="more-horizontal" class="w-5 h-5 text-slate-500"></i> </a>
                                <div class="dropdown-menu w-40">
                                    <ul class="dropdown-content">
                                        <li>
                                            <a href="" class="dropdown-item"> <i icon-name="share-2" class="w-4 h-4 mr-2"></i> Share Contact </a>
                                        </li>
                                        <li>
                                            <a href="" class="dropdown-item"> <i icon-name="copy" class="w-4 h-4 mr-2"></i> Copy Contact </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>`;
	msgEmpList.append(content);	
			}
		}
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : ${status}, 에러메시지 : ${error}`);
	});

	}
	
	});
	
// sendBtn 을 눌렀을 경우!
	sendBtn.on("click", event=>{
		let sender = loginId;
		let msgContent = msgInput.val();
		let msgDate;

		if(!msgContent.trim()){
        Swal.fire({
            icon: 'fail',
            title: '내용을 입력해주세요.',
        });
		return;
	}
		let sendData = {
			empId : sender,
			msgContent : msgContent,
			msgRoomId: roomId
	};
	// AJAX 요청
$.ajax({
		url : `${$.CPATH}/chatting/addMessage`,
		type : "post",
		data : JSON.stringify(sendData),
		beforeSend : function(xhrToController){
	         xhrToController.setRequestHeader(headerName, headerValue);
	         xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	    },
		contentType : "application/json",
// 성공하면!	
		success : function(res) {
			msgDate =res.msgVO.msgDate
		// 채팅창 비워주기.
		msgInput.val("");
		  
		let payload = {empId:sender, msgContent:msgContent, msgDate:msgDate, empAtchSaveName:$('#topBarImgProfile').attr('src')  }
		client.publish({
			destination:`${findedRoom.destination}`, 
			body:JSON.stringify(payload),
			headers:{
				"content-type":"application/json"
			}
		});
		setTimeout(function(){
			$('#messageArea').scrollTop(999999); // 채팅 치면 마지막 메시지 보이게!!!  
		}, 1200);        
		
		},
		error : function(request, status, error) {
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: 'Something went wrong!'
			});
		}
	});		
		
	});
	
	myDropdownSelect = tailwind.Dropdown.getOrCreateInstance(document.querySelector("#myDropdownSelect"));
	
	
});
	
