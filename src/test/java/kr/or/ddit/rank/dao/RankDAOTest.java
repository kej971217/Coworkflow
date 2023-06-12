package kr.or.ddit.rank.dao;

import static org.junit.Assert.assertNotNull;

import javax.inject.Inject;

import org.junit.Test;

import kr.or.ddit.AbstractModelLayerTest;
import kr.or.ddit.employee.dao.PositionDAO;
import kr.or.ddit.employee.dao.RankDAO;
import kr.or.ddit.employee.vo.OrganizationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class RankDAOTest extends AbstractModelLayerTest {
	
	@Inject
	private RankDAO rankDAO;
	
	@Inject
	private PositionDAO positionDAO;
	
	@Test
	public void testSelectRole()  {
//		List<RoleVO> list = new ArrayList<RoleVO>();
//		
//		String empId = "a100002";
//		
//		list = roleDAO.selectRoleList(empId);
//		
//		for(RoleVO vo : list) {
//			log.info(vo.getEmpId(), vo.getRoleId(), vo.getRoleTypeId());
//		}
		
		assertNotNull(rankDAO.selectRank("G001"));
		
		
		
	}
	
	@Test
	public void testSelectTeam()  {
//		List<RoleVO> list = new ArrayList<RoleVO>();
//		
//		String empId = "a100002";
//		
//		list = roleDAO.selectRoleList(empId);
//		
//		for(RoleVO vo : list) {
//			log.info(vo.getEmpId(), vo.getRoleId(), vo.getRoleTypeId());
//		}
//		
//		assertNotNull(positionDAO.selectTeam(10));
//		
//		
//		
	}

	@Test
	public void testSelectpostion()  {
//		List<RoleVO> list = new ArrayList<RoleVO>();
//		
//		String empId = "a100002";
//		
//		list = roleDAO.selectRoleList(empId);
//		
//		for(RoleVO vo : list) {
//			log.info(vo.getEmpId(), vo.getRoleId(), vo.getRoleTypeId());
//		}
//		
//		assertNotNull(positionDAO.selectPosition("H001"));
//		
//		
		
	}

	@Test
	public void testSelectpostionVO()  {
		
		OrganizationInfoVO orgInfo = new OrganizationInfoVO();
		
		orgInfo.setEmpId("a100001");
		orgInfo.setTeamId(3);
		orgInfo.setPositionId("H004");
	
		assertNotNull(positionDAO.selectPostionVO(orgInfo));
		
		
		
		}	
	
	
}
