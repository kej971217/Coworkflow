<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="col-span-12 lg:col-span-6 mt-8">
	<div class="intro-y block sm:flex items-center h-10">
		<h1 class="text-lg font-medium truncate mr-5">동호회</h1>
	</div>
</div>

<style>
	#jpg{
		width: auto;
		height: 200px;
		display: block;
	}
	
	#pag{
	  position: absolute;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	}
</style>


<!-- BEGIN: Content -->
<div class="content">
	<div class="intro-y col-span-12 flex flex-wrap sm:flex-nowrap items-center mt-2">
		<div>
			<select class="w-20 form-select box mt-3 sm:mt-0" id="opt"> <!-- 오른쪽으로 옮기기 -->
				<option>10</option>
				<option>25</option>
				<option>35</option>
				<option>50</option>
			</select>
		</div>
		<div class="hidden md:block mx-auto text-slate-500"></div>
		<div class="w-full sm:w-auto mt-3 sm:mt-0 sm:ml-auto md:ml-0">
			<div class="w-56 relative text-slate-500">
				<input type="text" class="form-control w-56 box pr-10" placeholder="검색"> <i class="w-4 h-4 absolute my-auto inset-y-0 mr-3 right-0" data-lucide="search"></i>
			</div>
		</div>&nbsp
		<button class="btn btn-primary shadow-md mr-2">검색</button>
	</div>	
	
<!-- 	테니스    -->
	<div class="intro-y grid grid-cols-12 gap-6 mt-5">
		<!-- BEGIN: Blog Layout -->
		<div class="intro-y col-span-12 md:col-span-6 xl:col-span-4 box">
			<div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 px-5 py-4">
				<div class="ml-3 mr-auto">
					<a href="" class="font-medium">테니스</a>
				</div>
				<div class="flex text-slate-500 truncate text-xs mt-0.5">2023.05.15
				</div>
			</div>
			<div class="p-5">
				<div class="h-40 2xl:h-56 image-fit" id="jpg">
					<img src="https://d2qgx4jylglh9c.cloudfront.net/kr/wp-content/uploads/2022/03/CK_ti325004362.jpg">
				</div>
				<a href="" class="block font-medium text-base mt-5">주말</a>
				<div class="text-slate-600 dark:text-slate-500 mt-2">오전 10시 ~ 오전 11시 30분</div>
				<div>
				</div>
			</div>
			<div class="flex items-center px-5 py-3 border-t border-slate-200/60 dark:border-darkmode-400">
				<a href=""
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full text-primary bg-primary/10 dark:bg-darkmode-300 dark:text-slate-300 ml-auto tooltip"
					title="Share"> <i icon-name="share-2" class="w-3 h-3"></i>
				</a> 
				<a href="" 
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full bg-primary text-white ml-2 tooltip"
					title="Download PDF"> <i icon-name="bookmark" class="w-3 h-3"></i>
				</a>
			</div>
			<div
				class="px-5 pt-3 pb-5 border-t border-slate-200/60 dark:border-darkmode-400">
				<div class="w-full flex text-slate-500 text-xs sm:text-sm">
					<button class="btn btn-rounded btn-primary-soft w-24 mr-1 mb-2">신청하기</button>
				</div>
			</div>
		</div>
		
		
		
		
<!-- 	밴드부	 -->
		<div class="intro-y col-span-12 md:col-span-6 xl:col-span-4 box">
			<div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 px-5 py-4">
				<div class="ml-3 mr-auto">
					<a href="" class="font-medium">밴드부</a>
				</div>
			<div class="flex text-slate-500 truncate text-xs mt-0.5">2022.09.01
			</div>
			</div>
			<div class="p-5">
				<div class="h-40 2xl:h-56 image-fit" id="jpg">
					<img src="https://img.freepik.com/free-vector/rock-band-isometric-composition_1284-23938.jpg">
				</div>
				<a href="" class="block font-medium text-base mt-5">월,수,금</a>
				<div class="text-slate-600 dark:text-slate-500 mt-2">오후 7시 ~ 오후 8시</div>
			</div>
			<div class="flex items-center px-5 py-3 border-t border-slate-200/60 dark:border-darkmode-400">
				<a href=""
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full text-primary bg-primary/10 dark:bg-darkmode-300 dark:text-slate-300 ml-auto tooltip"
					title="Share"> <i icon-name="share-2" class="w-3 h-3"></i>
				</a> 
				<a href="" 
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full bg-primary text-white ml-2 tooltip"
					title="Download PDF"> <i icon-name="bookmark" class="w-3 h-3"></i>
				</a>
			</div>
			<div class="px-5 pt-3 pb-5 border-t border-slate-200/60 dark:border-darkmode-400">
				<div class="w-full flex text-slate-500 text-xs sm:text-sm">
					<button class="btn btn-rounded btn-primary-soft w-24 mr-1 mb-2">신청하기</button>
				</div>
			</div>
		</div>
		
		
		
