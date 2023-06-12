package kr.or.ddit.mypage.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.approval.vo.ApprovalDocumentVO;
import kr.or.ddit.approval.vo.DeputyApproverVO;
import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.OrganizationInfoVO;
import kr.or.ddit.mypage.dao.MypageDAO;
import kr.or.ddit.mypage.vo.EmpAtchFileVO;
import kr.or.ddit.mypage.vo.MypageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MypageServiceImpl implements MypageService{
   
   @Inject
   private MypageDAO mypageDAO;
   
   @Inject
   private EmpAtchFileService fileService;
   
   @Value("#{appInfo['mypage.attatchPath']}")
   private File saveFolder;
   
   @Inject
   private PasswordEncoder encoder;
   
   private void encryptBoard(MypageVO mypage) {
      // 입력받은 평문 비번을 암호화.
      
      String encoded = encoder.encode(mypage.getEmpPass());
      mypage.setEmpPass(encoded);
   }
   
   @Override
   public MypageVO retrieveMypage(String empId) {
	   
	   
      MypageVO mypage = mypageDAO.selectEmployee(empId);
      EmpAtchFileVO empAtchFileTemp = new EmpAtchFileVO();
      empAtchFileTemp.setEmpAtchSaveName("profile-12.jpg");
      mypage.setProfileImage(empAtchFileTemp);
      
      if(mypage.getEmpAtchId()!= null) {
         List<EmpAtchFileVO> mypageImgs = fileService.retrieveAttatchFile(mypage.getEmpAtchId(), saveFolder);
         log.info("확인 마이페이지 조회 값 = {}",mypage.getProfileImage());
         for(EmpAtchFileVO mypageImg : mypageImgs) {
            if(mypageImg.getEmpAtchClasfct() == 0) {
               mypage.setEmpAtchId(mypageImg.getEmpAtchId());
               mypage.setProfileImage(mypageImg);
               log.info("확인 마이페이지 이미지 값 = {}",mypage.getProfileImage());
            }else {
               mypage.setEmpAtchId(mypageImg.getEmpAtchId());
               mypage.setSignImage(mypageImg);
               log.info("확인 마이페이지 사인 값 = {}",mypage.getSignImage());
               
            }
         }
      }
      return mypage;
   }
   
   @Override
   public void changePass(MypageVO mypage) {
      encryptBoard(mypage);
      mypageDAO.updatePass(mypage);
   }
   
   @Override
   public void modifyMypage(MypageVO mypage) {
      modifyProfileImg(mypage);
      
   }
   
   @Override
   public void modifyProfileImg(MypageVO mypage) {
      
      MypageVO saved = retrieveMypage(mypage.getEmpId());
      EmpAtchFileVO empAtchFile = new EmpAtchFileVO(mypage.getEmpFiles());
      empAtchFile.setEmpAtchId(saved.getEmpAtchId());
      empAtchFile.setEmpAtchClasfct(0);
      
      if(mypage.getProfileImage().getEmpAtchSaveName() != "profile-12.jpg") {// 프로필 있음
         fileService.modifyAttatchFile(empAtchFile, saveFolder);
         mypageDAO.updateMypage(mypage);
      }else {
         if(saved.getSignImage() != null) { // 프로필 없고, 결재 있음
            fileService.createAddAtchFile(empAtchFile, saveFolder);

         }else { // 프로필 없고, 결재 없음
            fileService.createAttatchFile(empAtchFile, saveFolder);
            mypageDAO.updateMypage(mypage);
            
            mypage.setEmpAtchId(empAtchFile.getEmpAtchId());
            createAtchId(mypage);
         }
      }
   }
   
   @Override
   public void modifySignImg(MypageVO mypage) {
      
      MypageVO saved = retrieveMypage(mypage.getEmpId());
      EmpAtchFileVO empAtchFile = new EmpAtchFileVO(mypage.getEmpFiles());
      
      empAtchFile.setEmpAtchId(saved.getEmpAtchId());
      empAtchFile.setEmpAtchClasfct(1);
      
      log.info("mypage.getProfileImage().getEmpAtchSaveName() 사인사인 = {}",  saved.getProfileImage().getEmpAtchSaveName()); 
      if(saved.getSignImage() != null) { // 사인 있음
         fileService.modifyAttatchFile(empAtchFile, saveFolder);
      }else {
    	  if(saved.getProfileImage().getEmpAtchSaveName() == "profile-12.jpg") {// 사인 없고 프로필 없음
    		  fileService.createSignFile(empAtchFile, saveFolder);
    		  mypage.setEmpAtchId(empAtchFile.getEmpAtchId());
    		  createAtchId(mypage);
            
         }else { // 사인 없고 프로필 있음
        	 fileService.createAddAtchFile(empAtchFile, saveFolder);
         }
         
      }
   }

   @Override
   public List<DepartmentVO> retrieveUpperDPMT() {
      List<DepartmentVO> dpmt = mypageDAO.selectUpperDPMT();
      return dpmt;
   }

   @Override
   public List<DepartmentVO> retrieveTeamInfo() {
      List<DepartmentVO> team = mypageDAO.selectTeamInfo();
      return team;
   }

   @Override
   public List<OrganizationInfoVO> retrieveTeamEmpList() {
      List<OrganizationInfoVO> teamEmp = mypageDAO.selectTeamEmpList();
      return teamEmp;
   }

   @Override
   public int createDeputyApprover(DeputyApproverVO deputy) {
      int cnt = mypageDAO.insertDeputyApprover(deputy);
      return cnt;
   }

   @Override
   public List<DeputyApproverVO> retrieveDeputyApprover(DeputyApproverVO deputy) {
      List<DeputyApproverVO> approver = mypageDAO.selectDeputyApprover(deputy);
      return approver;
   }

   @Override
   public int modifyDeputyApprover(DeputyApproverVO deputy) {
      int cnt = mypageDAO.updateDeputyApprover(deputy);
      return cnt;
   }

   @Override
   public int createAtchId(MypageVO mypage) {
      int cnt = mypageDAO.insertAtchId(mypage);
      return cnt;
   }
   
   
}