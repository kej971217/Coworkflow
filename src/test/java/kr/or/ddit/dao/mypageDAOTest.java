package kr.or.ddit.dao;

import static org.junit.Assert.assertNotNull;

import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.inject.Inject;

import org.junit.Test;

import kr.or.ddit.AbstractModelLayerTest;
import kr.or.ddit.approval.dao.ApprovalDAO;
import kr.or.ddit.approval.vo.ApprovalDocumentVO;
import kr.or.ddit.approval.vo.AuthorizationReplyVO;
import kr.or.ddit.approval.vo.IsapprovalVO;
import kr.or.ddit.employee.dao.PositionDAO;
import kr.or.ddit.mypage.dao.MypageDAO;
import kr.or.ddit.mypage.vo.MypageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class mypageDAOTest extends AbstractModelLayerTest {
	
	@Inject
	private ApprovalDAO aprvDAO;
	
	@Inject
	private MypageDAO myDAO;
	
	@Inject
	private PositionDAO positionDAO;
	
	@Test
	public void testSelectRole()  {
		
		IsapprovalVO isapproval = new IsapprovalVO();
		isapproval.setAprvDocId("230610005");
		isapproval.setEmpId("a100242");
		
		String result = aprvDAO.replyEmpProfile("230610005");
		
		log.info("확인 = {}",result);
		
	}
	
	
	
}
