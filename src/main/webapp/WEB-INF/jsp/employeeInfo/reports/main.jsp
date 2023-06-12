<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <!-- BEGIN: Content -->
        <div class="content">
            <div class="grid grid-cols-12 gap-6 mt-8">
                <div class="col-span-12 lg:col-span-3 2xl:col-span-2">
                    <h2 class="intro-y text-lg font-medium mr-auto mt-2">
                    &nbsp;
                    </h2>   
                    <%-- 인사정보 좌측 사이드 메뉴 include --%>
					<jsp:include page="/includee/employeeInfoLeftMenu.jsp"></jsp:include>
                </div>
                <div class="col-span-12 lg:col-span-9 2xl:col-span-10">
                    <!-- BEGIN: Inbox Filter -->
                    <div class="intro-y flex flex-col-reverse sm:flex-row items-center">
                        <div class="w-full sm:w-auto relative mr-auto mt-3 sm:mt-0">
                            <i class="w-4 h-4 absolute my-auto inset-y-0 ml-3 left-0 z-10 text-slate-500" icon-name="search"></i> 
                            <input type="text" class="form-control w-full sm:w-64 box px-10" placeholder="Search...">  
                            <div class="inbox-filter dropdown absolute inset-y-0 mr-3 right-0 flex items-center" data-tw-placement="bottom-start">
                                <i class="dropdown-toggle w-4 h-4 cursor-pointer text-slate-500" role="button" aria-expanded="false" data-tw-toggle="dropdown" icon-name="chevron-down"></i> 
                                <div class="inbox-filter__dropdown-menu dropdown-menu pt-2">
                                    <div class="dropdown-content">
                                        <div class="grid grid-cols-12 gap-4 gap-y-3 p-3">
                                            <div class="col-span-6">
                                                <label for="input-filter-1" class="form-label text-xs">From</label>
                                                <input id="input-filter-1" type="text" class="form-control flex-1" placeholder="example@gmail.com">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-2" class="form-label text-xs">To</label>
                                                <input id="input-filter-2" type="text" class="form-control flex-1" placeholder="example@gmail.com">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-3" class="form-label text-xs">Subject</label>
                                                <input id="input-filter-3" type="text" class="form-control flex-1" placeholder="Important Meeting">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-4" class="form-label text-xs">Has the Words</label>
                                                <input id="input-filter-4" type="text" class="form-control flex-1" placeholder="Job, Work, Documentation">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-5" class="form-label text-xs">Doesn't Have</label>
                                                <input id="input-filter-5" type="text" class="form-control flex-1" placeholder="Job, Work, Documentation">
                                            </div>
                                            <div class="col-span-6">
                                                <label for="input-filter-6" class="form-label text-xs">Size</label>
                                                <select id="input-filter-6" class="form-select flex-1">
                                                    <option>10</option>
                                                    <option>25</option>
                                                    <option>35</option>
                                                    <option>50</option>
                                                </select>
                                            </div>
                                            <div class="col-span-12 flex items-center mt-3">
                                                <button class="btn btn-secondary w-32 ml-auto">Create Filter</button>
                                                <button class="btn btn-primary w-32 ml-2">Search</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
		                <div class="w-full sm:w-auto flex mt-4 sm:mt-0">
		                    <button class="btn btn-primary shadow-md mr-2" onclick="window.print(); "><i icon-name="printer" class="w-4 h-4 mr-2"></i>Print</button>      
		                    <div class="dropdown ml-auto sm:ml-0">
		                        <button class="dropdown-toggle btn px-2 box" aria-expanded="false" data-tw-toggle="dropdown">
		                            <span class="w-5 h-5 flex items-center justify-center"> <i class="w-4 h-4" icon-name="plus"></i> </span>  
		                        </button>
		                        <div class="dropdown-menu w-40">
		                            <ul class="dropdown-content">
		                                <li>
		                                    <a href="" class="dropdown-item"> <i icon-name="file-plus" class="w-4 h-4 mr-2"></i> New Category </a>
		                                </li>
		                                <li>
		                                    <a href="" class="dropdown-item"> <i icon-name="users" class="w-4 h-4 mr-2"></i> New Group </a>
		                                </li>
		                            </ul>
		                        </div>
		                    </div>
		                </div>
                    </div>
                    <!-- END: Inbox Filter -->
                    
                    
                    
            <!-- BEGIN: HTML Table Data -->
            <div class="intro-y box p-5 mt-5">   
				<ul class="nav nav-link-tabs" role="tablist">
				    <li id="reportTab1" class="nav-item flex-1 text-lg font-bold " role="presentation">  
				    	<button class="nav-link w-full py-2 active" data-tw-toggle="pill" data-tw-target="#reportTab1" type="button" role="tab" aria-controls="reportTab1" aria-selected="true"> 인사현황보고서 </button> 
				    </li>
				    <li id="reportTab2" class="nav-item flex-1 text-lg font-bold" role="presentation"> 
				    	<button class="nav-link w-full py-2" data-tw-toggle="pill" data-tw-target="#reportTab2" type="button" role="tab" aria-controls="reportTab2" aria-selected="false"> 근무현황보고서 </button> 
				    </li>
				    <li id="reportTab3" class="nav-item flex-1 text-lg font-bold" role="presentation"> 
				    	<button class="nav-link w-full py-2" data-tw-toggle="pill" data-tw-target="#reportTab3" type="button" role="tab" aria-controls="reportTab3" aria-selected="false"> 급여현황보고서 </button> 
				    </li>
				</ul>
				<div class="tab-content mt-5">
					<!-- 인사현황보고서 -->
				    <div id="reportTab1" class="tab-pane leading-relaxed active" role="tabpanel" aria-labelledby="reportTab1"> 
				    	<div class="m-10">
				    		<div class="flex flex-row pb-10">  
					    		<h1 class="flex flex-1 text-3xl text-center font-extrabold">인사현황보고서</h1>  
					    		<h1 class="flex text-lg text-right font-bold">작성일&nbsp;|&nbsp;</h1>
					    		<div class="flex text-lg font-bold text-right nowTimeDiv"><%-- 현재 날짜와 시간 --%></div>
					    	</div>
  				    	</div>
				    	<div class="m-3 ml-10 mr-10">
				    	이 보고서는 우리 회사의 인사현황을 깊이 있게 분석하여 어떤 패턴, 트렌드, 특징이 있는지를 이해하는 데 도움을 줄 것입니다. 특히, 직급별, 부서별, 성별, 연령대별 인원 분포에 초점을 맞추고 있습니다.
				    	</div>  
			    		<div class="m-3 ml-10">  
				    		<div class="flex flex-row">  
					    		<h1 class="flex flex-1 text-xl text-center font-bold">1. 직급별 인원 분포</h1>
					    	</div>
					    </div>    
				    	<div class="m-3 ml-10 mr-10">
				    	우리 회사의 직급별 인원 분포는 아래와 같습니다.
				    	</div>  
				    	<div class="flex flex-row mt-10 mb-10" style="justify-content: center; align-items: center;">
					    	<div class="h-[500px] flex flex-row">  
					    		<canvas id="myChart1"></canvas> 
					    	</div>
					    	<div class="ml-5">
						    	<ul>
						    		<li>임원: 3명</li>
						    		<li>수석: 4명</li>
						    		<li>책임: 17명</li>
						    		<li>선임: 231명</li>
						    		<li>사원: 46명</li>
						    	</ul>
					    	</div>
					    </div>	
				    	<div class="m-3 ml-10 mr-10">
				    	세부적으로 보면, '선임' 직급에서 가장 많은 인원이 배치되어 있으며 이는 총 인원의 대부분을 차지하고 있습니다. 그 다음으로 '사원'이 이어지며, 이는 저희 회사에서 기초적인 업무를 담당하고 있는 직급입니다. '책임'은 17명으로 상당히 중요한 역할을 담당하고 있으며, 그 다음으로 '수석'과 '임원'이 이어집니다. 이 분포는 저희 회사에서 선임과 사원이 주를 이루는 동시에, 책임, 수석, 임원 등의 상위 직급도 적절하게 분포되어 있음을 보여줍니다.
				    	</div>  
					    <div class="m-3 ml-10 mr-10">
				    		<div class="flex flex-row">  
					    		<h1 class="flex flex-1 text-xl text-center font-bold">2. 부서별 인원 분포</h1>
					    	</div>
					    </div> 
				    	<div class="m-1 ml-10 mr-10">  
				    	회사의 각 부서별 인원 분포를 살펴보면, '마케팅팀'이 총 54명으로 가장 많은 인원을 확보하고 있습니다. 이는 마케팅 활동이 회사의 주요 업무 중 하나라는 점을 시사하고 있습니다. 그 다음으로는 '지원팀', '전략기획팀', '회계팀', 'ETC영업팀' 등이 뒤를 이어 가며, 이 부서들도 회사의 중요한 역할을 수행하고 있습니다. 한편, '경영지원본부', '제조본부', '영업마케팅본부', '연구개발본부'는 각각 1명의 인원으로 구성되어 있습니다.
				    	</div>  
				    	<div class="flex flex-row mt-10 mb-10" style="justify-content: center; align-items: center;">
					    	<div class="h-[500px] flex flex-row">
					    		<canvas id="myChart2"></canvas>  
					    	</div>
				    	</div>
					    <div class="m-3 ml-10 mr-10">
				    		<div class="flex flex-row">  
					    		<h1 class="flex flex-1 text-xl text-center font-bold">3. 부서별, 성별 인원 분포</h1>
					    	</div>
					    </div> 
				    	<div class="m-1 ml-10 mr-10">
				    	성별 인원 분포를 살펴보면, '마케팅팀'에서 여성의 비율이 가장 높게 나타나며, 54명 중 32명이 여성이라는 결과가 나왔습니다. 이는 마케팅 부문에서 여성의 역할이 중요하게 작용하고 있음을 보여줍니다. '전략기획팀'과 '지원팀'에서도 여성의 비중이 높게 나타났습니다. 이와 반대로, 'IT팀', '생산관리팀', 'ETC영업팀' 등에서는 남성의 비중이 더 높게 나타났습니다. 이런 성별 분포는 각 부서의 특성과 역할, 그리고 여성과 남성이 각각의 업무에서 어떤 역할을 수행하고 있는지를 보여주는 중요한 지표가 될 수 있습니다.
				    	</div>  
				    	<div class="flex flex-row mt-10 mb-10" style="justify-content: center; align-items: center;">
					    	<div class="h-[350px] flex flex-row">  
					    		<canvas id="myChart21"></canvas>  
					    	</div>
				    	</div>
					    <div class="m-3 ml-10 mr-10">
				    		<div class="flex flex-row">  
					    		<h1 class="flex flex-1 text-xl text-center font-bold">4. 부서별, 연령대별 인원 분포</h1>
					    	</div>
					    </div> 
				    	<div class="m-1 ml-10 mr-10">
				    	연령대별 인원 분포를 살펴보면, 'CEO실'에서는 50대 인원이 3명으로 전체를 차지하고 있습니다. 이는 일반적으로 경영진의 연령대가 높은 편이기 때문에 나타나는 결과로 보입니다. 대부분의 부서에서 30대 인원의 비율이 가장 높게 나타났는데, 이는 30대가 경력과 역량 모두를 겸비한 활동적인 연령대로 볼 수 있습니다. 특히 '마케팅팀'에서는 20대와 30대의 인원 수가 거의 비슷하게 나타났습니다. 이는 마케팅 분야가 창의성과 동적인 업무를 요구하기 때문에 젊은 인력이 활발히 활동하고 있음을 보여줍니다.
				    	</div>  
				    	<div class="flex flex-row mt-10 mb-10" style="justify-content: center; align-items: center;">
					    	<div class="h-[350px] flex flex-row">  
					    		<canvas id="myChart22"></canvas>  
					    	</div>
				    	</div>
					    <div class="m-3 ml-10 mr-10">
				    		<div class="flex flex-row">  
					    		<h1 class="flex flex-1 text-xl text-center font-bold">5. 결론</h1>
					    	</div>
					    </div> 
				    	<div class="m-1 ml-10 mr-10 mb-10">  
				    	위의 분석 결과, 우리 회사의 인원 구성은 다양한 직급, 부서, 성별, 연령대에 걸쳐 이루어져 있습니다. 이는 우리 회사가 다양한 시각을 가진 인원들로부터 끊임없는 혁신과 성장을 이뤄내고 있음을 의미합니다.
						<br><br>
						직급별로는 선임과 사원이 주를 이루면서도, 책임, 수석, 임원 등의 상위 직급도 적절하게 구성되어 있어, 업무의 전반적인 흐름을 이해하고 관리할 수 있는 체계가 잘 구축되어 있습니다. 부서별로는 마케팅, 지원, 전략기획 등의 핵심 업무를 담당하는 팀에 많은 인원이 배치되어 있음을 확인할 수 있습니다. 또한 성별 분포는 각 부서의 업무 특성과 연관되어 있는 것으로 나타났으며, 연령대 분포는 부서의 역할과 연관성이 높게 나타났습니다.
						<br>
						성별 분포를 보면, 일부 부서에서는 여성의 비율이 높게 나타나는 반면, 일부 부서에서는 남성의 비율이 높게 나타나는 등 성별에 따른 역할 분배가 이루어지고 있는 것으로 해석할 수 있습니다. 연령대 분포를 보면, 대부분의 부서에서는 30대의 비중이 높은 것으로 나타났으며, 이는 이 연령대에서 경력과 역량을 동시에 갖춘 인력이 많이 분포하고 있음을 시사하고 있습니다.
						<br><br>
						이러한 결과는 저희 회사가 다양한 직급, 부서, 성별, 연령대의 인원으로 구성되어 있어 다양한 관점과 역량을 활용해 업무를 수행하고 있음을 보여주고 있습니다. 이는 회사의 유연성과 다양성을 보장하며, 이를 통해 더 큰 성과를 이끌어 낼 수 있음을 보여줍니다.
						<br>
						또한, 이 결과는 인사정책 및 업무 분배 등에 대한 향후 방향성을 설정하는 데 중요한 참고 자료가 될 수 있습니다. 특히 각 부서의 성별 및 연령대 분포를 고려하여 더욱 공정하고 효과적인 인사 관리 방안을 마련할 수 있을 것입니다.
						<br>
						앞으로도 이러한 데이터 분석을 통해 저희 회사의 인사현황을 계속해서 모니터링하며, 더욱 향상된 조직 문화와 업무 환경을 만들어 나가는데 최선을 다하겠습니다. 이를 통해 직원들의 만족도와 업무 효율성을 높이는 데 기여하며, 회사의 지속적인 성장을 이끌어 나갈 것입니다.
				    	</div>  
				    </div>
				    <!-- 근무현황보고서 -->
				    <div id="reportTab2" class="tab-pane leading-relaxed" role="tabpanel" aria-labelledby="reportTab2"> 
				    	<div class="m-10">
				    		<div class="flex flex-row pb-10">  
					    		<h1 class="flex flex-1 text-3xl text-center font-extrabold">제목</h1>  
					    		<h1 class="flex text-lg text-right font-bold">작성일&nbsp;|&nbsp;</h1>
					    		<div class="flex text-lg font-bold text-right nowTimeDiv"><%-- 현재 날짜와 시간 --%></div>
					    	</div>
					    	<div>
					    	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. 
					    	</div>
				    	</div>
				    	<div class="flex flex-row mt-10 mb-10" style="justify-content: center; align-items: center;">
					    	<div class="h-[400px] flex flex-row"> 
					    		<canvas id="myChart3"></canvas> 
					    	</div>
					    </div>
				    	<div class="m-3 ml-10">  
				    	It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). 
				    	</div>
				    	<div class="flex flex-row mt-10 mb-10" style="justify-content: center; align-items: center;">  
					    	<div class="h-[600px] flex flex-row"> 
					    		<canvas id="myChart4"></canvas>   
					    	</div>
					    </div>
				    	<div class="m-3 ml-10">  
				    	It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). 
				    	</div>
				    </div>
				    <!-- 급여현황보고서 -->
				    <div id="reportTab3" class="tab-pane leading-relaxed" role="tabpanel" aria-labelledby="reportTab3">
				    	<div class="m-10">
				    		<div class="flex flex-row pb-10">  
					    		<h1 class="flex flex-1 text-3xl text-center font-extrabold">제목</h1>  
					    		<h1 class="flex text-lg text-right font-bold">작성일&nbsp;|&nbsp;</h1>
					    		<div class="flex text-lg font-bold text-right nowTimeDiv"><%-- 현재 날짜와 시간 --%></div>
					    	</div>
					    	<div>
					    	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. 
					    	</div>
				    	</div>
				    	<div class="flex flex-row mt-10 mb-10" style="justify-content: center; align-items: center;">
					    	<div class="h-[400px] flex flex-row"> 
					    		<canvas id="myChart5"></canvas> 
					    	</div>
					    </div>
				    	<div class="m-3 ml-10">  
				    	It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). 
				    	</div>
				    	<div class="flex flex-row mt-10 mb-10" style="justify-content: center; align-items: center;">  
					    	<div class="h-[600px] flex flex-row"> 
					    		<canvas id="myChart6"></canvas>   
					    	</div>
					    </div>
				    	<div class="m-3 ml-10">  
				    	It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). 
				    	</div>
				    </div>
				</div>
            </div>




