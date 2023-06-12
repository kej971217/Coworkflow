package kr.or.ddit.mypage.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.approval.vo.DeputyApproverVO;
import kr.or.ddit.employee.service.EmpService;
import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.EmployeeVOWrapper;
import kr.or.ddit.employee.vo.OrganizationInfoVO;
import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.mypage.vo.MypageVO;
import kr.or.ddit.role.service.UserDetailServiceImpl;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	
	@Inject
	@Named("authManager")
	private AuthenticationManager authenticationManager;
	
	@Inject
	private UserDetailsService userDetailsService;
	
	@Inject
	private MypageService service;
	
	@Inject
	private EmpService empService;
	
	@Resource(name = "authenticationProvider")
	private AuthenticationProvider provider;
	
	@GetMapping("/mypageHome.do")
	public String mypageHome(Model model, Authentication authentication) {
		
		MypageVO mypage = service.retrieveMypage(authentication.getName());
		
		model.addAttribute("mypage", mypage);
		model.addAttribute("level1Menu", "mypage");
		
		return "mypage/mypageHome";
		
	}
	
//	/**s
//	 * 마이페이지
//	 *(개인정보 확인 및 수정 할 수 있는 주소)
//	 * Authentication 으로 본인 정보 sql 생성
//	 * 
//	 */
//	
//	@GetMapping("/mypageView.do")
//	public String getUI(Model model, Authentication authentication) {
//		
//		MypageVO mypage = service.retrieveMypage(authentication.getName());
//		
//		model.addAttribute("mypage", mypage);
//		model.addAttribute("level1Menu", "mypage");
//		
//		return "mypage/mypageView";
//		
//	}
	
