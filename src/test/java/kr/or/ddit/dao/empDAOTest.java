package kr.or.ddit.dao;

import static org.junit.Assert.assertNotNull;

import javax.inject.Inject;

import org.junit.Test;

import kr.or.ddit.AbstractModelLayerTest;
import kr.or.ddit.employee.dao.EmpDAO;
import kr.or.ddit.employee.dao.PositionDAO;
import kr.or.ddit.mypage.dao.MypageDAO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class empDAOTest extends AbstractModelLayerTest {

	@Inject
	private EmpDAO empDAO;

	@Test
	public void testSelectRole() {

		assertNotNull(empDAO.selectEmp("a100001"));

	}

	@Test
	public void listSelectEmp() {
		
		assertNotNull(empDAO.allEmpList());
		
	}

}
