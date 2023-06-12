package kr.or.ddit.employee.vo;


import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

public class EmployeeVOWrapper extends User{
	private EmployeeVO realUser;
//	private String userImage;
//	private byte[] memberImage;
//	private String memberImagePath;

	public static List<GrantedAuthority> makeAuthorities(EmployeeVO realUser) {
		realUser.getRank().getRankName();
		realUser.getPosition();
		List<GrantedAuthority> list = new ArrayList<GrantedAuthority>();
		list.add(new RankAuthorityVO(realUser.getRank()));
		list.add(new PositionAuthorityVO(realUser.getPosition()));
		
		return list;
	}
	
	
	public EmployeeVOWrapper(EmployeeVO realUser) { 
		super(realUser.getEmpId(), realUser.getEmpPass(), makeAuthorities(realUser));
		this.realUser = realUser;
	}
	
	
	public EmployeeVOWrapper(EmployeeVO realUser, Set<GrantedAuthority> authSet) {
		super(realUser.getEmpId(), realUser.getEmpPass(), Stream.concat(AuthorityUtils.createAuthorityList(realUser.getMemRole()).stream(), authSet.stream())
					  .collect(Collectors.toList())); 
		this.realUser=realUser;
	}

	public EmployeeVO getRealUser() {
		return realUser;
	}

	
	
	
	// 이미지를 저장
//    public EmployeeVOWrapper(EmployeeVO realUser, byte[] memberImage) { 
//        super(realUser.getEmpId(), realUser.getEmpPass(), makeAuthorities(realUser));
//        this.realUser = realUser;
//        this.memberImage = memberImage;
//    }
//
//    public byte[] getMemberImage() {
//        return memberImage;
//    }
//
//    public void setMemberImage(byte[] memberImage) {
//        this.memberImage = memberImage;
//    }
	
    
    
//    이미지 경로를 저장
//    public EmployeeVOWrapper(EmployeeVO realUser, String memberImagePath) { 
//        super(realUser.getEmpId(), realUser.getEmpPass(), makeAuthorities(realUser));
//        this.realUser = realUser;
//        this.memberImagePath = memberImagePath;
//    }
//
//    public String getMemberImagePath() {
//        return memberImagePath;
//    }
//
//    public void setMemberImagePath(String memberImagePath) {
//        this.memberImagePath = memberImagePath;
//    }
}
