<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<script>
    //--------------------------화면 교체 시작--------------------------
    var compose = document.querySelector("#compose");
    var composeUrl = "${cPath}/mail/mailForm.do"
    compose.addEventListener("click", (event) => {
        event.preventDefault();
        let xhr = new XMLHttpRequest();
        xhr.open("GET", composeUrl, true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("메일쓰기 이동 성공")
                console.log(xhr.responseText);
            } else {
                console.log("비동기 실패")
            }
        }
        xhr.send();
        return false;
    })


</script>