package kr.or.ddit.role.service;

import java.util.Optional;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.or.ddit.employee.dao.EmpDAO;
import kr.or.ddit.employee.dao.OrganizationInfoDAO;
import kr.or.ddit.employee.dao.PositionDAO;
import kr.or.ddit.employee.dao.RankDAO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.EmployeeVOWrapper;
import kr.or.ddit.employee.vo.OrganizationInfoVO;
import kr.or.ddit.employeeInfo.dao.EmployeeInfoDAO;
import kr.or.ddit.employeeInfo.vo.EmployeeInfoVO;
import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.mypage.vo.MypageVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class UserDetailServiceImpl implements UserDetailsService {
	// 직원 기본 정보 수집용 emp DAO
	@Inject
	private EmpDAO empDao;

	// 직원 아이디로 가지고 있는 모든 권한 수집용.
//	@Inject
//	private RoleDAO roleDAO;

	// 직원 아이디로 가지고 있는 모든 팀, 직위, 직무 정보 가져오기.
	@Inject
	private OrganizationInfoDAO organizationInfoDAO;

	// 사용자가 가지고 있는 직원 ID로 rankVO 가져오기.
	@Inject
	private RankDAO rankDAO;

	// 사용자가 가지고 있는 직원 ID 로 position 정보 가져오기.
	@Inject
	private PositionDAO positionDAO;
	
	@Inject
	private MypageService mypageService;

	@Inject
	private EmployeeInfoDAO empInfoDAO;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// roleList 담을 빈 list 생성
//		List<RoleVO> roleList = new ArrayList<RoleVO>();

		System.err.println("loadUserByUsername 실행");
		// 이 사용자가 있냐 없냐 먼저 확인
		EmployeeVO emp = Optional.of(empDao.selectEmp(username))
				.orElseThrow(()->{return new UsernameNotFoundException(username);});

		// 사용자 Id를 통해 사용자의 조직 정보 가져오기.
		OrganizationInfoVO orgInfoVO = organizationInfoDAO.selectOrgInfo(username);
		emp.setOrganizationInfo(orgInfoVO);

		// 직원의 개인정보 넣어주기.
		EmployeeInfoVO empInfoVO = empInfoDAO.selectEmpInfo(username);
		emp.setEmployeeInfo(empInfoVO);

		// 랭크 정보 넣어주기.
		emp.setRank(rankDAO.selectRank(orgInfoVO.getRankId()));

		emp.setPosition(positionDAO.selectPostionVO(orgInfoVO));

		MypageVO mypage = mypageService.retrieveMypage(username);
		emp.setMypage(mypage);
		
		
		// 포지션 정보 넣어주기.
//		 PositionVO postionVo = new PositionVO();
//		 postionVo.setPositionId(orgInfoVO.getPositionId());
//		 postionVo.setPositionName(positionDAO.selectPosition(orgInfoVO.getPositionId()).getPositionName());
//		 postionVo.setTeamId(orgInfoVO.getTeamId());
//		 postionVo.setTeamName(positionDAO.selectTeam(orgInfoVO.getTeamId()).getTeamName());
//		 log.error("positionVO : {}",postionVo);
//		 emp.setPosition(postionVo);

//		 Set<GrantedAuthority> authSet = new LinkedHashSet<>(); 
//		 authSet.addAll(loadUserAutherities(username));
//		 emp.setRoleList(roleList);
//		roleList  = loadUserAutherities(username);
//		return new EmployeeVOWrapper(emp ,authSet);
		return new EmployeeVOWrapper(emp);

	}

	// role 정리.
//	private List<GrantedAuthority> loadUserAutherities(String username) { 
//		List<RoleVO> list = new ArrayList<RoleVO>();
////		list = roleDAO.selectRoleList(username);
//		
//		return list.stream()
//					.map(role-> new SimpleGrantedAuthority(role.getRoleId().toString()))
//					.collect(Collectors.toList());
//				
//	}
}
