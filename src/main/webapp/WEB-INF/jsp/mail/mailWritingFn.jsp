<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
    console.log("메일 쓰기 진입");
    /* --------------------- 메일 쓰기 버튼 이벤트 시작 ---------------------- */
    function fn_writing(event) {
        location.href = `${cPath}/mail/mailForm/mailWriteForm.do`;
    }

    var compose = document.querySelector("#compose");
    compose.addEventListener("click", function (event) {
        console.log("메일 쓰기 버튼 클릭")
        fn_writing(event);
    });

    /* --------------------- 메일 쓰기 버튼 이벤트 종료 ---------------------- */
    /* ------------------------- CK 에디터 설정 시작 ------------------------ */
    CKEDITOR.replace(`mailContent`, {
        resize_enabled: false,
        uiColor: '#CCEAEE',
        width: 800,
        height: 400

    });
    /* ------------------------- CK 에디터 설정 종료 ------------------------ */
    /* ------------------------- <select> change 이벤트 시작 ------------------------ */
    var selectedEmails = [];

    /* <select><option> 선택 시 작동*/
    function handleOptionTagClick(e) {
        console.log("메일 계정 클릭 함수 진입");
        var selectedValue = e.target.value;// 클릭하여 선택한 값 변수에 담기
        // e.target.selectedIndex = 0; // 기본 selected 설정해놓은 option으로 돌아가기

        // 선택한 option 값 input에 입력하기
        var mailsAddrInput = document.querySelector("#addrInput");
        mailsAddrInput.value = selectedValue;


        selectedEmails.push(selectedValue);/* 이메일 모으기*/


        /* 새로운 input 생성 */
        var createNewInput = document.createElement("input");
        createNewInput.type = "text";
        createNewInput.id = "addrInput";
        createNewInput.name = "mailSendTo";
        createNewInput.className = "form-control w-full sm:w-72 box px-10";
        createNewInput.placeholder = "<spring:message code="level2Menu.mailSearch"/>";
        createNewInput.oninput = "fn_filterDropDownAddr(e)";

        mailsAddrInput.append(createNewInput);// 기존 input에 추가하기
    }

    var selectBoxElement = document.querySelector("#selectBox");
    selectBoxElement.addEventListener("change", function (e) {
        console.log("메일 쓰기 : 계정 클릭 이벤트 감지");
        handleOptionTagClick(e);
    });
    /* ------------------------- <select> change 이벤트 종료 ------------------------ */

</script>