package com.camping.bit.dao;

import java.util.List;
import java.util.Map;

import com.camping.bit.dto.MemberDto;

public interface MemberDao {
	
	public MemberDto getMember(String id);

	public boolean idCheck(String id);

    public boolean nicknameCheck(String nickname);

    public boolean emailCheck(String email);

    public boolean login(MemberDto dto);

    public void addMember(MemberDto dto);

    public String findId(MemberDto dto);
    public String findPw(MemberDto dto);

    public void updatePw(MemberDto dto);
}