//	/**
//	 * 마이페이지 수정
//	 * @param mypage
//	 * @param errors
//	 * @param model
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping(value="/viewMypage",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	public MypageVO editMypage(Authentication authentication
//		) {
//		MypageVO mypage = service.retrieveMypage(authentication.getName());
//		return mypage;
//		
//	}
//	
   @ModelAttribute("mypage")
   public MypageVO mypage(Authentication authentication) {
      return service.retrieveMypage(authentication.getName());
   }
   
   @GetMapping("/mypageEditView.do")
	public String mypageEditView(Model model, Authentication authentication) {
	   MypageVO mypage = service.retrieveMypage(authentication.getName());
	   log.info("controller mypage.setProfileImage = {}",mypage.getProfileImage());
		model.addAttribute("mypage", mypage);
		model.addAttribute("level1Menu", "mypage");
	   return "mypage/mypageEdit";
		
	}
	/**
	 * 
	 * 폼에 입력 받은 data로 update를 하는 controller
	 * @param mypage
	 * @param errors
	 * @param model
	 * @return
	 */
   @PostMapping("/mypageEditView.do")
   public String updateMypage(
      @Validated(UpdateGroup.class) @ModelAttribute("mypage") MypageVO mypage, Authentication realUser
      , Errors errors
   ) {
      String viewName = null;
      if(!errors.hasErrors()) {
         service.modifyMypage(mypage);
		MypageVO updatedMypage = service.retrieveMypage(mypage.getEmpId());
		
 		// 인증객체에 저장된 프로필 사진도 업뎃해줌
 		EmployeeVOWrapper user = (EmployeeVOWrapper) realUser.getPrincipal();
 		 user.getRealUser().setMypage(updatedMypage);
 		 
 		String pass = String.valueOf(SecurityContextHolder.getContext().getAuthentication().getCredentials());

 		Authentication auth = new UsernamePasswordAuthenticationToken(user, realUser.getCredentials(), realUser.getAuthorities());
 		SecurityContextHolder.getContext().setAuthentication(auth);
 		
         viewName = "redirect:/mypage/mypageEditView.do";
      }else {
         viewName = "/mypage/mypageEdit";
      }
      return viewName;
   }
   
   
	
	/**
	 * 비밀번호 변경 폼 생성
	 * @param mypage
	 * @param errors
	 * @param model
	 * @param authentication
	 * @return
	 */
	@RequestMapping("/passChange.do")
	public String passChange(@ModelAttribute("mypage") MypageVO mypage
		, Errors errors, Model model, Authentication authentication
	) {
		mypage = service.retrieveMypage(authentication.getName());
		model.addAttribute("mypage", mypage);
		model.addAttribute("level1Menu", "mypage");
		return "mypage/passChange";
	}
	
	@PostMapping("/passUpdate.do")
	public String passUpdate(@RequestParam("checkEmpPass") String checkEmpPass, 
			@RequestParam("empPass") String empPass,
			Model model, Authentication authentication,
			 RedirectAttributes attributes
			) {
	      // 1. 비밀번호 재확인 하기
	      // 1) 로그인된 아이디와 (비밀번호 재확인하기 위해)입력 받은 비밀번호로 token을 만들어서
	      UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(authentication.getName(), checkEmpPass);
	      
	      try {
	         // 2) security에서 인증하기
	         // 예외 발생 안하면 인증 성공, 예외 발생하면 인증 실패
	         provider.authenticate(token);
	         
	         // 2. 새 비밀번호로 변경
	         MypageVO mypage = new MypageVO();
	         mypage.setEmpId(authentication.getName());
	         mypage.setEmpPass(empPass);
	         service.changePass(mypage);
	         
            attributes.addFlashAttribute("message", "비밀번호가 변경되었습니다.");
            attributes.addFlashAttribute("messageIcon", "success");

	         return "redirect:/";
	         
	      }catch (AuthenticationException e) { // 인증 실패
	         e.printStackTrace();
	         
	         model.addAttribute("level1Menu", "mypage");
	         return "mypage/passChange";
	      }
	      
	}
	
	/**
	 * 마이페이지 >> 프로필 이미지 등록/변경 버튼 >> 이미지 수정 팝업
	 *
	 * 
	 */
	@GetMapping("/profileEdit.do")
	public String profileEdit(
			@Validated(InsertGroup.class) @ModelAttribute("mypage") MypageVO mypage,
			BindingResult errors, Model model, Authentication authentication) {
		
		model.addAttribute("level1Menu", "mypage");
		
		return "myEdit/profileImgEdit";
		
	}
	
	@PostMapping("/profileUpdate.do")
	public String profileUpdate(@RequestPart("empFiles") MultipartFile empFiles,
			@Validated(InsertGroup.class) @ModelAttribute("mypage") MypageVO mypage,
			BindingResult errors, Model model, Authentication realUser) {  
		mypage.setEmpFiles(empFiles);
		service.modifyMypage(mypage);
//		MypageVO newMypage = service.retrieveMypage(mypage.getEmpId());
		model.addAttribute("level1Menu", "mypage");
		
		
		log.error("\n\n\n 마이페이지 겟 이엠피 앙디디 : " +  mypage.getEmpId());
		
		MypageVO updatedMypage = service.retrieveMypage(mypage.getEmpId());

		// 인증객체에 저장된 프로필 사진도 업뎃해줌
		EmployeeVOWrapper user = (EmployeeVOWrapper) realUser.getPrincipal();
		 user.getRealUser().setMypage(updatedMypage);

		
		String pass = String.valueOf(SecurityContextHolder.getContext().getAuthentication().getCredentials());
	    UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(user.getUsername(), pass);
	    Authentication auth = authenticationManager.authenticate(token);
	    SecurityContextHolder.getContext().setAuthentication(auth);
	    
		
		return "mypage/mypageEdit";
		
	}

	@GetMapping("/signEdit.do")
	public String signEdit(@ModelAttribute("mypage") MypageVO mypage,
			BindingResult errors, Model model, Authentication authentication) {
		
		model.addAttribute("level1Menu", "mypage");
		
		return "mypage/mypageEdit";
		
	}
	
	@PostMapping("/updateSignImg.do")
	@ResponseBody
	public String signUpdate(MultipartFile signIMG,
		Model model, Authentication authentication
	) {
		MypageVO mypage = new MypageVO();
		mypage.setEmpId(authentication.getName());
		mypage.setEmpFiles(signIMG);
		service.modifySignImg(mypage);
		
		model.addAttribute("level1Menu", "mypage");
		
		return "success";
		
	}
	
	@GetMapping("/atrzSetting.do")
	public String atrzSetting(@ModelAttribute DeputyApproverVO deputy,
			BindingResult errors, Model model, Authentication authentication) {
		
		List<DepartmentVO> dpmtName = service.retrieveUpperDPMT();
		List<DepartmentVO> teamInfo = service.retrieveTeamInfo();
		List<OrganizationInfoVO> teamEmpList = service.retrieveTeamEmpList();

		model.addAttribute("teamEmpList", teamEmpList);
		model.addAttribute("dpmtName", dpmtName);
		model.addAttribute("teamInfo", teamInfo);
		
		MypageVO mypage = service.retrieveMypage(authentication.getName());
			
		deputy.setEmpId(authentication.getName());
		List<DeputyApproverVO> approver =  service.retrieveDeputyApprover(deputy);
		log.info("approver 확인 = {}", approver);
		model.addAttribute("mypage", mypage);
		model.addAttribute("approver", approver);
		model.addAttribute("level1Menu", "mypage");
		
		return "mypage/atrzSetting";
		
	}
	
	@PostMapping("/atrzSettingImgUpdate.do")
	public String atrzSettingImgUpdate(@ModelAttribute("mypage") MypageVO mypage,
			BindingResult errors, Model model
	) {
		
		service.modifyMypage(mypage);
		
		model.addAttribute("level1Menu", "mypage");
		
		return "mypage/mypageEdit";
		
	}
	
	@ResponseBody
	@PostMapping("/insertDeputyApprover.do")
	public String insertDeputyApprover(@RequestBody DeputyApproverVO deputy, 
			Model model, Authentication authentication) {
		deputy.setEmpId(authentication.getName());
		service.createDeputyApprover(deputy);
	         log.info("지나는지 확인하기");
		return "redirect:/mypage/atrzSetting.do";
		
	}
	
	public void defaultImg(Authentication authentication) {
		MypageVO mypage = service.retrieveMypage(authentication.getName());

	        // 기본 이미지 로드
	        BufferedImage baseImage;
	        try {
	            baseImage = ImageIO.read(new File("base_image.jpg"));
	        } catch (IOException e) {
	            e.printStackTrace();
	            return;
	        }

	        // 이미지에 텍스트 추가
	        Graphics2D graphics = baseImage.createGraphics();
	        graphics.setFont(new Font("Arial", Font.BOLD, 24));
	        graphics.setColor(Color.BLACK);
	        graphics.drawString(mypage.getEmpName(), 100, 100);

	        // 이미지 저장
	        try {
	            ImageIO.write(baseImage, "jpg", new File("output_image.jpg"));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }

	        graphics.dispose();
	}
	
}
