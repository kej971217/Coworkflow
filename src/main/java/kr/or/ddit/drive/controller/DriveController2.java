package kr.or.ddit.drive.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/drive2")
public class DriveController2 {
/*	
	//업로드
	@PostMapping("/upload")
	public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file) {
	    if (file.isEmpty()) {
	        return ResponseEntity.badRequest().body("File cannot be empty");
	    }

	    // 파일 메타데이터를 DB에 저장합니다. (이 부분은 당신의 DB 환경에 따라 변경될 것입니다.)
	    FileMetaData metaData = new FileMetaData();
	    metaData.setFileName(file.getOriginalFilename());
	    metaData.setFileSize(file.getSize());
	    metaData.setUploadTime(Instant.now());

	    // 파일을 파일 시스템에 저장합니다.
	    Path filePath = Paths.get("/path/to/upload/directory", file.getOriginalFilename());
	    try {
	        Files.copy(file.getInputStream(), filePath);
	        metaData.setFilePath(filePath.toString());
	    } catch (IOException e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to save file");
	    }

	    // 파일 메타데이터를 DB에 저장합니다. (이 부분은 당신의 DB 환경에 따라 변경될 것입니다.)
	    fileMetaDataRepository.save(metaData);

	    return ResponseEntity.ok().body("File uploaded successfully");
	}

	//파일을 다운로드
	@GetMapping("/download/{fileName}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) {
	    // DB에서 파일 메타데이터를 조회합니다. (이 부분은 당신의 DB 환경에 따라 변경될 것입니다.)
	    FileMetaData metaData = fileMetaDataRepository.findByFileName(fileName);
	    if (metaData == null) {
	        return ResponseEntity.notFound().build();
	    }

	    // 파일을 파일 시스템에서 로드합니다.
	    Path filePath = Paths.get(metaData.getFilePath());
	    Resource resource = null;
	    try {
	        resource = new UrlResource(filePath.toUri());
	    } catch (MalformedURLException e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to load file");
	    }

	    return ResponseEntity.ok()
	        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
	        .body(resource);
	}
	
	// 파일 정보를 JSON 형식으로 반환
	@GetMapping("/files")
	public ResponseEntity<?> listFiles() {
	    // DB에서 모든 파일 메타데이터를 조회합니다. (이 부분은 당신의 DB 환경에 따라 변경될 것입니다.)
	    List<FileMetaData> metaDataList = fileMetaDataRepository.findAll();

	    // 파일 메타데이터를 JSON으로 변환하기 위해 객체를 생성합니다.
	    List<Map<String, Object>> fileList = new ArrayList<>();
	    for (FileMetaData metaData : metaDataList) {
	        Map<String, Object> fileMap = new HashMap<>();
	        fileMap.put("name", metaData.getFileName());
	        fileMap.put("size", metaData.getFileSize());
	        fileMap.put("uploadTime", metaData.getUploadTime());
	        fileList.add(fileMap);
	    }

	    return ResponseEntity.ok().body(fileList);
	}

	*/
	
}
