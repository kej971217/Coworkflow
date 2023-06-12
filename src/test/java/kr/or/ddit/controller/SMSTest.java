package kr.or.ddit.controller;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.*;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import kr.or.ddit.AbstractControllerTest;
import kr.or.ddit.employee.vo.EmployeeVO;

public class SMSTest extends AbstractControllerTest {


//	@Test
//	public void testGetUI() throws Exception {
//			mockMvc.perform(get("/buyer/buyerList.do"))
//			.andExpect(view().name("buyer/buyerList"))
//			.andDo(log());
//	}
// 컨텐츠에서 찾아봐야해! 
// json data가 있느지 없는지 봐야지...
	
	@Test
	public void testDoGet() throws Exception {
		mockMvc.perform(get("/passwordFindSMS")
//				.accept(MediaType.APPLICATION_JSON)
				.param("empId", "test")
				)
//		.andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8))
				.andDo(log());
	}

}
