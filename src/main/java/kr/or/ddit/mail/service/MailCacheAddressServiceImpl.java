package kr.or.ddit.mail.service;

import kr.or.ddit.mail.dao.MailDAO;
import kr.or.ddit.mail.vo.MailSendVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.*;

@Slf4j
@Service
public class MailCacheAddressServiceImpl implements MailCacheAddressService {

    @Inject
    MailDAO mailDAO;
    @Inject
    MailService mailService;

    @Inject
    MailCacheAddressOfEmployeeService mailCacheAddressOfEmployeeService;

    @Inject
    MailCacheInfoAboutTeam mailCacheInfoAboutTeam;

    @Inject
    MailCacheInfoAboutProject mailCacheInfoAboutProject;


    /**
     * 이메일 계정 전체 불러오기
     *
     * @return
     */
    @Override
    public List<MailSendVO> retrieveAllEmailAddress(List<MailSendVO> info) {
//        log.info("이메일 정보 주입으로 이메일 전체 조회 진입");
        List<MailSendVO> emailsInfo = new ArrayList<>();//조회 후 반환용
        MailSendVO save = new MailSendVO();//조회 후 반환용

        List<MailSendVO> cacheCheck = new ArrayList<>();//캐시 저장 후 확인용

        for (MailSendVO mailSendVO : info) {
            String empId = mailSendVO.getEmpId();
//            log.info("empId : {}", empId);
            if (empId != null) {
                MailSendVO address = mailDAO.selectEmailOfEmp(empId);
                log.info("address : {}", address);
                if (address != null) {
//                    log.info("이메일 계정 존재하는 직원 정보 저장 (반환 준비)");
                    {
                        save.setEmpId(empId);
                        save.setInfoEmail(address.getInfoEmail());
                        save.setEmpName(mailSendVO.getEmpName());
                        emailsInfo.add(save);// 조회 반환용 List 저장

                        MailSendVO returnCheck = mailCacheAddressOfEmployeeService.saveAddressOfEmployee(empId, save);
                        cacheCheck.add(returnCheck);
//                        log.info("메일 목록 캐시 저장 확인 : {}", cacheCheck);
                    }

                }
            }
        }
        // null 은 포함 되지 않음
        return emailsInfo;
    }

    /**
     * 이메일 가진 직원의 팀 정보 불러오기 + 캐시 저장
     *
     * @param info
     * @return List<MailSendVO>
     */
    @Override
    public List<MailSendVO> retrieveInfoTeam(List<MailSendVO> info) {
//        log.info("이메일 정보 주입으로 팀 정보 조회 진입");
        List<MailSendVO> emailsInfo = new ArrayList<>();//조회 후 반환용
        MailSendVO save = new MailSendVO();//조회 후 반환용

        /*TEAM_ID
            , TEAM_NAME
            , EMP_ID*/

        Map<String, Object> addMap = new HashMap<>();//캐시 저장용
        List<MailSendVO> cacheCheck = new ArrayList<>();//캐시 저장 후 확인용

        for (MailSendVO mailSendVO : info) {
            String empId = mailSendVO.getEmpId();
//            log.info("empId : {}", empId);
            if (empId != null) {
                /*
                * <select id="selectAllTeamInfo" resultType="kr.or.ddit.mail.vo.MailSendVO">
        SELECT TEAM_ID
            , TEAM_NAME
            , EMP_ID
        FROM DEPARTMENT
    </select>
                * */

//                log.info("각 직원이 속한 팀 정보 저장");

                int teamId = mailSendVO.getTeamId();
                String teamName = mailSendVO.getTeamName();
                save.setEmpId(empId);
                save.setTeamId(teamId);
                save.setTeamName(teamName);

                // 캐시 저장용 Map에 정보 저장
                addMap.put(empId + "-teamId", teamId);
                addMap.put(empId + "-teamName", teamName);

                emailsInfo.add(save);// 조회 반환용 List 저장

                /*
                 * 팀 : teamId, teamName, empId
                 * Map 키 : empId + "-teamId"
                 * Map 키 : empId + "-teamName"
                 *
                 * */

                // 캐시 키 empId 가 null 체크를 하여도 비어있어서 오류
                if (addMap.get(empId) != null && !addMap.isEmpty()) {
                    MailSendVO returnCheck = mailCacheInfoAboutTeam.saveInfoAboutTeam(empId, save);
                    cacheCheck.add(returnCheck);
//                    log.info("메일 목록 캐시 저장 확인 : {}", cacheCheck);
                }
            }
        }
        return emailsInfo;
    }

    /**
     * 이메일 계정 가진 직원들의 프로젝트 정보 불러오기 + 캐시 저장
     *
     * @param info
     * @return List<MailSendVO>
     */
    @Override
    public List<MailSendVO> retrieveInfoProject(List<MailSendVO> empEmailsList, List<List<MailSendVO>> info) {
//        log.info("이메일 정보 주입으로 프로젝트 전체 조회 진입");
        List<MailSendVO> emailsInfo = new ArrayList<>();//조회 후 반환용
        MailSendVO save = new MailSendVO();//조회 후 반환용

        Map<String, Object> addMap = new HashMap<>();//캐시 저장용
        List<MailSendVO> cacheCheck = new ArrayList<>();//캐시 저장 후 확인용


        for (List<MailSendVO> projectlist : info) {
            for (MailSendVO vo : empEmailsList) {
                String empId = vo.getEmpId();
                if (empId != null) {
                    for (int i = 0; i < projectlist.size(); i++) {
                        if (empId.equals(projectlist.get(i))) {
                            for (MailSendVO vo2 : projectlist) {
//                                log.info("직원이 가진 프로젝트 정보 저장");
                                save.setEmpId(empId);
                                int projectId = vo2.getProjectId();
                                String projectName = vo2.getProjectName();
                                save.setProjectName(projectName);

                                addMap.put(empId + "-projectId", projectId);
                                addMap.put(empId + "-projectName", projectName);
                                emailsInfo.add(save);// 조회 반환용 List 저장

                                // 캐시 키 empId 가 null 체크를 하여도 비어있어서 오류
                                if (addMap.get(empId) != null && !addMap.isEmpty()) {
                                    MailSendVO returnCheck = mailCacheInfoAboutProject.saveInfoAboutProject(empId, save);
                                    cacheCheck.add(returnCheck);
//                                    log.info("메일 목록 캐시 저장 확인 : {}", cacheCheck);
                                }
                            }
                        }
                    }
                }
            }

        }
        return emailsInfo;

    }

