/**
 * 
 */
let mypageForm = $("#mypageForm");
const fn_mypageEditForm = function(mypage){
	let retHtml=`
    <table class="table table-bordered m-5 relative w-full" border="1" style="border-collapse: collapse;">
        <tr>
            <th class="mypageHomeTh">입사일</th><td>${mypage.empDate }</td>
            <th class="mypageHomeTh">사번</th><td>${mypage.empNum }</td>
        </tr>
        <tr>
            <th class="mypageHomeTh">아이디</th><td>${mypage.empId }</td>
            <th class="mypageHomeTh">메일주소</th><td>${mypage.infoEmail }</td>
        </tr>
        <tr>
            <th class="mypageHomeTh">이름</th><td>${mypage.empName }</td>
            <th class="mypageHomeTh">성별</th><td>${mypage.empGend }</td>
        </tr>
        <tr>
            <th class="mypageHomeTh">부서</th><td>${mypage.teamName }</td>
            <th class="mypageHomeTh">로그인 비밀번호</th><td> <button class="btn btn-sm btn-secondary w-24 mr-1 mb-2">변경</button></td>
        </tr>
        <tr>
            <th class="mypageHomeTh">직급</th><td>${mypage.empId }</td>
            <th class="mypageHomeTh">결재 비밀번호</th><td><button class="btn btn-sm btn-secondary w-24 mr-1 mb-2">변경</button></td>
        </tr>
        <tr>
            <th class="mypageHomeTh">휴대전화</th><td>${mypage.infoHp }</td>
            <th class="mypageHomeTh">담당업무</th><td>${mypage.empId }</td>
        </tr>
        <tr>
            <th class="mypageHomeTh">내선번호</th><td>${mypage.empId }</td>
            <th class="mypageHomeTh">직책</th><td>${mypage.empId }</td>
        </tr>
        <tr>
            <th class="mypageHomeTh">주소</th><td>${mypage.infoAddr }</td>
            <th class="mypageHomeTh">상세주소</th><td>${mypage.infoAddrdetail }</td>
        </tr>
    </table>
    `;
    mypageForm.html(retHtml);
}


let fn_mypageUpdate = $("[name=mypageUpdate]").on("click", "#updateBtn", function(event){
   event.preventDefault();
   let url = this.action;
   let method = this.method;
   let data = $(this).serialize();
   $.ajax({
      url : url,
      method : method,
      data : data,
      dataType : "json"
   }).done(function(resp, textStatus, jqXHR) {
    console.log(resp)
    mypageForm.empsty();
      
    fn_mypageUpdate(resp)
      
   });
   return false;
});


function changePass(){
                window.open("changePass.do", "비밀번호 변경", "width=400, height=200")  
            }
function profileEdit(){
                window.open(`profileEdit.do`, "프로필 이미지 등록/변경", "width=400, height=400")  
            }
function signEdit(){
                window.open(`signEdit.do`, "결재 이미지 등록/변경", "width=400, height=400")  
            }