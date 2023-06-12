package kr.or.ddit.commons.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class CommVO implements Serializable {
	@EqualsAndHashCode.Include
	@NotBlank
	private String commId;
	@NotBlank
	private String commName;
}

