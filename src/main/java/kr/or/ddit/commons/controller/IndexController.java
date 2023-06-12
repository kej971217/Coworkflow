package kr.or.ddit.commons.controller;

import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.board.notice.service.NoticeBoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PostVO;
import kr.or.ddit.commons.service.WebCrawlerService;
import kr.or.ddit.employee.service.EmpService;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employeeInfo.service.VacationService;
import kr.or.ddit.employeeInfo.vo.VacationVO;
import kr.or.ddit.mail.MailDefaultPaginationRenderer;
import kr.or.ddit.mail.service.MailOpenService;
import kr.or.ddit.mail.service.MailService;
import kr.or.ddit.mail.vo.MailBoxVO;
import kr.or.ddit.mail.vo.MailPagination;
import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class IndexController {
	
	@Inject
	private WebCrawlerService webCrawlerService;
	
	@Inject
	private MailOpenService mailOpenService;
	
	@Inject
	private MailService mailService;
	
	@Inject
	private MypageService mypageService;
	


	@RequestMapping("/index.do")
	public String index(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException {
		mailOpenService.accessInbox(model, authentication, session);
		mailOpenService.accessSent(model, authentication, session);
		mailOpenService.accessDraft(model, authentication, session);
		
		
//		mailOpen(model, authentication, session);
//		mailSentOpen(model, authentication, session);
//		mailDraftOpen(model, authentication, session);
		
		
		model.addAttribute("level1Menu", "home");
		return "index";
	}
	
	
	@Inject
	private EmpService empService;
	
	@ModelAttribute("emp")
	   public EmployeeVO employee(Authentication authentication) {
	      return empService.selectEmpDetail(authentication.getName());
	}
	
	
	
	

//	public void mailOpen(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException {
////		log.info("Mail 1단계");
//		// 메일 신규 요청 넣어주기.
//		mailOpenService.accessInbox(model, authentication, session);
//	}
//
//	public void mailSentOpen(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException {
////		log.info("Mail 2단계");
//		// 메일 신규 요청 넣어주기.
//		mailOpenService.accessSent(model, authentication, session);
//	}
//	
//	public void mailDraftOpen(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException {
////		log.info("Mail 3단계");
//		// 메일 신규 요청 넣어주기.
//		mailOpenService.accessDraft(model, authentication, session);
//	}
	
	/**
     * 메일 받은편지함
     */
    @GetMapping("recieveMailBox.do")
    public String recieveMailBox(
            @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
            , SimpleCondition simpleCondition
            , Model model
            , Authentication authentication
            , HttpSession session
    ) {
        String empId = authentication.getName();
//        log.info("선택 페이지 : {}", currentPage);
        // messageId 목록 가져오기
        List<MailBoxVO> messageIdsList = mailService.retrieveMessageIdFromDB(empId);
        // -------------------------------- 메일 출력 준비 시작 --------------------------------
        List<MailBoxVO> readyForViewList = new ArrayList<>();
        for (MailBoxVO messageIdVO : messageIdsList) {
            MailBoxVO mailbox = new MailBoxVO();
            String messageId = messageIdVO.getMailMessageId();
            mailbox.setReceiverInfo(empId);
            mailbox.setMailMessageId(messageId);
            List<MailBoxVO> tempList = mailService.retrieveViewFromDB(mailbox);//DB에 저장한 메일 조회
            MailBoxVO mailPrint = tempList.get(0);// 첫번째 VO을 출력 대상으로 만들기
            LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
            LocalDateTime mailDateTime = mailPrint.getMailInboxDate();//DB 저장한 일시 불러오기
            if (localDateTime.toLocalDate().isEqual(mailDateTime.toLocalDate())) {
                mailPrint.setReceivedLocalTime(mailDateTime.toLocalTime());
            } else if (localDateTime.toLocalDate().isAfter(mailDateTime.toLocalDate())) {
                mailPrint.setReceivedLocalDate(mailDateTime.toLocalDate());
            }
            readyForViewList.add(mailPrint);
        }
//        log.info("출력용 순서 확인 : {}", readyForViewList)


        // -------------------------------- 메일 출력 준비 종료 --------------------------------


        // ------------------------------------ 페이지네이션 시작 -----------------------------------
        MailPagination<List<MailBoxVO>> mailPagination = new MailPagination<>();
        {
            mailPagination.setCurrentPage(currentPage);
            mailPagination.setSimpleCondition(simpleCondition);

            int totalRows = readyForViewList.size();// 메세지(메일) 개수
//            log.info("받은 메일함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", totalRows);
            mailPagination.setTotalRows(totalRows);
            mailPagination.setDataList(readyForViewList);
//            log.info("받은 메일함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", mailPagination);
        }

        /* 페이지네이션 렌더러 UI 적용*/
        MailDefaultPaginationRenderer mailPaginationRenderer = new MailDefaultPaginationRenderer();
        String rendererPagination = mailPaginationRenderer.renderMailPagination(mailPagination);

        // model에 저장
        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailInbox");
        model.addAttribute("mailList", mailPagination);
        model.addAttribute("rendererPagination", rendererPagination);

        return "jsonView";
    }// 받은 편지함 : openMail() 메서드 :/choicePage.do 종료
	
	
	
	/**
     * 메일 보낸편지함
     */
    @GetMapping("sentMailBox.do")
    public String sentMailBox(
            @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
            , SimpleCondition simpleCondition
            , Model model
            , Authentication authentication
            , HttpSession session
    ) throws MessagingException, IOException {
//        log.info("기존 DB로 보낸 메일함 열기 메서드 진입");
        // 토큰/DB 정보 뷰로 가져가기
        String empId = authentication.getName();
        // -------------------------------- 메일 출력 준비 시작 --------------------------------
        List<MailBoxVO> messageIdsList = mailService.retrieveMessageIdFromDBSent(empId);

        List<MailBoxVO> readyForViewList = new ArrayList<>();
        for (MailBoxVO messageIdVO : messageIdsList) {
            MailBoxVO mailbox = new MailBoxVO();
            String messageId = messageIdVO.getMailMessageId();
            mailbox.setReceiverInfo(empId);
            mailbox.setMailMessageId(messageId);
            List<MailBoxVO> tempList = mailService.retrieveViewFromDBSent(mailbox);

            List<MailBoxVO> viewList = new ArrayList<>();
            MailBoxVO mailPrint = tempList.get(0);
            LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
            LocalDateTime mailDateTime = mailPrint.getMailSendDate();//DB 저장한 일시 불러오기
            if (localDateTime.toLocalDate().isEqual(mailDateTime.toLocalDate())) {
                mailPrint.setReceivedLocalTime(mailDateTime.toLocalTime());
            } else if (localDateTime.toLocalDate().isAfter(mailDateTime.toLocalDate())) {
                mailPrint.setReceivedLocalDate(mailDateTime.toLocalDate());
            }
            readyForViewList.add(mailPrint);
        }
//        log.info("출력용 순서 확인 : {}", readyForViewList);

        // -------------------------------- 메일 출력 준비 종료 --------------------------------


        // ------------------------------------ 페이지네이션 시작 -----------------------------------
        MailPagination<List<MailBoxVO>> mailPagination = new MailPagination<>();
        {
            mailPagination.setCurrentPage(currentPage);
            mailPagination.setSimpleCondition(simpleCondition);

            int totalRows = readyForViewList.size();// 메세지(메일) 개수
//            log.info("보낸 메일함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", totalRows);
            mailPagination.setTotalRows(totalRows);
            mailPagination.setDataList(readyForViewList);
//            log.info("보낸 메일함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", mailPagination);
        }

        /* 페이지네이션 렌더러 UI 적용*/
        MailDefaultPaginationRenderer mailPaginationRenderer = new MailDefaultPaginationRenderer();
        String rendererPagination = mailPaginationRenderer.renderMailPagination(mailPagination);

        // model에 저장
        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailInbox");
        model.addAttribute("mailList", mailPagination);
        model.addAttribute("rendererPagination", rendererPagination);

        return "jsonView"; // ------------------- 최초로 메일 받고, 최초로 메일 등록 종료  --------------------- 경로 1


    }
	
      
    
    
    @Inject
	private NoticeBoardService noticeService;
    
    /**
     * 공지사항
     */
    @ModelAttribute("notice")
	public BoardVO getUI() {
    	Pagination<PostVO> pagination = new Pagination<PostVO>();
		pagination.setCurrentPage(1);
		BoardVO board = noticeService.retrieveNoticeBoardList(pagination);
		if(board!=null) {
			for(int i=0; i<board.getPostList().size(); i++) {
				String content = board.getPostList().get(i).getPostContent().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
				if(content.length() > 50) {
					content = content.substring(0, 50) + " ...";
				}
				board.getPostList().get(i).setPostContent(content);
			}
		}
		return board;
	}
    
    
    
    @Inject
	private VacationService vacationService;
    
    @GetMapping(value = "todayTeamVacationList.do", produces = MediaType.APPLICATION_PROBLEM_JSON_UTF8_VALUE)
    public String todayTeamVacationList(Authentication authentication, Model model) {
    	VacationVO vacation = new VacationVO();
    	vacation.setEmpId(authentication.getName());
    	List<VacationVO> todayTeamVacationList = vacationService.retrieveTodayTeamVacationList(vacation);
    	for(VacationVO todayTeamVacation : todayTeamVacationList) {
    		todayTeamVacation.setMypage(mypageService.retrieveMypage(todayTeamVacation.getEmpId()));
    	}
    	model.addAttribute("todayList", todayTeamVacationList);
    	return "jsonView";
    }
    
    
    
	@PostMapping(value = "crawling.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String crawling (Model model, @RequestBody String newsKeyword){
	
		log.error(newsKeyword);
		System.out.println(newsKeyword);
		
		
		
		
		model.addAttribute("newsList", webCrawlerService.getNewsFromNaver(newsKeyword));
		return "jsonView";
	}
}