<!-- 	독서 토론회     -->
		<div class="intro-y col-span-12 md:col-span-6 xl:col-span-4 box">
			<div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 px-5 py-4">
				<div class="ml-3 mr-auto">
					<a href="" class="font-medium">독서 토론</a>
				</div>
			<div class="flex text-slate-500 truncate text-xs mt-0.5">2023.04.16
			</div>
			</div>
			<div class="p-5">
				<div class="h-40 2xl:h-56 image-fit" id="jpg">
					<img src="https://cdn.lecturernews.com/news/photo/202112/85045_294954_5616.jpg">
				</div>
				<a href="" class="block font-medium text-base mt-5">월,화,수</a>
				<div class="text-slate-600 dark:text-slate-500 mt-2">오후 1시 ~ 오후 1시 30분</div>
			</div>
			<div class="flex items-center px-5 py-3 border-t border-slate-200/60 dark:border-darkmode-400">
				<a href=""
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full text-primary bg-primary/10 dark:bg-darkmode-300 dark:text-slate-300 ml-auto tooltip"
					title="Share"> <i icon-name="share-2" class="w-3 h-3"></i>
				</a> 
				<a href="" 
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full bg-primary text-white ml-2 tooltip"
					title="Download PDF"> <i icon-name="bookmark" class="w-3 h-3"></i>
				</a>
			</div>
			<div class="px-5 pt-3 pb-5 border-t border-slate-200/60 dark:border-darkmode-400">
				<div class="w-full flex text-slate-500 text-xs sm:text-sm">
					<button class="btn btn-rounded btn-secondary-soft w-24 mr-1 mb-2">신청 완료</button>
				</div>
			</div>
		</div>
		
		

<!--     런데이      -->
		<div class="intro-y col-span-12 md:col-span-6 xl:col-span-4 box">
			<div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 px-5 py-4">
				<div class="ml-3 mr-auto">
					<a href="" class="font-medium">런데이</a>
				</div>
			<div class="flex text-slate-500 truncate text-xs mt-0.5">2023.01.05
			</div>
			</div>
			<div class="p-5">
				<div class="h-40 2xl:h-56 image-fit" id="jpg">
					<img src="https://www.runday.co.kr/img/runday_og.png">
				</div>
				<a href="" class="block font-medium text-base mt-5">평일</a>
				<div class="text-slate-600 dark:text-slate-500 mt-2">오후 6시 30분 ~ 오후 7시 30분</div>
			</div>
			<div class="flex items-center px-5 py-3 border-t border-slate-200/60 dark:border-darkmode-400">
				<a href=""
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full text-primary bg-primary/10 dark:bg-darkmode-300 dark:text-slate-300 ml-auto tooltip"
					title="Share"> <i icon-name="share-2" class="w-3 h-3"></i>
				</a> 
				<a href="" 
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full bg-primary text-white ml-2 tooltip"
					title="Download PDF"> <i icon-name="bookmark" class="w-3 h-3"></i>
				</a>
			</div>
			<div class="px-5 pt-3 pb-5 border-t border-slate-200/60 dark:border-darkmode-400">
				<div class="w-full flex text-slate-500 text-xs sm:text-sm">
					<button class="btn btn-rounded btn-primary-soft w-24 mr-1 mb-2">신청하기</button>
				</div>
			</div>
		</div>
		
		
		
		
		
