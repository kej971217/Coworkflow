package kr.or.ddit.commons.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.commons.vo.CommVO;

@Mapper
public interface CommDAO {
	
	public List<CommVO> selectF();
	public List<CommVO> selectG();
	public List<CommVO> selectH();
	public List<CommVO> selectI();
	public List<CommVO> selectD();
	public List<CommVO> selectA();
	public List<CommVO> selectB();
	public List<CommVO> selectS();
	public List<CommVO> selectK();
	public List<CommVO> selectC();
	public List<CommVO> selectM();
	public List<CommVO> selectE();
	public List<CommVO> selectJ();

}
