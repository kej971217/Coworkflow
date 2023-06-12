<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h4> 웹소켓 샘플 </h4>
<button class="wsControl" data-role="connect">연결수립</button>
<button class="wsControl" data-role="disconnect" disabled="disabled">연결종료</button>
<br />
<input type="text" class="wsControl" id="msgInput"  disabled="disabled"/>
<button class="wsControl" data-role="send"  disabled="disabled">전송</button>
<div id="messageArea">

</div>
<script>
	const messageArea = $("#messageArea");`
	const msgInput = $("#msgInput");
	let ws = null;
	const wsControl = $(".wsControl").on("click", function(event){
		switch (this.dataset.role) {
		case "connect":
			ws = connectWS();
			break;

		case "disconnect":
			ws.close(1000);
			break;
			
		case "send":
			let message = msgInput.val();
			ws.send(message);
			msgInput.val("");
			break;
		}
	});
	
	function connectWS(){
		let ws = new WebSocket("ws://\${document.location.host}${cPath}/ws/echo");
		ws.onopen=function(event){
			console.log(event);
			messageArea.append($("<p>").html("Connect!"));
			wsControl.prop("disabled", (i,v)=>!v);
		}
		ws.onclose=function(event){
			console.log(event);
			messageArea.append($("<p>").html("DisConnect!"));
			wsControl.prop("disabled", (i,v)=>!v);
		}
		ws.onmessage=function(event){
			console.log(event);
			let messageVO = JSON.parse(event.data);
			messageArea.append($("<p>").append(
				$("<span>").addClass("sender").html(messageVO.sender)	
				, $("<span>").addClass("message").html(messageVO.message)	
			));
		}
		return ws;
	}
</script>