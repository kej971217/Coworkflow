package kr.or.ddit.employee.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "rankId")
public class RankVO implements Serializable {
	
	private String rankId;
	private String rankName;
	
	
}
