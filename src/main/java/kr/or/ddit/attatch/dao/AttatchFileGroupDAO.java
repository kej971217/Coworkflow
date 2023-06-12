package kr.or.ddit.attatch.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;

/**
 * 첨부된 형태의 파일 데이터를 관리하기 위한 Persistence Layer
 *
 */
@Mapper
public interface AttatchFileGroupDAO {
	
	public int insertAttatchFileGroup(AttatchFileGroupVO atchFileGroup);
	
	public AttatchFileVO selectAttatch(AttatchFileVO condition);
	
	public AttatchFileGroupVO selectAttatchList(int atchId);
	
	public int updateAttatchFileGroup(AttatchFileGroupVO atchFileGroup);
	
	public int deleteAttatch(AttatchFileVO condition);
	
	public int deleteAttatchList(int atchId);
}
