package kr.or.ddit.employee.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employee.vo.RankVO;

@Mapper
public interface RankDAO {
	
	/**
	 * 사원이 가지고 있는 RankID로 rank의 정보를 가져오는 메서드
	 * @param rankId
	 * @return RankVO
	 */
	public RankVO selectRank(String rankId);
	
	
}