<script>
function getTime(){
	var now = new Date();
	var hour = padStartZero(now.getHours());
	var minute = padStartZero(now.getMinutes());
	var second = padStartZero(now.getSeconds());
	
	var nowTimeDiv = $(".nowTimeDiv");  
	
	var time = `\${hour}:\${minute}:\${second}`;
	
	var dateTime = now.toLocaleString('ko-KR');   
	nowTimeDiv.html(dateTime);  
}

function padStartZero(num){
	return (num).toString().padStart(2,'0');
}
     


// 색상 랜덤으로 뽑는 함수
function randomColor(opacity = 1) {
    const r = Math.floor(Math.random() * 256);
    const g = Math.floor(Math.random() * 256);
    const b = Math.floor(Math.random() * 256);
    return `rgba(\${r}, \${g}, \${b}, \${opacity})`;    
}

function randomSelectedColor(){
    const selectedColor = [
        'rgba(255, 99, 132, 1)',
        'rgba(255, 159, 64, 1)',
        'rgba(255, 205, 86, 1)',
        'rgba(75, 192, 192, 1)',
        'rgba(54, 162, 235, 1)',
        'rgba(153, 102, 255, 1)',
        'rgba(201, 203, 207, 1)'  
    ];
    const randomIndex = Math.floor(Math.random() * selectedColor.length);
    return selectedColor[randomIndex];

}
  

