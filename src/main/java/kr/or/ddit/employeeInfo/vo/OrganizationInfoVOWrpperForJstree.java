package kr.or.ddit.employeeInfo.vo;

import java.util.Optional;

import kr.or.ddit.employee.vo.OrganizationInfoVO;
import kr.or.ddit.employeeInfo.vo.jstree.JstreeVO;

public class OrganizationInfoVOWrpperForJstree implements JstreeVO {
	
	private OrganizationInfoVO orgInfo;
	
	public OrganizationInfoVOWrpperForJstree(OrganizationInfoVO orgInfo) {
		super();
		this.orgInfo = orgInfo;
	}

	@Override
	public String getId() {
		return orgInfo.getTeamId().toString();
	}

	@Override
	public String getParent() {
		return orgInfo.getBelongTeam().toString();
	}

	@Override
	public String getText() {
		return orgInfo.getEmpName();
	}

}
/*
 * JSON 형식 2
 * 
$('#using_json_2').jstree({ 'core' : {
    'data' : [
       { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
       { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
       { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
       { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
    ]
} });
 * 
 */