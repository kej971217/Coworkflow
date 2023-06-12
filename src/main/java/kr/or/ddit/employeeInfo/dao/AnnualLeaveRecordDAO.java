package kr.or.ddit.employeeInfo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employeeInfo.vo.AnnualLeaveRecordVO;

@Mapper
public interface AnnualLeaveRecordDAO {
	public List<AnnualLeaveRecordVO> selectMyAnnualLeaveRecordList(AnnualLeaveRecordVO annualLeaveRecord);
}
