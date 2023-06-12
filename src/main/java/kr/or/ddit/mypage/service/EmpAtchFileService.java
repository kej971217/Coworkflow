package kr.or.ddit.mypage.service;

import java.io.File;
import java.util.List;

import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.mypage.vo.EmpAtchFileVO;

public interface EmpAtchFileService {
	public int createAttatchFile(EmpAtchFileVO atchFile, File saveFolder);
	public int createSignFile(EmpAtchFileVO atchFile, File saveFolder);
	public int createAddAtchFile(EmpAtchFileVO atchFile, File saveFolder);
	public List<EmpAtchFileVO> retrieveAttatchFile(int atchId, File saveFolder);
	public EmpAtchFileVO retrieveAttatchFile(EmpAtchFileVO condition, File saveFolder);
	public int modifyAttatchFile(EmpAtchFileVO atchFile, File saveFolder);
	public int removeAttatchFile(EmpAtchFileVO delFile, File saveFolder);
}


