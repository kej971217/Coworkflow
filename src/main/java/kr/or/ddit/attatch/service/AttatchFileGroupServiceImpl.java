package kr.or.ddit.attatch.service;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import kr.or.ddit.attatch.dao.AttatchFileGroupDAO;
import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;

@Service
public class AttatchFileGroupServiceImpl implements AttatchFileGroupService {

	@Inject
	private AttatchFileGroupDAO fileGroupDAO;

	@Override
	public int createAttatchFileGroup(AttatchFileGroupVO atchFileGroup, File saveFolder) {
		int rowcnt =Optional.ofNullable(atchFileGroup.getAtchFileList())
							.filter((afl)->!afl.isEmpty())
							.map((afl)->fileGroupDAO.insertAttatchFileGroup(atchFileGroup))
							.orElse(0);
		if(rowcnt>0) {
			processAttatchFileGroupBinary(atchFileGroup, saveFolder);
		}
		return rowcnt;
	}

	private void processAttatchFileGroupBinary(AttatchFileGroupVO atchFileGroup, File saveFolder) {
		atchFileGroup.getAtchFileList().stream()
				.forEach((af)->{  
					try {
						af.saveTo(saveFolder);
					}catch (IOException e) {
						throw new RuntimeException(e);
					}
				});
	}

	@Override
	public AttatchFileGroupVO retrieveAttatchFileGroup(int atchId, File saveFolder) {
		AttatchFileGroupVO atchFileGroup = fileGroupDAO.selectAttatchList(atchId);
		return atchFileGroup;
	}

	@Override
	public AttatchFileVO retrieveAttatchFile(AttatchFileVO condition, File saveFolder) {
		AttatchFileVO atchFileVO = fileGroupDAO.selectAttatch(condition);
		Optional.ofNullable(atchFileVO)
				.ifPresent((afv)->{
					File saveFile = new File(saveFolder, afv.getAtchSaveName());
					afv.setAtchFile(saveFile);
				});
		return atchFileVO;
	}

	@Override
	public int modifyAttatchFileGroup(AttatchFileGroupVO atchFileGroup, File saveFolder) {
		// 첨부파일 수정 절차 ??
		return Optional.ofNullable(atchFileGroup.getAtchFileList())
						.filter((fl)->!fl.isEmpty())
						.map((fl)->{
							int rowcnt = fileGroupDAO.updateAttatchFileGroup(atchFileGroup);
							if(rowcnt > 0) {
								processAttatchFileGroupBinary(atchFileGroup, saveFolder);
							}
							return rowcnt;
						}).orElse(0);
	}

	private void processAttatchFileBinaryDataDelete(AttatchFileGroupVO fileGroup, File saveFolder){
		fileGroup.getAtchFileList().stream()
			.forEach((af)->{
				FileUtils.deleteQuietly(new File(saveFolder, af.getAtchSaveName()));
			});
	}
	
	@Override
	public int removeAttatchFileGroup(int atchId, File saveFolder) {
		AttatchFileGroupVO fileGroup = fileGroupDAO.selectAttatchList(atchId);
		int rowcnt = fileGroupDAO.deleteAttatchList(atchId);
		if(rowcnt > 0) {
			processAttatchFileBinaryDataDelete(fileGroup, saveFolder);
		}
		return rowcnt;
	}
	
	@Override
	public int removeAttatchFileGroup(AttatchFileGroupVO delFileGroup, File saveFolder) {
 		List<AttatchFileVO> conditionList = Optional.ofNullable(delFileGroup.getDelSeqs())
									 				.map((delSeqs)->{
									 					return Arrays.stream(delSeqs)
											 						.mapToObj((seq)->{
											 							AttatchFileVO condition = new AttatchFileVO();
											 							condition.setAtchId(delFileGroup.getAtchId());
											 							condition.setAtchSeq(seq);
											 							return fileGroupDAO.selectAttatch(condition);
											 						}).collect(Collectors.toList());
									 				}).orElse(null);
 		return Optional.ofNullable(conditionList)
		 				.map((cl)->{
		 					cl.stream()
		 						.forEach((condition)->{
		 							fileGroupDAO.deleteAttatch(condition);
		 							FileUtils.deleteQuietly(new File(saveFolder, condition.getAtchSaveName()));
		 						});
		 					return cl.size();
		 				}).orElse(0);
	}
}












































