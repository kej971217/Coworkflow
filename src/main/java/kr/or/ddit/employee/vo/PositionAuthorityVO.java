package kr.or.ddit.employee.vo;

import org.springframework.security.core.GrantedAuthority;

public class PositionAuthorityVO implements GrantedAuthority{
	
	private PositionVO position;


	public PositionAuthorityVO(PositionVO position) {
		super();
		this.position = position;
	}


	@Override
	public String getAuthority() {
		return String.format("%s_%s_%s_%s", position.getTeamId(), position.getTeamName().toString(), position.getPositionId(), position.getPositionName().toString());
	}


	

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((position == null) ? 0 : position.hashCode());
		return result;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PositionAuthorityVO other = (PositionAuthorityVO) obj;
		if (position == null) {
			if (other.position != null)
				return false;
		} else if (!position.equals(other.position))
			return false;
		return true;
	}


	@Override
	public String toString() {
		return getAuthority();
	}
}
