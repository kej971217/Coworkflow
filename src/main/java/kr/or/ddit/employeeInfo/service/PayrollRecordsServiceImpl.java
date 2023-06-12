package kr.or.ddit.employeeInfo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.employeeInfo.dao.PayrollRecordsDAO;
import kr.or.ddit.employeeInfo.vo.PayrollRecordsVO;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PayrollRecordsServiceImpl implements PayrollRecordsService {
	
	@Inject
	private PayrollRecordsDAO payrollRecordsDAO;


	@Override
	public List<PayrollRecordsVO> retrieveMyPayrollRecordsList(PayrollRecordsVO payrollRecord) {
		return payrollRecordsDAO.selectMyPayrollRecordsList(payrollRecord);
	}

	
}
