package com.camping.bit.service;

import java.util.List;
import java.util.Map;

import com.camping.bit.dto.MemberDto;

public interface MemberService {

	public MemberDto getMember(String id);

	public boolean idCheck(String id);

	public boolean nicknameCheck(String nickname);

	public boolean emailCheck(String email);

	public boolean login(MemberDto dto);

	public void addMember(MemberDto dto);

	public String findId(MemberDto dto);
}
