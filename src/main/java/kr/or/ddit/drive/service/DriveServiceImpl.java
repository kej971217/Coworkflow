package kr.or.ddit.drive.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.drive.dao.DriveDAO;
import kr.or.ddit.drive.vo.DriveAtchVO;
import kr.or.ddit.drive.vo.DriveVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DriveServiceImpl implements DriveService {
	
	@Inject
	private DriveDAO driveDAO;
	
	@Override
	public int createFile(DriveAtchVO driveAtch) {
		return driveDAO.insertFile(driveAtch);
	}

	@Override
	public int createFolder(DriveVO drive) {
		return driveDAO.insertFolder(drive);
	}

	@Override
	public List<DriveVO> retrieveFolderListJoin(DriveVO drive) {
		return driveDAO.selelctFolderListJoin(drive);
	}
	
	@Override
	public List<DriveVO> retrieveFolderList(DriveVO drive) {
		return driveDAO.selectFolderList(drive);
	}

	@Override
	public List<DriveAtchVO> retrieveFileList(DriveAtchVO driveAtch) {
		return driveDAO.selectFileList(driveAtch);
	}

	@Override
	public DriveVO retrieveFolder(DriveVO drive) {
		return driveDAO.selectFolder(drive);
	}

	@Override
	public DriveAtchVO retrieveFile(DriveAtchVO driveAtch) {
		return driveDAO.selectFile(driveAtch);
	}

	@Override
	public int modifyFileName(DriveAtchVO driveAtch) {
		return driveDAO.updateFileName(driveAtch);
	}

	@Override
	public int removeFile(DriveAtchVO driveAtch) {
		return driveDAO.deleteFile(driveAtch);
	}

	@Override
	public int modifyFolderName(DriveVO drive) {
		int res = driveDAO.updateFolderName(drive);
		if(res > 0) {
			driveDAO.updateFolderNameOnDriveAtch(drive.getDriveId());
		}
		return res;
	}

	@Override
	public int removeFolder(DriveVO drive) {
		int fileRes = driveDAO.deleteFolderFileList(drive.getDriveId());
		int folderRes = 0;
		if(fileRes >= 0) { // 파일이 없으면 삭제한 파일 수는 0이니까 포함해야 함
			folderRes = driveDAO.deleteFolder(drive);
		}
		return folderRes;
	}

	@Override
	public DriveVO retrieveDrivePath(DriveVO drive) {
		return driveDAO.selectDrivePath(drive);
	}

	@Override
	public DriveAtchVO retrieveDriveFileRoot(DriveAtchVO driveAtch) {
		return driveDAO.selectDriveFileRoot(driveAtch);
	}

}