<!--     암벽 등반      -->
	<div class="intro-y col-span-12 md:col-span-6 xl:col-span-4 box">
			<div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 px-5 py-4">
				<div class="ml-3 mr-auto">
					<a href="" class="font-medium">암벽등반</a>
				</div>
			<div class="flex text-slate-500 truncate text-xs mt-0.5">2022.03.18
			</div>
			</div>
			<div class="p-5">
				<div class="h-40 2xl:h-56 image-fit" id="jpg">
					<img src="https://destination-ontario-prod.s3.ca-central-1.amazonaws.com/files/s3fs-public/styles/article_masthead/public/2022-12/climb-muskoka-rock-climbing.jpg">
				</div>
				<a href="" class="block font-medium text-base mt-5">화,목,토</a>
				<div class="text-slate-600 dark:text-slate-500 mt-2">오후 6시 30분 ~ 오후 7시 30분</div>
			</div>
			<div class="flex items-center px-5 py-3 border-t border-slate-200/60 dark:border-darkmode-400">
				<a href=""
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full text-primary bg-primary/10 dark:bg-darkmode-300 dark:text-slate-300 ml-auto tooltip"
					title="Share"> <i icon-name="share-2" class="w-3 h-3"></i>
				</a> 
				<a href="" 
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full bg-primary text-white ml-2 tooltip"
					title="Download PDF"> <i icon-name="bookmark" class="w-3 h-3"></i>
				</a>
			</div>
			<div class="px-5 pt-3 pb-5 border-t border-slate-200/60 dark:border-darkmode-400">
				<div class="w-full flex text-slate-500 text-xs sm:text-sm">
					<button class="btn btn-rounded btn-primary-soft w-24 mr-1 mb-2">신청하기</button>
				</div>
			</div>
		</div>		
		
		
		
<!-- 	축구    	 -->
	<div class="intro-y col-span-12 md:col-span-6 xl:col-span-4 box">
			<div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 px-5 py-4">
				<div class="ml-3 mr-auto">
					<a href="" class="font-medium">여자 축구</a>
				</div>
			<div class="flex text-slate-500 truncate text-xs mt-0.5">2023.03.20
			</div>
			</div>
			<div class="p-5">
				<div class="h-40 2xl:h-56 image-fit" id="jpg">
					<img src="https://mblogthumb-phinf.pstatic.net/MjAyMDA3MjBfMjYy/MDAxNTk1MjM0OTEzMTkx.KE5Iie7Fj7rhMHjSdvYBmgAVh3vDTjXDGMpoDF9NXbMg.nNvTVSuM_UK8gDfmpZ1hVWkX7cWUwdifb2f_CMTWitwg.JPEG.noyangcar/%EC%9D%BC%EC%82%B0_%EC%97%AC%EC%9E%90%ED%8C%80_%EB%8B%A8%EC%B2%B4%EC%82%AC%EC%A7%84.jpg?type=w2">
				</div>
				<a href="" class="block font-medium text-base mt-5">금,토</a>
				<div class="text-slate-600 dark:text-slate-500 mt-2">오후 6시 30분 ~ 오후 7시 30분</div>
			</div>
			<div class="flex items-center px-5 py-3 border-t border-slate-200/60 dark:border-darkmode-400">
				<a href=""
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full text-primary bg-primary/10 dark:bg-darkmode-300 dark:text-slate-300 ml-auto tooltip"
					title="Share"> <i icon-name="share-2" class="w-3 h-3"></i>
				</a> 
				<a href="" 
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full bg-primary text-white ml-2 tooltip"
					title="Download PDF"> <i icon-name="bookmark" class="w-3 h-3"></i>
				</a>
			</div>
			<div class="px-5 pt-3 pb-5 border-t border-slate-200/60 dark:border-darkmode-400">
				<div class="w-full flex text-slate-500 text-xs sm:text-sm">
					<button class="btn btn-rounded btn-primary-soft w-24 mr-1 mb-2">신청하기</button>
				</div>
			</div>
		</div>		
		
			
	<div class="intro-y col-span-12 md:col-span-6 xl:col-span-4 box">
			<div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 px-5 py-4">
				<div class="ml-3 mr-auto">
					<a href="" class="font-medium">남자 축구</a>
				</div>
			<div class="flex text-slate-500 truncate text-xs mt-0.5">2023.03.20
			</div>
			</div>
			<div class="p-5">
				<div class="h-40 2xl:h-56 image-fit" id="jpg">
					<img src="https://cdn.dynews.co.kr/news/photo/202008/513364_161042_133.jpg">
				</div>
				<a href="" class="block font-medium text-base mt-5">금,토</a>
				<div class="text-slate-600 dark:text-slate-500 mt-2">오후 6시 30분 ~ 오후 7시 30분</div>
			</div>
			<div class="flex items-center px-5 py-3 border-t border-slate-200/60 dark:border-darkmode-400">
				<a href=""
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full text-primary bg-primary/10 dark:bg-darkmode-300 dark:text-slate-300 ml-auto tooltip"
					title="Share"> <i icon-name="share-2" class="w-3 h-3"></i>
				</a> 
				<a href="" 
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full bg-primary text-white ml-2 tooltip"
					title="Download PDF"> <i icon-name="bookmark" class="w-3 h-3"></i>
				</a>
			</div>
			<div class="px-5 pt-3 pb-5 border-t border-slate-200/60 dark:border-darkmode-400">
				<div class="w-full flex text-slate-500 text-xs sm:text-sm">
					<button class="btn btn-rounded btn-primary-soft w-24 mr-1 mb-2">신청하기</button>
				</div>
			</div>
		</div>		
		
		
			
		
		
		
