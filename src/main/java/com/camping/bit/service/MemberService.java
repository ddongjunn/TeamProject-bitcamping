package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.MemberDto;

public interface MemberService {

	public MemberDto getMember(String id);

	public boolean idCheck(String id);

	public boolean nicknameCheck(String nickname);

	public boolean emailCheck(String email);

	public void addMember(MemberDto dto);
}
