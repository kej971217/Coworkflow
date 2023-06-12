package kr.or.ddit.drive.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.drive.vo.DriveAtchVO;
import kr.or.ddit.drive.vo.DriveVO;

@Mapper
public interface DriveDAO{
	
	public int insertFile(DriveAtchVO driveAtch);
	
	public int insertFolder(DriveVO drive);
	
	
	public List<DriveVO> selelctFolderListJoin(DriveVO drive);
	
	public List<DriveVO> selectFolderList(DriveVO drive);
	
	public List<DriveAtchVO> selectFileList(DriveAtchVO driveAtch);
	
	
	
	public DriveVO selectFolder(DriveVO drive);
	
	public DriveAtchVO selectFile(DriveAtchVO driveAtch);
	
	
	
	public int updateFileName(DriveAtchVO driveAtch);
	
	public int deleteFile(DriveAtchVO driveAtch);
	
	
	
	public int updateFolderName(DriveVO drive);

	public int updateFolderNameOnDriveAtch(Integer driveId);

	
	
	public int deleteFolder(DriveVO drive);
	
	public int deleteFolderFileList(Integer driveId);
	
	
	
	public DriveVO selectDrivePath(DriveVO drive);
	
	public DriveAtchVO selectDriveFileRoot(DriveAtchVO driveAtch);
	
	
}
