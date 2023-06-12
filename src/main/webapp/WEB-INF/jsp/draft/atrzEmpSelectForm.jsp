<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>  
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<style>
.atrzScrollable-table{
  	display: block;
    height: 150px;
    overflow: auto;
/*     width:360px; */
}
.empListTr{
	width:360px;
}

.empSelectFormBtnBox{
	padding:15px 0px;4
	}
</style>
<div>
    <div>결재라인지정</div>
    <hr>
    	<div  >		소속명
					<select name="team" class="form-select">
						<option value="">전체</option>
						<c:forEach  items="${teamInfo }" var="team">
							<option class="${team.belongTeam }" value="${team.teamId }">${team.teamName }</option>
						</c:forEach>
					</select>
					<br>
					<div>직원명 <input name="atrzEmpName"/> <input type="submit" value="검색"/></div>
				<div class="empSelectFormBtnBox">
					<input type="button" value="결재" onclick="updateSelectedList(event)">
					<input type="button" value="참조" onclick="updateSelectedList(event)">
					<input type="button" value="수신" onclick="updateSelectedList(event)">
				</div>
				<div>
					<table border="1">
					<thead>
						<tr>
							<td colspan=2 >
							<input type="checkbox"/>부서/사원선택</td>
						</tr>
					</thead>
					<tbody id="teamEmpListBody" class="atrzScrollable-table">
						<c:forEach items="${teamEmpList }" var="teamEmp">
							<tr class="${teamEmp.teamId } empListTr">
								<td><input type="checkbox" name="atrzEmp" value="${teamEmp.empId }" data-teamname="${teamEmp.teamName }"/></td>
								<td>[${teamEmp.teamName }] ${teamEmp.positionName } ${teamEmp.empName }</td>
							</tr>
						</c:forEach>
					</tbody>
					</table>
				</div>
				<div class="empSelectFormBtnBox">
					<input type="button" value="삭제">
				</div>
				<div>
					<table border="1" style="width:364.8px; text-align: center;">
						<thead>
						<tr>
							<td><input type="checkbox"/></td>
							<td>no</td>
							<td>열람타입</td>
							<td>부서</td>
							<td>이름</td>
						</tr>
						</thead>
						<tbody id="selectedList">
						
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div style="display: flex; justify-content: center;" class="empSelectFormBtnBox">
			<input type="submit" value="저장"/>
	</div>
	
	
<script type="text/javascript">



$("[name=team]").on("change", function(event){
	console.log(this.value);
	$("#teamEmpListBody > tr").css("display","none");
	$("#teamEmpListBody > tr." +this.value).css("display","block");
})



function updateSelectedList(e) {
    var selectedButton = this.value; // 선택된 버튼의 값
    console.log(this.value)
    var checkBoxes = document.querySelectorAll("#teamEmpListBody input[type='checkbox']:checked");
//    var checkBoxes = $("#teamEmpListBody input[type='checkbox']:checked");
//     checkBoxes.prop('checked',false);
	for(let i=0; i< checkBoxes.length; i++){
		checkBoxes[i].checked = false;
	}


    // 선택된 데이터의 세 번째 <td> 위치에 변경사항을 반영
    var selectedList = document.querySelector("#selectedList");

    var atrzType = e.target.value;
//     selectedList.empty()
    for (var i = 0; i < checkBoxes.length; i++) {
    	
        var tr = document.createElement("tr");
        var td1 = document.createElement("td");
        var td2 = document.createElement("td");
        var td3 = document.createElement("td");
        var td4 = document.createElement("td");
        var td5 = document.createElement("td"); 

        td1.innerHTML = "<input type='checkbox' />";
        td2.textContent = i+1;
        td3.textContent = atrzType; // 선택된 버튼의 값으로 열람타입 입력
        td4.textContent = checkBoxes[i].getAttribute("data-teamname"); // 부서 입력
        td5.textContent = checkBoxes[i].value; // 이름 입력

        tr.appendChild(td1);
        tr.appendChild(td2);
        tr.appendChild(td3);
        tr.appendChild(td4);
        tr.appendChild(td5);

        selectedList.appendChild(tr);
    }
}


	function draftInsert(atrzFormId){
		window.open(`draft.do?what=\${atrzFormId}`, "결재문서", "width=780, height=760")  
	}
	

</script>