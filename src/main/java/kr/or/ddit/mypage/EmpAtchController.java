package kr.or.ddit.mypage;

import java.io.File;
import java.io.IOException;
import java.util.Properties;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.mypage.service.EmpAtchFileService;
import kr.or.ddit.mypage.view.EmpAttatchDownloadView;
import kr.or.ddit.mypage.vo.EmpAtchFileVO;

public class EmpAtchController {
	
	@Inject
	private EmpAtchFileService servcie;
	@Inject
	private WebApplicationContext context;
	
	@Resource(name="appInfo")
	private Properties appInfo;
	
	@RequestMapping("/{attType}/empAtch/download.do")
	public EmpAttatchDownloadView download(
			int atchId
			, int atchClsfct
			, @PathVariable String attType
	) throws IOException {
		EmpAtchFileVO condition = new EmpAtchFileVO();
		condition.setEmpAtchId(atchId);
		condition.setEmpAtchClasfct(atchClsfct);
		
		String attatchPath = appInfo.getProperty(attType+".attatchPath");
		
		File saveFolder = context.getResource(attatchPath).getFile();
		
		EmpAtchFileVO atchFileVO = servcie.retrieveAttatchFile(condition, saveFolder);
		
		return new EmpAttatchDownloadView() {
			
			@Override
			protected EmpAtchFileVO getModel() {
				return atchFileVO;
			}
		};
	}
}
