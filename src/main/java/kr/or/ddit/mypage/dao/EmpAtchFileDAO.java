package kr.or.ddit.mypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.mypage.vo.EmpAtchFileVO;

/**
 * 첨부된 형태의 파일 데이터를 관리하기 위한 Persistence Layer
 *
 */
@Mapper
public interface EmpAtchFileDAO {
	
	public int insertAttatchFile(EmpAtchFileVO atchFile);
	
	public int insertAddAtchFile(EmpAtchFileVO atchFile);
	
	public EmpAtchFileVO selectAttatch(EmpAtchFileVO condition);
	
	public List<EmpAtchFileVO> selectAttatchList(int atchId);
	
	public int updateAttatchFile(EmpAtchFileVO atchFile);
	
	public int deleteAttatch(EmpAtchFileVO condition);
	
	public int deleteAttatchList(int atchId);
}