<!-- 	요리    	 -->
	<div class="intro-y col-span-12 md:col-span-6 xl:col-span-4 box">
			<div class="flex items-center border-b border-slate-200/60 dark:border-darkmode-400 px-5 py-4">
				<div class="ml-3 mr-auto">
					<a href="" class="font-medium">베이킹</a>
				</div>
			<div class="flex text-slate-500 truncate text-xs mt-0.5">2021.10.21
			</div>
			</div>
			<div class="p-5">
				<div class="h-40 2xl:h-56 image-fit" id="jpg">
					<img src="https://i0.wp.com/uracle.blog/wp-content/uploads/2022/06/12.jpg?resize=1200%2C900&ssl=1">
				</div>
				<a href="" class="block font-medium text-base mt-5">토</a>
				<div class="text-slate-600 dark:text-slate-500 mt-2">오후 4시 30분 ~ 오후 6시 30분</div>
			</div>
			<div class="flex items-center px-5 py-3 border-t border-slate-200/60 dark:border-darkmode-400">
				<a href=""
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full text-primary bg-primary/10 dark:bg-darkmode-300 dark:text-slate-300 ml-auto tooltip"
					title="Share"> <i icon-name="share-2" class="w-3 h-3"></i>
				</a> 
				<a href="" 
					class="intro-x w-8 h-8 flex items-center justify-center rounded-full bg-primary text-white ml-2 tooltip"
					title="Download PDF"> <i icon-name="bookmark" class="w-3 h-3"></i>
				</a>
			</div>
			<div class="px-5 pt-3 pb-5 border-t border-slate-200/60 dark:border-darkmode-400">
				<div class="w-full flex text-slate-500 text-xs sm:text-sm">
					<button class="btn btn-rounded btn-primary-soft w-24 mr-1 mb-2">신청하기</button>
				</div>
			</div>
		</div>		
		<div>
		
		</div>
		<!-- END: Blog Layout -->
		<!-- BEGIN: Pagination -->
		<div class="intro-y col-span-12 flex flex-wrap sm:flex-row sm:flex-nowrap items-center">
			<nav class="w-full sm:w-auto sm:mr-auto" id="pag">
				<ul class="pagination">
					<li class="page-item"><a class="page-link" href="#"> <i
							class="w-4 h-4" data-lucide="chevrons-left"></i>
					</a></li>
					<li class="page-item"><a class="page-link" href="#"> <i
							class="w-4 h-4" data-lucide="chevron-left"></i>
					</a></li>
					<li class="page-item"><a class="page-link" href="#">...</a></li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item active"><a class="page-link" href="#">2</a>
					</li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#">...</a></li>
					<li class="page-item"><a class="page-link" href="#"> <i
							class="w-4 h-4" data-lucide="chevron-right"></i>
					</a></li>
					<li class="page-item"><a class="page-link" href="#"> <i
							class="w-4 h-4" data-lucide="chevrons-right"></i>
					</a></li>
				</ul>
			</nav>
		</div>
		<!-- END: Pagination -->
	</div>
</div>
<!-- END: Content -->