package kr.or.ddit.mypage.service;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.ddit.attatch.service.AttatchFileGroupService;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.mypage.dao.EmpAtchFileDAO;
import kr.or.ddit.mypage.vo.EmpAtchFileVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmpAtchFileServiceImpl implements EmpAtchFileService {

	@Inject
	private EmpAtchFileDAO fileDAO;
	
	@Value("#{appInfo['mypage.attatchPath']}")
	private File saveFolder;

	@Override
	public List<EmpAtchFileVO> retrieveAttatchFile(int atchId, File saveFolder) {
		List<EmpAtchFileVO> atchFile = fileDAO.selectAttatchList(atchId);
		return atchFile;
	}
	
	@Override
	public int createAttatchFile(EmpAtchFileVO atchFile, File saveFolder) {
		int cnt = 0;
		if (atchFile != null) {
			atchFile.setEmpAtchClasfct(0);
			cnt = fileDAO.insertAttatchFile(atchFile);
			
			if(cnt >0)
				processAttatchFileBinary(atchFile, saveFolder);
		}
		
		return cnt;
	}
	@Override
	public int createSignFile(EmpAtchFileVO atchFile, File saveFolder) {
		int cnt = 0;
		if (atchFile != null) {
			atchFile.setEmpAtchClasfct(1);
			cnt = fileDAO.insertAttatchFile(atchFile);
			
			if(cnt >0)
				processAttatchFileBinary(atchFile, saveFolder);
		}
		
		return cnt;
	}

	private void processAttatchFileBinary(EmpAtchFileVO atchFile, File saveFolder) {
		
		
		if (atchFile != null) {
		    try {
		    	atchFile.saveTo(saveFolder);
		    } catch (IOException e) {
		        throw new RuntimeException(e);
		    }
		}
		
	}

	@Override
	public EmpAtchFileVO retrieveAttatchFile(EmpAtchFileVO condition, File saveFolder) {
		EmpAtchFileVO atchFileVO = fileDAO.selectAttatch(condition);
		Optional.ofNullable(atchFileVO)
				.ifPresent((afv)->{
					File saveFile = new File(saveFolder, afv.getEmpAtchSaveName());
					afv.setAtchFile(saveFile);
				});
		return atchFileVO;
	}

	@Override
	public int modifyAttatchFile(EmpAtchFileVO atchFile, File saveFolder) {
		int cnt = 0;
		log.info("여기 2 = {}",atchFile);
		if (atchFile.getEmpAtchId() != null) {
			log.info("여기 3 = {}",atchFile);
			EmpAtchFileVO saved = retrieveAttatchFile(atchFile, saveFolder);
			removeAttatchFile(saved, saveFolder);
			log.info("여기 4 = {}",saved);
			
			cnt = fileDAO.updateAttatchFile(atchFile);
			log.info("여기 5 = {}",atchFile);
			if(cnt >0)
				processAttatchFileBinary(atchFile, saveFolder);
		}
		
		return cnt;
	}

	private void processAttatchFileBinaryDataDelete(EmpAtchFileVO file, File saveFolder){
		if (file != null) {
		    FileUtils.deleteQuietly(new File(saveFolder, file.getEmpAtchSaveName()));
		}
	}
	
	@Override
	public int removeAttatchFile(EmpAtchFileVO file, File saveFolder) {
		EmpAtchFileVO removeFile = fileDAO.selectAttatch(file);
		log.info("안녕 removeFile ={}",removeFile);
			int rowcnt = fileDAO.deleteAttatch(removeFile);
			log.info("떠났니 ? removeFile ={}",removeFile);
			if (rowcnt > 0) {
				processAttatchFileBinaryDataDelete(file, saveFolder);
			}
			
		return rowcnt;
	}

	@Override
	public int createAddAtchFile(EmpAtchFileVO atchFile, File saveFolder) {
		int cnt = 0;
		if (atchFile != null) {
			cnt = fileDAO.insertAddAtchFile(atchFile);
			
			if(cnt >0)
				processAttatchFileBinary(atchFile, saveFolder);
		}
		return cnt;
	}


}


