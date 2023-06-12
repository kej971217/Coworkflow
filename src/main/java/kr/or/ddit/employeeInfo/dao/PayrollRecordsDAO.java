package kr.or.ddit.employeeInfo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employeeInfo.vo.PayrollRecordsVO;
import kr.or.ddit.vo.Pagination;

@Mapper
public interface PayrollRecordsDAO {
	public List<PayrollRecordsVO> selectMyPayrollRecordsList(PayrollRecordsVO payrollRecord);
}
