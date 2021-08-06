package com.camping.bit.dao;

import java.util.List;

import com.camping.bit.dto.MemberDto;

public interface MemberDao {
	
	public List<MemberDto> getMember();

	public boolean idCheck(String id);

    public boolean nicknameCheck(String nickname);

    public boolean emailCheck(String email);
}