// 직급별 인원 차트에 뽑는 함수
function rankCntDataLoad(){
	$.ajax({  
		url : "${cPath}/employeeInfo/reports/rankCnt.do",
		method : "post",  
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
		var labels = resp.rankCntList.map(function(item) { return item.rankName; });
		var data = resp.rankCntList.map(function(item) { return item.rankCnt; });
		
		var rankSumCnt = resp.rankCntList.reduce(function(sum, item) {
			return sum + item.rankCnt;
		}, 0);
		
		var myChart1 = document.getElementById('myChart1');
		new Chart(myChart1, {
		  type: 'pie',
		  data: {
		    labels: labels,
		    datasets: [{
		      label: '[현재 총: ' + rankSumCnt + '명] 직급별 인원 수 ',
		      data: data,
		      backgroundColor: [
		          'rgba(255, 99, 132, 0.2)',
		          'rgba(255, 159, 64, 0.2)',
		          'rgba(255, 205, 86, 0.2)',
		          'rgba(75, 192, 192, 0.2)',
		          'rgba(54, 162, 235, 0.2)',
		          'rgba(153, 102, 255, 0.2)',
		          'rgba(201, 203, 207, 0.2)'
		      ],
		      borderColor: [
		          'rgb(255, 99, 132)',
		          'rgb(255, 159, 64)',
		          'rgb(255, 205, 86)',
		          'rgb(75, 192, 192)',
		          'rgb(54, 162, 235)',
		          'rgb(153, 102, 255)',
		          'rgb(201, 203, 207)'
		      ],
		      borderWidth: 1
		    }]
		  },
		  options: {
			layout: {
		        padding: {
		            left: 50
		        }
		    },
		    plugins: {
// 			      legend: {
// 			        position: 'right',
// 			      },
// 			      title: {
// 			        display: true,
// 			        text: '직급 분포'
// 			      }  
			 },
		    scales: {
		      y: {
		        beginAtZero: true
		      }
		    }
		  }
		});
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}



// 부서별 직원 수 차트에 뽑는 함수
function depEmpCntDataLoad(){
	$.ajax({
		url : "${cPath}/employeeInfo/reports/depEmpCnt.do",
		method : "post",
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
		let labels = [];
		let data = [];
		
		var depEmpSumCnt = 0;
		for (let i=0; i<resp.depEmpCntList.length; i++) {
			labels.push(resp.depEmpCntList[i].teamName);
			data.push(resp.depEmpCntList[i].teamCnt);
			depEmpSumCnt += resp.depEmpCntList[i].teamCnt;
		}
		
		var myChart2 = document.getElementById('myChart2');
		new Chart(myChart2, {
		  type: 'bar', 
		  data: {
		    labels: labels,
		    datasets: [{
		      label: '[현재 총: ' + depEmpSumCnt + '명] 부서별 인원 수 ',
		      data: data,
		      backgroundColor: [
		          'rgba(255, 99, 132, 0.2)',
		          'rgba(255, 159, 64, 0.2)',
		          'rgba(255, 205, 86, 0.2)',
		          'rgba(75, 192, 192, 0.2)',
		          'rgba(54, 162, 235, 0.2)',
		          'rgba(153, 102, 255, 0.2)',
		          'rgba(201, 203, 207, 0.2)'
		      ],
		      borderColor: [
		          'rgb(255, 99, 132)',
		          'rgb(255, 159, 64)',
		          'rgb(255, 205, 86)',
		          'rgb(75, 192, 192)',
		          'rgb(54, 162, 235)',
		          'rgb(153, 102, 255)',
		          'rgb(201, 203, 207)'
		      ],
		      borderWidth: 1,
		    }]
		  },
		  options: {
			layout: {
		        padding: {
		            left: 100,
		            right: 120
		        }
		    }, 
		    indexAxis: 'y',
		    elements: {
		        bar: {
		          borderWidth: 2,
		        }
		    },
		    responsive: true,
		    plugins: {
//	 	      legend: {
//	 	        position: 'right',
//	 	      },
//	 	      title: {
//	 	        display: true,
//	 	        text: '부서별 인원'
//	 	      }
		    },
			scales: {
		      y: {
		        beginAtZero: true
		      }
		    }
		  }
		});
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}

// 성비 차트에 뽑는 함수
function depGendRatioLoad(){
	$.ajax({
		url : "${cPath}/employeeInfo/reports/depGendRatio.do",
		method : "post",
		data : {},
		dataType : "json",
		beforeSend : function(xhrToController){
			xhrToController.setRequestHeader(headerName, headerValue);
	        xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); // 요청 dataType에 따라 맞게 적어야 함
		}
	}).done(function(resp, textStatus, jqXHR) {
// 		console.log(resp);
		let labels = [];
		let data1 = [];
		let data2 = [];
		for (let i=0; i<resp.depGendRatioList.length; i++) {
			labels.push(resp.depGendRatioList[i].teamName);
// 			data1.push(resp.depGendRatioList[i].femalePercent);
			data1.push(resp.depGendRatioList[i].femaleCnt);
// 			data2.push(resp.depGendRatioList[i].malePercent);
			data2.push(resp.depGendRatioList[i].maleCnt);  
		}
		var myChart21 = document.getElementById('myChart21');
		var myChart21Data = {
		  labels: labels,
			  datasets: [{
			    type: 'bar',
			    label: '여성',
			    data: data1,
			    borderColor: 'rgb(255, 99, 132)',
			    backgroundColor: 'rgba(255, 99, 132, 0.2)',
			    borderWidth: 1
			  }, {
			    type: 'bar',
			    label: '남성',  
			    data: data2,
			    borderColor: 'rgb(54, 162, 235)',
			    backgroundColor: 'rgba(54, 162, 235, 0.2)',
			    borderWidth: 1
			  }]
			};  
		  
		new Chart(myChart21, {
		  type: 'bar',
		  data: myChart21Data,
		  options: {
			  layout: {
		          padding: {
// 		              left: 50  
		          }
		      },
		      responsive: true,
			  scales: {
			  x: {
			      stacked: true,
			  },  
		      y: {
		    	  stacked: true,  
		      }
		    }
		  }
		});
	}).fail(function(jqXHR, status, error) {
		console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
	});
}

// 연령대 비율 차트에 뽑는 함수 ==> R&D팀, CRO팀 안 나와.... 왜?
function depAgeGroupCntLoad(){
    $.ajax({
        url : "${cPath}/employeeInfo/reports/depAgeGroupCnt.do",
        method : "post",
        data : {},
        dataType : "json",
        beforeSend : function(xhrToController){
            xhrToController.setRequestHeader(headerName, headerValue);
            xhrToController.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); 
        }
    }).done(function(resp, textStatus, jqXHR) {
//         console.log(resp);
        let labels = [];
        let datasets = {};  
        for (let i=0; i<resp.depAgeGroupCntList.length; i++) {    
            let teamName = resp.depAgeGroupCntList[i].teamName;
            let ageGroup = resp.depAgeGroupCntList[i].ageGroup;
            let empCnt = resp.depAgeGroupCntList[i].empCnt;  

            if (!labels.includes(teamName)) {
                labels.push(teamName);
            }
            // 모든 라벨(팀 이름)을 대상으로 0으로 초기화된 배열을 생성
            if (!datasets[ageGroup]) {
                const color = randomColor();  
                datasets[ageGroup] = {
                    label: ageGroup + "대",
                    data: new Array(labels.length).fill(0), // all labels are initialized with 0
                    borderColor: color,
                    backgroundColor: color.replace(", 1)", ", 0.2)"),  
                    borderWidth: 1
                };
            }
            // 해당 팀의 연령대 데이터가 위치한 인덱스에 실제 데이터를 넣어줌
            let index = labels.indexOf(teamName);
            datasets[ageGroup].data[index] = empCnt;
        }  
        
        var myChart22 = document.getElementById('myChart22');
        var myChart22Data = {
            labels: labels,
            datasets: Object.values(datasets)
        };

        new Chart(myChart22, {
            type: 'bar',
            data: myChart22Data,
            options: {
                responsive: true,
                scales: {
                    x: { stacked: true },
                    y: { stacked: true }
                }
            }
        });
    }).fail(function(jqXHR, status, error) {
        console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
    });
}




// function contentPrint(){
// 	// DOM Body 영역 가져옴
//     var initBody = document.body.innerHTML;
//     // 프린트 전에 프린트할 영역 선택
// 	window.onbeforeprint = function(){
//         document.body.innerHTML = document.querySelector('.tab-content').innerHTML;
//     }
//     // 프린트 실행
//     window.print();
//     // 프린트 후에 다시 Body영역 처음으로 초기화
//     window.onafterprint = function(){
//         document.body.innerHTML = initBody;
//     }
// }





$(function(){
	getTime();  
	rankCntDataLoad();
	depEmpCntDataLoad();
	depGendRatioLoad();
	depAgeGroupCntLoad();
	

	
	myChart3 = document.getElementById('myChart3');
	
	var myChart3Data = {
	  labels: [
		    'January',
		    'February',
		    'March',
		    'April'
		  ],
		  datasets: [{
		    type: 'bar',
		    label: 'Bar Dataset',
		    data: [10, 20, 30, 40],
		    borderColor: 'rgb(255, 99, 132)',
		    backgroundColor: 'rgba(255, 99, 132, 0.2)'
		  }, {
		    type: 'line',
		    label: 'Line Dataset',
		    data: [50, 50, 50, 50],
		    fill: false,
		    borderColor: 'rgb(54, 162, 235)'
		  }]
		};
	  
	new Chart(myChart3, {
	  type: 'scatter',
	  data: myChart3Data,
	  options: {
		  layout: {
	          padding: {
	              left: 50
	          }
	      },
		  scales: {
	      y: {
	        beginAtZero: true
	      }
	    }
	  }
	});
	
	
	myChart4 = document.getElementById('myChart4');
	
	var myChart4Data = {
	  labels: [
		    'Eating',
		    'Drinking',
		    'Sleeping',
		    'Designing',
		    'Coding',
		    'Cycling',
		    'Running'
		  ],
		  datasets: [{
		    label: 'My First Dataset',
		    data: [65, 59, 90, 81, 56, 55, 40],
		    fill: true,
		    backgroundColor: 'rgba(255, 99, 132, 0.6)',
		    borderColor: 'rgb(255, 99, 132)',
		    pointBackgroundColor: 'rgb(255, 99, 132)',
		    pointBorderColor: '#fff',
		    pointHoverBackgroundColor: '#fff',
		    pointHoverBorderColor: 'rgb(255, 99, 132)'
		  }, {
		    label: 'My Second Dataset',
		    data: [28, 48, 40, 19, 96, 27, 100],
		    fill: true,
		    backgroundColor: 'rgba(54, 162, 235, 0.2)',
		    borderColor: 'rgb(54, 162, 235)',
		    pointBackgroundColor: 'rgb(54, 162, 235)',
		    pointBorderColor: '#fff',
		    pointHoverBackgroundColor: '#fff',
		    pointHoverBorderColor: 'rgb(54, 162, 235)'
		  }]
		};
	
	new Chart(myChart4, {
		  type: 'radar',
		  data: myChart4Data,
		  options: {
			  elements: {
			      line: {
			        borderWidth: 3
			      }
			  },
			  layout: {
				  padding: {
		              left: 50
		          }
		      },
			  scales: {
		      y: {
		        beginAtZero: true
		      }
		    }
		  }
	});    
	
});
</script>
                   