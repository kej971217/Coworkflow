package kr.or.ddit.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
public class MyConfig implements WebMvcConfigurer{

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		System.err.println("요기가 실행되었는지 check?");
		registry.addResourceHandler("/mypage/**")             // 웹 접근 경로 
		        .addResourceLocations("file:///d:/Coworkflow/resources/mypage/");  // 서버 내 실제 경로
		registry.addResourceHandler("/drive/**")
				.addResourceLocations("file:///D:/Coworkflow/resources/drive/");
		registry.addResourceHandler("/board/**")
		.addResourceLocations("file:///D:/Coworkflow/resources/board/");
	}

}