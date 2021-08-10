package com.camping.bit.dao;

import java.util.List;

import com.camping.bit.dto.MemberDto;

public interface MemberDao {
	
	public MemberDto getMember(String id);

	public boolean idCheck(String id);

    public boolean nicknameCheck(String nickname);

    public boolean emailCheck(String email);

    public boolean login(MemberDto dto);

    public void addMember(MemberDto dto);
}
