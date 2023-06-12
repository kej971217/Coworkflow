package kr.or.ddit.drive.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.drive.service.DriveService;
import kr.or.ddit.drive.vo.DriveAtchVO;
import kr.or.ddit.drive.vo.DriveVO;
import kr.or.ddit.employee.service.EmpService;
import kr.or.ddit.employee.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/drive")
public class DriveController {
	
	@Inject
	private DriveService driveService;
	
	@Value("#{appInfo.drive}")
	private File saveFolder;
	
	@Value("#{appInfo.drive}")
	private String folderURL;
	
	@PostConstruct
	public void init() {
		log.info("주입된 객체 : {}", saveFolder);
	}
	
	@GetMapping("main.do")
	public String getUI(Model model) {
		model.addAttribute("level1Menu","drive");
		return "drive/main";
	}
	
	
	
	@GetMapping("download.do")
	public void downloadFile(
			@RequestParam Integer driveAtchNo
			, Model model
			, HttpServletResponse resp
//			, DriveAtchVO driveAtch
//			, DriveVO drive
	) throws Exception {
		// driveAtchId 받고, DB 조회 -> VO로 받아서 아래 정보들 채워주기
		
		//파일 No 받아서 DB 조회
		DriveAtchVO driveAtchCon = new DriveAtchVO();
		driveAtchCon.setDriveAtchNo(driveAtchNo);
		DriveAtchVO driveAtchRes = driveService.retrieveFile(driveAtchCon);
		
//		driveAtch.getDriveId();
//		driveAtch.getDriveFileRoot();
//		driveAtch.getDriveAtchOriginName();
		
		//폴더 Id 받아서 DB 조회
		DriveVO driveCon = new DriveVO();
		driveCon.setDriveId(driveAtchRes.getDriveId());
		DriveVO driveRes = driveService.retrieveFolder(driveCon); //drive_file_root
		
//		D:\Coworkflow\resources\drive
		
		
//	    File file = new File("/path/to/uploads/" + filename);
	    File file = new File(saveFolder + driveAtchRes.getDriveFileRoot() + driveAtchRes.getDriveAtchSaveName());  
//	    File file = new File("D:\\Coworkflow\\resources\\drive");
	    
//	    log.info("\n\n\n 파일 절대경로 : {}", file.getAbsolutePath());
	    if (file.exists()) {
	    	String mimeType = URLConnection.guessContentTypeFromName(driveAtchRes.getDriveAtchType());
	    	if (mimeType == null) {
	    		mimeType = "application/octet-stream";
	    	}
	    	resp.setContentType(mimeType);
	    	String encodedOrgName = URLEncoder.encode(driveAtchRes.getDriveAtchOriginName(), "utf-8");
	    	resp.setHeader("Content-Disposition", "inline; filename=\"" + encodedOrgName + "\"");
	    	resp.setContentLengthLong(driveAtchRes.getDriveAtchSize());
	    	InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
	    	FileCopyUtils.copy(inputStream, resp.getOutputStream());
	    }
	    
	    
	}
	
	
	
	
	
