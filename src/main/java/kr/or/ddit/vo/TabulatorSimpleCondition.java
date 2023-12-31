package kr.or.ddit.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 단순 키워드 검색 지원
 * (검색조건, 검색키워드)
 *
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TabulatorSimpleCondition {
	/**
	 * 검색조건
	 */
	private String field; 
	/**
	 * 검색 키워드
	 */
	private String value; 
}
