package kr.or.ddit.commons.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

//@ControllerAdvice
public class GlobalExceptionHandler {
	
//	@ExceptionHandler(value = {Exception.class})
//    public ModelAndView defaultErrorHandler(HttpServletRequest request, Exception e) {
//        ModelAndView mav = new ModelAndView();
//        mav.addObject("exception", e);
//        mav.addObject("url", request.getRequestURL());
//        mav.setViewName("/WEB-INF/jsp/error-pages/generalError.jsp");
//        return mav;
//    }
}