	@PostMapping(value="upload.do")
	@ResponseBody
	public List<Map<String, Object>> fileUpload(
			List<MultipartFile> uploads
			, Integer driveId
			, HttpServletRequest req
			, Authentication authentication
	) throws IOException {
		List<Map<String, Object>> targets = new ArrayList<>();
		
		for(MultipartFile upload : uploads) {
			Map<String, Object> target = new HashMap<>();
			if(upload.isEmpty()) {
				Map<String, Object> error = new HashMap<>();
				target.put("error", error);
				error.put("number", 400);
				error.put("message", "업로드할 파일이 없음");
			}else {
				// 폴더명 불러오기 위한 DB 조회
				DriveAtchVO driveAtch = new DriveAtchVO();
				if(driveId == null){
					driveAtch.setDriveId(1);
				}else {
					driveAtch.setDriveId(driveId);
				}
				DriveAtchVO driveAtchRes = driveService.retrieveDriveFileRoot(driveAtch);
//				String selectedFolder = "/" + driveRes.getDriveRoot() + "/";
//				if(driveRes.getDriveId() == 1) {
//					selectedFolder = "/";
//				}
				
				String savename = UUID.randomUUID().toString();
				File saveFile = new File(saveFolder + driveAtchRes.getDriveFileRoot(), savename);
				upload.transferTo(saveFile);
				target.put("fileName", upload.getOriginalFilename());
				target.put("uploaded", 1);
				String url = String.format("%s%s/%s", req.getContextPath(), folderURL, savename);
				target.put("url", url);
				
				
				//파일 메타데이터 DriveAtchVO에 저장
				DriveAtchVO driveAtchCon = new DriveAtchVO();
//				driveAtchCon.setDriveAtchNo(null);//파일번호
				driveAtchCon.setDriveId(driveAtch.getDriveId());//드라이브ID***
				driveAtchCon.setDriveAtchType(upload.getContentType());//파일종류
				driveAtchCon.setDriveAtchOriginName(upload.getOriginalFilename());//파일원본명
				driveAtchCon.setDriveAtchSaveName(savename);//파일저장명
				driveAtchCon.setEmpId(authentication.getName());//등록직원ID
//				driveAtchCon.setDriveAtchRgstDate(null);//등록일자
				driveAtchCon.setIsopen(null);//노출여부
				driveAtchCon.setDriveAtchSize(upload.getSize());//파일크기
				driveAtchCon.setDriveFileRoot(driveAtchRes.getDriveFileRoot());//파일경로***
				
				//DriveAtchVO 정보를 DB에 저장
				driveService.createFile(driveAtchCon);
			}
			targets.add(target);
		}
		return targets;
	}

	
		
	@Inject
	private EmpService empService;
	
	
	
