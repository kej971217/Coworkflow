package kr.or.ddit.employeeInfo.service;

import java.util.List;

import kr.or.ddit.employeeInfo.vo.AnnualLeaveRecordVO;

public interface AnnualLeaveRecordService {
	public List<AnnualLeaveRecordVO> retrieveMyAnnualLeaveRecordList(AnnualLeaveRecordVO annualLeaveRecord);
}
