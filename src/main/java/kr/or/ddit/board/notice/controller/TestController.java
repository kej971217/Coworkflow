package kr.or.ddit.board.notice.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chahyun")
public class TestController {

	@GetMapping("/list")
	@ResponseBody
	public String testList() {
		
		List<String> aList = new ArrayList();
		aList.add("채"); //  담기
		aList.add("현");
		aList.add("짱");
		
		 log.info("1-->" + aList.get(1)); // 현
		   aList.remove(1);
		 log.info("1-->" + aList.get(1)); //?
		  
		
		return "success";
	}
	
	
	@GetMapping("/map")
	@ResponseBody
	public String testMap() {
		// map은 사실 VO당
		Map<String,String> myMap = new HashMap<String, String>();
		myMap.put("L", "272");
		myMap.put("T", "쌤");
		myMap.put("C", "짱");
		
		log.info("L -->" + myMap.get("L"));
		myMap.remove("L");
		log.info("L -->" + myMap.get("L"));
		
		
		return "success";
	}

	@GetMapping(value="/listmap" , produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String,Object> listMap() {
		/*
		 * List<Map<String, Object>> listMap = new ArrayList<Map<String,Object>>();
		 * 
		 * Map<String, Object> myMap;
		 * 
		 * myMap = new HashMap<String, Object>(); myMap.put("name", "aaa");
		 * myMap.put("age", 10); myMap.put("alias", "bbb"); listMap.add(myMap);
		 * 
		 * myMap = new HashMap<String, Object>(); myMap.put("name", "ccc");
		 * myMap.put("age", 20); myMap.put("alias", "ddd"); listMap.add(myMap);
		 * 
		 * myMap = new HashMap<String, Object>(); myMap.put("name", "eee");
		 * myMap.put("age", 30); myMap.put("alias", "fff"); listMap.add(myMap);
		 */
		
		
		 Map<String, Object> myMap = new HashMap<String, Object>();
		 
		 List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		 Map<String, String> mapp;
		 
		 mapp = new HashMap<String, String>();
		 mapp.put("hy", "혜연");
		 list.add(mapp);
		 
		 mapp = new HashMap<String, String>();
		 mapp.put("mm", "수정");
		 list.add(mapp);
		 
		 myMap.put("name","채현");
		 myMap.put("age",20);
		 myMap.put("alias",list);
				
		return myMap;
	}

	
	
}