    /**
     * 이메일이 존재하여 캐시에 저장된 팀 불러오기
     *
     * @param empEmailsList
     * @return List<MailSendVO>
     */
    @Override
    public Map<String, List> retrieveBeingEmailInfos(List<MailSendVO> empEmailsList) {
        // 반환용 합
        Map<String, List> returnMap = new HashMap<>();

        // 반환용 직원정보
        List<MailSendVO> empList = new ArrayList<>();
        MailSendVO empVO = new MailSendVO();

        // 반환용 팀 정보
        List<MailSendVO> teamList = new ArrayList<>();
        MailSendVO teamVO = new MailSendVO();
        List<MailSendVO> teamTempList = new ArrayList<>();

        // 반환용 프로젝트 정보
        List<MailSendVO> projectList = new ArrayList<>();
        MailSendVO projectVO = new MailSendVO();

        List<MailSendVO> proIdList = mailDAO.selectAllProjectInfo();//캐시 키 용
        List<MailSendVO> cacheCheck = new ArrayList<>();
        List<MailSendVO> forListProject = new ArrayList<>();

        for (MailSendVO vo : empEmailsList) {
            // 1. 이메일 존재하여 캐시에 저장된 직원 정보 불러오기
//            log.info("1. 이메일 존재하여 캐시에 저장된 직원 정보 불러오기");
            String empIdSelect = vo.getEmpId();
            // null 없는 직원 정보
            MailSendVO returnCheck = mailCacheAddressOfEmployeeService.getAddressOfEmployee(empIdSelect);
            cacheCheck.add(returnCheck);
//            log.info("목록 : {}", cacheCheck);
            for (MailSendVO empSelect : cacheCheck) {
//                log.info("이메일 존재하는 직원 정보 저장");
                String empId = empSelect.getEmpId();
                empVO.setEmpId(empSelect.getEmpId());
                empVO.setEmpName(empSelect.getEmpName());
                empVO.setInfoEmail(empSelect.getInfoEmail());
                empList.add(empVO);


//                log.info("2. 이메일 존재하는 직원의 팀 정보 불러오기");

                MailSendVO forListTeam = mailCacheInfoAboutTeam.getInfoAboutTeam(empId);//팀 정보 가져오기
                teamTempList.add(forListTeam);

                cacheCheck.add(returnCheck);
                int teamId = 0;
                String teamName = null;

//                if(forListTeam != null && Optional.ofNullable(forListTeam.get(empId + "-teamId")).isPresent()) {
//                    teamId = Integer.parseInt(forListTeam.get(empId + "-teamId").toString());
//                    teamName = forListTeam.get(empId + "-teamName").toString();
//                }

//                log.info("이메일 존재하는 팀 정보 저장");
//                teamVO.setEmpId(empId);
//                teamVO.setTeamId(teamId);
//                teamVO.setTeamName(teamName);
//                teamList.add(teamVO);


//                log.info("3. 이메일 존재하는 프로젝트 정보 불러오기");
                //empId, projectId

                for (MailSendVO proId : proIdList) {
                    if (Optional.ofNullable(mailCacheInfoAboutProject.getInfoAboutProject(empId, proId.getProjectId())).isPresent()) {
                        MailSendVO tempvo = mailCacheInfoAboutProject.getInfoAboutProject(empId, proId.getProjectId());

//                        int projectId = Integer.parseInt(forListProject.get(empId + "-projectId").toString());
//                        String projectName = forListProject.get(empId + "-projectName").toString
                    }
                    /**
                     *     addMap.put(empId + "-projectId", projectId);
                     *                     addMap.put(empId + "-projectName", projectName);
                     *
                     *String projectId = forListTeam.get(empId + "-projectId");
                     *String projectName = forListTeam.get(empId + "-projectName");
                     */

                }
            }

            }
            if (teamTempList != null) {
                for (MailSendVO temp : teamTempList) {
                    teamVO.setEmpId(temp.getEmpId());
                    teamVO.setTeamId(temp.getTeamId());
                    teamVO.setTeamName(temp.getTeamName());
                    teamList.add(teamVO);
                }
            }

            if (forListProject != null) {
                for (MailSendVO temp : forListProject) {
                    projectVO.setEmpId(temp.getEmpId());
                    projectVO.setProjectId(temp.getProjectId());
                    projectVO.setProjectName(temp.getProjectName());
                    projectList.add(projectVO);
                }
            }

            returnMap.put("listBeingEmp", empList);
            returnMap.put("listBeingTeam", teamList);
            returnMap.put("listBeingProject", projectList);
            return returnMap;
        }
    }
