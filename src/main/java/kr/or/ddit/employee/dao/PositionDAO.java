package kr.or.ddit.employee.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employee.vo.OrganizationInfoVO;
import kr.or.ddit.employee.vo.PositionVO;

@Mapper
public interface PositionDAO {
	
	
	/**
	 * 직원정보를 한번에 가져올 수 있는 메서드
	 * @param orgInfo
	 * @return
	 */
	public PositionVO selectPostionVO(OrganizationInfoVO orgInfo);
	
	
	
	
}
