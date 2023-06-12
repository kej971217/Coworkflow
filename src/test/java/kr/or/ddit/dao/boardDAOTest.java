package kr.or.ddit.dao;

import javax.inject.Inject;

import org.junit.Test;

import kr.or.ddit.AbstractModelLayerTest;
import kr.or.ddit.board.notice.dao.NoticeBoardDAO;
import kr.or.ddit.board.project.dao.ProjectBoardDAO;
import kr.or.ddit.board.project.vo.ProjectVO;
import kr.or.ddit.board.vo.PostVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class boardDAOTest extends AbstractModelLayerTest {
	
	@Inject
	private NoticeBoardDAO boardDAO;
	
	@Inject
	private ProjectBoardDAO projectDAO;
	
	
	
	@Test
	public void testSelectRole()  {
		ProjectVO project = new ProjectVO();
		project.setProjectName("qwe");
		project.setProjectGoal("123");
		project.setEmpId("a100002");
		project.setProjectStartDate("2023/05/17 22:00:00.000000000");
		project.setProjectGoalDate("2023/05/17 22:00:00.000000000");
		projectDAO.insertProjectBoard(project);
		
		log.info("project Id = {}", project.getProjectId() );
		
	}
	
}
