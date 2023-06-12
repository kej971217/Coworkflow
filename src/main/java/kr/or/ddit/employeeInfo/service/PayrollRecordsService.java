package kr.or.ddit.employeeInfo.service;

import java.util.List;

import kr.or.ddit.employeeInfo.vo.PayrollRecordsVO;
import kr.or.ddit.vo.Pagination;

public interface PayrollRecordsService {
	public List<PayrollRecordsVO> retrieveMyPayrollRecordsList(PayrollRecordsVO payrollRecord);
}
