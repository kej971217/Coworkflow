package kr.or.ddit.drive.service;

import java.util.List;

import kr.or.ddit.drive.vo.DriveAtchVO;
import kr.or.ddit.drive.vo.DriveVO;

public interface DriveService {
	
	public int createFile(DriveAtchVO driveAtch);
	
	public int createFolder(DriveVO drive);
	
	
	public List<DriveVO> retrieveFolderListJoin(DriveVO drive);
	
	public List<DriveVO> retrieveFolderList(DriveVO drive);
	
	public List<DriveAtchVO> retrieveFileList(DriveAtchVO driveAtch);
	
	
	
	public DriveVO retrieveFolder(DriveVO drive);
	
	public DriveAtchVO retrieveFile(DriveAtchVO driveAtch);
	
	
	
	public int modifyFileName(DriveAtchVO driveAtch);
	
	public int removeFile(DriveAtchVO driveAtch);

	
	
	public int modifyFolderName(DriveVO drive);
	
	public int removeFolder(DriveVO drive);
	
	
	
	public DriveVO retrieveDrivePath(DriveVO drive);
	
	public DriveAtchVO retrieveDriveFileRoot(DriveAtchVO driveAtch);
	
	
}
