package kr.or.ddit.employeeInfo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.employeeInfo.dao.AnnualLeaveRecordDAO;
import kr.or.ddit.employeeInfo.vo.AnnualLeaveRecordVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AnnualLeaveRecordServiceImpl implements AnnualLeaveRecordService {
	
	@Inject
	private AnnualLeaveRecordDAO annualLeaveRecordDAO;
	
	@Override
	public List<AnnualLeaveRecordVO> retrieveMyAnnualLeaveRecordList(AnnualLeaveRecordVO annualLeaveRecord) {
		return annualLeaveRecordDAO.selectMyAnnualLeaveRecordList(annualLeaveRecord);
	}

}
