
    //--------------------------화면 교체 시작--------------------------
    var bodyContent = document.querySelector(".content");
    var inboxMenu = document.querySelector("#inbox-menu");

    var aTagInfos = [
    {id: 'compose', url: '${cPath}/mail/mailForm.do'}
    , {id: 'inbox', url: '${cPath}/mail/mailInbox.do'}
    , {id: 'star', url: '${cPath}/mail/mailStar.do'}
    , {id: 'draft', url: '${cPath}/mail/mailDraft.do'}
    , {id: 'alle', url: '${cPath}/mail/mailAll.do'}
    , {id: 'sent', url: '${cPath}/mail/mailSent.do'}
    , {id: 'spam', url: '${cPath}/mail/mailSpam.do'}
    , {id: 'trash', url: '${cPath}/mail/mailTrash.do'}
    , {id: 'archive', url: '${cPath}/mail/mailArchive.do'}
    ]

    function handleButtonClick(event) {
    event.preventDefault();

    // buttonId(<div>의 id 값)와 일치하는 객체 꺼내기
    var aTagId = event.target.id;
    console.log(aTagId);
    var aTagInfo = aTagInfos.find((anInfo) => anInfo.id === aTagId);
    console.log(aTagInfo);
    // find() : () 내부에 주어진 콜백 함수를, 배열의 각 요소마다 실행.
    //          true를 반환하는 '첫 번째 요소' 반환


    let xhr = new XMLHttpRequest();
    xhr.open("GET", aTagInfo.url, true);
    xhr.onreadystatechange = () => {
    if (xhr.readyState == 4 && xhr.status == 200) {
    console.log("{} 로 이동 성공", aTagInfo.url);

    let startIndex = xhr.responseText.indexOf(`<div class="mailInboxContainer">`);
    let endIndex = xhr.responseText.indexOf(`</div>`);

    if (startIndex >= 0 && endIndex >= 0) {
    var content = xhr.responseText.substring(startIndex, endIndex+6);


    console.log(content);
    bodyContent.innerHTML = content;
} else {
    console.error('<div class="content"> 가 없습니다.');
}

}
}
    xhr.send();
    return false;
}

    inboxMenu.addEventListener('click', (event) => {
    if (event.target.tagName !== "A" && event.target.tagName !== "BUTTON") {
    return;
}
    handleButtonClick(event);
});


    // ---------------화면 교체 종료 --------------------------------