	@PostMapping(value = "makeFolder.do",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String makeFolder(
		HttpServletRequest req
		, Authentication authentication
		, Model model
		, DriveVO drive //driveId2, driveRoot(폴더명)
	) {
		
		log.info("폴더 이름: {}", drive.getDriveRoot());
		
		
		if(drive.getDriveId2()==1) {
			drive.setDrivePath("\\" + drive.getDriveRoot());
		}else {
			DriveVO driveRes = driveService.retrieveDrivePath(drive); //driveId2로 보내주곤 있지만, 쿼리에서는 drive_id를 조회합니다. 
			drive.setDrivePath(driveRes.getDrivePath());
		}
		log.info("폴더 경로: {}",  saveFolder + drive.getDrivePath());
		
		
		
		log.info("(drive.getDriveId2():  {}",  drive.getDriveId2());
		
	
		File newFolder = new File(saveFolder + drive.getDrivePath());
		// 폴더명 아예 안 적었을 때랑, .으로 시작하면 안 됨 -> 막아야 함!!
 		if(! newFolder.exists()) {
			newFolder.mkdirs();
			
			if(drive.getDriveId2()==null) {
				drive.setDriveId2(1);
			}
			int res = driveService.createFolder(drive);
			if(res>0) {
				model.addAttribute("result", true);
			}else {
				model.addAttribute("message", "서버 오류 발생! 잠시 후 다시 시도해주세요.");
				model.addAttribute("result", false);
			}
		}else {
			model.addAttribute("message", "이미 존재하는 폴더명입니다.");
			model.addAttribute("result", false);
		}
 	
		return "jsonView";
	}
	

	
	
	// 폴더 모두 한번에 불러오는 거랑 -> 조금 느림, 요청 1회
	// 폴더 마다 각각 불러오는 거랑 -> 조금 더 빠름, 요청 多
	@PostMapping(value = "openFolder.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String openFolder(
		Model model
		, DriveAtchVO driveAtch
		, DriveVO drive
		, Authentication authentication
	) {
		
		try {
			//파일 조회
			if(driveAtch.getDriveId() == null) {
				driveAtch.setDriveId(1);
			}
			List<DriveAtchVO> fileList = driveService.retrieveFileList(driveAtch);
//			model.addAttribute("fileList", fileList);
			
			
			//폴더 조회
			if(drive.getDriveId() == null) {
				drive.setDriveId(1);
			}
			// case1. driveId2 에 해당하는 폴더를 모두 보여주거나, CEO실일 때
			List<DriveVO> folderList = driveService.retrieveFolderList(drive);
			//TeamId 가져오기
			EmployeeVO emp = empService.selectEmpDetail(authentication.getName());
			// case2. driveId=1(최상위 폴더)이고, CEO실 아닐 때
			if(emp.getTeamId() != 1 && drive.getDriveId() == 1) { 
				drive.setTeamId(emp.getTeamId());
				folderList = driveService.retrieveFolderListJoin(drive);
			}
			
			
//			model.addAttribute("folderList", folderList);
			
			Map<String, Object> data = new HashMap<String, Object>();
			data.put("fileList", fileList);
			data.put("folderList", folderList);
			model.addAttribute("data", data);
			model.addAttribute("result", true);
		} catch (Exception e) {
			e.printStackTrace();  
			model.addAttribute("message", "서버 오류 발생! 잠시 후 다시 시도해주세요.");
			model.addAttribute("result", false);
		}
		return "jsonView";
	}
	
	
	
	
	
	@PostMapping(value = "getParentDriveId2.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String getParentDriveId2(
		DriveVO drive
		, Model model
	) {
		try {
			DriveVO driveRes = driveService.retrieveFolder(drive);
			model.addAttribute("data", driveRes);
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("message", "서버 오류 발생! 잠시 후 다시 시도해주세요.");
			model.addAttribute("result", false);
		}
		return "jsonView";
	}
	
	
	
	
	
	@PostMapping(value = "updateFileName.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String updateFileName(
		DriveAtchVO driveAtch
		, Model model
	) {
		DriveAtchVO driveAtchRes = driveService.retrieveFile(driveAtch);
		String[] tmpArr = driveAtchRes.getDriveAtchOriginName().split("\\.");
		log.info("조회한 파일명: {}", driveAtchRes.getDriveAtchOriginName());
		log.info("tmpArr: {}", tmpArr.toString());
		log.info("tmpArr.length: {}", tmpArr.length);
		String type = tmpArr[ (tmpArr.length-1) ];
		
		//수정하는 파일명에 확장자로 끝나는지 검사
		if(!driveAtch.getDriveAtchOriginName().endsWith("."+type)) {
			//수정할 파일명에 확장자로 안 끝나면
			driveAtch.setDriveAtchOriginName(driveAtch.getDriveAtchOriginName() + "." + type);
		}
		
		//수정하는 파일명에 허용되지 않는 특수문자 포함되는지 검사 --> replace? or message?
		
		
		if(driveService.modifyFileName(driveAtch) > 0) {
			log.info("수정할 파일명: {}", driveAtch.getDriveAtchOriginName());
			model.addAttribute("result", true);
		}else {
			model.addAttribute("message", "서버 오류 발생! 잠시 후 다시 시도해주세요.");
			model.addAttribute("result", false);
		}
		return "jsonView";
	}
	
	
	
	
	
	@PostMapping(value="removeFile.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String removeFile(
		DriveAtchVO driveAtch
		, Model model
	) {	
		//ID로 DB 파일 메타데이터 조회하기 
		DriveAtchVO driveAtchRes = driveService.retrieveFile(driveAtch);
		String selectedFolder = driveAtchRes.getDriveFileRoot();
		String savename = driveAtchRes.getDriveAtchSaveName();
		
		File selectedFile = new File(saveFolder + selectedFolder, savename);
		if(selectedFile.exists()) {
			// 로컬 파일 삭제하기
			log.info("삭제하려는 파일: {}", selectedFile.getAbsolutePath());
			selectedFile.delete();
			// 로컬 파일 삭제 후 DB 파일 메타데이터 삭제하기
			if(driveService.removeFile(driveAtch)> 0) {
				model.addAttribute("result", true);
			}else {
				model.addAttribute("message", "서버 오류 발생! 잠시 후 다시 시도해주세요.");
				model.addAttribute("result", false);
			}
		}else {
			// 로컬 파일이 존재하지 않는다면...?
			model.addAttribute("message", "파일이 존재하지 않습니다.");
			model.addAttribute("result", false);
		}
		return "jsonView";
	}
	
	
	
	
	public void renameSubFolders(File folder, String oldRoot, String newRoot) {
	    // 모든 파일 및 하위 폴더를 순회한다.
	    for (final File fileEntry : folder.listFiles()) {
	        // 폴더인 경우
	        if (fileEntry.isDirectory()) {
	            // 재귀적으로 하위 폴더로 들어간다.
	            renameSubFolders(fileEntry, oldRoot, newRoot);
	        }
	        
	        // 파일이거나 하위 폴더의 탐색이 완료된 경우 경로를 변경한다.
	        String oldPath = fileEntry.getAbsolutePath();
	        String newPath = oldPath.replace(oldRoot, newRoot);
	        File newFile = new File(newPath);
	        fileEntry.renameTo(newFile);
	    }
	}

	
	
	
	
	@PostMapping(value="updateFolderName.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String updateFolderName(
		DriveVO drive //driveId, driveId2,  driveRoot
		, Model model
	) {
		//최상위 루트인 경우 폴더 이름 변경 불가
		if(drive.getDriveId() == 1) {
			model.addAttribute("message", "최상위 폴더의 이름은 변경할 수 없습니다.");
			model.addAttribute("result", false);
		}else {
			
			
			//ID로 폴더 경로 조회하기
			// DriveVO driveRes = driveService.retrieveFolder(drive);
			
			
			DriveAtchVO oldPathVO = new DriveAtchVO();
			oldPathVO.setDriveId( drive.getDriveId() );
			DriveAtchVO oldPathVORes = driveService.retrieveDriveFileRoot(oldPathVO);
			
			DriveAtchVO newPathVO = new DriveAtchVO();
			newPathVO.setDriveId( drive.getDriveId2() );
			DriveAtchVO newPathVORes = driveService.retrieveDriveFileRoot(newPathVO);
			
			
			//String oldFolderRoot = oldPathVORes.getDrivePath();
			String newFolderRoot = newPathVORes.getDriveFileRoot() + drive.getDriveRoot();         
			
			log.info("saveFolder: {}", saveFolder);
			log.info("oldFolderRoot: {}", oldPathVORes.getDriveFileRoot());
			log.info("newFolderRoot: {}", newFolderRoot);
			
			File oldFolder = new File(saveFolder + oldPathVORes.getDriveFileRoot());
			if(oldFolder.exists()) {
				//로컬 폴더 이름 변경하기
				File newFolder = new File(saveFolder + newFolderRoot);
				oldFolder.renameTo(newFolder);
				
				//로컬 폴더 안에 있는 서브폴더들도 경로 변경해줘야 함
				renameSubFolders(newFolder, oldPathVORes.getDriveFileRoot(), newFolderRoot);
				
				//로컬 변경 후 DB 폴더 이름 변경하기(drive, driveAtch 둘 다 변경해줘야 함 ==> 서비스에서 해줌!)
				if(driveService.modifyFolderName(drive) > 0) {   
					model.addAttribute("result", true);
				}else {
					model.addAttribute("message", "서버 오류 발생! 잠시 후 다시 시도해주세요.");
					model.addAttribute("result", false);
				}
			}
		}
		
		return "jsonView";
	}
	
	
	
	
	@PostMapping(value="deleteFolder.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String deleteFolder(
		DriveVO drive
		, Model model
	) {
		//최상위 루트인 경우 폴더 삭제 불가
		if(drive.getDriveId() == 1) {
			model.addAttribute("message", "최상위 폴더는 삭제할 수 없습니다.");
			model.addAttribute("result", false);
		}else {
			//ID로 폴더 경로 조회하기
			DriveVO driveRes = driveService.retrieveFolder(drive);
			File folder = new File(saveFolder + driveRes.getDrivePath());
			if(folder.exists()) {
				while(folder.exists()) {
					//로컬 폴더에 들어있는 파일 리스트 얻어오기
					File[] fileList = folder.listFiles();
					for(int i=0; i<fileList.length; i++) {
						//로컬 폴더에 들어있는 파일 삭제하기
						fileList[i].delete();
						log.info("삭제한 파일_{}: {}", i, fileList[i].getAbsolutePath());
					}
					
					//로컬 폴더에 들어있는 파일이 없으면
					if(fileList.length == 0 && folder.isDirectory()) {
						//로컬 폴더 삭제 --> 하위 파일들 먼저 삭제해야만 delete() 실행됨!!!
						folder.delete();
						log.info("삭제한 폴더: {}", folder.getAbsolutePath());
						//로컬 삭제 후 DB 폴더 삭제하기(drive, driveAtch 둘 다 삭제해줘야 함 ==> 서비스에서 해줌!)
						if(driveService.removeFolder(drive) > 0) {
							model.addAttribute("result", true);
						}else {
							model.addAttribute("message", "서버 오류 발생! 잠시 후 다시 시도해주세요.");
							model.addAttribute("result", false);
						}
					}
				}
			}
		}
		return "jsonView";
	}
	
	
	
	
	@PostMapping(value="deleteMultipleItems.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String deleteMultipleItems(
	    @RequestBody List<Map<String, Object>> itemsToDelete,
	    Model model
	) {
	    try {
	        for (Map<String, Object> item : itemsToDelete) {
	            String type = (String) item.get("type");
//	            String type = (Integer) item.get("id"); 
//	            java.lang.ClassCastException: java.lang.String cannot be cast to java.lang.Integer
//	            (Integer) 캐스팅 에러로 인해 Integer.parseInt() 캐스팅 해줌
	            Integer id = Integer.parseInt(item.get("id").toString());
	            
	            
	            
	            if ("folder".equals(type)) { //폴더 라면
	                DriveVO drive = new DriveVO();
	                drive.setDriveId(id);
	                // 폴더 정보 조회
	                DriveVO driveRes = driveService.retrieveFolder(drive);
	                log.info("삭제하려는 폴더: {}", driveRes.getDriveRoot());
	                
	                if(id == 1) {
	                	// 최상위 폴더는 삭제 불가
	                	model.addAttribute("message", "최상위 폴더는 삭제할 수 없습니다.");
	        			model.addAttribute("result", false);
	                }else {
	                	// 폴더 삭제 로직
	                	String folderRoot = driveRes.getDriveRoot();
	                	File folder = new File(saveFolder + "/" + folderRoot);
	                	
	                	if(folder.exists()) {
	        				while(folder.exists()) {
	        					//로컬 폴더에 들어있는 파일 리스트 얻어오기
	        					File[] fileList = folder.listFiles();
	        					for(int i=0; i<fileList.length; i++) {
	        						//로컬 폴더에 들어있는 파일 삭제하기
	        						fileList[i].delete();
	        						log.info("삭제한 파일_{}: {}", i, fileList[i].getAbsolutePath());
	        					}
	        					
	        					//로컬 폴더에 들어있는 파일이 없으면
	        					if(fileList.length == 0 && folder.isDirectory()) {
	        						//로컬 폴더 삭제 --> 하위 파일들 먼저 삭제해야만 delete() 실행됨!!!
	        						folder.delete();
	        						log.info("삭제한 폴더: {}", folder.getAbsolutePath());
	        						//로컬 삭제 후 DB 폴더 삭제하기(drive, driveAtch 둘 다 삭제해줘야 함 ==> 서비스에서 해줌!)
	        						if(driveService.removeFolder(drive) > 0) {
	        							model.addAttribute("result", true);
	        						}else {
	        							model.addAttribute("message", "서버 오류 발생! 잠시 후 다시 시도해주세요.");
	        							model.addAttribute("result", false);
	        						}
	        					}
	        				}
	        			}
	                }
	                
	            } else if ("file".equals(type)) { // 파일이라면
	                DriveAtchVO driveAtch = new DriveAtchVO();
	                driveAtch.setDriveAtchNo(id);
	                // 파일 정보 조회
	                DriveAtchVO driveAtchRes = driveService.retrieveFile(driveAtch);
	                log.info("삭제하려는 파일: {}", driveAtchRes.getDriveAtchOriginName());
	                
	                // 파일 삭제 로직
	                String fileRoot = driveAtchRes.getDriveFileRoot();
	                String fileSaveName = driveAtchRes.getDriveAtchSaveName();
	                String fileOrgName = driveAtchRes.getDriveAtchOriginName();
	                File file = new File(saveFolder + fileRoot + fileSaveName);
	                if(file.exists()) {
	        			// 로컬 파일 삭제하기
	        			log.info("삭제하려는 파일: {}", file.getAbsolutePath());
	        			file.delete();
	        			// 로컬 파일 삭제 후 DB 파일 메타데이터 삭제하기
	        			if(driveService.removeFile(driveAtch)> 0) {
	        				model.addAttribute("result", true);
	        			}else {
	        				model.addAttribute("message", "서버 오류 발생! 잠시 후 다시 시도해주세요.");
	        				model.addAttribute("result", false);
	        			}
	        		}else {
	        			// 로컬 파일이 존재하지 않는다면...?
	        			model.addAttribute("message", fileOrgName + "파일이 존재하지 않습니다.");
	        			model.addAttribute("result", false);
	        		}
	            }
	        }
	        model.addAttribute("result", true);
	    } catch (Exception e) {
	        e.printStackTrace();  
	        model.addAttribute("message", "서버 오류 발생! 잠시 후 다시 시도해주세요.");
	        model.addAttribute("result", false);
	    }
	    return "jsonView";
	}


	
}
