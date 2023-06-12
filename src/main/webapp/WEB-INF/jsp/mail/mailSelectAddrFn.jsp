<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
    var selectedEmails = [];

    /* <select><option> 선택 시 작동*/
    function handleOptionTagClick(e) {
        console.log("메일 계정 클릭 함수 진입");
        var selectedValue = e.target.value;// 클릭하여 선택한 값 변수에 담기
        // e.target.selectedIndex = 0; // 기본 selected 설정해놓은 option으로 돌아가기

        // 선택한 option 값 input에 입력하기
        var mailsAddrInput = document.querySelector("#mailsAddrInput");
        mailsAddrInput.value = selectedValue;


        selectedEmails.push(selectedValue);/* 이메일 모으기*/


        /* 새로운 input 생성 */
        var createNewInput = document.createElement("input");
        createNewInput.type = "text";
        createNewInput.id = "mailsAddrInput";
        createNewInput.name = "mailsAddrInput";
        createNewInput.className = "form-control w-full sm:w-72 box px-10";
        createNewInput.placeholder = "<spring:message code="level2Menu.mailSearch"/>";
        createNewInput.oninput = "fn_filterDropDownAddr(e)";

        mailsAddrInput.append(createNewInput);// 기존 input에 추가하기
    }

    // /* <select><option> 선택 시 작동*/
    // function handleOnInputOptionClick(e) {
    //     console.log("메일 계정 검색 함수 진입");
    //     if(e.target.tagName !== "OPTION") return;/* option 클릭 아니면 함수 작동 안함 */
    //
    //     var selectedValue = e.target.value;// 클릭하여 선택한 값 변수에 담기
    //     e.target.selectedIndex = 0; // 기본 selected 설정해놓은 option으로 돌아가기
    //
    //     // 선택한 option 값 input에 입력하기
    //     var mailsAddrInput = document.querySelector("#mailsAddrInput");
    //     mailsAddrInput.value = selectedValue;
    //
    //
    //     selectedEmails.push(selectedValue);/* 이메일 모으기*/
    //
    //
    //     /* 새로운 input 생성 */
    //     var createNewInput = document.createElement("input");
    //     createNewInput.type = "text";
    //     createNewInput.id = "mailsAddrInput";
    //     createNewInput.name = "mailsAddrInput";
    //     createNewInput.className = "form-control w-full sm:w-72 box px-10";
    //     createNewInput.oninput = "fn_filterDropDownAddr(e)";
    //
    //     mailsAddrInput.append(createNewInput);// 기존 input에 추가하기
    //
    //     var selectFromElement = document.querySelector("#selectFromBenchmark");
    //     selectFromElement.style.display = "none";
    // }

    // /* input에 문자열 입력 시 작동 */
    // function fn_filterDropDownAddr(e) {
    //     if(e.target.tagName !== "OPTION") return;/* option 클릭 아니면 함수 작동 안함 */
    //
    //     var mailsAddrInput = document.querySelector("#mailsAddrInput");
    //     var datasFromDiv = document.querySelector("#onEmails");/* 값 가져오는 곳 block */
    //     var benchMarkEmails = datasFromDiv.querySelectorAll("#emailList");/* 값 가져오는 곳 input 여러 개 : NodeList 객체 : 배열 아님 */
    //
    //     for(let i =0; i <benchMarkEmails.length; i++) {
    //         var benchmarkInput = benchMarkEmails[i];
    //         var onInputValue = mailsAddrInput.value().toLowerCase();/* 키보드로 입력한 값 -> 소문자 변환 */
    //         var inputValue = benchmarkInput.value().toLowerCase();/* 이메일 목록 값 -> 소문자로 변환 */
    //         if((inputValue.indexOf(onInputValue)) !== -1) {
    //             /* 이메일 목록에 일치하는 값이 있음 */
    //             /* <select><option> 만들기 */
    //             var tempSelect = document.createElement("select");
    //             tempSelect.id = "selectFromBenchmark";
    //             tempSelect.className = "form-select col-span-12";
    //             tempSelect.style = "width: 100%;";
    //             var tempInput = document.createElement("input");
    //             tempInput.value = inputValue.value();
    //             tempInput.text = inputValue.dataset.name + "&nbsp│&nbsp" + inputValue.value();
    //
    //             /* HTML 에 위치 시키기 */
    //             tempSelect.appendChild(tempInput);
    //             mailsAddrInput.append(tempSelect);
    //
    //         }
    //         /* 이메일 목록에 키보드로 입력한 값이 포함되지 않음 (일치하는 인덱스 반환 X) */
    //     }
    // }



        // handleOptionTagClick(e);


    document.addEventListener('DOMContentLoaded', function() {
        var selectBoxElement = document.querySelector("#selectBox");
        selectBoxElement.addEventListener("change", function (e) {
            console.log("메일 쓰기 : 계정 클릭 이벤트 감지");
        });
    });



    /* select 말고 다른 곳 클릭하면 select 안 보이게 하기*/



        // if(selectFromElement.contains(e.target)) {
        //     handleOnInputOptionClick(e);
        // } else {
        //     selectFromElement.style.display = "none";
        // }
        //
        //
        // function fn_sendBtn(e) {
        //     var selectAddrJSON = JSON.stringify(selectedEmails);
        //     document.querySelector("#seletedAddrInput").value = selectAddrJSON;
        //     e.target.submit();
        // }
        //
        // var sendBtn = document.querySelector("#sendingButton");
        // if(sendBtn.contains(e.target)) {
        //     fn_sendBtn(e);
        // }

</script>