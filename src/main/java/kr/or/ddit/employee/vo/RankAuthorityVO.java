package kr.or.ddit.employee.vo;

import org.springframework.security.core.GrantedAuthority;

public class RankAuthorityVO implements GrantedAuthority{
	
	private RankVO rank;

	public RankAuthorityVO(RankVO rank) {
		this.rank = rank;
	}


	@Override
	public String getAuthority() {
		return String.format("%s_%s", rank.getRankId(), rank.getRankName());
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((rank == null) ? 0 : rank.hashCode());
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
		RankAuthorityVO other = (RankAuthorityVO) obj;
		if (rank == null) {
			if (other.rank != null)
				return false;
		} else if (!rank.equals(other.rank))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return getAuthority();
	}
}
