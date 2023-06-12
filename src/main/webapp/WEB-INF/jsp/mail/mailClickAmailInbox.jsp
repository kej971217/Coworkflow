<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
    console.log("받은 메일함 진입");
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
    var mailPagination = document.querySelector("#mailPagination");
    function fn_paging(pageNumber, event) {
        console.log("fn_paging 진입");
        location.href = `${cPath}/mail/mailInbox/choicePage.do?page=` + pageNumber;
    }

    fn_viewMail = (e) => {
        console.log("fn_viewMail 함수 시작")
        var clickedRow = e.target.closest("#mailListIndex");
        console.log("clickedRow 인덱스 : %s", clickedRow.dataset.index);

        var index = clickedRow.dataset.index;
        var mailId = document.querySelector("#mailId" + index).value;
        console.log(" 선택한 인덱스 : %s", index);
        console.log(" 선택한 메일 id : %s", mailId);

        location.href = "${cPath}/mail/mailInbox/choiceMail.do?what=" + mailId;


    }


    mailPagination.addEventListener("click", function (e) {
        console.log("메일 행 클릭 이벤트 감지");

        fn_viewMail(e);
    });

</script>