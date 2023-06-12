package kr.or.ddit.employee.controller;

import java.util.Map;
import java.util.Optional;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.employee.service.EmpService;
import kr.or.ddit.employee.vo.EmployeeVO;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Controller
public class ForgetPasswordController {

    final DefaultMessageService messageSmsService;
    
    @Inject
    private EmpService service;
    
    public ForgetPasswordController() {
        // 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
        this.messageSmsService = NurigoApp.INSTANCE.initialize("NCSJKEEDUGHYHN2L", "P5G50ULMU2AMXMXCIJHZUGTVIFUXWIJA", "https://api.coolsms.co.kr");
    }
    
    
    /**
     * 단일 메시지 발송
     */
    @RequestMapping("/passwordFindSMS")
    public String sendOne(
    		@RequestBody Map<String,String> mapData
    		) {
//    	System.out.println(mapData.get("findPasswordId"));
    	EmployeeVO emp = Optional.of(service.findPassword(mapData.get("findPasswordId")))
				.orElseThrow(()->{return new UsernameNotFoundException(mapData.get("findPasswordId"));});
    	
    	
        Message message = new Message();
        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
        message.setFrom("01044472906");
        message.setTo(emp.getInfoHp());
        message.setText("임시비밀번호 : "+emp.getEmpPass()+ " 입니다.");

        SingleMessageSentResponse response = this.messageSmsService.sendOne(new SingleMessageSendingRequest(message));
//        System.out.println(response);

        return "redirect:/login";
    }

}
